import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// In dev, the Vite server proxies API + real-time calls to the Express backend
// so the browser sees a single origin (session cookie + SSE work unchanged).
export default defineConfig({
  // GitHub Pages can serve the app from either / or /<repository>/.
  // Relative asset URLs keep the build working in both cases.
  base: './',
  plugins: [react()],
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
      },
    },
  },
})
