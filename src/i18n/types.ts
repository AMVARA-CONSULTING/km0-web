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
    significado: string;
    mision: string;
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
