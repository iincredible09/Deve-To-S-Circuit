/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        circuit: {
          50: '#eff6ff',
          100: '#dbeafe',
          200: '#bfdbfe',
          300: '#93c5fd',
          400: '#60a5fa',
          500: '#3b82f6',
          600: '#2563eb', // Royal Blue Primary
          700: '#1d4ed8',
          800: '#1e40af', // Deep Royal Blue
          900: '#1e3a8a',
          950: '#0b1945',
        },
        royal: {
          light: '#3b82f6',
          DEFAULT: '#1d4ed8',
          deep: '#1e3a8a',
          glow: '#60a5fa',
        },
        cyber: {
          accent: '#06b6d4',
          purple: '#8b5cf6',
          green: '#10b981',
          slate: '#0f172a',
        }
      },
      boxShadow: {
        'circuit-glow': '0 0 25px -5px rgba(37, 99, 235, 0.35)',
        'circuit-hover': '0 10px 30px -10px rgba(29, 78, 216, 0.45)',
        'circuit-cyan': '0 0 20px -3px rgba(6, 182, 212, 0.3)',
      },
      backgroundImage: {
        'circuit-pattern': "radial-gradient(#2563eb 0.75px, transparent 0.75px), radial-gradient(#2563eb 0.75px, #ffffff 0.75px)",
      },
      animation: {
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'float': 'float 4s ease-in-out infinite',
      },
      keyframes: {
        float: {
          '0%, 100%': { transform: 'translateY(0px)' },
          '50%': { transform: 'translateY(-6px)' },
        }
      }
    },
  },
  plugins: [],
}
