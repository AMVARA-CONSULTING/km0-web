const MAX_IDEA_LENGTH = 4000;

function initIdeasForm(): void {
  const form = document.getElementById('ideas-form') as HTMLFormElement | null;
  if (!form) return;

  const fields = document.getElementById('ideas-fields');
  const successEl = document.getElementById('ideas-success');
  const errorEl = document.getElementById('ideas-error');
  const ideaInput = form.querySelector<HTMLTextAreaElement>('#ideas-idea');
  const charCountEl = document.getElementById('ideas-char-count');
  const submitBtn = form.querySelector<HTMLButtonElement>('[data-ideas-submit]');

  const locale = form.dataset.locale ?? 'es';
  const charCountTemplate = form.dataset.charCountTemplate ?? '{count} / 4000';

  const updateCharCount = (): void => {
    if (!ideaInput || !charCountEl) return;
    const count = ideaInput.value.length;
    charCountEl.textContent = charCountTemplate.replace('{count}', String(count));
  };

  ideaInput?.addEventListener('input', updateCharCount);
  updateCharCount();

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    if (!ideaInput || !fields || !successEl || !errorEl) return;

    errorEl.classList.add('hidden');
    submitBtn?.setAttribute('disabled', 'true');

    const idea = ideaInput.value.trim();
    const nameInput = form.querySelector<HTMLInputElement>('#ideas-name');
    const hpInput = form.querySelector<HTMLInputElement>('#ideas-website');
    const name = nameInput?.value.trim() ?? '';
    const website = hpInput?.value ?? '';

    if (!idea || idea.length > MAX_IDEA_LENGTH) {
      errorEl.classList.remove('hidden');
      submitBtn?.removeAttribute('disabled');
      return;
    }

    try {
      const response = await fetch('/hooks/ideas', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ idea, name, locale, website }),
      });

      const data = (await response.json()) as { ok?: boolean };
      if (!response.ok || !data.ok) {
        throw new Error('submit failed');
      }

      fields.classList.add('hidden');
      successEl.classList.remove('hidden');
    } catch {
      errorEl.classList.remove('hidden');
      submitBtn?.removeAttribute('disabled');
    }
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initIdeasForm);
} else {
  initIdeasForm();
}
