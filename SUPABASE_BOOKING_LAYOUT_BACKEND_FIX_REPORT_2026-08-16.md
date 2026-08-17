# รายงานปัญหา Supabase: Booking Layout ไม่แสดงโต๊ะในแอปลูกค้า

วันที่ตรวจสอบ: 16 สิงหาคม 2026
ระบบที่ตรวจสอบ: Production Supabase
Project ref: `[REDACTED]`
Venue ID: `[REDACTED]`
Customer test UID: `[REDACTED]`

## 1. Executive summary

ข้อมูลผังและโต๊ะมีอยู่จริงใน Production แต่แอปลูกค้าอ่าน `venue_daily_layout_tables`
ไม่ได้เพราะ Production ไม่มี RLS policy สำหรับ customer ให้อ่าน table rows ทั้งหมด

อาการจึงเป็นดังนี้:

```text
อ่าน venue_daily_layouts ได้          ✅
อ่าน venue_daily_layout_floors ได้   ✅
อ่าน venue_daily_layout_tables ได้ 0 แถว ❌
```

นอกจากนี้ วันที่ที่ตรวจพบ daily layout จริงมีเพียง `2026-08-12` ถึง
`2026-08-14` ส่วนวันที่ `2026-08-15` เป็นต้นไปยังไม่มี daily layout แม้จะมี
preset `offytest` ที่มีโครงสร้างตรงกับ daily layout ล่าสุดอยู่แล้วก็ตาม

จึงมีปัญหาแยกกัน 2 เรื่อง:

1. **RLS ซ่อน table rows จาก customer** — กระทบแม้แต่วันที่มี daily layout แล้ว
2. **ไม่มี daily inventory สำหรับวันที่ใหม่** — ต่อให้แสดง preset ได้ RPC จองโต๊ะก็ยัง
   ทำงานไม่ได้ เพราะ RPC บังคับให้มี daily layout ของวันที่ตรงกัน

## 2. หลักฐานจาก Production

### 2.1 Daily layouts และจำนวน layout objects

ผล query ด้วยสิทธิ์ database login:

| Date | Floor | Normalized rows | Available | Unavailable |
|---|---:|---:|---:|---:|
| 2026-08-12 | F1 | 11 | 11 | 0 |
| 2026-08-13 | F1 | 11 | 11 | 0 |
| 2026-08-14 | F1 | 11 | 11 | 0 |

ไม่พบ daily layout สำหรับ `2026-08-15` ถึง `2026-08-22`

หมายเหตุ: 11 rows ประกอบด้วย layout objects ต่อไปนี้:

```text
stage_2
table_A1 ... table_A5
table_B1 ... table_B5
```

จึงเป็นโต๊ะจริง 10 ตัวและ object ประเภท stage 1 ตัว ทีม Backend/Product ควรยืนยันว่า
`stage_2` ต้องไม่สามารถกดจองได้

### 2.2 Preset layouts

พบ preset ของ venue นี้ 6 รายการผ่าน database login แต่ customer app ได้ `rows=[]`
เพราะ preset policy อนุญาตเฉพาะ staff

| Preset | Created at (UTC) | Floor | Objects |
|---|---|---:|---:|
| offytest | 2026-08-03 15:49:28 | F1 | 11 |
| offy test1 | 2026-08-03 15:27:12 | F1 | 5 |
| New preset | 2026-04-26 09:28:12 | F1 | 0 |
| test | 2026-03-16 15:46:32 | F1 | 4 |
| Copy of preset | 2026-03-01 18:42:10 | F1 | 2 |
| New preset | 2026-02-21 16:35:00 | F1 | 0 |

Table keys ของ preset `offytest` ตรงกับ daily layout วันที่ `2026-08-14` ครบทุก key
จึงมีหลักฐานว่า `offytest` เป็นแม่แบบของ daily layout ชุดปัจจุบัน

### 2.3 App runtime evidence

วันที่ `2026-08-15`:

```text
[BookingDate] booking page
routeDate=2026-08-15T12:00:00.000
resolved=2026-08-15T12:00:00.000

[LayoutPreview] loaded
requestedDate=2026-08-15
authRole=authenticated
layoutId=null
floors={}
```

วันที่ `2026-08-12` ก่อนหน้านี้:

```text
layoutId=5b00e11a-8be9-4e31-acbc-97822593b771
floor=F1
legacy_tables=0
normalized_tables=0
merged_tables=0
```

Database login ตรวจพบ 11 rows สำหรับ layout เดียวกัน จึงยืนยันว่า 0 rows ที่ customer
ได้รับเกิดจาก RLS ไม่ใช่การวาด UI หรือการกรอง status

## 3. Root cause: RLS และ grants

### 3.1 Policies ที่มีอยู่จริง

Production มี customer policies ดังนี้:

```text
venue_daily_layouts:
  "authenticated can read daily layouts" — SELECT TO authenticated USING (true)

venue_daily_layout_floors:
  "authenticated can read floors" — SELECT TO authenticated USING (true)

venue_daily_layout_tables:
  ไม่มี customer SELECT policy
  มีเฉพาะ staff SELECT policies

preset_layouts:
  "preset_layouts_select_staff" — staff only
```

RLS ของ PostgreSQL จะคืนรายการว่างเมื่อผู้ใช้ไม่มี row policy ที่ผ่านเงื่อนไข จึงไม่มี
permission error ใน initial fetch แต่ได้ table rows เป็น `[]`

### 3.2 Grants ที่พบ

`authenticated` มี table-level `SELECT` บน daily layouts/floors/tables แล้ว แต่ RLS
ยังซ่อน rows ของ `venue_daily_layout_tables`

`anon` ไม่มี `SELECT` บน daily layout tables แต่มี grants ประเภท write/TRUNCATE หลายรายการ
ซึ่งควรถูกทบทวนและ revoke ตามหลัก least privilege แม้ RLS จะช่วยจำกัด row operations อยู่

## 4. Root cause: ไม่มี daily layout สำหรับวันใหม่

RPC `toggle_table_reservation(p_venue_id, p_date, ...)` ที่ deploy อยู่ทำงานดังนี้:

```sql
SELECT vdl.id
FROM venue_daily_layouts vdl
WHERE vdl.venue_id = p_venue_id
  AND vdl.date = p_date::date;

IF v_layout_id IS NULL THEN
  RAISE EXCEPTION 'Layout not found for venue % and date %';
END IF;
```

RPC ไม่มี logic เลือก preset หรือสร้าง daily layout จาก preset ดังนั้น frontend ไม่ควร
fallback ไปแสดงโต๊ะจากวันที่อื่นแล้วเปิดให้จอง เพราะการกดโต๊ะจะล้มเหลวหรือใช้สถานะผิดวัน

## 5. Realtime configuration

Production publication `supabase_realtime` มีเพียง:

```text
venue_daily_layout_tables
```

ยังไม่มี:

```text
venue_daily_layouts
venue_daily_layout_floors
```

จึงเกิด runtime error เมื่อแอป subscribe layout/floor changes

## 6. Migration drift

ผล `supabase migration list --linked`:

Remote-only:

```text
20260120000001
20260120000002
20260120000003
20260120000004
20260120153000
```

Local-only:

```text
20260805230000
20260808000000
20260808010000
```

Migration `20260808010000_layout_reservation_infrastructure.sql` มี
`table_customer_read` และ Realtime setup ที่ต้องการอยู่แล้ว แต่ยังไม่ถูก deploy

**ห้าม `db push` ทั้งชุดโดยไม่ review** เพราะ migration history ระหว่าง Local/Remote ไม่ตรงกัน
และไฟล์ infrastructure มีการเปลี่ยนแปลงหลายระบบนอกเหนือจาก RLS

## 7. งานแก้ไขที่แนะนำ

### P0 — เพิ่ม customer read policy สำหรับ normalized tables

ใช้ targeted migration ที่ไม่ลบ staff policies เดิม:

```sql
BEGIN;

ALTER TABLE public.venue_daily_layout_tables ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS booking_customer_read_layout_tables
  ON public.venue_daily_layout_tables;

CREATE POLICY booking_customer_read_layout_tables
  ON public.venue_daily_layout_tables
  FOR SELECT
  TO authenticated
  USING (true);

GRANT SELECT ON public.venue_daily_layouts TO authenticated;
GRANT SELECT ON public.venue_daily_layout_floors TO authenticated;
GRANT SELECT ON public.venue_daily_layout_tables TO authenticated;

COMMIT;
```

ไม่แนะนำเปิด `TO public` หรือ `TO anon` เพราะ Booking route ต้อง login และ table rows มี
`customer_uid` หากต้องทำ public preview ควรใช้ sanitized view/RPC ที่ไม่เผย UUID ลูกค้า

### P0 — สร้าง daily layout สำหรับวันเปิดจอง

Backend ต้องเลือกหนึ่งแนวทาง:

1. สร้าง daily layouts ล่วงหน้าเป็น rolling window เช่น 7–60 วัน
2. สร้างเมื่อ staff เปิดวันจอง
3. ใช้ secure RPC สร้างแบบ idempotent เมื่อ customer ขอวันที่ที่ยังไม่มี

ข้อกำหนดสำหรับการ copy จาก preset:

- ต้องมี field/mapping ระบุ active booking preset ต่อ venue ห้ามใช้ “preset ล่าสุด” โดยเดา
- ใช้ unique constraint `(venue_id, date)` ป้องกัน daily layout ซ้ำ
- ใช้ unique constraint `(venue_daily_layout_id, floor_key)` ป้องกัน floor ซ้ำ
- ใช้ unique constraint `(venue_daily_layout_floor_id, table_key)` ป้องกัน object ซ้ำ
- copy geometry, shape, price และ capacity จาก preset
- reset booking state ของวันใหม่เป็น `available`
- reset `customer_uid`, `staff_bill_id`, booking ID และ timestamp ที่เป็นสถานะเก่า
- ทำทั้งหมดใน transaction เดียว
- concurrent calls ต้องคืน layout เดียวกัน ไม่สร้างข้อมูลซ้ำ

สำหรับ incident นี้ preset ที่ตรงกับ daily ล่าสุดคือ:

```text
preset_id: 4a79dedd-74ac-422b-9da5-53463c7e167b
name: offytest
floor: F1
objects: 11
```

ทีม Backend ต้องยืนยัน preset นี้เป็น active preset ก่อนนำไปสร้างวันใหม่

### P1 — เปิด Realtime อย่างปลอดภัย

ใช้ migration แบบ idempotent:

```sql
DO $$
DECLARE
  target_table text;
BEGIN
  FOREACH target_table IN ARRAY ARRAY[
    'venue_daily_layouts',
    'venue_daily_layout_floors',
    'venue_daily_layout_tables'
  ]
  LOOP
    IF NOT EXISTS (
      SELECT 1
      FROM pg_publication_tables
      WHERE pubname = 'supabase_realtime'
        AND schemaname = 'public'
        AND tablename = target_table
    ) THEN
      EXECUTE format(
        'ALTER PUBLICATION supabase_realtime ADD TABLE public.%I',
        target_table
      );
    END IF;
  END LOOP;
END;
$$;
```

### P1 — ทบทวน grants และ policies ซ้ำ

Production มี staff policies หลายชุดที่ชื่อและเงื่อนไขทับซ้อนกัน ควรจัดทำ canonical
policy migration หลัง smoke test โดยระวังไม่ตัดสิทธิ์ staff manager ที่ใช้งานจริง

อย่างน้อยควร revoke สิทธิ์ที่ไม่จำเป็นจาก `anon`:

```sql
REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER
ON public.venue_daily_layouts,
   public.venue_daily_layout_floors,
   public.venue_daily_layout_tables,
   public.preset_layouts
FROM anon;
```

## 8. Security note

Policy `SELECT USING (true)` บน `venue_daily_layout_tables` จะทำให้ authenticated customers
อ่าน `customer_uid` ของ rows อื่นได้ด้วย เพราะ RLS กรองระดับ row ไม่ได้ mask column

ทางแก้ระยะสั้นคือใช้ policy ข้างต้นให้ระบบกลับมาทำงานตาม architecture ปัจจุบัน
ทางแก้ระยะยาวที่แนะนำคือสร้าง sanitized booking read model/view/RPC ซึ่งคืนเฉพาะ:

- geometry และ display metadata
- status code
- `is_reserved_by_current_user` แทน raw `customer_uid`

จากนั้นให้ frontend subscribe/read model ที่ไม่เปิดเผยข้อมูลผู้ใช้อื่น

## 9. Verification queries

### ตรวจจำนวนโต๊ะด้วย database/admin role

```sql
SELECT
  l.date,
  f.floor_key,
  count(t.id) AS table_count,
  count(*) FILTER (WHERE t.status_code = 'available') AS available_count,
  count(*) FILTER (WHERE t.status_code <> 'available') AS unavailable_count
FROM public.venue_daily_layouts l
JOIN public.venue_daily_layout_floors f
  ON f.venue_daily_layout_id = l.id
LEFT JOIN public.venue_daily_layout_tables t
  ON t.venue_daily_layout_floor_id = f.id
WHERE l.venue_id = '<VENUE_ID>'::uuid
  AND l.date BETWEEN '2026-08-12'::date AND '2026-08-22'::date
GROUP BY l.date, f.floor_key, f.sort_order
ORDER BY l.date, f.sort_order;
```

### ตรวจ customer policy

```sql
SELECT tablename, policyname, roles, cmd, qual
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN (
    'venue_daily_layouts',
    'venue_daily_layout_floors',
    'venue_daily_layout_tables'
  )
ORDER BY tablename, policyname;
```

### ตรวจ Realtime publication

```sql
SELECT schemaname, tablename
FROM pg_publication_tables
WHERE pubname = 'supabase_realtime'
  AND tablename IN (
    'venue_daily_layouts',
    'venue_daily_layout_floors',
    'venue_daily_layout_tables'
  )
ORDER BY tablename;
```

## 10. Acceptance criteria

### วันที่ที่มี daily layout แล้ว เช่น 2026-08-12 ถึง 2026-08-14

- customer query เห็น F1 และ 11 layout objects
- UI แสดงโต๊ะ A1–A5 และ B1–B5 พร้อม stage ตาม shape type
- โต๊ะทุก status แสดงบนผัง ไม่กรองเฉพาะ `available`
- customer เลือกได้เฉพาะ object ที่ bookable และ status อนุญาต
- customer A ไม่สามารถแก้สถานะของ customer B โดย bypass RPC

### วันที่ใหม่ เช่น 2026-08-16

- มี daily layout/floor/table rows ก่อนเปิดให้เลือกโต๊ะ
- table keys ตรงกับ active preset
- สถานะเริ่มต้นถูก reset ไม่ติดสถานะของวันก่อน
- `toggle_table_reservation` ทำงานโดยไม่เกิด `Layout not found`

### Realtime

- subscription ของ layouts, floors และ tables สำเร็จ
- insert/update/delete จาก staff ทำให้ customer refetch ผังได้
- ไม่มี log `Unable to subscribe to changes with given parameters`

## 11. Deployment sequence

1. Backup database และบันทึกผล verification queries ก่อนแก้
2. Apply targeted customer table-read policy ใน staging
3. Smoke test ด้วย customer account จริง ไม่ใช้ service role
4. Deploy RLS fix ไป Production
5. เปิด Realtime layouts/floors แบบ idempotent
6. Implement และทดสอบ daily-layout materialization จาก active preset
7. ทดสอบ customer A/customer B/staff รวม concurrency และ status transitions
8. Reconcile migration history ก่อน deploy infrastructure migrations ชุดใหญ่

## 12. ข้อสรุปสำหรับทีม Backend

Frontend ส่ง `venue_id`, `date` และ authenticated UID ถูกต้อง และ query ตาม integration
contract ที่ได้รับ ปัญหาที่ทำให้ “พบผังแต่ไม่พบโต๊ะ” คือ Production RLS ไม่มี customer
SELECT policy บน `venue_daily_layout_tables`

หลังแก้ RLS วันที่ 12–14 จะแสดงโต๊ะได้ แต่วันที่ 15 เป็นต้นไปยังต้องสร้าง daily layout
จาก active preset ก่อน มิฉะนั้น RPC จองโต๊ะจะยังคืน `Layout not found`
