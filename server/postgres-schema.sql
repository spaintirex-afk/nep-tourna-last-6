-- Nep Tourna PostgreSQL / Supabase schema
-- Run this in Supabase SQL Editor before deploying the PostgreSQL adapter.

create table if not exists users (
  id text primary key,
  "fullName" text not null,
  username text not null unique,
  email text not null unique,
  "passwordHash" text not null,
  phone text not null default '',
  "ffUid" text,
  "ffIgn" text,
  role text not null default 'player',
  status text not null default 'active',
  "createdAt" timestamptz not null,
  "avatarColor" text not null default '#1d4ed8'
);
create table if not exists wallets (
  "userId" text primary key references users(id) on delete cascade,
  available bigint not null default 0,
  pending bigint not null default 0,
  "totalDeposited" bigint not null default 0,
  "totalWithdrawn" bigint not null default 0,
  "totalSpent" bigint not null default 0
);
create table if not exists transactions (
  id text primary key,
  "userId" text not null references users(id) on delete cascade,
  amount bigint not null,
  type text not null,
  status text not null,
  "createdAt" timestamptz not null,
  description text not null default ''
);
create table if not exists meta (key text primary key, value text not null);
create table if not exists tournaments (
  id text primary key,
  data jsonb not null,
  "createdAt" timestamptz not null,
  name text not null
);
create table if not exists registrations (
  id text primary key,
  "tournamentId" text not null references tournaments(id) on delete cascade,
  "userId" text not null references users(id) on delete cascade,
  "joinedAt" timestamptz not null,
  status text not null default 'joined',
  unique ("tournamentId", "userId")
);
create table if not exists matches (
  id text primary key,
  "tournamentId" text not null references tournaments(id) on delete cascade,
  data jsonb not null
);
create table if not exists results (
  id text primary key,
  "matchId" text not null references matches(id) on delete cascade,
  "tournamentId" text not null references tournaments(id) on delete cascade,
  data jsonb not null
);
create table if not exists deposits (
  id text primary key,
  "userId" text not null references users(id) on delete cascade,
  amount bigint not null,
  status text not null,
  "createdAt" timestamptz not null,
  data jsonb not null
);
create table if not exists withdrawals (
  id text primary key,
  "userId" text not null references users(id) on delete cascade,
  amount bigint not null,
  status text not null,
  "createdAt" timestamptz not null,
  data jsonb not null
);
create table if not exists announcements (
  id text primary key,
  status text not null,
  "createdAt" timestamptz not null,
  data jsonb not null
);
create table if not exists tickets (
  id text primary key,
  "userId" text not null references users(id) on delete cascade,
  status text not null,
  "createdAt" timestamptz not null,
  data jsonb not null
);
create table if not exists audit_logs (
  id text primary key,
  timestamp timestamptz not null,
  category text not null,
  data jsonb not null
);
create table if not exists notifications (
  id text primary key,
  "userId" text not null,
  read boolean not null default false,
  "createdAt" timestamptz not null,
  data jsonb not null
);
create table if not exists settings (
  id integer primary key check (id = 1),
  data jsonb not null
);
create table if not exists sessions (
  token text primary key,
  "userId" text not null references users(id) on delete cascade,
  "createdAt" timestamptz not null,
  "expiresAt" timestamptz not null
);

create index if not exists idx_tx_user on transactions("userId");
create index if not exists idx_reg_tournament on registrations("tournamentId");
create index if not exists idx_reg_user on registrations("userId");
create index if not exists idx_notif_user on notifications("userId");
create index if not exists idx_sessions_user on sessions("userId");
create index if not exists idx_tournaments_created on tournaments("createdAt" desc);
create index if not exists idx_announcements_created on announcements("createdAt" desc);
create index if not exists idx_deposits_created on deposits("createdAt" desc);
create index if not exists idx_withdrawals_created on withdrawals("createdAt" desc);

-- Required for secure server-side access: the Nep Tourna API should use the
-- Supabase/Postgres connection string from Vercel Environment Variables.
-- Do not put DATABASE_URL in source control.
