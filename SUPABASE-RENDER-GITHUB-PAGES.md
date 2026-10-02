# Nep Tourna — Supabase + Render + GitHub Pages

## IMPORTANT: current database status

This package contains the Nep Tourna PostgreSQL/Supabase schema in `server/postgres-schema.sql`, but the current Express server implementation still uses `better-sqlite3`.

Therefore:

- GitHub Pages can host the frontend.
- Render can host the current Express API.
- Supabase can hold the prepared PostgreSQL schema.
- **Do not set `DATABASE_URL` on the current server expecting it to switch from SQLite to PostgreSQL. It will not.**

A separate SQLite-to-PostgreSQL backend migration is required before the existing API can use Supabase as its database.

## Safe deployment order

1. Create/run `server/postgres-schema.sql` in Supabase SQL Editor.
2. Put the project in GitHub.
3. Set GitHub Pages source to GitHub Actions.
4. Set GitHub Actions repository variable `VITE_API_URL` to the public backend URL.
5. Deploy the existing Express API to Render using `server/` as the root directory.
6. Set `CORS_ORIGINS` on Render to the GitHub Pages origin.
7. Keep database credentials only on the backend.
8. Before using production data, migrate `server/db.js`, `server/repo.js`, `server/actions.js`, and `server/state.js` from synchronous SQLite calls to asynchronous PostgreSQL queries.

## GitHub Pages variable

Repository → Settings → Secrets and variables → Actions → Variables:

`VITE_API_URL=https://YOUR-BACKEND.onrender.com`

## Render variables

Set these in Render → Environment:

- `DATABASE_URL` = Supabase PostgreSQL connection string (for the migrated PostgreSQL backend)
- `CORS_ORIGINS` = `https://YOUR-USERNAME.github.io`
- `ADMIN_EMAIL` = your admin email
- `ADMIN_PASSWORD` = a strong production password

## Security

Never commit:

- Supabase database passwords
- `DATABASE_URL`
- service-role keys
- production admin passwords

The browser should know only the public API URL, not the PostgreSQL connection string.
