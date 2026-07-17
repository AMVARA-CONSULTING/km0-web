/**
 * Site motion: scroll reveals (once) + masthead compact state.
 * Tokens: --ease-out-expo, --duration-reveal, --reveal-distance, --reveal-stagger.
 * Honors prefers-reduced-motion.
 */

function prefersReducedMotion(): boolean {
  return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
}

function initScrollReveal() {
  const elements = document.querySelectorAll<HTMLElement>('[data-reveal]');
  if (!elements.length) return;

  if (prefersReducedMotion()) {
    elements.forEach((el) => {
      el.classList.add('reveal', 'is-visible');
      el.style.removeProperty('--reveal-delay');
    });
    return;
  }

  const staggerMs = Number.parseInt(
    getComputedStyle(document.documentElement).getPropertyValue('--reveal-stagger').trim() ||
      '80',
    10
  );

  /** Auto-stagger siblings that share a parent and omit data-delay. */
  const groupIndex = new Map<ParentNode, number>();

  elements.forEach((el) => {
    el.classList.add('reveal');

    let delay = el.dataset.delay;
    if (delay === undefined) {
      const parent = el.parentElement;
      if (parent) {
        const next = groupIndex.get(parent) ?? 0;
        groupIndex.set(parent, next + 1);
        delay = String(next * (Number.isFinite(staggerMs) ? staggerMs : 80));
      } else {
        delay = '0';
      }
    }

    el.style.setProperty('--reveal-delay', `${delay}ms`);
  });

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        const el = entry.target as HTMLElement;
        el.classList.add('is-visible');
        observer.unobserve(el);
      });
    },
    { threshold: 0.14, rootMargin: '0px 0px -10% 0px' }
  );

  elements.forEach((el) => observer.observe(el));
}

function initMastheadScroll() {
  const masthead = document.querySelector<HTMLElement>('.masthead');
  if (!masthead) return;

  const root = document.documentElement;
  const threshold = 20;
  let ticking = false;

  const update = () => {
    const compact = window.scrollY > threshold;
    masthead.classList.toggle('masthead--compact', compact);
    root.dataset.masthead = compact ? 'compact' : 'default';
    ticking = false;
  };

  const onScroll = () => {
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(update);
  };

  update();
  window.addEventListener('scroll', onScroll, { passive: true });
}

initScrollReveal();
initMastheadScroll();
