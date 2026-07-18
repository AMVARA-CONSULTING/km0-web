/**
 * Site motion: scroll reveals (once) + masthead compact + Offer pin stuck.
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
      el.classList.add('is-visible');
      el.style.removeProperty('--reveal-delay');
    });
    return;
  }

  const staggerMs = Number.parseInt(
    getComputedStyle(document.documentElement).getPropertyValue('--reveal-stagger').trim() ||
      '90',
    10
  );

  /** Auto-stagger siblings that share a parent and omit data-delay. */
  const groupIndex = new Map<ParentNode, number>();

  elements.forEach((el) => {
    let delay = el.dataset.delay;
    if (delay === undefined) {
      const parent = el.parentElement;
      if (parent) {
        const next = groupIndex.get(parent) ?? 0;
        groupIndex.set(parent, next + 1);
        delay = String(next * (Number.isFinite(staggerMs) ? staggerMs : 90));
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
    /* Trigger when a meaningful slice is on screen so the rise is seen */
    { threshold: 0.18, rootMargin: '0px 0px -12% 0px' }
  );

  elements.forEach((el) => observer.observe(el));
}

function initMastheadScroll() {
  const masthead = document.querySelector<HTMLElement>('.masthead');
  if (!masthead) return;

  const root = document.documentElement;
  /* Fire within the first scroll tick so compact is obvious on desktop */
  const threshold = 12;
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

/**
 * Visual stuck state for home Offer pin (lg+). Sticky layout is CSS;
 * this only toggles the Snow panel + Signal edge when the pin is pinned.
 */
function initOfferPinStuck() {
  const pin = document.querySelector<HTMLElement>('[data-offer-pin]');
  if (!pin) return;

  const mq = window.matchMedia('(min-width: 1024px)');
  let ticking = false;

  const update = () => {
    ticking = false;
    if (!mq.matches) {
      pin.classList.remove('offer__pin--stuck');
      return;
    }

    const stickyTop = Number.parseFloat(getComputedStyle(pin).top) || 0;
    const rect = pin.getBoundingClientRect();
    /* Engaged sticky: pin sits at its CSS top under the masthead */
    const stuck = rect.top <= stickyTop + 1;
    pin.classList.toggle('offer__pin--stuck', stuck);
  };

  const onScroll = () => {
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(update);
  };

  update();
  window.addEventListener('scroll', onScroll, { passive: true });
  window.addEventListener('resize', onScroll, { passive: true });
  mq.addEventListener('change', update);
}

initScrollReveal();
initMastheadScroll();
initOfferPinStuck();
