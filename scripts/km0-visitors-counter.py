#!/usr/bin/env python3
"""KM0 first-party unique visitor counter (count-only HTTP API).

GET  /api/visitors -> {"count": N}
POST /api/visitors  body {"id": "<client-uuid>"} -> {"count": N}
  Increments once per distinct id (sha256 stored). Public JSON never includes ids.
"""
from __future__ import annotations

import hashlib
import json
import os
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlparse

HOST = os.environ.get("KM0_VISITORS_HOST", "127.0.0.1")
PORT = int(os.environ.get("KM0_VISITORS_PORT", "9182"))
STATE_PATH = Path(
    os.environ.get("KM0_VISITORS_STATE", "/var/spool/km0-visitors/state.json")
)
MAX_BODY = 2048

_lock = threading.Lock()


def _empty_state() -> dict:
    return {"count": 0, "ids": []}


def _load() -> dict:
    if not STATE_PATH.exists():
        return _empty_state()
    try:
        data = json.loads(STATE_PATH.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return _empty_state()
    if not isinstance(data, dict):
        return _empty_state()
    count = data.get("count", 0)
    ids = data.get("ids", [])
    if not isinstance(count, int) or count < 0:
        count = 0
    if not isinstance(ids, list):
        ids = []
    ids = [x for x in ids if isinstance(x, str)]
    return {"count": count, "ids": ids}


def _save(state: dict) -> None:
    STATE_PATH.parent.mkdir(parents=True, exist_ok=True)
    tmp = STATE_PATH.with_suffix(".tmp")
    tmp.write_text(json.dumps(state, separators=(",", ":")) + "\n", encoding="utf-8")
    tmp.replace(STATE_PATH)


def _hash_id(raw: str) -> str:
    return hashlib.sha256(raw.encode("utf-8")).hexdigest()


class Handler(BaseHTTPRequestHandler):
    server_version = "km0-visitors/1.0"

    def log_message(self, fmt: str, *args) -> None:
        return

    def _cors(self) -> None:
        self.send_header("Cache-Control", "no-store")
        self.send_header("Content-Type", "application/json; charset=utf-8")

    def _json(self, code: int, payload: dict) -> None:
        body = json.dumps(payload, separators=(",", ":")).encode("utf-8")
        self.send_response(code)
        self._cors()
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def _path_ok(self) -> bool:
        path = urlparse(self.path).path.rstrip("/") or "/"
        return path in ("/api/visitors", "/api/visitors/")

    def do_OPTIONS(self) -> None:  # noqa: N802
        if not self._path_ok():
            self.send_error(404)
            return
        self.send_response(204)
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.send_header("Content-Length", "0")
        self.end_headers()

    def do_GET(self) -> None:  # noqa: N802
        if not self._path_ok():
            self.send_error(404)
            return
        with _lock:
            state = _load()
            count = state["count"]
        self._json(200, {"count": count})

    def do_POST(self) -> None:  # noqa: N802
        if not self._path_ok():
            self.send_error(404)
            return
        length = int(self.headers.get("Content-Length") or "0")
        if length < 0 or length > MAX_BODY:
            self._json(400, {"error": "bad_request"})
            return
        raw = self.rfile.read(length) if length else b"{}"
        try:
            payload = json.loads(raw.decode("utf-8") or "{}")
        except (UnicodeDecodeError, json.JSONDecodeError):
            self._json(400, {"error": "bad_json"})
            return
        if not isinstance(payload, dict):
            self._json(400, {"error": "bad_json"})
            return
        vid = payload.get("id")
        if not isinstance(vid, str) or not (8 <= len(vid) <= 128):
            self._json(400, {"error": "bad_id"})
            return
        if not vid.strip() or any(ord(c) < 32 for c in vid):
            self._json(400, {"error": "bad_id"})
            return
        digest = _hash_id(vid)
        with _lock:
            state = _load()
            ids = set(state["ids"])
            if digest not in ids:
                ids.add(digest)
                state["ids"] = sorted(ids)
                state["count"] = int(state["count"]) + 1
                _save(state)
            count = int(state["count"])
        self._json(200, {"count": count})


def main() -> None:
    STATE_PATH.parent.mkdir(parents=True, exist_ok=True)
    if not STATE_PATH.exists():
        with _lock:
            _save(_empty_state())
    httpd = ThreadingHTTPServer((HOST, PORT), Handler)
    print(f"km0-visitors listening on {HOST}:{PORT} state={STATE_PATH}", flush=True)
    httpd.serve_forever()


if __name__ == "__main__":
    main()
