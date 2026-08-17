# Layout reservation deployment

The repository implementation is complete, but production still requires the
database and Edge Function deployment steps below. Run them in a staging
project first and keep a database backup.

## 1. Preflight

The infrastructure migration intentionally stops if a table key is duplicated
across floors in one daily layout. Locate conflicts before deployment:

```sql
select f.venue_daily_layout_id, t.table_key, count(*)
from public.venue_daily_layout_tables t
join public.venue_daily_layout_floors f
  on f.id = t.venue_daily_layout_floor_id
group by f.venue_daily_layout_id, t.table_key
having count(*) > 1;

select venue_id, date, count(*)
from public.venue_daily_layouts
group by venue_id, date
having count(*) > 1;

select user_id, venue_id, date, count(*)
from public.active_reservations
group by user_id, venue_id, date
having count(*) > 1;
```

Resolve each conflict according to the source-of-truth data; do not delete rows
automatically.

## 2. Database migrations

Apply migrations in timestamp order:

1. `20260805230000_toggle_table_reservation.sql`
2. `20260808000000_reapply_secure_toggle_table_reservation.sql`
3. `20260808010000_layout_reservation_infrastructure.sql`

The last migration adds integrity constraints, RLS, private slip storage,
payment submission/finalization, expiration cleanup, realtime publication, and
the cleanup cron when `pg_cron` is available.

## 3. Verification webhook

Set a long random secret and deploy the function:

```bash
supabase secrets set SLIP_VERIFICATION_WEBHOOK_SECRET='<random-secret>'
supabase functions deploy verify-payment-for-reservation --no-verify-jwt
```

The trusted slip verifier must call the deployed function with:

- header `x-verification-secret: <random-secret>`
- JSON fields `reservation_bill_id`, `approved`, and optional `tx_ref`,
  `slip_hash`

This endpoint does not inspect bank slips itself. It is the authenticated bridge
from the team's existing verifier to the database-only finalization RPC.

## 4. Smoke checks

Using two test customer accounts, verify that one account cannot toggle or read
the other's active reservation, simultaneous claims produce one winner, expired
holds are released, a rejected slip releases tables, and an approved slip sets
the bill/reservation/table state to `paid`/`reserved`/`reserved`.
