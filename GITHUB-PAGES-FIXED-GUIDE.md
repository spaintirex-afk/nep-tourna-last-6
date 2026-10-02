# Nep Tourna — GitHub Pages fixed package

## IMPORTANT
Upload the **contents of this folder** to the root of your GitHub repository.
Do NOT upload the `neptourna_final` folder itself as a nested folder.

The repository root must contain:
- `index.html`
- `package.json`
- `vite.config.ts`
- `.github/workflows/deploy-pages.yml`
- `src/`
- `server/`

## GitHub Pages
1. Create a GitHub repository.
2. Upload the contents of this package to the repository root.
3. Push to `main`.
4. GitHub → Settings → Pages → Source: **GitHub Actions**.
5. The workflow builds `dist/` and deploys it.
6. If you use an external backend, add repository variable:
   `VITE_API_URL=https://YOUR-BACKEND.onrender.com`

## Important backend note
GitHub Pages only hosts the frontend. The Express API must run separately (for example on Render).
The current server code in this package still uses SQLite; the included PostgreSQL/Supabase schema does not automatically switch the server to PostgreSQL.

## If you already deployed the old version
Do not manually upload `src/` to the Pages site. Push the fixed source to GitHub and let the GitHub Actions workflow build `dist/`.
