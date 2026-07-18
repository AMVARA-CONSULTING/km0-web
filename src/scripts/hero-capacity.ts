/**
 * 500 GB capacity moment (#104 home + pricing masthead): once-only count-up
 * synced to reveal. Meter fill is CSS on `.is-visible`. Honors prefers-reduced-motion.
 */

function prefersReducedMotion(): boolean {
  return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
}

/** Expo-out matching --ease-out-expo (approx.). */
function easeOutExpo(t: number): number {
  return t >= 1 ? 1 : 1 - Math.pow(2, -10 * t);
}

function parseDurationMs(raw: string, fallback: number): number {
  const trimmed = raw.trim();
  if (!trimmed) return fallback;
  if (trimmed.endsWith('ms')) {
    const n = Number.parseFloat(trimmed);
    return Number.isFinite(n) ? n : fallback;
  }
  if (trimmed.endsWith('s')) {
    const n = Number.parseFloat(trimmed) * 1000;
    return Number.isFinite(n) ? n : fallback;
  }
  const n = Number.parseFloat(trimmed);
  return Number.isFinite(n) ? n : fallback;
}

function settleValue(el: HTMLElement, target: number): void {
  el.textContent = String(target);
  el.dataset.settled = 'true';
}

function runCountUp(el: HTMLElement, target: number, durationMs: number): void {
  const start = performance.now();
  el.textContent = '0';

  const tick = (now: number) => {
    const t = Math.min(1, (now - start) / durationMs);
    const value = Math.round(easeOutExpo(t) * target);
    el.textContent = String(value);
    if (t < 1) {
      requestAnimationFrame(tick);
    } else {
      settleValue(el, target);
    }
  };

  requestAnimationFrame(tick);
}

function whenVisible(host: HTMLElement, onVisible: () => void): void {
  if (host.classList.contains('is-visible')) {
    onVisible();
    return;
  }

  const observer = new MutationObserver(() => {
    if (!host.classList.contains('is-visible')) return;
    observer.disconnect();
    onVisible();
  });

  observer.observe(host, { attributes: true, attributeFilter: ['class'] });
}

function initCapacityReadout(host: HTMLElement | null, valueEl: HTMLElement | null): void {
  if (!host || !valueEl) return;

  const target = Number.parseInt(valueEl.dataset.target || valueEl.textContent || '500', 10);
  if (!Number.isFinite(target) || target <= 0) return;

  if (prefersReducedMotion()) {
    settleValue(valueEl, target);
    return;
  }

  const durationMs = parseDurationMs(
    getComputedStyle(document.documentElement).getPropertyValue('--duration-hero-capacity'),
    480
  );

  whenVisible(host, () => {
    if (valueEl.dataset.settled === 'true') return;
    runCountUp(valueEl, target, durationMs);
  });
}

function initHeroCapacity(): void {
  initCapacityReadout(
    document.querySelector<HTMLElement>('.hero__visual[data-reveal]'),
    document.querySelector<HTMLElement>('[data-hero-capacity]')
  );
  initCapacityReadout(
    document.querySelector<HTMLElement>('.pricing-hero-stat[data-reveal]'),
    document.querySelector<HTMLElement>('[data-pricing-capacity]')
  );
}

initHeroCapacity();
