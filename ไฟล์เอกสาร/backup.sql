-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.users (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  email text,
  display_name text,
  photo_url text,
  created_at timestamp with time zone,
  phone_number text,
  caption text,
  photoshow jsonb,
  chekin text,
  unread integer DEFAULT 0,
  cheers ARRAY,
  usermassage ARRAY,
  cheers_end ARRAY,
  usermassage_read ARRAY,
  seeusercheers boolean DEFAULT false,
  usercheerme ARRAY,
  showprofilecheers ARRAY,
  list_store ARRAY,
  pending_reservations jsonb DEFAULT '{}'::jsonb,
  pending_bills jsonb DEFAULT '{}'::jsonb,
  FCMtoken text,
  CONSTRAINT users_pkey PRIMARY KEY (id),
  CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id)
);
CREATE TABLE public.venues (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_name text,
  bg text,
  capacity integer,
  max_capacity integer,
  position jsonb,
  open_close_time text,
  stylevenuse ARRAY,
  stylemusic ARRAY,
  logo text,
  events ARRAY,
  dateevents ARRAY,
  promotion ARRAY,
  photos ARRAY,
  linkcontact jsonb,
  user_review ARRAY,
  rating double precision,
  created_time timestamp with time zone,
  updated_time timestamp with time zone,
  promptpay text,
  CONSTRAINT venues_pkey PRIMARY KEY (id)
);
CREATE TABLE public.events (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid,
  name_store text,
  name_artise ARRAY,
  location jsonb,
  date timestamp with time zone,
  poster text,
  capacity integer,
  max_capacity integer,
  musicstyle text,
  detail text,
  style_venues ARRAY,
  free boolean,
  price_detail text,
  created_time timestamp with time zone,
  CONSTRAINT events_pkey PRIMARY KEY (id),
  CONSTRAINT events_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id)
);
CREATE TABLE public.user_in_venues (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  venue_id uuid,
  created_time timestamp with time zone DEFAULT now(),
  CONSTRAINT user_in_venues_pkey PRIMARY KEY (id),
  CONSTRAINT user_in_venues_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
  CONSTRAINT user_in_venues_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id)
);
CREATE TABLE public.table_database (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  tid text,
  positions jsonb,
  created_time timestamp with time zone DEFAULT now(),
  CONSTRAINT table_database_pkey PRIMARY KEY (id)
);
CREATE TABLE public.promotions (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  location jsonb,
  date timestamp with time zone,
  created_time timestamp with time zone DEFAULT now(),
  CONSTRAINT promotions_pkey PRIMARY KEY (id)
);
CREATE TABLE public.chat_rooms (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  name text,
  user_ids ARRAY,
  last_message text,
  last_message_time timestamp with time zone,
  last_message_sender_id uuid,
  created_time timestamp with time zone DEFAULT now(),
  group_chat boolean DEFAULT false,
  image_url text,
  CONSTRAINT chat_rooms_pkey PRIMARY KEY (id),
  CONSTRAINT chat_rooms_last_message_sender_id_fkey FOREIGN KEY (last_message_sender_id) REFERENCES public.users(id)
);
CREATE TABLE public.messages (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  chat_room_id uuid,
  text text,
  sender_id uuid,
  sender_name text,
  sender_photo text,
  timestamp timestamp with time zone DEFAULT now(),
  image_url text,
  read_by_ids ARRAY,
  CONSTRAINT messages_pkey PRIMARY KEY (id),
  CONSTRAINT messages_chat_room_id_fkey FOREIGN KEY (chat_room_id) REFERENCES public.chat_rooms(id),
  CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id)
);
CREATE TABLE public.tickets (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  event_id uuid,
  created_time timestamp with time zone DEFAULT now(),
  CONSTRAINT tickets_pkey PRIMARY KEY (id),
  CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
  CONSTRAINT tickets_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id)
);
CREATE TABLE public.active_reservations (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  venue_id uuid,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone,
  date date,
  table_ids ARRAY,
  expires_at timestamp with time zone,
  status text,
  bill_id uuid,
  CONSTRAINT active_reservations_pkey PRIMARY KEY (id),
  CONSTRAINT active_reservations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
  CONSTRAINT active_reservations_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id)
);
CREATE TABLE public.group_invites (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  created_time timestamp with time zone DEFAULT now(),
  CONSTRAINT group_invites_pkey PRIMARY KEY (id),
  CONSTRAINT group_invites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
);
CREATE TABLE public.preset_layouts (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid,
  layout_data jsonb,
  created_time timestamp with time zone DEFAULT now(),
  name text,
  CONSTRAINT preset_layouts_pkey PRIMARY KEY (id),
  CONSTRAINT preset_layouts_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id)
);
CREATE TABLE public.event_details (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  event_id uuid,
  detail_data jsonb,
  created_time timestamp with time zone DEFAULT now(),
  CONSTRAINT event_details_pkey PRIMARY KEY (id),
  CONSTRAINT event_details_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id)
);
CREATE TABLE public.auth_tokens (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  token text NOT NULL UNIQUE,
  status text NOT NULL DEFAULT 'pending'::text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT auth_tokens_pkey PRIMARY KEY (id)
);
CREATE TABLE public.otp_codes (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  phone_number text NOT NULL,
  code text NOT NULL,
  expires_at timestamp with time zone NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  verified boolean DEFAULT false,
  CONSTRAINT otp_codes_pkey PRIMARY KEY (id)
);
CREATE TABLE public.reservation_bills (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid NOT NULL,
  paid_by uuid,
  created_by uuid,
  service_day date NOT NULL,
  party_size integer NOT NULL CHECK (party_size > 0),
  table_ids ARRAY NOT NULL DEFAULT '{}'::text[],
  amount numeric NOT NULL CHECK (amount >= 0::numeric),
  status text NOT NULL DEFAULT 'pending'::text CHECK (status = ANY (ARRAY['pending'::text, 'paid'::text, 'cancelled'::text])),
  bill_type text NOT NULL DEFAULT 'reservation'::text CHECK (bill_type = 'reservation'::text),
  qr_code_url text,
  slip_data jsonb,
  slip_hash text,
  tx_ref text,
  paid_at timestamp with time zone,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  created_by_role text NOT NULL CHECK (created_by_role = ANY (ARRAY['customer'::text, 'staff'::text])),
  booking_verified boolean NOT NULL DEFAULT false,
  CONSTRAINT reservation_bills_pkey PRIMARY KEY (id),
  CONSTRAINT reservation_bills_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id),
  CONSTRAINT reservation_bills_paid_by_fkey FOREIGN KEY (paid_by) REFERENCES public.users(id),
  CONSTRAINT reservation_bills_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id)
);
CREATE TABLE public.staff_users (
  id uuid NOT NULL,
  employee_id character varying NOT NULL UNIQUE,
  hire_date timestamp without time zone,
  status character varying NOT NULL DEFAULT 'active'::character varying CHECK (status::text = ANY (ARRAY['active'::character varying, 'inactive'::character varying, 'suspended'::character varying, 'terminated'::character varying]::text[])),
  created_at timestamp without time zone NOT NULL DEFAULT now(),
  updated_at timestamp without time zone NOT NULL DEFAULT now(),
  added_by uuid,
  CONSTRAINT staff_users_pkey PRIMARY KEY (id),
  CONSTRAINT staff_users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id),
  CONSTRAINT staff_users_added_by_fkey FOREIGN KEY (added_by) REFERENCES auth.users(id)
);
CREATE TABLE public.staff_venues (
  staff_id uuid NOT NULL,
  venue_id uuid NOT NULL,
  permissions jsonb DEFAULT '{}'::jsonb,
  role text DEFAULT 'staff'::text CHECK (role = ANY (ARRAY['owner'::text, 'manager'::text, 'staff'::text])),
  assigned_date date DEFAULT CURRENT_DATE,
  assigned_by uuid,
  is_active boolean DEFAULT true,
  is_primary_venue boolean DEFAULT false,
  created_time timestamp without time zone DEFAULT now(),
  updated_at timestamp without time zone DEFAULT now(),
  CONSTRAINT staff_venues_pkey PRIMARY KEY (staff_id, venue_id),
  CONSTRAINT staff_venues_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id),
  CONSTRAINT staff_venues_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff_users(id),
  CONSTRAINT staff_venues_assigned_by_fkey FOREIGN KEY (assigned_by) REFERENCES public.staff_users(id)
);
CREATE TABLE public.user_onesignal_player_ids (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  player_id text NOT NULL,
  device_type text,
  device_info jsonb,
  is_active boolean DEFAULT true,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT user_onesignal_player_ids_pkey PRIMARY KEY (id),
  CONSTRAINT user_onesignal_player_ids_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id)
);
CREATE TABLE public.orders (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid NOT NULL,
  service_date date NOT NULL,
  staff_bill_id text,
  reservation_bill_id uuid,
  customer_uid text,
  customer_name text,
  floor_id text,
  table_ids ARRAY NOT NULL DEFAULT '{}'::text[],
  party_size integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'occupied'::text,
  payment_status text NOT NULL DEFAULT 'unpaid'::text,
  payment_method text,
  total_amount numeric NOT NULL DEFAULT 0,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  created_by_staff_uid text,
  seated_at timestamp with time zone,
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT orders_pkey PRIMARY KEY (id)
);
CREATE TABLE public.order_items (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  order_id uuid NOT NULL,
  venue_id uuid NOT NULL,
  service_date date NOT NULL,
  menu_category_id text,
  menu_item_id text,
  name text NOT NULL,
  quantity integer NOT NULL CHECK (quantity > 0),
  unit_price numeric NOT NULL DEFAULT 0,
  subtotal numeric NOT NULL DEFAULT 0,
  unit text,
  notes text,
  status text NOT NULL DEFAULT 'pending'::text,
  reject_reason text,
  added_at timestamp with time zone NOT NULL DEFAULT now(),
  added_by_uid text,
  handled_at timestamp with time zone,
  handled_by_uid text,
  round_id text,
  round_number integer,
  ordered_at timestamp with time zone,
  ordered_by_uid text,
  CONSTRAINT order_items_pkey PRIMARY KEY (id),
  CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id)
);
CREATE TABLE public.menu_items (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid NOT NULL,
  name text NOT NULL,
  description text,
  price numeric NOT NULL DEFAULT 0 CHECK (price >= 0::numeric),
  unit text,
  sort_order integer NOT NULL DEFAULT 0,
  is_available boolean NOT NULL DEFAULT true,
  image_url text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  menu_category_id uuid,
  CONSTRAINT menu_items_pkey PRIMARY KEY (id),
  CONSTRAINT menu_items_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id),
  CONSTRAINT menu_items_menu_category_id_fkey FOREIGN KEY (menu_category_id) REFERENCES public.menu_categories(id)
);
CREATE TABLE public.staff_bills (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid NOT NULL,
  service_day date NOT NULL,
  created_by_staff_uuid uuid NOT NULL,
  customer_name ARRAY NOT NULL DEFAULT '{}'::text[],
  customer_uuid ARRAY NOT NULL DEFAULT '{}'::uuid[],
  party_size integer,
  reservation_bill_uuid uuid,
  table_ids ARRAY NOT NULL DEFAULT '{}'::text[],
  floor text,
  status text NOT NULL DEFAULT 'open'::text CHECK (status = ANY (ARRAY['open'::text, 'closed'::text, 'cancelled'::text])),
  total_amount numeric NOT NULL DEFAULT 0 CHECK (total_amount >= 0::numeric),
  paid_amount numeric NOT NULL DEFAULT 0 CHECK (paid_amount >= 0::numeric),
  remaining_amount numeric NOT NULL DEFAULT 0 CHECK (remaining_amount >= 0::numeric),
  payment_status text NOT NULL DEFAULT 'unpaid'::text CHECK (payment_status = ANY (ARRAY['unpaid'::text, 'pending'::text, 'paid'::text, 'verified'::text])),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT staff_bills_pkey PRIMARY KEY (id),
  CONSTRAINT staff_bills_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id),
  CONSTRAINT staff_bills_created_by_staff_fkey FOREIGN KEY (created_by_staff_uuid) REFERENCES public.staff_users(id),
  CONSTRAINT staff_bills_reservation_bill_fkey FOREIGN KEY (reservation_bill_uuid) REFERENCES public.reservation_bills(id)
);
CREATE TABLE public.staff_bill_payments (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  staff_bill_id uuid NOT NULL,
  amount numeric NOT NULL CHECK (amount >= 0::numeric),
  payment_method text,
  status text NOT NULL DEFAULT 'pending'::text CHECK (status = ANY (ARRAY['pending'::text, 'accepted'::text, 'paid'::text, 'verified'::text])),
  paid_at timestamp with time zone,
  paid_by uuid,
  slip_url text,
  clear_type text CHECK (clear_type IS NULL OR (clear_type = ANY (ARRAY['full'::text, 'partial'::text]))),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT staff_bill_payments_pkey PRIMARY KEY (id),
  CONSTRAINT staff_bill_payments_staff_bill_fkey FOREIGN KEY (staff_bill_id) REFERENCES public.staff_bills(id)
);
CREATE TABLE public.staff_bill_items (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  staff_bill_id uuid NOT NULL,
  round_id uuid NOT NULL,
  line_group_id uuid,
  menu_item_id uuid,
  name text,
  quantity numeric NOT NULL DEFAULT 1 CHECK (quantity > 0::numeric),
  unit_price numeric NOT NULL DEFAULT 0 CHECK (unit_price >= 0::numeric),
  total_price numeric NOT NULL DEFAULT 0 CHECK (total_price >= 0::numeric),
  sort_order integer NOT NULL DEFAULT 0,
  notes text,
  status text NOT NULL DEFAULT 'pending'::text CHECK (status = ANY (ARRAY['pending'::text, 'accepted'::text, 'rejected'::text])),
  handled_by uuid,
  handled_at timestamp with time zone,
  reject_reason text,
  cleared_by_payment_id uuid,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT staff_bill_items_pkey PRIMARY KEY (id),
  CONSTRAINT staff_bill_items_staff_bill_fkey FOREIGN KEY (staff_bill_id) REFERENCES public.staff_bills(id),
  CONSTRAINT staff_bill_items_menu_item_fkey FOREIGN KEY (menu_item_id) REFERENCES public.menu_items(id),
  CONSTRAINT staff_bill_items_cleared_by_fkey FOREIGN KEY (cleared_by_payment_id) REFERENCES public.staff_bill_payments(id)
);
CREATE TABLE public.menu_categories (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid,
  name text,
  created_time timestamp with time zone DEFAULT now(),
  sort_order integer NOT NULL DEFAULT 0,
  is_active boolean NOT NULL DEFAULT true,
  CONSTRAINT menu_categories_pkey PRIMARY KEY (id),
  CONSTRAINT menu_categories_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id)
);
CREATE TABLE public.spatial_ref_sys (
  srid integer NOT NULL CHECK (srid > 0 AND srid <= 998999),
  auth_name character varying,
  auth_srid integer,
  srtext character varying,
  proj4text character varying,
  CONSTRAINT spatial_ref_sys_pkey PRIMARY KEY (srid)
);
CREATE TABLE public.venue_daily_layouts (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid NOT NULL,
  date date NOT NULL,
  reservations ARRAY DEFAULT '{}'::uuid[],
  walls jsonb,
  other_data jsonb DEFAULT '{}'::jsonb,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT venue_daily_layouts_pkey PRIMARY KEY (id),
  CONSTRAINT venue_daily_layouts_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id)
);
CREATE TABLE public.venue_daily_layout_floors (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_daily_layout_id uuid NOT NULL,
  floor_key text NOT NULL,
  label text,
  sort_order integer NOT NULL DEFAULT 0,
  bounds jsonb,
  walls jsonb,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT venue_daily_layout_floors_pkey PRIMARY KEY (id),
  CONSTRAINT venue_daily_layout_floors_venue_daily_layout_id_fkey FOREIGN KEY (venue_daily_layout_id) REFERENCES public.venue_daily_layouts(id)
);
CREATE TABLE public.venue_daily_layout_tables (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_daily_layout_floor_id uuid NOT NULL,
  table_key text NOT NULL,
  display_name text,
  capacity integer,
  min_capacity integer,
  max_capacity integer,
  xi ARRAY NOT NULL DEFAULT ARRAY[0, 100],
  yi ARRAY NOT NULL DEFAULT ARRAY[0, 100],
  rotation numeric,
  shape_type text DEFAULT 'table'::text,
  status_code text NOT NULL DEFAULT 'available'::text,
  customer_uid text DEFAULT ''::text,
  staff_bill_id text DEFAULT ''::text,
  status_action_timestamp bigint,
  status_extra jsonb DEFAULT '{}'::jsonb,
  meta jsonb DEFAULT '{}'::jsonb,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT venue_daily_layout_tables_pkey PRIMARY KEY (id),
  CONSTRAINT venue_daily_layout_tables_venue_daily_layout_floor_id_fkey FOREIGN KEY (venue_daily_layout_floor_id) REFERENCES public.venue_daily_layout_floors(id)
);
CREATE TABLE public.group_chat (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  title text NOT NULL,
  created_by uuid NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  last_message_id uuid,
  last_message_time timestamp with time zone,
  CONSTRAINT group_chat_pkey PRIMARY KEY (id),
  CONSTRAINT fk_group_chat_created_by FOREIGN KEY (created_by) REFERENCES public.users(id),
  CONSTRAINT fk_group_chat_last_message FOREIGN KEY (last_message_id) REFERENCES public.group_message(id)
);
CREATE TABLE public.group_member (
  group_id uuid NOT NULL,
  user_id uuid NOT NULL,
  role text NOT NULL DEFAULT 'member'::text CHECK (role = ANY (ARRAY['owner'::text, 'admin'::text, 'member'::text])),
  joined_at timestamp with time zone NOT NULL DEFAULT now(),
  left_at timestamp with time zone,
  mute boolean NOT NULL DEFAULT false,
  CONSTRAINT group_member_pkey PRIMARY KEY (group_id, user_id),
  CONSTRAINT fk_group_member_group FOREIGN KEY (group_id) REFERENCES public.group_chat(id),
  CONSTRAINT fk_group_member_user FOREIGN KEY (user_id) REFERENCES public.users(id)
);
CREATE TABLE public.group_message (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  group_id uuid NOT NULL,
  sender_id uuid NOT NULL,
  content text NOT NULL CHECK (length(btrim(content)) > 0),
  sent_at timestamp with time zone NOT NULL DEFAULT now(),
  edited_at timestamp with time zone,
  deleted_at timestamp with time zone,
  CONSTRAINT group_message_pkey PRIMARY KEY (id),
  CONSTRAINT fk_group_message_group FOREIGN KEY (group_id) REFERENCES public.group_chat(id),
  CONSTRAINT fk_group_message_sender FOREIGN KEY (sender_id) REFERENCES public.users(id)
);
CREATE TABLE public.friend_request (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  sender_id uuid NOT NULL,
  receiver_id uuid NOT NULL,
  status text NOT NULL DEFAULT 'pending'::text CHECK (status = ANY (ARRAY['pending'::text, 'accepted'::text, 'rejected'::text, 'cancelled'::text])),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  responded_at timestamp with time zone,
  CONSTRAINT friend_request_pkey PRIMARY KEY (id),
  CONSTRAINT friend_request_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id),
  CONSTRAINT friend_request_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id)
);
CREATE TABLE public.friend (
  user_low_id uuid NOT NULL,
  user_high_id uuid NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT friend_pkey PRIMARY KEY (user_low_id, user_high_id),
  CONSTRAINT friend_user_low_id_fkey FOREIGN KEY (user_low_id) REFERENCES public.users(id),
  CONSTRAINT friend_user_high_id_fkey FOREIGN KEY (user_high_id) REFERENCES public.users(id)
);
CREATE TABLE public.venue_stories (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  venue_id uuid NOT NULL,
  user_id uuid,
  video_url text NOT NULL,
  storage_path text NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  expires_at timestamp with time zone NOT NULL DEFAULT (now() + '24:00:00'::interval),
  CONSTRAINT venue_stories_pkey PRIMARY KEY (id),
  CONSTRAINT venue_stories_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id),
  CONSTRAINT venue_stories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
);