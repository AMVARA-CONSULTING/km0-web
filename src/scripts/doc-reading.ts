/** Wire TOC highlight and assign ids for legacy HTML kit headings. */
function initDocReading() {
  const article = document.querySelector<HTMLElement>('[data-doc-reading]');
  if (!article) return;

  const tocNavs = article.querySelectorAll<HTMLElement>('[data-doc-toc]');
  if (tocNavs.length === 0) return;

  const links = Array.from(
    tocNavs[0].querySelectorAll<HTMLAnchorElement>('[data-toc-link]'),
  );
  if (links.length === 0) return;

  const kitHeadings = Array.from(
    article.querySelectorAll<HTMLElement>('.doc-block-title, .doc-block-heading'),
  );

  links.forEach((link, index) => {
    const id = link.getAttribute('href')?.replace(/^#/, '');
    if (!id) return;

    const existing = article.querySelector<HTMLElement>(`#${CSS.escape(id)}`);
    if (existing) return;

    const heading = kitHeadings[index];
    if (!heading) return;
    heading.id = id;
    const section = heading.closest('section');
    if (section && !section.id) {
      section.id = id;
    }
  });

  const observed = links
    .map((link) => {
      const id = link.getAttribute('href')?.replace(/^#/, '');
      return id ? article.querySelector<HTMLElement>(`#${CSS.escape(id)}`) : null;
    })
    .filter((el): el is HTMLElement => Boolean(el));

  if (observed.length === 0) return;

  const setActive = (id: string) => {
    tocNavs.forEach((nav) => {
      nav.querySelectorAll('[data-toc-link]').forEach((link) => {
        const isActive = link.getAttribute('href') === `#${id}`;
        link.setAttribute('aria-current', isActive ? 'location' : 'false');
      });
    });
  };

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        setActive(entry.target.id);
      });
    },
    { rootMargin: '-20% 0px -70% 0px', threshold: 0 },
  );

  observed.forEach((heading) => observer.observe(heading));
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initDocReading, { once: true });
} else {
  initDocReading();
}
