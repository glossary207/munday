-- Canonical infrastructure for customer layout reservations.
-- Apply after the base schema and 20260808000000 secure toggle RPC.

-- --------------------------------------------------------------------------
-- Data integrity
-- --------------------------------------------------------------------------
CREATE UNIQUE INDEX IF NOT EXISTS venue_daily_layouts_venue_date_uidx
  ON public.venue_daily_layouts (venue_id, date);

CREATE UNIQUE INDEX IF NOT EXISTS venue_daily_layout_floors_layout_key_uidx
  ON public.venue_daily_layout_floors (venue_daily_layout_id, floor_key);

CREATE UNIQUE INDEX IF NOT EXISTS venue_daily_layout_tables_floor_key_uidx
  ON public.venue_daily_layout_tables (venue_daily_layout_floor_id, table_key);

-- active_reservations stores table keys without floor ids, so a key must be
-- unique across the whole daily layout (not only inside one floor).
DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM public.venue_daily_layout_tables table_row
    JOIN public.venue_daily_layout_floors floor
      ON floor.id = table_row.venue_daily_layout_floor_id
    GROUP BY floor.venue_daily_layout_id, table_row.table_key
    HAVING count(*) > 1
  ) THEN
    RAISE EXCEPTION
      'Duplicate table_key values exist across floors in a daily layout; resolve them before applying this migration';
  END IF;
END;
$$;

CREATE OR REPLACE FUNCTION public.enforce_layout_table_key_uniqueness()
RETURNS trigger
LANGUAGE plpgsql
SET search_path = public, pg_temp
AS $$
DECLARE
  target_layout_id uuid;
BEGIN
  SELECT venue_daily_layout_id INTO target_layout_id
  FROM public.venue_daily_layout_floors
  WHERE id = NEW.venue_daily_layout_floor_id;

  IF target_layout_id IS NULL THEN
    RAISE EXCEPTION 'Layout floor % does not exist', NEW.venue_daily_layout_floor_id;
  END IF;

  -- Serialize checks across different floors; a per-floor unique index alone
  -- cannot prevent two concurrent inserts from choosing the same table key.
  PERFORM pg_advisory_xact_lock(hashtextextended(target_layout_id::text, 0));

  IF EXISTS (
    SELECT 1
    FROM public.venue_daily_layout_tables table_row
    JOIN public.venue_daily_layout_floors floor
      ON floor.id = table_row.venue_daily_layout_floor_id
    WHERE floor.venue_daily_layout_id = target_layout_id
      AND table_row.table_key = NEW.table_key
      AND table_row.id IS DISTINCT FROM NEW.id
  ) THEN
    RAISE EXCEPTION 'table_key % already exists in this daily layout', NEW.table_key;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS enforce_layout_table_key_uniqueness
  ON public.venue_daily_layout_tables;
CREATE TRIGGER enforce_layout_table_key_uniqueness
  BEFORE INSERT OR UPDATE OF venue_daily_layout_floor_id, table_key
  ON public.venue_daily_layout_tables
  FOR EACH ROW
  EXECUTE FUNCTION public.enforce_layout_table_key_uniqueness();

CREATE UNIQUE INDEX IF NOT EXISTS active_reservations_user_venue_date_uidx
  ON public.active_reservations (user_id, venue_id, date);

CREATE INDEX IF NOT EXISTS active_reservations_expiry_idx
  ON public.active_reservations (expires_at)
  WHERE status IN ('pending', 'payment_pending');

CREATE INDEX IF NOT EXISTS venue_daily_layout_tables_customer_status_idx
  ON public.venue_daily_layout_tables (customer_uid, status_code);

-- --------------------------------------------------------------------------
-- Staff authorization helpers
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.is_staff_of_venue(p_venue_id uuid)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.staff_venues sv
    JOIN public.staff_users su ON su.id = sv.staff_id
    WHERE sv.staff_id = auth.uid()
      AND sv.venue_id = p_venue_id
      AND COALESCE(sv.is_active, true)
      AND su.status = 'active'
  );
$$;

CREATE OR REPLACE FUNCTION public.has_venue_permission(
  p_venue_id uuid,
  p_permission text
) RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.staff_venues sv
    JOIN public.staff_users su ON su.id = sv.staff_id
    WHERE sv.staff_id = auth.uid()
      AND sv.venue_id = p_venue_id
      AND COALESCE(sv.is_active, true)
      AND su.status = 'active'
      AND (
        sv.role = 'owner'
        OR COALESCE((sv.permissions->'layout'->>p_permission)::boolean, false)
      )
  );
$$;

CREATE OR REPLACE FUNCTION public.has_bill_permission(
  p_venue_id uuid,
  p_permission text
) RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.staff_venues sv
    JOIN public.staff_users su ON su.id = sv.staff_id
    WHERE sv.staff_id = auth.uid()
      AND sv.venue_id = p_venue_id
      AND COALESCE(sv.is_active, true)
      AND su.status = 'active'
      AND (
        sv.role = 'owner'
        OR COALESCE((sv.permissions->'bill'->>p_permission)::boolean, false)
      )
  );
$$;

-- --------------------------------------------------------------------------
-- Canonical RLS. Customers read layout state but cannot write base tables.
-- All customer writes go through the security-definer RPCs below.
-- --------------------------------------------------------------------------
ALTER TABLE public.venue_daily_layouts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.venue_daily_layout_floors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.venue_daily_layout_tables ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.active_reservations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.staff_bills ENABLE ROW LEVEL SECURITY;

DO $$
DECLARE
  policy_record record;
BEGIN
  FOR policy_record IN
    SELECT schemaname, tablename, policyname
    FROM pg_policies
    WHERE schemaname = 'public'
      AND tablename IN (
        'venue_daily_layouts',
        'venue_daily_layout_floors',
        'venue_daily_layout_tables',
        'active_reservations',
        'staff_bills'
      )
  LOOP
    EXECUTE format(
      'DROP POLICY IF EXISTS %I ON %I.%I',
      policy_record.policyname,
      policy_record.schemaname,
      policy_record.tablename
    );
  END LOOP;
END;
$$;

CREATE POLICY layout_customer_read
  ON public.venue_daily_layouts
  FOR SELECT TO authenticated
  USING (true);

CREATE POLICY layout_staff_insert
  ON public.venue_daily_layouts
  FOR INSERT TO authenticated
  WITH CHECK (public.has_venue_permission(venue_id, 'edit_layout'));

CREATE POLICY layout_staff_update
  ON public.venue_daily_layouts
  FOR UPDATE TO authenticated
  USING (public.has_venue_permission(venue_id, 'edit_layout'))
  WITH CHECK (public.has_venue_permission(venue_id, 'edit_layout'));

CREATE POLICY layout_owner_delete
  ON public.venue_daily_layouts
  FOR DELETE TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.staff_venues sv
      WHERE sv.staff_id = auth.uid()
        AND sv.venue_id = venue_daily_layouts.venue_id
        AND sv.role = 'owner'
        AND COALESCE(sv.is_active, true)
    )
  );

CREATE POLICY floor_customer_read
  ON public.venue_daily_layout_floors
  FOR SELECT TO authenticated
  USING (true);

CREATE POLICY floor_staff_insert
  ON public.venue_daily_layout_floors
  FOR INSERT TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.venue_daily_layouts layout
      WHERE layout.id = venue_daily_layout_floors.venue_daily_layout_id
        AND public.has_venue_permission(layout.venue_id, 'edit_layout')
    )
  );

CREATE POLICY floor_staff_update
  ON public.venue_daily_layout_floors
  FOR UPDATE TO authenticated
  USING (
    EXISTS (
      SELECT 1
      FROM public.venue_daily_layouts layout
      WHERE layout.id = venue_daily_layout_floors.venue_daily_layout_id
        AND public.has_venue_permission(layout.venue_id, 'edit_layout')
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.venue_daily_layouts layout
      WHERE layout.id = venue_daily_layout_floors.venue_daily_layout_id
        AND public.has_venue_permission(layout.venue_id, 'edit_layout')
    )
  );

CREATE POLICY floor_owner_delete
  ON public.venue_daily_layout_floors
  FOR DELETE TO authenticated
  USING (
    EXISTS (
      SELECT 1
      FROM public.venue_daily_layouts layout
      JOIN public.staff_venues sv ON sv.venue_id = layout.venue_id
      WHERE layout.id = venue_daily_layout_floors.venue_daily_layout_id
        AND sv.staff_id = auth.uid()
        AND sv.role = 'owner'
        AND COALESCE(sv.is_active, true)
    )
  );

CREATE POLICY table_customer_read
  ON public.venue_daily_layout_tables
  FOR SELECT TO authenticated
  USING (true);

CREATE POLICY table_staff_insert
  ON public.venue_daily_layout_tables
  FOR INSERT TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.venue_daily_layout_floors floor
      JOIN public.venue_daily_layouts layout
        ON layout.id = floor.venue_daily_layout_id
      WHERE floor.id = venue_daily_layout_tables.venue_daily_layout_floor_id
        AND public.has_venue_permission(layout.venue_id, 'edit_layout')
    )
  );

CREATE POLICY table_staff_update
  ON public.venue_daily_layout_tables
  FOR UPDATE TO authenticated
  USING (
    EXISTS (
      SELECT 1
      FROM public.venue_daily_layout_floors floor
      JOIN public.venue_daily_layouts layout
        ON layout.id = floor.venue_daily_layout_id
      WHERE floor.id = venue_daily_layout_tables.venue_daily_layout_floor_id
        AND (
          public.has_venue_permission(layout.venue_id, 'edit_layout')
          OR public.has_venue_permission(layout.venue_id, 'edit_table_status')
        )
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.venue_daily_layout_floors floor
      JOIN public.venue_daily_layouts layout
        ON layout.id = floor.venue_daily_layout_id
      WHERE floor.id = venue_daily_layout_tables.venue_daily_layout_floor_id
        AND (
          public.has_venue_permission(layout.venue_id, 'edit_layout')
          OR public.has_venue_permission(layout.venue_id, 'edit_table_status')
        )
    )
  );

CREATE POLICY table_owner_delete
  ON public.venue_daily_layout_tables
  FOR DELETE TO authenticated
  USING (
    EXISTS (
      SELECT 1
      FROM public.venue_daily_layout_floors floor
      JOIN public.venue_daily_layouts layout
        ON layout.id = floor.venue_daily_layout_id
      JOIN public.staff_venues sv ON sv.venue_id = layout.venue_id
      WHERE floor.id = venue_daily_layout_tables.venue_daily_layout_floor_id
        AND sv.staff_id = auth.uid()
        AND sv.role = 'owner'
        AND COALESCE(sv.is_active, true)
    )
  );

CREATE POLICY active_reservations_read_own
  ON public.active_reservations
  FOR SELECT TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY staff_bills_read
  ON public.staff_bills
  FOR SELECT TO authenticated
  USING (public.has_bill_permission(venue_id, 'view'));

CREATE POLICY staff_bills_insert
  ON public.staff_bills
  FOR INSERT TO authenticated
  WITH CHECK (
    created_by_staff_uuid = auth.uid()
    AND public.is_staff_of_venue(venue_id)
  );

CREATE POLICY staff_bills_update
  ON public.staff_bills
  FOR UPDATE TO authenticated
  USING (public.is_staff_of_venue(venue_id))
  WITH CHECK (public.is_staff_of_venue(venue_id));

CREATE POLICY staff_bills_delete
  ON public.staff_bills
  FOR DELETE TO authenticated
  USING (public.is_staff_of_venue(venue_id));

REVOKE INSERT, UPDATE, DELETE ON public.venue_daily_layouts FROM anon, authenticated;
REVOKE INSERT, UPDATE, DELETE ON public.venue_daily_layout_floors FROM anon, authenticated;
REVOKE INSERT, UPDATE, DELETE ON public.venue_daily_layout_tables FROM anon, authenticated;
REVOKE INSERT, UPDATE, DELETE ON public.active_reservations FROM anon, authenticated;

GRANT SELECT ON public.venue_daily_layouts TO authenticated;
GRANT SELECT ON public.venue_daily_layout_floors TO authenticated;
GRANT SELECT ON public.venue_daily_layout_tables TO authenticated;
GRANT SELECT ON public.active_reservations TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.staff_bills TO authenticated;

-- Staff policies still require table privileges. These grants are constrained
-- by the RLS policies above.
GRANT INSERT, UPDATE, DELETE ON public.venue_daily_layouts TO authenticated;
GRANT INSERT, UPDATE, DELETE ON public.venue_daily_layout_floors TO authenticated;
GRANT INSERT, UPDATE, DELETE ON public.venue_daily_layout_tables TO authenticated;

-- --------------------------------------------------------------------------
-- Private reservation slip bucket
-- --------------------------------------------------------------------------
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'reservation-slips',
  'reservation-slips',
  false,
  10485760,
  ARRAY['image/jpeg', 'image/png', 'image/webp']
)
ON CONFLICT (id) DO UPDATE
SET public = false,
    file_size_limit = EXCLUDED.file_size_limit,
    allowed_mime_types = EXCLUDED.allowed_mime_types;

DROP POLICY IF EXISTS reservation_slips_insert_own ON storage.objects;
DROP POLICY IF EXISTS reservation_slips_select_own ON storage.objects;
DROP POLICY IF EXISTS reservation_slips_delete_own ON storage.objects;

CREATE POLICY reservation_slips_insert_own
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'reservation-slips'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

CREATE POLICY reservation_slips_select_own
  ON storage.objects FOR SELECT TO authenticated
  USING (
    bucket_id = 'reservation-slips'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

CREATE POLICY reservation_slips_delete_own
  ON storage.objects FOR DELETE TO authenticated
  USING (
    bucket_id = 'reservation-slips'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- --------------------------------------------------------------------------
-- Payment submission. Amount and table ownership are read from server state.
-- Slip verification remains asynchronous and must be performed by the
-- verify-payment-for-reservation Edge Function/service role.
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.update_legacy_reservation_status(
  p_node jsonb,
  p_table_ids text[],
  p_customer_uid text,
  p_status jsonb
) RETURNS jsonb
LANGUAGE plpgsql
IMMUTABLE
SET search_path = public, pg_temp
AS $$
DECLARE
  entry record;
  result jsonb := p_node;
  current_status jsonb;
BEGIN
  IF p_node IS NULL OR jsonb_typeof(p_node) <> 'object' THEN
    RETURN p_node;
  END IF;

  FOR entry IN SELECT key, value FROM jsonb_each(p_node)
  LOOP
    IF entry.key = ANY(p_table_ids)
      AND jsonb_typeof(entry.value) = 'object'
      AND entry.value ? 'status'
    THEN
      current_status := entry.value->'status';
      IF COALESCE(current_status->>'customer_uid', '') = p_customer_uid
        AND COALESCE(current_status->>'status_code', '') IN (
          'pending', 'payment_pending'
        )
      THEN
        result := jsonb_set(
          result,
          ARRAY[entry.key, 'status'],
          p_status,
          false
        );
      END IF;
    ELSIF jsonb_typeof(entry.value) = 'object' THEN
      result := jsonb_set(
        result,
        ARRAY[entry.key],
        public.update_legacy_reservation_status(
          entry.value,
          p_table_ids,
          p_customer_uid,
          p_status
        ),
        false
      );
    END IF;
  END LOOP;
  RETURN result;
END;
$$;

REVOKE ALL ON FUNCTION public.update_legacy_reservation_status(jsonb, text[], text, jsonb) FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.legacy_reservation_totals(
  p_node jsonb,
  p_table_ids text[],
  p_customer_uid text,
  p_status_code text
) RETURNS jsonb
LANGUAGE plpgsql
IMMUTABLE
SET search_path = public, pg_temp
AS $$
DECLARE
  entry record;
  nested_totals jsonb;
  matched_count integer := 0;
  total_amount numeric := 0;
  minimum_capacity integer := 0;
  maximum_capacity integer := 0;
BEGIN
  IF p_node IS NULL OR jsonb_typeof(p_node) <> 'object' THEN
    RETURN jsonb_build_object(
      'count', 0,
      'amount', 0,
      'minimum_capacity', 0,
      'maximum_capacity', 0
    );
  END IF;

  FOR entry IN SELECT key, value FROM jsonb_each(p_node)
  LOOP
    IF entry.key = ANY(p_table_ids)
      AND jsonb_typeof(entry.value) = 'object'
      AND entry.value ? 'status'
      AND COALESCE(entry.value->'status'->>'customer_uid', '') = p_customer_uid
      AND COALESCE(entry.value->'status'->>'status_code', '') = p_status_code
    THEN
      matched_count := matched_count + 1;
      total_amount := total_amount + COALESCE(
        (entry.value->>'price')::numeric,
        (entry.value->'meta'->>'price')::numeric,
        0
      );
      minimum_capacity := minimum_capacity + COALESCE(
        (entry.value->>'min_capacity')::integer,
        (entry.value->>'min_seat')::integer,
        (entry.value->'meta'->>'min_capacity')::integer,
        (entry.value->'meta'->>'min_seat')::integer,
        0
      );
      maximum_capacity := maximum_capacity + COALESCE(
        (entry.value->>'max_capacity')::integer,
        (entry.value->>'max_seat')::integer,
        (entry.value->'meta'->>'max_capacity')::integer,
        (entry.value->'meta'->>'max_seat')::integer,
        0
      );
    ELSIF jsonb_typeof(entry.value) = 'object' THEN
      nested_totals := public.legacy_reservation_totals(
        entry.value,
        p_table_ids,
        p_customer_uid,
        p_status_code
      );
      matched_count := matched_count + COALESCE(
        (nested_totals->>'count')::integer,
        0
      );
      total_amount := total_amount + COALESCE(
        (nested_totals->>'amount')::numeric,
        0
      );
      minimum_capacity := minimum_capacity + COALESCE(
        (nested_totals->>'minimum_capacity')::integer,
        0
      );
      maximum_capacity := maximum_capacity + COALESCE(
        (nested_totals->>'maximum_capacity')::integer,
        0
      );
    END IF;
  END LOOP;

  RETURN jsonb_build_object(
    'count', matched_count,
    'amount', total_amount,
    'minimum_capacity', minimum_capacity,
    'maximum_capacity', maximum_capacity
  );
END;
$$;

REVOKE ALL ON FUNCTION public.legacy_reservation_totals(jsonb, text[], text, text) FROM PUBLIC, anon, authenticated;

-- Returns the amount/capacity from authoritative layout rows before the user
-- transfers money. submit_reservation_payment recalculates everything again
-- under locks, so this quote cannot be used to bypass final validation.
CREATE OR REPLACE FUNCTION public.get_reservation_payment_quote(
  p_venue_id uuid,
  p_date text
) RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  caller_uid uuid := auth.uid();
  reservation_row public.active_reservations%ROWTYPE;
  layout_id uuid;
  layout_data jsonb;
  normalized_layout boolean;
  matched_tables integer;
  server_amount numeric;
  minimum_party_size integer;
  maximum_party_size integer;
  totals jsonb;
BEGIN
  IF caller_uid IS NULL THEN
    RAISE EXCEPTION 'Authentication required' USING ERRCODE = '42501';
  END IF;

  SELECT * INTO reservation_row
  FROM public.active_reservations
  WHERE user_id = caller_uid
    AND venue_id = p_venue_id
    AND date = p_date::date;
  IF NOT FOUND OR reservation_row.status NOT IN ('pending', 'payment_pending') THEN
    RAISE EXCEPTION 'No payable reservation found';
  END IF;
  IF reservation_row.expires_at IS NULL OR reservation_row.expires_at <= now() THEN
    RAISE EXCEPTION 'Reservation has expired';
  END IF;

  SELECT id, other_data INTO layout_id, layout_data
  FROM public.venue_daily_layouts
  WHERE venue_id = p_venue_id AND date = p_date::date;
  IF layout_id IS NULL THEN
    RAISE EXCEPTION 'Daily layout was not found';
  END IF;

  SELECT EXISTS (
    SELECT 1 FROM public.venue_daily_layout_floors
    WHERE venue_daily_layout_id = layout_id
  ) INTO normalized_layout;

  IF normalized_layout THEN
    SELECT
      count(*),
      COALESCE(sum(COALESCE((table_row.meta->>'price')::numeric, 0)), 0),
      COALESCE(sum(COALESCE(
        table_row.min_capacity,
        (table_row.meta->>'min_capacity')::integer,
        (table_row.meta->>'min_seat')::integer,
        0
      )), 0),
      COALESCE(sum(COALESCE(
        table_row.max_capacity,
        table_row.capacity,
        (table_row.meta->>'max_capacity')::integer,
        (table_row.meta->>'max_seat')::integer,
        0
      )), 0)
    INTO matched_tables, server_amount, minimum_party_size, maximum_party_size
    FROM public.venue_daily_layout_tables table_row
    JOIN public.venue_daily_layout_floors floor
      ON floor.id = table_row.venue_daily_layout_floor_id
    WHERE floor.venue_daily_layout_id = layout_id
      AND table_row.table_key = ANY(reservation_row.table_ids::text[])
      AND table_row.status_code = reservation_row.status
      AND table_row.customer_uid = caller_uid::text;
  ELSE
    totals := public.legacy_reservation_totals(
      layout_data,
      reservation_row.table_ids::text[],
      caller_uid::text,
      reservation_row.status
    );
    matched_tables := COALESCE((totals->>'count')::integer, 0);
    server_amount := COALESCE((totals->>'amount')::numeric, 0);
    minimum_party_size := COALESCE(
      (totals->>'minimum_capacity')::integer,
      0
    );
    maximum_party_size := COALESCE(
      (totals->>'maximum_capacity')::integer,
      0
    );
  END IF;

  IF matched_tables <> cardinality(reservation_row.table_ids::text[]) THEN
    RAISE EXCEPTION 'One or more selected tables no longer match the reservation';
  END IF;

  RETURN jsonb_build_object(
    'success', true,
    'status', reservation_row.status,
    'bill_id', reservation_row.bill_id,
    'table_ids', reservation_row.table_ids,
    'amount', server_amount,
    'minimum_party_size', minimum_party_size,
    'maximum_party_size', maximum_party_size,
    'expires_at', reservation_row.expires_at
  );
END;
$$;

REVOKE ALL ON FUNCTION public.get_reservation_payment_quote(uuid, text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_reservation_payment_quote(uuid, text) TO authenticated;

CREATE OR REPLACE FUNCTION public.submit_reservation_payment(
  p_venue_id uuid,
  p_date text,
  p_table_ids text[],
  p_party_size integer,
  p_slip_path text
) RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, storage, pg_temp
AS $$
DECLARE
  caller_uid uuid := auth.uid();
  reservation_row public.active_reservations%ROWTYPE;
  pending_key text;
  pending_data jsonb;
  expected_tables text[];
  server_amount numeric;
  new_bill_id uuid;
  layout_id uuid;
  matched_tables integer;
  normalized_layout boolean;
  payment_status jsonb;
  minimum_party_size integer;
  maximum_party_size integer;
  layout_data jsonb;
  legacy_totals jsonb;
BEGIN
  IF caller_uid IS NULL THEN
    RAISE EXCEPTION 'Authentication required' USING ERRCODE = '42501';
  END IF;
  IF p_party_size IS NULL OR p_party_size < 1 THEN
    RAISE EXCEPTION 'Party size must be greater than zero';
  END IF;
  IF p_table_ids IS NULL OR cardinality(p_table_ids) = 0 THEN
    RAISE EXCEPTION 'At least one table is required';
  END IF;
  IF split_part(p_slip_path, '/', 1) <> caller_uid::text OR NOT EXISTS (
    SELECT 1 FROM storage.objects object
    WHERE object.bucket_id = 'reservation-slips'
      AND object.name = p_slip_path
      AND object.owner_id = caller_uid::text
  ) THEN
    RAISE EXCEPTION 'Slip upload is missing or does not belong to the caller';
  END IF;

  SELECT * INTO reservation_row
  FROM public.active_reservations
  WHERE user_id = caller_uid
    AND venue_id = p_venue_id
    AND date = p_date::date
  FOR UPDATE;

  IF NOT FOUND OR reservation_row.status <> 'pending' THEN
    RAISE EXCEPTION 'No pending reservation found';
  END IF;
  IF reservation_row.expires_at IS NULL OR reservation_row.expires_at <= now() THEN
    RAISE EXCEPTION 'Reservation has expired';
  END IF;

  SELECT array_agg(value ORDER BY value) INTO expected_tables
  FROM unnest(reservation_row.table_ids::text[]) value;
  IF expected_tables IS DISTINCT FROM (
    SELECT array_agg(value ORDER BY value) FROM unnest(p_table_ids) value
  ) THEN
    RAISE EXCEPTION 'Table selection does not match the active reservation';
  END IF;

  pending_key := p_venue_id::text || '_' || p_date;
  SELECT pending_reservations->pending_key INTO pending_data
  FROM public.users
  WHERE id = caller_uid
  FOR UPDATE;
  IF pending_data IS NULL THEN
    RAISE EXCEPTION 'Pending reservation summary is missing';
  END IF;

  SELECT id, other_data INTO layout_id, layout_data
  FROM public.venue_daily_layouts
  WHERE venue_id = p_venue_id AND date = p_date::date
  FOR UPDATE;

  IF layout_id IS NULL THEN
    RAISE EXCEPTION 'Daily layout was not found';
  END IF;

  SELECT EXISTS (
    SELECT 1 FROM public.venue_daily_layout_floors
    WHERE venue_daily_layout_id = layout_id
  ) INTO normalized_layout;

  IF normalized_layout THEN
    SELECT
      count(*),
      COALESCE(sum(COALESCE((table_row.meta->>'price')::numeric, 0)), 0),
      COALESCE(sum(COALESCE(
        table_row.min_capacity,
        (table_row.meta->>'min_capacity')::integer,
        (table_row.meta->>'min_seat')::integer,
        0
      )), 0),
      COALESCE(sum(COALESCE(
        table_row.max_capacity,
        table_row.capacity,
        (table_row.meta->>'max_capacity')::integer,
        (table_row.meta->>'max_seat')::integer,
        0
      )), 0)
    INTO matched_tables, server_amount, minimum_party_size, maximum_party_size
    FROM public.venue_daily_layout_tables table_row
    JOIN public.venue_daily_layout_floors floor
      ON floor.id = table_row.venue_daily_layout_floor_id
    WHERE floor.venue_daily_layout_id = layout_id
      AND table_row.table_key = ANY(p_table_ids)
      AND table_row.status_code = 'pending'
      AND table_row.customer_uid = caller_uid::text;
  ELSE
    legacy_totals := public.legacy_reservation_totals(
      layout_data,
      p_table_ids,
      caller_uid::text,
      'pending'
    );
    matched_tables := COALESCE((legacy_totals->>'count')::integer, 0);
    server_amount := COALESCE((legacy_totals->>'amount')::numeric, 0);
    minimum_party_size := COALESCE(
      (legacy_totals->>'minimum_capacity')::integer,
      0
    );
    maximum_party_size := COALESCE(
      (legacy_totals->>'maximum_capacity')::integer,
      0
    );
  END IF;

  IF matched_tables <> cardinality(p_table_ids) THEN
    RAISE EXCEPTION 'One or more selected tables are no longer pending';
  END IF;
  IF minimum_party_size > 0 AND p_party_size < minimum_party_size THEN
    RAISE EXCEPTION 'Party size is below the selected tables minimum capacity (%)',
      minimum_party_size;
  END IF;
  IF maximum_party_size > 0 AND p_party_size > maximum_party_size THEN
    RAISE EXCEPTION 'Party size exceeds the selected tables maximum capacity (%)',
      maximum_party_size;
  END IF;

  INSERT INTO public.reservation_bills (
    venue_id,
    paid_by,
    created_by,
    service_day,
    party_size,
    table_ids,
    amount,
    status,
    bill_type,
    slip_data,
    created_by_role,
    booking_verified
  ) VALUES (
    p_venue_id,
    caller_uid,
    caller_uid,
    p_date::date,
    p_party_size,
    p_table_ids,
    server_amount,
    'pending',
    'reservation',
    jsonb_build_object('bucket', 'reservation-slips', 'path', p_slip_path),
    'customer',
    false
  ) RETURNING id INTO new_bill_id;

  UPDATE public.active_reservations
  SET status = 'payment_pending',
      bill_id = new_bill_id,
      expires_at = now() + interval '15 minutes',
      updated_at = now()
  WHERE id = reservation_row.id;

  UPDATE public.venue_daily_layout_tables table_row
  SET status_code = 'payment_pending',
      status_action_timestamp = (extract(epoch FROM now()) * 1000)::bigint,
      status_extra = COALESCE(table_row.status_extra, '{}'::jsonb) ||
        jsonb_build_object('reservation_bill_id', new_bill_id),
      updated_at = now()
  FROM public.venue_daily_layout_floors floor
  WHERE floor.id = table_row.venue_daily_layout_floor_id
    AND floor.venue_daily_layout_id = layout_id
    AND table_row.table_key = ANY(p_table_ids)
    AND table_row.customer_uid = caller_uid::text
    AND table_row.status_code = 'pending';

  IF NOT normalized_layout THEN
    payment_status := jsonb_build_object(
      'status_code', 'payment_pending',
      'customer_uid', caller_uid::text,
      'reservation_bill_id', new_bill_id,
      'status_action_timestamp',
        (extract(epoch FROM now()) * 1000)::bigint
    );
    UPDATE public.venue_daily_layouts
    SET other_data = public.update_legacy_reservation_status(
          other_data,
          p_table_ids,
          caller_uid::text,
          payment_status
        ),
        updated_at = now()
    WHERE id = layout_id;
  END IF;

  UPDATE public.users
  SET pending_reservations = jsonb_set(
    pending_reservations,
    ARRAY[pending_key],
    pending_data || jsonb_build_object(
      'status', 'payment_pending',
      'reservationBillId', new_bill_id,
      'updatedAt', now()
    )
  )
  WHERE id = caller_uid;

  RETURN jsonb_build_object(
    'success', true,
    'reservation_bill_id', new_bill_id,
    'status', 'payment_pending',
    'amount', server_amount
  );
END;
$$;

REVOKE ALL ON FUNCTION public.submit_reservation_payment(uuid, text, text[], integer, text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.submit_reservation_payment(uuid, text, text[], integer, text) FROM anon;
GRANT EXECUTE ON FUNCTION public.submit_reservation_payment(uuid, text, text[], integer, text) TO authenticated;

-- Called only by the trusted slip-verification service after it has verified
-- the bank transaction. This function performs the final state transition.
CREATE OR REPLACE FUNCTION public.verify_reservation_payment(
  p_reservation_bill_id uuid,
  p_approved boolean,
  p_tx_ref text DEFAULT NULL,
  p_slip_hash text DEFAULT NULL
) RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  bill_row public.reservation_bills%ROWTYPE;
  reservation_row public.active_reservations%ROWTYPE;
  pending_key text;
  final_status jsonb;
BEGIN
  IF p_approved IS NULL THEN
    RAISE EXCEPTION 'Approval result is required';
  END IF;

  -- Lock active_reservations before reservation_bills, matching the cleanup
  -- function's lock order and avoiding verifier/expiry deadlocks.
  SELECT * INTO reservation_row
  FROM public.active_reservations
  WHERE bill_id = p_reservation_bill_id
  FOR UPDATE;
  IF NOT FOUND THEN
    SELECT * INTO bill_row
    FROM public.reservation_bills
    WHERE id = p_reservation_bill_id
    FOR UPDATE;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'Reservation bill was not found';
    END IF;
    IF (p_approved AND bill_row.status = 'paid')
      OR (NOT p_approved AND bill_row.status = 'cancelled')
    THEN
      RETURN jsonb_build_object(
        'success', true,
        'reservation_bill_id', p_reservation_bill_id,
        'status', bill_row.status,
        'already_processed', true
      );
    END IF;
    RAISE EXCEPTION 'Active reservation is not awaiting payment';
  END IF;

  SELECT * INTO bill_row
  FROM public.reservation_bills
  WHERE id = p_reservation_bill_id
  FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Reservation bill was not found';
  END IF;
  IF bill_row.status <> 'pending' THEN
    IF (p_approved AND bill_row.status = 'paid')
      OR (NOT p_approved AND bill_row.status = 'cancelled')
    THEN
      RETURN jsonb_build_object(
        'success', true,
        'reservation_bill_id', p_reservation_bill_id,
        'status', bill_row.status,
        'already_processed', true
      );
    END IF;
    RAISE EXCEPTION 'Reservation bill is not pending';
  END IF;
  IF reservation_row.status <> 'payment_pending' THEN
    RAISE EXCEPTION 'Active reservation is not awaiting payment';
  END IF;

  pending_key := reservation_row.venue_id::text || '_' ||
    reservation_row.date::text;

  IF p_approved THEN
    UPDATE public.reservation_bills
    SET status = 'paid',
        booking_verified = true,
        tx_ref = p_tx_ref,
        slip_hash = p_slip_hash,
        paid_at = now()
    WHERE id = p_reservation_bill_id;

    UPDATE public.active_reservations
    SET status = 'reserved',
        expires_at = NULL,
        updated_at = now()
    WHERE id = reservation_row.id;

    UPDATE public.venue_daily_layout_tables table_row
    SET status_code = 'reserved',
        status_action_timestamp = (extract(epoch FROM now()) * 1000)::bigint,
        status_extra = COALESCE(table_row.status_extra, '{}'::jsonb) ||
          jsonb_build_object('reservation_bill_id', p_reservation_bill_id),
        updated_at = now()
    FROM public.venue_daily_layout_floors floor
    JOIN public.venue_daily_layouts layout
      ON layout.id = floor.venue_daily_layout_id
    WHERE floor.id = table_row.venue_daily_layout_floor_id
      AND layout.venue_id = reservation_row.venue_id
      AND layout.date = reservation_row.date
      AND table_row.table_key = ANY(reservation_row.table_ids::text[])
      AND table_row.customer_uid = reservation_row.user_id::text
      AND table_row.status_code = 'payment_pending';

    final_status := jsonb_build_object(
      'status_code', 'reserved',
      'customer_uid', reservation_row.user_id::text,
      'reservation_bill_id', p_reservation_bill_id,
      'status_action_timestamp',
        (extract(epoch FROM now()) * 1000)::bigint
    );
    UPDATE public.venue_daily_layouts layout
    SET other_data = public.update_legacy_reservation_status(
          layout.other_data,
          reservation_row.table_ids::text[],
          reservation_row.user_id::text,
          final_status
        ),
        updated_at = now()
    WHERE layout.venue_id = reservation_row.venue_id
      AND layout.date = reservation_row.date;

    UPDATE public.users
    SET pending_reservations = COALESCE(
      pending_reservations,
      '{}'::jsonb
    ) - pending_key
    WHERE id = reservation_row.user_id;
  ELSE
    UPDATE public.reservation_bills
    SET status = 'cancelled',
        tx_ref = p_tx_ref,
        slip_hash = p_slip_hash
    WHERE id = p_reservation_bill_id;

    UPDATE public.venue_daily_layout_tables table_row
    SET status_code = 'available',
        customer_uid = NULL,
        staff_bill_id = NULL,
        status_action_timestamp = (extract(epoch FROM now()) * 1000)::bigint,
        status_extra = '{}'::jsonb,
        updated_at = now()
    FROM public.venue_daily_layout_floors floor
    JOIN public.venue_daily_layouts layout
      ON layout.id = floor.venue_daily_layout_id
    WHERE floor.id = table_row.venue_daily_layout_floor_id
      AND layout.venue_id = reservation_row.venue_id
      AND layout.date = reservation_row.date
      AND table_row.table_key = ANY(reservation_row.table_ids::text[])
      AND table_row.customer_uid = reservation_row.user_id::text
      AND table_row.status_code = 'payment_pending';

    final_status := jsonb_build_object(
      'status_code', 'available',
      'customer_uid', '',
      'booking_id', '',
      'customer_name', '',
      'status_action_timestamp',
        (extract(epoch FROM now()) * 1000)::bigint
    );
    UPDATE public.venue_daily_layouts layout
    SET other_data = public.update_legacy_reservation_status(
          layout.other_data,
          reservation_row.table_ids::text[],
          reservation_row.user_id::text,
          final_status
        ),
        updated_at = now()
    WHERE layout.venue_id = reservation_row.venue_id
      AND layout.date = reservation_row.date;

    UPDATE public.users
    SET pending_reservations = pending_reservations - pending_key
    WHERE id = reservation_row.user_id;
    DELETE FROM public.active_reservations WHERE id = reservation_row.id;
  END IF;

  RETURN jsonb_build_object(
    'success', true,
    'reservation_bill_id', p_reservation_bill_id,
    'status', CASE WHEN p_approved THEN 'reserved' ELSE 'cancelled' END
  );
END;
$$;

REVOKE ALL ON FUNCTION public.verify_reservation_payment(uuid, boolean, text, text) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.verify_reservation_payment(uuid, boolean, text, text) TO service_role;

-- --------------------------------------------------------------------------
-- Expiry cleanup. active_reservations.expires_at is the single source of truth.
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.cleanup_expired_layout_reservations(
  p_batch_size integer DEFAULT 200
) RETURNS integer
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  expired_row record;
  pending_key text;
  cleaned_count integer := 0;
BEGIN
  FOR expired_row IN
    SELECT reservation.*
    FROM public.active_reservations reservation
    WHERE reservation.status IN ('pending', 'payment_pending')
      AND reservation.expires_at <= now()
    ORDER BY reservation.expires_at
    FOR UPDATE SKIP LOCKED
    LIMIT GREATEST(1, LEAST(COALESCE(p_batch_size, 200), 1000))
  LOOP
    UPDATE public.venue_daily_layout_tables table_row
    SET status_code = 'available',
        customer_uid = NULL,
        staff_bill_id = NULL,
        status_action_timestamp = (extract(epoch FROM now()) * 1000)::bigint,
        status_extra = '{}'::jsonb,
        updated_at = now()
    FROM public.venue_daily_layout_floors floor
    JOIN public.venue_daily_layouts layout
      ON layout.id = floor.venue_daily_layout_id
    WHERE floor.id = table_row.venue_daily_layout_floor_id
      AND layout.venue_id = expired_row.venue_id
      AND layout.date = expired_row.date
      AND table_row.table_key = ANY(expired_row.table_ids::text[])
      AND table_row.customer_uid = expired_row.user_id::text
      AND table_row.status_code IN ('pending', 'payment_pending');

    UPDATE public.venue_daily_layouts layout
    SET other_data = public.update_legacy_reservation_status(
          layout.other_data,
          expired_row.table_ids::text[],
          expired_row.user_id::text,
          jsonb_build_object(
            'status_code', 'available',
            'customer_uid', '',
            'booking_id', '',
            'customer_name', '',
            'status_action_timestamp',
              (extract(epoch FROM now()) * 1000)::bigint
          )
        ),
        updated_at = now()
    WHERE layout.venue_id = expired_row.venue_id
      AND layout.date = expired_row.date;

    pending_key := expired_row.venue_id::text || '_' || expired_row.date::text;
    UPDATE public.users
    SET pending_reservations = COALESCE(pending_reservations, '{}'::jsonb) - pending_key
    WHERE id = expired_row.user_id;

    IF expired_row.bill_id IS NOT NULL THEN
      UPDATE public.reservation_bills
      SET status = 'cancelled'
      WHERE id = expired_row.bill_id AND status = 'pending';
    END IF;

    DELETE FROM public.active_reservations WHERE id = expired_row.id;
    cleaned_count := cleaned_count + 1;
  END LOOP;
  RETURN cleaned_count;
END;
$$;

REVOKE ALL ON FUNCTION public.cleanup_expired_layout_reservations(integer) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.cleanup_expired_layout_reservations(integer) TO service_role;

-- Legacy timestamp-only cleanup functions do not synchronize active
-- reservations/users/bills. Leave them in place for rollback visibility but
-- remove all client execution rights; the canonical cron below replaces them.
DO $$
DECLARE
  legacy_function text;
BEGIN
  FOREACH legacy_function IN ARRAY ARRAY[
    'cleanup_expired_pending_status()',
    'cleanup_expired_payment_pending_status()'
  ]
  LOOP
    IF to_regprocedure('public.' || legacy_function) IS NOT NULL THEN
      EXECUTE format(
        'REVOKE ALL ON FUNCTION public.%s FROM PUBLIC, anon, authenticated',
        legacy_function
      );
    END IF;
  END LOOP;
END;
$$;

-- --------------------------------------------------------------------------
-- Realtime publication, idempotent
-- --------------------------------------------------------------------------
DO $$
DECLARE
  table_name text;
BEGIN
  FOREACH table_name IN ARRAY ARRAY[
    'venue_daily_layouts',
    'venue_daily_layout_floors',
    'venue_daily_layout_tables'
  ]
  LOOP
    IF NOT EXISTS (
      SELECT 1 FROM pg_publication_tables
      WHERE pubname = 'supabase_realtime'
        AND schemaname = 'public'
        AND tablename = table_name
    ) THEN
      EXECUTE format(
        'ALTER PUBLICATION supabase_realtime ADD TABLE public.%I',
        table_name
      );
    END IF;
  END LOOP;
END;
$$;

-- Install an idempotent cron schedule only when pg_cron is available.
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
    PERFORM cron.unschedule(jobid)
    FROM cron.job
    WHERE jobname IN (
      'cleanup-expired-pending-status',
      'cleanup-expired-payment-pending-status',
      'cleanup-expired-layout-reservations'
    );
    PERFORM cron.schedule(
      'cleanup-expired-layout-reservations',
      '* * * * *',
      'SELECT public.cleanup_expired_layout_reservations(200);'
    );
  END IF;
END;
$$;
