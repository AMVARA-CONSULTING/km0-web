const MAX_IDEA_LENGTH = 4000;
const VALID_SCOPES = new Set(['web', 'cloud', 'mail']);
const SUCCESS_RESET_MS = 2200;

function initIdeasChatWidget(): void {
  const root = document.getElementById('ideas-chat');
  const form = document.getElementById('ideas-form') as HTMLFormElement | null;
  const panel = document.getElementById('ideas-chat-panel');
  const launcher = document.querySelector<HTMLButtonElement>('[data-ideas-launcher]');
  const closeBtn = document.querySelector<HTMLButtonElement>('[data-ideas-close]');
  if (!root || !form || !panel || !launcher) return;

  const errorEl = document.getElementById('ideas-error');
  const successEl = document.getElementById('ideas-success');
  const ideaInput = form.querySelector<HTMLTextAreaElement>('#ideas-idea');
  const charCountEl = document.getElementById('ideas-char-count');
  const submitBtn = form.querySelector<HTMLButtonElement>('[data-ideas-submit]');
  const scopeInput = form.querySelector<HTMLSelectElement>('#ideas-scope');
  const nameInput = form.querySelector<HTMLInputElement>('#ideas-name');
  const passwordInput = form.querySelector<HTMLInputElement>('#ideas-password');
  const hpInput = form.querySelector<HTMLInputElement>('#ideas-website');

  const locale = root.dataset.locale ?? 'es';
  const charCountTemplate = root.dataset.charCountTemplate ?? '{count} / 4000';
  const openAria = launcher.getAttribute('aria-label') ?? 'Open';
  const closeAria = closeBtn?.getAttribute('aria-label') ?? 'Close';

  let resetTimer: number | undefined;

  const updateCharCount = (): void => {
    if (!ideaInput || !charCountEl) return;
    charCountEl.textContent = charCountTemplate.replace('{count}', String(ideaInput.value.length));
  };

  const setOpen = (open: boolean): void => {
    if (open) {
      panel.hidden = false;
      launcher.setAttribute('aria-expanded', 'true');
      launcher.setAttribute('aria-label', closeAria);
      ideaInput?.focus();
    } else {
      panel.hidden = true;
      launcher.setAttribute('aria-expanded', 'false');
      launcher.setAttribute('aria-label', openAria);
      launcher.focus();
    }
  };

  const clearStatus = (): void => {
    errorEl?.classList.add('hidden');
    successEl?.classList.add('hidden');
  };

  const resetFormFields = (): void => {
    if (ideaInput) ideaInput.value = '';
    if (nameInput) nameInput.value = '';
    if (passwordInput) passwordInput.value = '';
    if (hpInput) hpInput.value = '';
    if (scopeInput) scopeInput.value = 'web';
    updateCharCount();
    submitBtn?.removeAttribute('disabled');
  };

  ideaInput?.addEventListener('input', updateCharCount);
  updateCharCount();

  launcher.addEventListener('click', () => {
    setOpen(panel.hidden);
  });

  closeBtn?.addEventListener('click', () => {
    setOpen(false);
  });

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && !panel.hidden) {
      event.preventDefault();
      setOpen(false);
    }
  });

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    if (!ideaInput || !errorEl || !successEl) return;

    window.clearTimeout(resetTimer);
    clearStatus();
    submitBtn?.setAttribute('disabled', 'true');

    const idea = ideaInput.value.trim();
    const scope = scopeInput?.value ?? 'web';
    const name = nameInput?.value.trim() ?? '';
    const password = passwordInput?.value ?? '';
    const website = hpInput?.value ?? '';

    if (!VALID_SCOPES.has(scope) || !idea || idea.length > MAX_IDEA_LENGTH) {
      errorEl.classList.remove('hidden');
      submitBtn?.removeAttribute('disabled');
      return;
    }

    const body: Record<string, string> = { idea, name, locale, scope, website };
    if (password.trim()) {
      body.password = password;
    }

    try {
      const response = await fetch('/hooks/ideas', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      });

      const data = (await response.json()) as { ok?: boolean };
      if (!response.ok || !data.ok) {
        throw new Error('submit failed');
      }

      successEl.classList.remove('hidden');
      resetTimer = window.setTimeout(() => {
        clearStatus();
        resetFormFields();
      }, SUCCESS_RESET_MS);
    } catch {
      errorEl.classList.remove('hidden');
      submitBtn?.removeAttribute('disabled');
    }
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initIdeasChatWidget);
} else {
  initIdeasChatWidget();
}
