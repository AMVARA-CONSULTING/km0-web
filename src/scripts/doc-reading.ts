/** Assign stable ids to doc headings and wire the table of contents. */
function initDocReading() {
  const article = document.querySelector<HTMLElement>('[data-doc-reading]');
  if (!article) return;

  const tocNav = article.querySelector<HTMLElement>('[data-doc-toc]');
  const tocEntries = article.querySelectorAll<HTMLElement>('[data-toc-anchor]');
  const headingSelectors = '.doc-block-title, .doc-block-heading';

  const headings = Array.from(article.querySelectorAll<HTMLElement>(headingSelectors));
  headings.forEach((heading, index) => {
    const entry = tocEntries[index];
    const id = entry?.dataset.tocAnchor ?? `section-${index + 1}`;
    heading.id = id;
    const section = heading.closest('section');
    if (section && !section.id) {
      section.id = id;
    }
  });

  if (!tocNav || headings.length === 0) return;

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        const id = entry.target.id;
        tocNav.querySelectorAll('[data-toc-link]').forEach((link) => {
          const isActive = link.getAttribute('href') === `#${id}`;
          link.setAttribute('aria-current', isActive ? 'location' : 'false');
        });
      });
    },
    { rootMargin: '-20% 0px -70% 0px', threshold: 0 },
  );

  headings.forEach((heading) => observer.observe(heading));
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initDocReading, { once: true });
} else {
  initDocReading();
}
