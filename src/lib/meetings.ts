export type MeetingTag = 'informal';

export interface MeetingEventRecord {
  id: string;
  date: string;
  time: string;
  mapsUrl: string;
  venueWebsite?: string;
  tag: MeetingTag;
}

export const MEETING_EVENTS: MeetingEventRecord[] = [
  {
    id: 'masnou-jul-2026',
    date: '2026-07-10',
    time: '18:30',
    mapsUrl:
      'https://www.google.com/maps?um=1&ie=UTF-8&fb=1&gl=es&sa=X&geocode=KUen8omSsaQSMSs90c6FD59J&daddr=Carrer+de+Barcelona,+1,+08320+El+Masnou,+Barcelona',
    venueWebsite: 'https://casinomasnou.com/',
    tag: 'informal',
  },
];

export function parseMeetingDate(isoDate: string): Date {
  const [y, m, d] = isoDate.split('-').map(Number);
  return new Date(y, m - 1, d);
}

export function isFutureOrTodayEvent(isoDate: string, reference = new Date()): boolean {
  const eventDate = parseMeetingDate(isoDate);
  const ref = new Date(reference.getFullYear(), reference.getMonth(), reference.getDate());
  return eventDate >= ref;
}

export function upcomingMeetingEvents(reference = new Date()): MeetingEventRecord[] {
  return MEETING_EVENTS.filter((event) => isFutureOrTodayEvent(event.date, reference)).sort(
    (a, b) => a.date.localeCompare(b.date),
  );
}
