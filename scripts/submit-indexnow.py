#!/usr/bin/env python3
"""Submit km0digital.com sitemap URLs to IndexNow (Bing and peers)."""
from __future__ import annotations

import json
import re
import sys
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SITE = "https://km0digital.com"
HOST = "km0digital.com"
ENDPOINTS = (
    "https://api.indexnow.org/indexnow",
    "https://www.bing.com/indexnow",
)


def load_key() -> str:
    env = (ROOT / ".env").read_text(encoding="utf-8")
    for line in env.splitlines():
        if line.startswith("INDEXNOW_KEY="):
            key = line.split("=", 1)[1].strip()
            if key:
                return key
    raise SystemExit("INDEXNOW_KEY missing in .env")


def load_urls() -> list[str]:
    with urllib.request.urlopen(f"{SITE}/sitemap-0.xml", timeout=60) as resp:
        xml = resp.read().decode("utf-8", "replace")
    urls = [u for u in re.findall(r"<loc>([^<]+)</loc>", xml) if "/403/" not in u]
    if not urls:
        raise SystemExit("no URLs in sitemap")
    return urls


def post(endpoint: str, payload: dict) -> int:
    data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(
        endpoint,
        data=data,
        headers={"Content-Type": "application/json; charset=utf-8"},
        method="POST",
    )
    n = len(payload["urlList"])
    try:
        with urllib.request.urlopen(req, timeout=90) as resp:
            print(f"{endpoint} -> HTTP {resp.status} ({n} urls)")
            return int(resp.status)
    except Exception as exc:  # noqa: BLE001
        code = getattr(exc, "code", None)
        detail = ""
        if hasattr(exc, "read"):
            detail = exc.read().decode("utf-8", "replace")[:300]
        print(f"{endpoint} -> HTTP {code} {exc} {detail}")
        return int(code or 0)


def main() -> int:
    key = load_key()
    urls = load_urls()
    payload = {
        "host": HOST,
        "key": key,
        "keyLocation": f"{SITE}/{key}.txt",
        "urlList": urls,
    }
    statuses = [post(ep, payload) for ep in ENDPOINTS]
    ok = any(s in (200, 202) for s in statuses)
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
