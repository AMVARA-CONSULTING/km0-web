/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,ts}'],
  theme: {
    extend: {
      colors: {
        /* CSS variables so light/dark schemes remap sitewide (opacity via /N) */
        ink: 'rgb(var(--rgb-ink) / <alpha-value>)',
        paper: 'rgb(var(--rgb-paper) / <alpha-value>)',
        snow: 'rgb(var(--rgb-snow) / <alpha-value>)',
        mist: 'rgb(var(--rgb-mist) / <alpha-value>)',
        signal: {
          DEFAULT: 'rgb(var(--rgb-signal) / <alpha-value>)',
          hover: 'rgb(var(--rgb-signal-hover) / <alpha-value>)',
        },
        /* Legacy aliases - same roles as ink / paper */
        navy: 'rgb(var(--rgb-ink) / <alpha-value>)',
        surface: 'rgb(var(--rgb-paper) / <alpha-value>)',
      },
      fontFamily: {
        display: ['"Bricolage Grotesque"', 'system-ui', 'sans-serif'],
        body: ['"Source Serif 4"', 'Georgia', 'serif'],
        sans: ['"IBM Plex Sans"', 'system-ui', 'sans-serif'],
      },
      transitionTimingFunction: {
        apple: 'cubic-bezier(0.16, 1, 0.3, 1)',
        outExpo: 'cubic-bezier(0.16, 1, 0.3, 1)',
      },
    },
  },
  plugins: [],
};
