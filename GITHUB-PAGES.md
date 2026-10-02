# Nep Tourna — GitHub Pages deployment

## Important architecture note

GitHub Pages hosts static files only. It cannot run the Express server, SQLite database, PostgreSQL database, sessions, deposits, withdrawals, admin actions, or real-time SSE by itself.

This project has therefore been prepared so the React/Vite frontend can live on GitHub Pages while the existing Nep Tourna API runs on a separate backend host.

## Changes made

- Vite uses `base: './'` so assets work from a GitHub Pages repository path.
- React Router uses `HashRouter`, so routes such as `#/dashboard` do not require server-side rewrites.
- `VITE_API_URL` can point the frontend to an external Nep Tourna API.
- Added `.github/workflows/deploy-pages.yml` for automatic GitHub Pages deployment.

## Deploy

1. Create a GitHub repository and upload this project.
2. In the repository, open **Settings → Pages** and select **GitHub Actions** as the source.
3. Deploy your Nep Tourna API/backend separately.
4. In **Settings → Secrets and variables → Actions → Variables**, create:
   - Name: `VITE_API_URL`
   - Value: your public API URL, for example `https://api.example.com`
5. On the backend, set `CORS_ORIGINS` to the exact GitHub Pages origin, for example:
   `https://YOUR-USERNAME.github.io`
   If the project is hosted under a repository path, the origin is still only `https://YOUR-USERNAME.github.io`.
6. Push to `main`. The workflow builds `dist/` and deploys it.

## URL format

Because the app uses hash routing, a page will look like:

`https://YOUR-USERNAME.github.io/YOUR-REPOSITORY/#/login`

## PostgreSQL note

The supplied ZIP is **not yet a PostgreSQL runtime migration**. Its `server/` code still uses `better-sqlite3`. Do not put database credentials in the GitHub Pages frontend.

For a production deployment, migrate/host the API separately and connect that backend to PostgreSQL/Supabase.
