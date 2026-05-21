import type { Locale } from './types';
import type { Messages } from './types';
import ca from './ca.json';
import en from './en.json';
import es from './es.json';

export const catalogs: Record<Locale, Messages> = {
  es: es as Messages,
  ca: ca as Messages,
  en: en as Messages,
};

export function getMessages(locale: Locale): Messages {
  return catalogs[locale];
}

export type { Locale, Messages };
