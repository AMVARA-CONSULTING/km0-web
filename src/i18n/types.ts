export type Locale = 'es' | 'ca' | 'en';

export interface MeaningItemJSON {
  title: string;
  desc: string;
}

export interface Messages {
  meta: {
    title: string;
    description: string;
  };
  brandName: string;
  brandNameShort: string;
  /** Wordmark: before the gradient “0” and after */
  brandMark: {
    before: string;
    after: string;
  };
  nav: {
    inicio: string;
    valores: string;
    servicios: string;
    significado: string;
    mision: string;
    blog: string;
    contacto: string;
  };
  hero: {
    eyebrow: string;
    titleLine1: string;
    titleGradient: string;
    tagline: string;
    ctaPrimary: string;
    ctaSecondary: string;
    logoAlt: string;
    laptopAlt: string;
    mobileAlt: string;
  };
  values: {
    eyebrow: string;
    headingBefore: string;
    headingAccent: string;
    headingAfter: string;
    chips: string[];
  };
  services: {
    eyebrow: string;
    headingBefore: string;
    headingAccent: string;
    headingAfter: string;
    intro: string;
    slogan: string;
    items: {
      id: string;
      title: string;
      desc: string;
      cta: string;
      url: string;
    }[];
  };
  doc: {
    metaTitle: string;
    metaDescription: string;
    eyebrow: string;
    heading: string;
    intro: string;
    readMore: string;
    backToIndex: string;
    breadcrumbHome: string;
  };
  meaning: {
    eyebrow: string;
    heading: string;
    items: MeaningItemJSON[];
  };
  mission: {
    eyebrow: string;
    heading: string;
    body: string;
  };
  merch: {
    eyebrow: string;
    headingBefore: string;
    headingGradient: string;
  };
  contact: {
    eyebrow: string;
    heading: string;
    body: string;
    email: string;
  };
  footer: {
    rights: string;
  };
}
