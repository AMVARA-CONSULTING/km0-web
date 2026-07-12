import type { Locale, Messages } from '../i18n/types';
import { localeHref, withHash } from '../i18n/paths';

export type SiteNavLink = {
  id: string;
  label: string;
  href: string;
  external?: boolean;
};

/** Primary header navigation (pages and landing anchors). */
export function headerNavLinks(locale: Locale, m: Messages): SiteNavLink[] {
  return [
    { id: 'services', label: m.nav.services, href: withHash(locale, 'services') },
    { id: 'tutorials', label: m.nav.tutorials, href: localeHref(locale, '/tutorials/') },
    { id: 'presentation', label: m.nav.presentation, href: localeHref(locale, '/presentation/') },
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
        { id: 'tutorials', label: m.nav.tutorials, href: localeHref(locale, '/tutorials/') },
        { id: 'presentation', label: m.nav.presentation, href: localeHref(locale, '/presentation/') },
        { id: 'blog', label: m.nav.blog, href: localeHref(locale, '/doc/') },
        { id: 'ideas', label: m.nav.ideas, href: localeHref(locale, '/ideas/') },
        { id: 'meeting', label: m.nav.meeting, href: localeHref(locale, '/meeting/') },
      ],
    },
    {
      id: 'about',
      title: m.footer.aboutTitle,
      links: [
        { id: 'vision', label: m.nav.vision, href: withHash(locale, 'vision') },
        { id: 'mission', label: m.nav.mission, href: withHash(locale, 'mission') },
        { id: 'values', label: m.nav.values, href: withHash(locale, 'values') },
        { id: 'community', label: m.nav.community, href: withHash(locale, 'community') },
        { id: 'meaning', label: m.nav.meaning, href: withHash(locale, 'meaning') },
        { id: 'faq', label: m.nav.faq, href: withHash(locale, 'faq') },
      ],
    },
    {
      id: 'legal',
      title: m.footer.legalTitle,
      links: [
        { id: 'pricing', label: m.nav.pricing, href: localeHref(locale, '/pricing/') },
        { id: 'legal', label: m.footer.legal, href: localeHref(locale, '/legal/') },
        { id: 'security', label: m.footer.security, href: localeHref(locale, '/security/') },
        { id: 'contact', label: m.nav.contact, href: withHash(locale, 'contact') },
      ],
    },
    {
      id: 'products',
      title: m.footer.servicesTitle,
      links: serviceLinks,
    },
  ];
}
