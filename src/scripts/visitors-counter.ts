const STORAGE_KEY = 'km0_visitor_id';
const API = '/api/visitors';

function ensureVisitorId(): string {
  try {
    const existing = localStorage.getItem(STORAGE_KEY);
    if (existing && existing.length >= 8) return existing;
  } catch {
    /* private mode */
  }
  const id =
    typeof crypto !== 'undefined' && 'randomUUID' in crypto
      ? crypto.randomUUID()
      : `v-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 12)}`;
  try {
    localStorage.setItem(STORAGE_KEY, id);
  } catch {
    /* ignore */
  }
  return id;
}

function formatCount(n: number, locale: string): string {
  try {
    return new Intl.NumberFormat(locale).format(n);
  } catch {
    return String(n);
  }
}

/** Load unique-visitor count into the footer line; fail soft (hide line). */
export function initVisitorsCounter(): void {
  const line = document.querySelector<HTMLElement>('[data-visitors-line]');
  const countEl = document.querySelector<HTMLElement>('[data-visitors-count]');
  if (!line || !countEl) return;

  const locale = line.dataset.locale || document.documentElement.lang || 'en';
  const id = ensureVisitorId();

  void (async () => {
    try {
      const res = await fetch(API, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id }),
        credentials: 'same-origin',
        keepalive: true,
      });
      if (!res.ok) return;
      const data = (await res.json()) as { count?: unknown };
      if (typeof data.count !== 'number' || !Number.isFinite(data.count) || data.count < 0) {
        return;
      }
      countEl.textContent = formatCount(Math.floor(data.count), locale);
      line.hidden = false;
    } catch {
      /* omit line if API down */
    }
  })();
}

initVisitorsCounter();
