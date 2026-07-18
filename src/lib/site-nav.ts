import type { Locale, Messages } from '../i18n/types';
import { localeHref, withHash } from '../i18n/paths';

export type SiteNavLink = {
  id: string;
  label: string;
  href: string;
  external?: boolean;
};

/** Primary header navigation (≤7 items). Secondary routes live in the footer. */
export function headerNavLinks(locale: Locale, m: Messages): SiteNavLink[] {
  return [
    { id: 'home', label: m.nav.home, href: withHash(locale, 'home') },
    { id: 'services', label: m.nav.services, href: withHash(locale, 'services') },
    { id: 'pricing', label: m.nav.pricing, href: localeHref(locale, '/pricing/') },
    { id: 'blog', label: m.nav.blog, href: localeHref(locale, '/doc/') },
    { id: 'ideas', label: m.nav.ideas, href: localeHref(locale, '/ideas/') },
    { id: 'meeting', label: m.nav.meeting, href: localeHref(locale, '/meeting/') },
    { id: 'contact', label: m.nav.contact, href: withHash(locale, 'contact') },
  ];
}

export type FooterNavColumn = {
  id: string;
  title: string;
  links: SiteNavLink[];
};

/** Grouped footer site map (Amazon-style columns, distinct from the header bar). */
export function footerNavColumns(locale: Locale, m: Messages): FooterNavColumn[] {
  const serviceLinks = m.services.items
    .filter((item): item is typeof item & { url: string } => Boolean(item.url) && item.available !== false)
    .map((item) => ({
      id: item.id,
      label: item.title,
      href: item.url,
      external: true,
    }));

  return [
    {
      id: 'explore',
      title: m.footer.exploreTitle,
      links: [
        { id: 'services', label: m.nav.services, href: withHash(locale, 'services') },
        { id: 'pricing', label: m.nav.pricing, href: localeHref(locale, '/pricing/') },
        { id: 'tutorials', label: m.nav.tutorials, href: localeHref(locale, '/tutorials/') },
        { id: 'blog', label: m.nav.blog, href: localeHref(locale, '/doc/') },
        { id: 'meeting', label: m.nav.meeting, href: localeHref(locale, '/meeting/') },
        { id: 'ideas', label: m.nav.ideas, href: localeHref(locale, '/ideas/') },
      ],
    },
    {
      id: 'about',
      title: m.footer.aboutTitle,
      links: [
        { id: 'why', label: m.nav.vision, href: withHash(locale, 'why') },
        { id: 'presentation', label: m.nav.presentation, href: localeHref(locale, '/presentation/') },
        { id: 'faq', label: m.nav.faq, href: withHash(locale, 'faq') },
        { id: 'community', label: m.nav.community, href: withHash(locale, 'community') },
        { id: 'contact', label: m.nav.contact, href: withHash(locale, 'contact') },
      ],
    },
    {
      id: 'legal',
      title: m.footer.legalTitle,
      links: [
        { id: 'legal', label: m.footer.legal, href: localeHref(locale, '/legal/') },
        { id: 'security', label: m.footer.security, href: localeHref(locale, '/security/') },
      ],
    },
    {
      id: 'products',
      title: m.footer.servicesTitle,
      links: serviceLinks,
    },
  ];
}
