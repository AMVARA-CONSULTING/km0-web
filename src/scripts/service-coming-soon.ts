const MODAL_ID = 'service-coming-soon-modal';

function getModal(): HTMLElement | null {
  return document.getElementById(MODAL_ID);
}

function openModal(): void {
  const modal = getModal();
  if (!modal) return;

  modal.hidden = false;
  document.body.style.overflow = 'hidden';
  requestAnimationFrame(() => {
    modal.dataset.open = 'true';
  });

  const closeBtn = modal.querySelector<HTMLButtonElement>('[data-modal-close]');
  closeBtn?.focus();
}

function closeModal(): void {
  const modal = getModal();
  if (!modal) return;

  modal.dataset.open = 'false';
  document.body.style.overflow = '';

  window.setTimeout(() => {
    if (modal.dataset.open !== 'true') {
      modal.hidden = true;
    }
  }, 320);
}

function init(): void {
  document.querySelectorAll<HTMLButtonElement>('[data-service-coming-soon]').forEach((btn) => {
    btn.addEventListener('click', openModal);
  });

  const modal = getModal();
  if (!modal) return;

  modal.querySelectorAll<HTMLElement>('[data-modal-close]').forEach((el) => {
    el.addEventListener('click', closeModal);
  });

  modal.addEventListener('click', (event) => {
    if (event.target === modal.querySelector('[data-modal-backdrop]')) {
      closeModal();
    }
  });

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && modal.dataset.open === 'true') {
      closeModal();
    }
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', init);
} else {
  init();
}
