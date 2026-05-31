function measurePanel(panel: HTMLElement): number {
  const content = panel.querySelector<HTMLElement>('.faq-panel__content');
  if (!content) return 0;
  return content.scrollHeight;
}

function setPanelHeight(panel: HTMLElement, height: number, animate: boolean) {
  if (!animate) {
    panel.style.transition = 'none';
  }
  panel.style.height = `${height}px`;
  if (!animate) {
    panel.getBoundingClientRect();
    panel.style.transition = '';
  }
}

function syncItem(item: HTMLElement, animate: boolean) {
  const panel = item.querySelector<HTMLElement>('[data-faq-panel]');
  if (!panel) return;

  const open = item.dataset.open === 'true';
  setPanelHeight(panel, open ? measurePanel(panel) : 0, animate);
}

export function initFaqAccordion() {
  const root = document.querySelector('[data-faq-accordion]');
  if (!root) return;

  const items = [...root.querySelectorAll<HTMLElement>('[data-faq-item]')];
  const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  const animate = !reducedMotion;

  const setOpen = (target: HTMLElement | null, open: boolean) => {
    items.forEach((item) => {
      const shouldOpen = item === target && open;
      item.dataset.open = shouldOpen ? 'true' : 'false';
      item.querySelector('.faq-trigger')?.setAttribute('aria-expanded', String(shouldOpen));
      syncItem(item, animate);
    });
  };

  items.forEach((item) => {
    item.querySelector('.faq-trigger')?.addEventListener('click', () => {
      const isOpen = item.dataset.open === 'true';
      setOpen(isOpen ? null : item, !isOpen);
    });
  });

  const syncAll = (withAnimation: boolean) => {
    items.forEach((item) => syncItem(item, withAnimation));
  };

  syncAll(false);
  requestAnimationFrame(() => syncAll(false));
  window.addEventListener('load', () => syncAll(false));
  window.addEventListener('resize', () => syncAll(false));
}

initFaqAccordion();
