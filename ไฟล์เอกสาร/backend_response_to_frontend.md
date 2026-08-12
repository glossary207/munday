# ชุดคำตอบและไฟล์สำหรับส่งให้ทีมทำแอป (Frontend)

เอกสารนี้รวบรวมสิ่งที่ทีมทำแอปขอมาใน **"หัวข้อที่ 8 (Deliverables)"** โดยไฟล์เกือบทั้งหมดมีอยู่แล้วในเครื่องของคุณ และบางส่วนได้เตรียมเขียนโค้ดที่ถูกต้องและปลอดภัยไว้ให้คุณคัดลอกส่งต่อได้ทันทีครับ

---

## 📁 1. ไฟล์หลักที่หยิบส่งให้ทีมทำแอปได้ทันที

| ของที่ทีมทำแอปขอ | ตำแหน่งไฟล์ในเครื่องของคุณ | หน้าที่ของไฟล์ |
|---|---|---|
| **`backup.sql`** (Schema ตารางทั้งหมด) | [backup.sql](file:///Users/romporatchanon/Downloads/mundaymanager_off/backup.sql) | สำหรับสร้างโครงสร้างฐานข้อมูลทั้งหมดของระบบ |
| **`supabase_helper.dart`** (ตัวเชื่อมต่อจริง) | [supabase_helper.dart](file:///Users/romporatchanon/Downloads/mundaymanager_off/lib/backend/supabase/supabase_helper.dart) | สำหรับให้เขาใช้ในการเรียกคิวรีและแกะโครงสร้าง UI ในโค้ดแอป Flutter |
| **`RLS policies และ grants (ของ Staff)`** | โฟลเดอร์ [supabase/rls/](file:///Users/romporatchanon/Downloads/mundaymanager_off/supabase/rls/) | ประกอบด้วยนโยบายความปลอดภัย RLS ของพนักงานสำหรับจัดการผังโต๊ะและบิล |
| **`สคริปต์ล้างโต๊ะหมดอายุ`** (Cron Job) | [CLEANUP_EXPIRED_PENDING_STATUS.sql](file:///Users/romporatchanon/Downloads/mundaymanager_off/CLEANUP_EXPIRED_PENDING_STATUS.sql) <br>[SETUP_CLEANUP_CRON.sql](file:///Users/romporatchanon/Downloads/mundaymanager_off/SETUP_CLEANUP_CRON.sql) | สำหรับตั้งระบบปลดล็อกโต๊ะที่กดจองเล่นๆ เกินเวลา (15 นาที) อัตโนมัติ |

*หมายเหตุ: โฟลเดอร์ `supabase/rls` มีอยู่จริงในเครื่องของคุณแล้วที่พาธด้านบน ลองเปิดใน Finder หรือ VS Code ดูได้เลยครับ*

---

## 🛠️ 2. โค้ด SQL และข้อมูลที่ต้องส่งเพิ่มเติม (คัดลอกส่งได้เลย)

### Deliverable: Customer & Public RLS Policies (เพิ่มเติมสิทธิ์ให้ลูกค้าและบุคคลทั่วไปเข้าชมผังโต๊ะได้)
*เนื่องจาก RLS ชุดเดิมมีเฉพาะสิทธิ์ของ Staff ทำให้แอปฝั่งลูกค้าอ่านผังโต๊ะไม่ได้และติด `permission denied` (ข้อ BE-03) ต้องใช้สคริปต์นี้เพื่อเปิดให้ลูกค้าเข้าถึงผังโต๊ะและจองโต๊ะของตัวเองได้:*

```sql
-- 1. อนุญาตให้บุคคลทั่วไป (รวมถึงผู้ใช้ที่ยังไม่ล็อกอิน - anon) สามารถดูผังโต๊ะและชั้นได้ (SELECT)
CREATE POLICY "layout_select_public" 
  ON public.venue_daily_layouts 
  FOR SELECT 
  TO public
  USING (true);

CREATE POLICY "layout_floors_select_public" 
  ON public.venue_daily_layout_floors 
  FOR SELECT 
  TO public
  USING (true);

CREATE POLICY "layout_tables_select_public" 
  ON public.venue_daily_layout_tables 
  FOR SELECT 
  TO public
  USING (true);

-- 2. อนุญาตให้ทุกคนสามารถดึงข้อมูลร้านค้าทั่วไป (SELECT)
ALTER TABLE public.venues ENABLE ROW LEVEL SECURITY;
CREATE POLICY "venues_select_public" 
  ON public.venues 
  FOR SELECT 
  TO public
  USING (true);

-- 3. สิทธิ์การจัดการ Active Reservations (จองชั่วคราว 5 นาที)
ALTER TABLE public.active_reservations ENABLE ROW LEVEL SECURITY;

-- 3.1 ลูกค้าอ่านเฉพาะรายการจองของตัวเองได้
CREATE POLICY "active_reservations_select_own" 
  ON public.active_reservations 
  FOR SELECT 
  TO authenticated
  USING (user_id = auth.uid());

-- 3.2 ลูกค้าสร้างรายการจองเฉพาะชื่อตัวเองได้
CREATE POLICY "active_reservations_insert_own" 
  ON public.active_reservations 
  FOR INSERT 
  TO authenticated
  WITH CHECK (user_id = auth.uid());

-- 3.3 ลูกค้าแก้ไข/ยกเลิกรายการจองของตัวเองได้
CREATE POLICY "active_reservations_update_own" 
  ON public.active_reservations 
  FOR UPDATE 
  TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

-- 3.4 ลูกค้าลบรายการจองของตัวเองได้
CREATE POLICY "active_reservations_delete_own" 
  ON public.active_reservations 
  FOR DELETE 
  TO authenticated
  USING (user_id = auth.uid());
```

---

### Deliverable: Realtime Publication Migration
คำสั่ง SQL สำหรับเปิดใช้ Supabase Realtime ให้ทีมทำแอปดึงผังโต๊ะแบบเรียลไทม์:
```sql
-- 1. บังคับใช้งาน RLS เพื่อความปลอดภัยก่อนเปิด Realtime
ALTER TABLE public.venue_daily_layouts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.venue_daily_layout_floors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.venue_daily_layout_tables ENABLE ROW LEVEL SECURITY;

-- 2. เพิ่มตารางเข้าสู่ Realtime Publication
ALTER PUBLICATION supabase_realtime ADD TABLE public.venue_daily_layouts;
ALTER PUBLICATION supabase_realtime ADD TABLE public.venue_daily_layout_floors;
ALTER PUBLICATION supabase_realtime ADD TABLE public.venue_daily_layout_tables;
```

---

### Deliverable: RPC `toggle_table_reservation` (เพิ่มการยืนยันสิทธิ์ `auth.uid()`)
เวอร์ชันความปลอดภัย ป้องกันการสวมรอยจอง/สลับโต๊ะแทนผู้อื่น (แก้ไขจุด `RPC-01`):
*(คัดลอกส่วนหัวนี้ หรือส่งไฟล์ [FIX_TOGGLE_TABLE_RESERVATION.sql](file:///Users/romporatchanon/Downloads/mundaymanager_off/FIX_TOGGLE_TABLE_RESERVATION.sql) ตัวเต็มได้เลย)*
```sql
CREATE OR REPLACE FUNCTION toggle_table_reservation(
  p_venue_id UUID,
  p_date TEXT,
  p_table_id TEXT,
  p_user_id UUID,
  p_floor_id TEXT
) RETURNS JSONB
LANGUAGE plpgsql
AS $$
DECLARE
  v_layout_id UUID;
  ...
BEGIN
  -- ========================================================================
  -- ✅ Security check: ป้องกันการแอบสลับและจองโต๊ะในนามของผู้ใช้อื่น
  -- ========================================================================
  IF auth.uid() IS NULL OR auth.uid() IS DISTINCT FROM p_user_id THEN
    RAISE EXCEPTION 'Unauthorized: User ID mismatch (auth.uid=% vs p_user_id=%)', auth.uid(), p_user_id;
  END IF;

  -- การทำงานจองโต๊ะเดิม...
```

---

### Deliverable: ตัวอย่าง JSON Payload (ดึงตามฟอร์แมตในฐานข้อมูลจริง)

#### A. โครงสร้าง Legacy Layout (เก็บใน JSONB ฟิลด์ `other_data` ในตาราง `venue_daily_layouts`)
```json
{
  "floors": {
    "F1": {
      "floor_name": "ชั้น 1",
      "table_layout": {
        "table_A1": {
          "x": 120,
          "y": 200,
          "width": 60,
          "height": 60,
          "status": {
            "status_code": "reserved",
            "customer_uid": "2a6eac1d-b8f7-4c7d-8032-4e201c8b09a1",
            "reservation_bill_id": "2c1844b6-19b9-42de-b0fd-0d4e92d413ed"
          },
          "meta": {
            "price": 1000,
            "min_capacity": 2,
            "max_capacity": 4,
            "table_name": "A1"
          }
        }
      }
    }
  }
}
```

#### B. โครงสร้างแบบตารางแยก (Normalized Table Row - จากตาราง `venue_daily_layout_tables`)
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "venue_daily_layout_floor_id": "330e8400-e29b-41d4-a716-446655440000",
  "table_key": "table_A1",
  "status_code": "reserved",
  "customer_uid": "2a6eac1d-b8f7-4c7d-8032-4e201c8b09a1",
  "staff_bill_id": null,
  "status_action_timestamp": 1786081482000,
  "status_extra": {
    "reservation_bill_id": "2c1844b6-19b9-42de-b0fd-0d4e92d413ed"
  },
  "meta": {
    "price": 1000,
    "min_capacity": 2,
    "max_capacity": 4,
    "table_name": "A1"
  }
}
```

---

### Deliverable: Seed Data สำหรับเขียนตัวทดสอบ (Mock Data)
```sql
-- 1. เพิ่ม Venue ทดสอบ
INSERT INTO public.venues (id, name, location)
VALUES ('02bbf696-17e4-4d9b-9be8-1e46abcd5ddf', 'Munday Venue Test', '{"lat": 13.756, "lng": 100.501}'::jsonb)
ON CONFLICT (id) DO NOTHING;

-- 2. เพิ่ม User ทดสอบ
INSERT INTO public.users (id, name, email)
VALUES ('2a6eac1d-b8f7-4c7d-8032-4e201c8b09a1', 'Customer Test', 'test@munday.com')
ON CONFLICT (id) DO NOTHING;

-- 3. เพิ่ม Layout วันที่จองทดสอบ
INSERT INTO public.venue_daily_layouts (id, venue_id, date, other_data)
VALUES ('8b786c99-7ee4-4322-8344-9de81e46abcd', '02bbf696-17e4-4d9b-9be8-1e46abcd5ddf', '2026-08-05'::date, '{}'::jsonb)
ON CONFLICT (id) DO NOTHING;
```

---

### Deliverable: ตารางวงจรสถานะโต๊ะ (State-Transition Document)

| สถานะ (Status Code) | ความหมาย | อัปเดตโดยใคร/ตอนไหน |
|---|---|---|
| **`available`** | โต๊ะว่าง พนักงานหรือลูกค้าคนอื่นทำรายการได้ | ค่าเริ่มต้นของระบบ หรือเมื่อบิลหมดเวลา |
| **`pending`** | ลูกค้ากำลังเลือกโต๊ะนี้อยู่ (ล็อคไว้ชั่วคราว 5 นาที) | ลูกค้าคลิกโต๊ะบนแอปเพื่อจอง (ผ่าน RPC `toggle_table_reservation`) |
| **`payment_pending`** | ลูกค้าโอนเงินแล้วและระบบกำลังสแกนเช็คสลิป | ลูกค้าทำการส่งสลิปโอนเงินมัดจำเข้ามา |
| **`reserved`** | จองโต๊ะสำเร็จ (จ่ายเงินเรียบร้อย) โชว์เป็นสีน้ำเงินในแอปพนักงาน | Edge Function ตรวจสลิปสำเร็จ (`verify-payment-for-reservation`) |
| **`occupied`** | ลูกค้านั่งโต๊ะใช้บริการจริง โชว์เป็นสีส้มในแอปพนักงาน | พนักงานกดเช็คอินต้อนรับลูกค้าที่หน้าร้าน (ผ่าน RPC `confirm_reservation`) |
| **`ready_to_pay`** | ลูกค้าเรียกพนักงานเช็คบิลเพื่อออกจากร้าน | พนักงานในร้านเปลี่ยนสถานะผ่านแอปจัดการ |

---

### ❓ คำตอบสำหรับคำถามประกอบอื่น ๆ:
* **เลือกหลายโต๊ะได้หรือเลือกได้หนึ่งโต๊ะ?** $\rightarrow$ แอปพนักงานกดรวมโต๊ะได้ ส่วนการจองออนไลน์เบื้องต้นล็อกให้จองพร้อมกันได้ตามเงื่อนไข `active_reservations.table_ids` ของผู้ใช้รายนั้น
* **ราคาอยู่ที่ไหน?** $\rightarrow$ ดึงจากออบเจ็กต์ `meta->'price'` ของฟิลด์โครงสร้างโต๊ะ
* **ยึด Timezone ไหน?** $\rightarrow$ ยึดตามเวลา UTC ของฐานข้อมูล Supabase เป็นหลัก และแปลงไปตาม Timezone ท้องถิ่นของตัวเครื่องผู้ใช้ตอนแสดงผล (เช่น GMT+7 ของไทย)
