/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,ts}'],
  theme: {
    extend: {
      colors: {
        ink: '#0B1220',
        paper: '#EEF0F2',
        snow: '#FFFFFF',
        mist: '#D8DCE0',
        signal: {
          DEFAULT: '#0F766E',
          hover: '#0D9488',
        },
        /* Legacy aliases - same hex as ink / paper */
        navy: '#0B1220',
        surface: '#EEF0F2',
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
