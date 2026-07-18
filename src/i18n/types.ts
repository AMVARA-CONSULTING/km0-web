export type Locale = 'es' | 'ca' | 'en' | 'de';

export const localeBcp47: Record<Locale, string> = {
  es: 'es',
  ca: 'ca',
  en: 'en',
  de: 'de',
};

export interface Messages {
  meta: {
    title: string;
    description: string;
  };
  brandName: string;
  brandNameShort: string;
  /** Wordmark: before the accent “0” and after */
  brandMark: {
    before: string;
    after: string;
  };
  nav: {
    home: string;
    vision: string;
    community: string;
    services: string;
    blog: string;
    ideas: string;
    meeting: string;
    tutorials: string;
    presentation: string;
    pricing: string;
    faq: string;
    contact: string;
    menuOpen: string;
    menuClose: string;
    servicesLauncherOpen: string;
    servicesLauncherClose: string;
    servicesLauncherTitle: string;
  };
  vision: {
    headingBefore: string;
    headingAccent: string;
    headingAfter: string;
    intro: string;
    /** Stirling-style audience/scale argument bands (person / community / org). */
    bands: {
      meta: string;
      title: string;
      body: string;
      fact: string;
      /** Primary CTA - Cloud on every band for CTA rhythm */
      ctaLabel: string;
      cta: 'cloud' | 'community' | 'pricing';
      /** Optional quieter secondary (meetups / pricing) */
      secondaryCtaLabel?: string;
      secondaryCta?: 'cloud' | 'community' | 'pricing';
    }[];
  };
  community: {
    heading: string;
    intro: string;
    /** Quiet secondary: WhatsApp group (same URL as Contact) */
    whatsappLink: string;
    /** Quiet secondary: Ideas form */
    ideasLink: string;
  };
  hero: {
    titleLine1: string;
    titleGradient: string;
    tagline: string;
    ctaPrimary: string;
    ctaSecondary: string;
    logoAlt: string;
    /** Cloud product-proof panel with live path (QR + deep link) */
    proof: {
      status: string;
      /** Full plan string for AT (aria-label); visual uses capacity + unit + label */
      planName: string;
      /** Numeric capacity for once-only readout (e.g. "500") */
      planCapacity: string;
      planUnit: string;
      /** Quiet localized plan word beside the capacity readout */
      planLabel: string;
      planMeta: string;
      files: { name: string; meta: string; kind: 'folder' | 'file' }[];
      emailMeta: string;
      /** Satisfecho-style live entry into real Cloud */
      liveLabel: string;
      liveHint: string;
      liveCta: string;
      liveAria: string;
      /** Secondary text link to auth hub register */
      registerCta: string;
      registerAria: string;
      qrAlt: string;
      host: string;
    };
  };
  /** Landing trust facts under the hero (hosting, operator, ISO, security). */
  trust: {
    ariaLabel: string;
    items: {
      label: string;
      value: string;
      /** Optional on-site link target */
      href?: 'security';
    }[];
  };
  services: {
    headingBefore: string;
    headingAccent: string;
    headingAfter: string;
    intro: string;
    slogan: string;
    cloudTutorialCta: string;
    cloudPricingCta: string;
    items: {
      id: string;
      title: string;
      subtitle?: string;
      priceFrom?: string;
      priceAriaLabel?: string;
      desc: string;
      cta?: string;
      ctaFragment?: string;
      secondaryCta?: string;
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
    readingTime: string;
    tocTitle: string;
    previousPost: string;
    nextPost: string;
    relatedPosts: string;
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
    readingTime: string;
    tocTitle: string;
    previousTutorial: string;
    nextTutorial: string;
    relatedTutorials: string;
  };
  faq: {
    heading: string;
    items: {
      id: string;
      question: string;
      answerHtml: string;
    }[];
  };
  contact: {
    heading: string;
    body: string;
    email: string;
    whatsappLabel: string;
    whatsappHint: string;
    whatsappQrAlt: string;
    whatsappAria: string;
  };
  /** Landing closer: mission goal + vision (above footer). Distinct from nav/vision scale bands. */
  purpose: {
    heading: string;
    missionLabel: string;
    missionBody: string;
    visionLabel: string;
    visionBody: string;
  };
  ideas: {
    metaTitle: string;
    metaDescription: string;
    eyebrow: string;
    heading: string;
    intro: string;
    scopeLabel: string;
    scopeHint: string;
    scopeOptions: {
      web: string;
      cloud: string;
      mail: string;
    };
    ideaLabel: string;
    ideaPlaceholder: string;
    nameLabel: string;
    namePlaceholder: string;
    submit: string;
    success: string;
    error: string;
    charCount: string;
  };
  cloudUsers: {
    countLabel: string;
    countAria: string;
    unavailable: string;
    /** Secondary text under Open Cloud CTA */
    registerCta: string;
  };
  pricing: {
    metaTitle: string;
    metaDescription: string;
    eyebrow: string;
    heading: string;
    intro: string;
    heroCta: string;
    heroPrice: {
      amount: string;
      period: string;
      /** Display digits only (e.g. "500"); unit is separate. */
      capacity: string;
      unit: string;
      /** Quiet host line under the capacity meter (e.g. Hetzner · Falkenstein). */
      hostMeta: string;
      ariaLabel: string;
    };
    /** Stirling-style plan paths (Cloud lead / Email quiet / Custom). */
    pathsHeading: string;
    pathsIntro: string;
    paths: {
      id: 'cloud' | 'email' | 'custom';
      meta: string;
      title: string;
      price: string;
      priceNote: string;
      body: string;
      features: string[];
      ctaLabel: string;
      cta: 'cloud' | 'email' | 'contact';
      lead?: boolean;
    }[];
    claim: string;
    compareHeading: string;
    compareIntro: string;
    tableDisclaimer: string;
    table: {
      provider: string;
      monthlyPrice: string;
      storageGb: string;
      costPerTbMonth: string;
    };
    rows: {
      provider: string;
      monthlyPrice: string;
      storageGb: string;
      costPerTbMonth: string;
      highlight?: boolean;
    }[];
    whyPricing: {
      heading: string;
      body: string;
    };
    trust: {
      heading: string;
      items: {
        title: string;
        desc: string;
      }[];
    };
    custom: {
      heading: string;
      body: string;
      cta: string;
    };
  };
  meeting: {
    metaTitle: string;
    metaDescription: string;
    eyebrow: string;
    heading: string;
    intro: string;
    calendarTitle: string;
    upcomingTitle: string;
    noUpcoming: string;
    prevMonth: string;
    nextMonth: string;
    closeDetail: string;
    closer: {
      heading: string;
      body: string;
      ctaSecondary: string;
    };
    labels: {
      date: string;
      time: string;
      where: string;
      website: string;
      audience: string;
      topic: string;
      tag: string;
    };
    tags: {
      informal: string;
    };
    events: Record<
      string,
      {
        title: string;
        location: string;
        audience: string;
        topic: string;
      }
    >;
  };
  presentation: {
    metaTitle: string;
    metaDescription: string;
    eyebrow: string;
    title: string;
    lead: string;
    download: string;
    downloadHint: string;
    why: {
      title: string;
      body: string;
    };
    compare: {
      title: string;
      usualTitle: string;
      km0Title: string;
      rows: { usual: string; km0: string }[];
    };
    community: {
      title: string;
      subtitle: string;
      body: string;
      imageAlt: string;
    };
    cloud: {
      title: string;
      lead: string;
      features: string[];
      imageAlt: string;
    };
    values: {
      title: string;
      items: { title: string; body: string }[];
    };
    privacy: {
      title: string;
      lead: string;
      highlight: string;
    };
    security: {
      title: string;
      items: { title: string; body: string }[];
    };
    roadmap: {
      title: string;
      steps: { title: string; body: string }[];
    };
    cta: {
      title: string;
      lead: string;
      website: string;
      cloud: string;
      email: string;
    };
  };
  legal: {
    metaTitle: string;
    metaDescription: string;
    eyebrow: string;
    heading: string;
    intro: string;
    updated: string;
    tocTitle: string;
    sections: {
      id: string;
      title: string;
      bodyHtml: string;
    }[];
  };
  security: {
    metaTitle: string;
    metaDescription: string;
    eyebrow: string;
    heading: string;
    intro: string;
    updated: string;
    tocTitle: string;
    sections: {
      id: string;
      title: string;
      bodyHtml: string;
    }[];
  };
  errors: {
    notFound: {
      metaTitle: string;
      code: string;
      heading: string;
      description: string;
      backHome: string;
    };
    forbidden: {
      metaTitle: string;
      code: string;
      heading: string;
      description: string;
      backHome: string;
    };
  };
  footer: {
    rights: string;
    github: string;
    pricing: string;
    legal: string;
    security: string;
    version: string;
    repoSince: string;
    poweredByHtml: string;
    navAriaLabel: string;
    exploreTitle: string;
    aboutTitle: string;
    legalTitle: string;
    servicesTitle: string;
  };
}
