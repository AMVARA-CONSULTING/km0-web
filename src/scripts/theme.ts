/** Theme preference: explicit light/dark, or follow OS until overridden. */
export type ThemePref = 'light' | 'dark' | 'system';
export type ResolvedTheme = 'light' | 'dark';

export const THEME_STORAGE_KEY = 'km0-theme';

const PREFS: ThemePref[] = ['system', 'light', 'dark'];

export function isThemePref(value: string | null | undefined): value is ThemePref {
  return value === 'light' || value === 'dark' || value === 'system';
}

export function getStoredThemePref(): ThemePref {
  try {
    const raw = localStorage.getItem(THEME_STORAGE_KEY);
    return isThemePref(raw) ? raw : 'system';
  } catch {
    return 'system';
  }
}

export function resolveTheme(pref: ThemePref): ResolvedTheme {
  if (pref === 'light') return 'light';
  if (pref === 'dark') return 'dark';
  return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
}

export function applyTheme(pref: ThemePref): ResolvedTheme {
  const resolved = resolveTheme(pref);
  const root = document.documentElement;
  root.dataset.theme = resolved;
  root.dataset.themePref = pref;
  root.style.colorScheme = resolved;
  return resolved;
}

export function setThemePref(pref: ThemePref): ResolvedTheme {
  try {
    localStorage.setItem(THEME_STORAGE_KEY, pref);
  } catch {
    /* private mode / blocked storage - still apply for this session */
  }
  return applyTheme(pref);
}

export function cycleThemePref(current: ThemePref): ThemePref {
  const i = PREFS.indexOf(current);
  return PREFS[(i + 1) % PREFS.length] ?? 'system';
}

function currentPref(): ThemePref {
  const fromDom = document.documentElement.dataset.themePref;
  return isThemePref(fromDom) ? fromDom : getStoredThemePref();
}

function syncThemeControls(pref: ThemePref, resolved: ResolvedTheme) {
  document.querySelectorAll<HTMLElement>('[data-theme-cycle]').forEach((btn) => {
    const label =
      pref === 'light'
        ? btn.dataset.labelLight
        : pref === 'dark'
          ? btn.dataset.labelDark
          : btn.dataset.labelSystem;
    const next =
      pref === 'light'
        ? btn.dataset.labelSetDark
        : pref === 'dark'
          ? btn.dataset.labelSetSystem
          : btn.dataset.labelSetLight;
    const short =
      pref === 'light'
        ? btn.dataset.shortLight
        : pref === 'dark'
          ? btn.dataset.shortDark
          : btn.dataset.shortSystem;

    if (next || label) btn.setAttribute('aria-label', next || label || '');
    btn.dataset.themePref = pref;
    btn.dataset.themeResolved = resolved;
    const text = btn.querySelector('[data-theme-current]');
    if (text && short) text.textContent = short;
  });
}

function refreshFromPref() {
  const pref = currentPref();
  const resolved = applyTheme(pref);
  syncThemeControls(pref, resolved);
}

function initTheme() {
  refreshFromPref();

  if (document.documentElement.dataset.themeInit === '1') return;
  document.documentElement.dataset.themeInit = '1';

  document.addEventListener('click', (event) => {
    const target = event.target;
    if (!(target instanceof Element)) return;
    const btn = target.closest<HTMLElement>('[data-theme-cycle]');
    if (!btn) return;
    const next = cycleThemePref(currentPref());
    const resolved = setThemePref(next);
    syncThemeControls(next, resolved);
  });

  const mq = window.matchMedia('(prefers-color-scheme: dark)');
  const onSystemChange = () => {
    if (currentPref() !== 'system') return;
    refreshFromPref();
  };
  if (typeof mq.addEventListener === 'function') {
    mq.addEventListener('change', onSystemChange);
  } else {
    mq.addListener(onSystemChange);
  }
}

initTheme();
document.addEventListener('astro:page-load', refreshFromPref);
