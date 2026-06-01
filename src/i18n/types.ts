export type Locale = 'es' | 'ca' | 'en' | 'de';

export const localeBcp47: Record<Locale, string> = {
  es: 'es',
  ca: 'ca',
  en: 'en',
  de: 'de',
};

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
    home: string;
    vision: string;
    values: string;
    community: string;
    services: string;
    meaning: string;
    mission: string;
    blog: string;
    tutorials: string;
    faq: string;
    contact: string;
    menuOpen: string;
    menuClose: string;
  };
  vision: {
    eyebrow: string;
    headingBefore: string;
    headingAccent: string;
    headingAfter: string;
    intro: string;
    usual: {
      title: string;
      items: string[];
    };
    km0: {
      title: string;
      items: string[];
    };
    blogCta: string;
  };
  community: {
    eyebrow: string;
    heading: string;
    intro: string;
    audiences: string[];
    humanNote: string;
    ctaPrimary: string;
    ctaExplore: string;
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
    blogCta: string;
    tutorialsCta: string;
    cloudTutorialCta: string;
    items: {
      id: string;
      title: string;
      desc: string;
      cta: string;
      url: string;
      available?: boolean;
    }[];
    comingSoon: {
      title: string;
      message: string;
      close: string;
    };
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
  tutorials: {
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
  faq: {
    eyebrow: string;
    heading: string;
    items: {
      id: string;
      question: string;
      answerHtml: string;
    }[];
  };
  contact: {
    eyebrow: string;
    heading: string;
    body: string;
    email: string;
    whatsappLabel: string;
    whatsappQrAlt: string;
    whatsappAria: string;
  };
  footer: {
    rights: string;
    github: string;
    company: string;
    version: string;
  };
}
