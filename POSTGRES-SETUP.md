# Nep Tourna PostgreSQL / Supabase setup

This package contains the PostgreSQL schema required for the shared production database.

## Important

The existing Nep Tourna server code in this ZIP is still the original synchronous SQLite implementation. The SQL schema is prepared, but **do not deploy this ZIP as the final PostgreSQL version yet**. The application database adapter and its async request flow still need to be migrated before SQLite is removed.

## Supabase setup

1. Create a Supabase project.
2. Open **SQL Editor**.
3. Copy everything from `server/postgres-schema.sql` and run it.
4. In Supabase, obtain the PostgreSQL connection string.
5. In Vercel → Project → Settings → Environment Variables, add:
   - `DATABASE_URL` = your PostgreSQL connection string
   - `ADMIN_EMAIL` = `admin@neptourna.local`
   - `ADMIN_PASSWORD` = `admin@5678_9`
6. Do not commit the real `DATABASE_URL` to GitHub.

## Next application migration

The final production adapter must replace the current `better-sqlite3` calls with PostgreSQL queries and async transactions. This is necessary because the current server uses synchronous SQLite APIs throughout `server/actions.js`, `server/repo.js`, and `server/state.js`.
