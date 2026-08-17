# รายงานปัญหาและข้อมูลที่ต้องขอเพิ่มจากทีม Backend: Layout Preview Integration

วันที่ตรวจสอบครั้งแรก: 5 สิงหาคม 2026  
อัปเดตหลังได้รับไฟล์จาก Backend: 7 สิงหาคม 2026  
โปรเจกต์ปลายทาง: Munday Flutter App  
Supabase project ที่ตรวจสอบ: `xdhhlxpysugtzkqrtdzp`

> หมายเหตุ: หัวข้อ 1–10 เก็บผลตรวจจากชุดแรกไว้เป็นประวัติ ส่วนผลตรวจไฟล์ที่ Backend ส่งเพิ่มในโฟลเดอร์ `ไฟล์เอกสาร/` และสถานะล่าสุดอยู่ในหัวข้อ 11–15 ซึ่งให้ถือเป็นข้อสรุปล่าสุด

## 1. ขอบเขตการตรวจสอบ

ตรวจสอบชุดไฟล์ที่ได้รับจากทีม Backend/ระบบต้นทาง:

- `layout_preview_integration_guide.md`
- `layout_preview_widget.dart`

เทียบกับ:

- โครงสร้าง Flutter/Supabase ของ Munday
- หน้า Booking และเส้นทางนำทางที่เรียกใช้งาน widget
- Supabase helper และ RPC ที่ต้องใช้
- Migration, RLS และ Supabase Realtime ที่มีอยู่ใน repository
- Supabase REST endpoint แบบ read-only เท่าที่ anon role สามารถตรวจสอบได้

## 2. บทสรุปสำหรับทีม Backend

ตัว widget สามารถนำมา integrate ในระดับ UI และเรียก RPC ได้ แต่ชุดไฟล์ที่ส่งมายังไม่เพียงพอสำหรับติดตั้งระบบแบบ end-to-end หรือสร้าง environment ใหม่ได้อย่างปลอดภัย

ประเด็นที่ต้องให้ทีม Backend ดำเนินการหรือส่งข้อมูลเพิ่มโดยเร่งด่วน:

1. ส่ง SQL schema/migration ของตารางทั้งหมด ไม่ใช่เฉพาะ RPC
2. ส่ง `supabase_helper.dart` ตัวจริงที่ widget ถูกออกแบบให้ใช้
3. ส่ง RLS policies, grants และ Realtime publication configuration
4. ยืนยันว่า `toggle_table_reservation` ถูก deploy ใน Supabase project ที่แอปใช้อยู่
5. เพิ่มการตรวจ `auth.uid()` ภายใน RPC หรือระบุ RLS policy ที่ป้องกันการปลอม `p_user_id`
6. ส่ง normalized schema และตัวอย่าง payload จริง เพื่อยืนยันการ mapping ของ floor/table/walls/meta
7. ระบุกติกาธุรกิจให้ชัดเจนเรื่องหลายโต๊ะ, การสลับโต๊ะ, expiry และสถานะ `payment_pending`/`occupied`

## 3. ปัญหาใน Integration Guide ที่ได้รับ

### BE-01 — ไม่มี SQL schema ของตารางที่จำเป็น

ระดับ: Blocker

คู่มือระบุชื่อตาราง แต่ไม่มี `CREATE TABLE`, constraints, indexes, defaults หรือ triggers สำหรับ:

- `venue_daily_layouts`
- `venue_daily_layout_floors`
- `venue_daily_layout_tables`
- `active_reservations`
- `users.pending_reservations`

คู่มืออ้างถึง `backup.sql` ผ่าน path ภายในเครื่องผู้ส่ง:

```text
/Users/romporatchanon/Downloads/mundaymanager_off/backup.sql
```

ไฟล์นี้ไม่ได้ถูกส่งมาด้วยและทีม Munday ไม่สามารถเข้าถึง path ดังกล่าวได้

ผลกระทบ:

- ไม่สามารถสร้าง database ใหม่จาก source control ได้
- ไม่สามารถยืนยันชนิดข้อมูล, nullability, defaults และ foreign keys ได้
- ไม่สามารถทดสอบว่า RPC ตรงกับ schema production จริง

สิ่งที่ขอจากทีม Backend:

- SQL migration แบบสมบูรณ์และเรียงลำดับการ deploy
- constraints/indexes/foreign keys/default values ของทุกตาราง
- data migration สำหรับระบบ legacy JSONB ไป normalized schema หากมี

### BE-02 — ไม่ได้ส่ง `supabase_helper.dart`

ระดับ: Blocker

Widget import:

```dart
import '/backend/supabase/supabase_helper.dart';
```

แต่ชุดไฟล์ที่ได้รับไม่มี helper ดังกล่าว คู่มือระบุเพียงให้ย้ายฟังก์ชันจากอีกโปรเจกต์ โดยอ้าง path ภายในเครื่องผู้ส่ง

ฟังก์ชันที่คู่มือระบุว่าต้องมี:

- `fetchVenueDailyLayoutOnce`
- `fetchLayoutFromNormalizedTables`
- `toggleTableReservation`

นอกจากนี้ widget ยังเรียก `SupabaseHelper.query(...)` เพื่อตรวจ `active_reservations` แต่ฟังก์ชันนี้ไม่ได้ระบุไว้ในรายการ requirement ของคู่มือ

ผลกระทบ:

- Widget ที่ส่งมา compile ไม่ได้ทันที
- ทีมปลายทางต้องเดา schema mapping และ error behavior เอง
- อาจเกิดความแตกต่างระหว่าง helper ของระบบต้นทางและ helper ที่สร้างขึ้นใหม่

สิ่งที่ขอจากทีม Backend:

- ส่ง helper ต้นฉบับที่ใช้งานจริงครบทั้งไฟล์
- ระบุ public API, return shape และ error contract ของแต่ละ method

### BE-03 — ไม่มี RLS policies และสิทธิ์ของ database

ระดับ: Blocker/Security

คู่มือไม่มี SQL สำหรับ:

- `ENABLE ROW LEVEL SECURITY`
- SELECT policies สำหรับอ่าน layout
- UPDATE policies สำหรับเปลี่ยนสถานะโต๊ะ
- policies ของ `active_reservations`
- policies ของ `users.pending_reservations`
- `GRANT/REVOKE EXECUTE` สำหรับ RPC

จากการตรวจ Supabase แบบ anon:

- `venue_daily_layouts`, `venue_daily_layout_floors` และ `venue_daily_layout_tables` มีอยู่ แต่ anon role ได้ `42501 permission denied`
- `active_reservations` และ `users` ตอบ HTTP 200 แบบไม่มีข้อมูล
- ยืนยันได้ว่า `users.pending_reservations` และคอลัมน์หลักของ `active_reservations` มีอยู่
- ยังยืนยันสิทธิ์ของ authenticated user ไม่ได้

สิ่งที่ขอจากทีม Backend:

- ส่ง RLS migration ครบทุก table
- ระบุว่า authenticated user ต้องอ่าน/เขียน column ใดได้บ้าง
- ส่ง test matrix ของ anon/authenticated/venue-admin/service-role

### BE-04 — ไม่มี Supabase Realtime configuration

ระดับ: High

Widget ใช้ Postgres Changes แต่คู่มือไม่ได้ระบุ:

- การเพิ่มตารางเข้า `supabase_realtime` publication
- replica identity ที่ต้องใช้
- RLS/SELECT policy ที่จำเป็นต่อ Realtime
- ตารางใดเป็น source of truth ระหว่าง legacy และ normalized schema

สิ่งที่ขอจากทีม Backend:

- Migration สำหรับ Realtime publication
- รายชื่อตารางที่ต้องเปิด Realtime
- ข้อกำหนด event ที่ client ต้องฟัง (`INSERT`, `UPDATE`, `DELETE`)

### BE-05 — ไม่มีตัวอย่าง normalized payload จริง

ระดับ: High

คู่มือกล่าวถึง normalized tables แต่ไม่ได้ระบุ columns/types อย่างครบถ้วน โดยเฉพาะ:

- รูปแบบ `xi` และ `yi`
- `floor_key`
- โครงสร้าง `walls`
- โครงสร้าง `meta`
- ตำแหน่งของ `price`, `type`, `color`, `table_name`
- ชนิดของ `status_action_timestamp`
- defaults ของ `status_code` และ `customer_uid`

RPC อ่านราคาจาก `meta->>'price'` แต่ Flutter UI อาจคาดหวัง `price` ใน table map ระดับบน จึงต้องมี mapping ที่ยืนยันจาก backend

สิ่งที่ขอจากทีม Backend:

- ตัวอย่าง response JSON จริงอย่างน้อยหนึ่ง venue ที่มีหลาย floor
- ตัวอย่าง table/chair/stage/bar และ walls
- schema dictionary ระบุชื่อ column, type, nullable และ default

### BE-06 — ไม่มี seed/test fixture

ระดับ: Medium

ไม่มีข้อมูลทดสอบมาตรฐานสำหรับ:

- layout แบบ legacy
- layout แบบ normalized
- หลาย floor
- โต๊ะทุกสถานะ
- reservation ที่หมดอายุ
- pending reservation หลายโต๊ะ

สิ่งที่ขอจากทีม Backend:

- SQL seed ที่ไม่ใช้ข้อมูล production
- test UUID สำหรับ venue/user/layout
- expected result ของการ toggle แต่ละสถานะ

## 4. ปัญหาและคำถามเกี่ยวกับ RPC `toggle_table_reservation`

### RPC-01 — RPC เชื่อ `p_user_id` จาก client โดยตรง

ระดับ: Blocker/Security

Function รับ `p_user_id` แล้วใช้แก้ไข:

- table status
- `users.pending_reservations`
- `active_reservations`

แต่ไม่มีการตรวจว่า:

```sql
auth.uid() = p_user_id
```

ความปลอดภัยจึงขึ้นกับ RLS ที่ไม่ได้แนบมา หาก policies กว้างเกินไป client สามารถส่ง UUID ของผู้ใช้อื่นได้

คำขอ:

- เพิ่ม validation กับ `auth.uid()` ภายใน RPC หรือส่ง RLS policy ที่พิสูจน์ว่าปลอม user ไม่ได้
- กำหนดสิทธิ์ execute เฉพาะ role ที่ต้องใช้
- กำหนด `search_path` ของ function ให้ชัดเจน

### RPC-02 — เงื่อนไขตรวจ active reservation ไม่สอดคล้องกับ deterministic ID

ระดับ: High

RPC สร้าง active reservation ID จาก:

```text
user_id + venue_id + date
```

จากนั้นอ่าน row เดียวกันและตรวจว่าหากสถานะไม่ใช่ `available/pending` และ row เป็นของผู้ใช้อื่นจึง block แต่ row ID นี้ถูกสร้างจาก `p_user_id` อยู่แล้ว จึงแทบไม่มีกรณีที่ `user_id` จะเป็นคนอื่นนอกจากข้อมูลผิดปกติหรือ hash collision

คำถาม:

- ต้องการ block ผู้ใช้ที่มี `payment_pending/occupied` ของตัวเองหรือไม่
- หรือต้องการตรวจ reservation อื่นของ venue/date โดยไม่จำกัด user
- เงื่อนไขที่ถูกต้องตาม business rule คืออะไร

### RPC-03 — คำอธิบาย “สลับโต๊ะ” ไม่ตรงกับพฤติกรรม RPC

ระดับ: High

Comment ฝั่ง widget ระบุว่า RPC จะยกเลิกโต๊ะเดิมและจองโต๊ะใหม่อัตโนมัติ แต่ RPC ปัจจุบันเพิ่ม table ID ใหม่เข้า reservation เดิม ไม่ได้ลบโต๊ะเดิม

จึงต้องยืนยันว่าระบบรองรับ:

- จองหลายโต๊ะพร้อมกัน หรือ
- เลือกได้เพียงโต๊ะเดียวและต้องสลับโต๊ะ

### RPC-04 — ไม่มี lifecycle สำหรับ reservation expiry

ระดับ: High

RPC ตั้ง `expires_at = now() + 5 minutes` แต่ชุดไฟล์ไม่ได้ส่ง:

- cron/Edge Function/pg_cron สำหรับ release โต๊ะหมดอายุ
- function เปลี่ยน table status กลับเป็น available
- logic ล้าง `users.pending_reservations`
- logic ลบ/ปิด `active_reservations`

หากไม่มี cleanup โต๊ะอาจค้างสถานะ `pending`

### RPC-05 — ต้องยืนยันพฤติกรรม `occupied` และ `payment_pending`

ระดับ: High

RPC อนุญาตให้เจ้าของโต๊ะเปลี่ยน `occupied` กลับเป็น `available` แต่ client block reservation บางสถานะก่อนเรียก RPC

ต้องยืนยันว่า:

- ลูกค้าควรปล่อยโต๊ะ `occupied` เองได้หรือไม่
- `payment_pending` ยกเลิกได้หรือไม่
- ใครมีสิทธิ์เปลี่ยน `occupied`
- สถานะทั้งหมดและ transition ที่อนุญาตมีอะไรบ้าง

### RPC-06 — Error contract ยังไม่ถูกกำหนด

ระดับ: Medium

RPC ใช้ข้อความ exception ภาษาอังกฤษ แต่ไม่มี error code ที่ client สามารถ map เป็นข้อความ UX ได้ เช่น:

- layout not found
- floor not found
- table not found
- table owned by another user
- reservation locked/payment pending
- user row not found

คำขอ:

- ส่งรายการ error codes ที่เสถียร
- ระบุ retryable/non-retryable errors

### RPC-07 — ต้องยืนยัน defaults และ constraints

ระดับ: Medium

RPC insert `active_reservations` โดยไม่ได้ส่ง `created_at` และบาง column อื่น จึงต้องมี default ที่ถูกต้องใน schema

ต้องยืนยันอย่างน้อย:

- primary/unique constraint ของ deterministic `id`
- defaults ของ `created_at`, `updated_at`, `status`, `table_ids`
- foreign keys ของ user/venue/layout/floor
- index สำหรับ `(venue_id, date)`, `venue_daily_layout_id`, `venue_daily_layout_floor_id`

## 5. ปัญหาใน `layout_preview_widget.dart` ที่ได้รับ

### W-01 — Realtime listener เดิมไม่ scope ตาม venue/floor

ระดับ: High/Performance

Widget ที่ได้รับ subscribe ทุก event ของ `venue_daily_layout_tables` ทั้งระบบ แล้ว refetch venue/date ปัจจุบันทุกครั้ง

ผลกระทบ:

- venue อื่นเปลี่ยนโต๊ะก็ทำให้ client ทุกเครื่อง refetch
- จำนวน query เพิ่มตาม traffic ทั้งระบบ
- เสี่ยงเกิดโหลดสูงเมื่อ production มีหลาย venue

### W-02 — Legacy layout ไม่ได้รับ Realtime จากผู้ใช้อื่น

ระดับ: High

Widget ที่ได้รับฟังเฉพาะ `venue_daily_layout_tables` แต่ legacy mode เปลี่ยน `venue_daily_layouts.other_data` ดังนั้น client อื่นที่เปิดหน้าค้างอยู่จะไม่เห็นการเปลี่ยนแปลงทันที

### W-03 — ไม่มี error handling ระหว่าง initial fetch

ระดับ: High

หาก initial fetch ล้มเหลว Future จะ throw โดยไม่มี UI error/retry ที่ชัดเจน และ state อาจค้าง loading

### W-04 — มี race condition เมื่อ venue/date เปลี่ยนเร็ว

ระดับ: Medium

เมื่อ `didUpdateWidget` เรียก fetch ใหม่ response เก่าสามารถกลับมาทีหลังและทับ state ของ venue/date ล่าสุดได้

### W-05 — Refetch หลัง RPC ไม่ได้ await

ระดับ: Medium

Widget ต้นฉบับเรียก `_refetchAndEmitLayout()` โดยไม่ await ทำให้ processing indicator หยุดก่อน UI โหลดสถานะล่าสุดเสร็จ และ error จาก refetch ไม่เข้า catch เดียวกัน

### W-06 — Client precheck กลืน error แล้วทำงานต่อ

ระดับ: Medium/Security

หาก query `active_reservations` ล้มเหลว widget ตั้งค่าเป็นไม่มี reservation แล้วเรียก RPC ต่อ จึงต้องให้ RPC เป็น security/business-rule boundary ที่สมบูรณ์ ไม่สามารถพึ่ง client precheck ได้

### W-07 — มี debug/dead code และ log ปริมาณมาก

ระดับ: Low

พบ:

- `_isInLockMode` ไม่ได้ใช้
- `_centerCanvas` ไม่ได้ใช้
- debug helper ไม่ได้ใช้
- floor selector ซ้ำ โดยส่วนหนึ่งถูกปิดด้วย `if (false && ...)`
- `print` ใน build/tap/realtime จำนวนมาก
- comment หลายจุดยังอ้าง Firestore ทั้งที่เปลี่ยนเป็น Supabase

ควรส่ง production-ready widget ที่ผ่าน analyzer และลด log ที่อาจเปิดเผย user/venue/table IDs

### W-08 — ไม่มี guard สำหรับ `currentuid` ว่าง

ระดับ: Medium

Widget บังคับ parameter เป็น `String` แต่ไม่ตรวจว่าว่างหรือ UUID ถูกต้อง หาก caller ส่งค่าว่าง RPC จะเกิด cast error หรือ query ผิดเงื่อนไข

## 6. สิ่งที่เป็นปัญหาฝั่งแอป Munday ไม่ใช่ความรับผิดชอบของ Backend

รายการนี้ควรแจ้งทีมแอปภายใน ไม่ควรโยนเป็น defect ของชุดไฟล์ Backend:

1. ปฏิทินอัปเดต `AppState.dateclick` แต่ Layout widget ยังใช้วันที่จาก route ค่าเดิม
2. Booking page hardcode `floorId: 'F1'` และไม่ได้ใช้ floor จาก route
3. Booking page รับ `currentuid` แต่ใช้ global auth UID แทน
4. `AppState()` ของโปรเจกต์เป็น singleton จึงไม่ใช่ปัญหาเรื่องสร้าง instance ใหม่ แต่ UI ชื่อโต๊ะ/ราคารวมไม่มีโค้ด sync `SeatSelect`/`Totlepricebooking` จาก RPC หรือ `active_reservations`
5. `UsersRecord` ยังไม่ได้ map `pending_reservations`
6. Payment page ยังไม่มี implementation
7. Test suite เดิมยังติด dependency `qr_flutter` และ Supabase initialization

อย่างไรก็ตาม Backend ต้องส่ง data contract ที่ชัดเจนก่อนทีมแอปจะเชื่อมข้อ 4–6 ได้ถูกต้อง

## 7. สิ่งที่ทีม Munday integrate ให้แล้ว

- นำ widget เข้า shared widgets และเชื่อมกับ Booking page
- เปลี่ยนจาก document reference เป็น venue UUID string
- สร้าง helper ชั่วคราวที่รองรับ legacy และ normalized layouts
- เพิ่ม RPC wrapper
- เพิ่ม initial loading/error/retry
- เพิ่ม stale-request protection
- scope Realtime ตาม venue/floor เท่าที่ schema ปัจจุบันอนุญาต
- ฟังทั้ง legacy daily layout และ normalized table changes
- เพิ่ม migration ของ RPC จากคู่มือเข้า repository
- รัน analyzer ของ widget/helper โดยไม่มี compile error

Helper ที่ทีม Munday สร้างขึ้นเป็นการอนุมานจากคู่มือ ไม่ควรถูกถือเป็น final contract จนกว่าจะเทียบกับ helper และ schema ต้นฉบับจากทีม Backend

## 8. Deliverables ที่ขอให้ทีม Backend ส่งกลับ

### จำเป็นก่อน QA end-to-end

- [ ] `backup.sql` หรือ migration schema แบบสมบูรณ์
- [ ] `supabase_helper.dart` ต้นฉบับที่ใช้งานจริง
- [ ] RLS policies และ grants
- [ ] Realtime publication migration
- [ ] RPC version ที่ยืนยัน `auth.uid()`
- [ ] sample normalized JSON และ legacy JSON
- [ ] seed data สำหรับ QA
- [ ] state-transition document
- [ ] expiry cleanup job/function
- [ ] ยืนยัน Supabase project/environment ที่ deploy RPC แล้ว

### ข้อมูลประกอบที่ต้องตอบ

- [ ] เลือกหลายโต๊ะได้หรือเลือกได้หนึ่งโต๊ะ
- [ ] `occupied` ปล่อยเองได้หรือไม่
- [ ] `payment_pending` ยกเลิกได้หรือไม่
- [ ] reservation หมดอายุแล้วใครเป็นผู้ cleanup
- [ ] ราคาอยู่ใน `meta.price` หรือ column `price`
- [ ] วันจองยึด timezone ใด
- [ ] floor key มีรูปแบบบังคับหรือไม่ เช่น `F1`
- [ ] client ต้องฟัง Realtime ตารางใดบ้าง

## 9. Acceptance criteria ที่เสนอ

ถือว่า Backend integration พร้อมเมื่อ:

1. สร้าง Supabase environment ว่างจาก migrations ได้ครบ
2. authenticated user อ่าน layout ของวัน/venue ที่อนุญาตได้
3. anon user อ่านหรือ toggle ไม่ได้ตาม policy
4. user A ไม่สามารถ toggle reservation ของ user B ได้แม้ปลอม request body
5. toggle พร้อมกันสอง client ไม่ทำให้โต๊ะถูกจองซ้ำ
6. legacy และ normalized layouts แสดงผลเท่ากัน
7. Realtime อัปเดตเฉพาะ client ที่เกี่ยวข้อง
8. expired pending reservation ถูก release อัตโนมัติ
9. pending reservation, table status และ user JSONB สอดคล้องกันเสมอ
10. RPC คืน error code ที่ client นำไปแสดงผลได้

## 10. ข้อความสรุปพร้อมส่งให้ทีม Backend

> ทีม Munday นำ LayoutPreviewWidget เข้าโปรเจกต์และเชื่อมการอ่าน layout/toggle RPC เบื้องต้นแล้ว แต่ชุด integration ที่ได้รับยังขาด database schema, helper ต้นฉบับ, RLS/grants, Realtime configuration, seed data และ expiry cleanup จึงยังไม่สามารถรับรอง end-to-end behavior และ security ได้ ขอให้ส่ง deliverables ตามหัวข้อ 8 พร้อมยืนยัน business rules เรื่องหลายโต๊ะ, state transitions และการตรวจ auth.uid() ใน RPC นอกจากนี้ widget ต้นฉบับ subscribe Realtime กว้างทั้งตารางและไม่มี initial-fetch error/race protection ซึ่งทีม Munday ได้แก้ชั่วคราวแล้ว แต่ต้องการ data contract ต้นฉบับเพื่อยืนยัน implementation ก่อน QA production

## 11. ผลตรวจไฟล์ที่ Backend ส่งเพิ่ม (อัปเดต 7 สิงหาคม 2026)

ได้รับไฟล์เพิ่มในโฟลเดอร์ `ไฟล์เอกสาร/` ครบ 6 รายการ:

- `backup.sql`
- `supabase_helper.zip`
- `rls.zip`
- `CLEANUP_EXPIRED_PENDING_STATUS.sql`
- `SETUP_CLEANUP_CRON.sql`
- `backend_response_to_frontend.md`

สรุปสถานะ: ไฟล์ชุดนี้ช่วยยืนยัน schema และ mapping ได้หลายส่วน แต่ **ยังไม่ใช่ deployment package ที่รันได้ครบและปลอดภัย** ห้ามนำ SQL ทั้งชุดไปรันใน production โดยตรงจนกว่า Backend จะแก้ประเด็นระดับ Blocker/Critical ด้านล่าง

| Deliverable | สถานะล่าสุด | ข้อสรุป |
|---|---|---|
| Database schema | ได้รับบางส่วน | `backup.sql` ระบุเองว่าใช้ดู context เท่านั้นและอาจรันไม่ได้ ไม่มี migration order/index/trigger/function |
| Supabase helper | ได้รับ | ใช้ยืนยัน mapping ได้ แต่คัดลอกทับโปรเจกต์ไม่ได้โดยตรง เพราะอ้าง global `supabase` และมี API อื่นจำนวนมาก |
| Staff RLS | ได้รับ | ไฟล์ layout RLS มี policy สองเวอร์ชันซ้ำและขัดกัน จึงไม่ปลอดภัยที่จะ deploy |
| Customer/Public RLS | ได้เป็นโค้ดใน Markdown | ยังไม่มี migration file และ policy แบบ public เปิดเผยข้อมูลมากเกินไป |
| Realtime publication | ได้เป็นโค้ดใน Markdown | ยังไม่มี migration ที่ idempotent/rollback ได้ |
| Secure toggle RPC | ยังไม่ได้รับ | ได้เพียง snippet ที่มี `...`; ไฟล์ `FIX_TOGGLE_TABLE_RESERVATION.sql` ที่อ้างถึงไม่ได้อยู่ในชุด |
| Cleanup pending | ได้รับแต่ใช้ไม่ได้กับ schema ที่ส่งมา | อ้าง column ผิดและไม่รองรับ normalized tables |
| Cleanup payment_pending | ไม่ได้รับ | Cron เรียก function ที่ไม่มีไฟล์ส่งมา |
| Seed data | ได้เป็นโค้ดใน Markdownแต่รันไม่ได้ | ชื่อ column ไม่ตรง `backup.sql` |
| Data/state contract | ได้บางส่วน | ยังมี format และ TTL ที่ขัดกันเอง |

## 12. ปัญหาที่พบในไฟล์ชุดใหม่

### BE-09 — `backup.sql` ไม่ใช่ migration ที่ deploy ได้

ระดับ: Blocker

บรรทัดแรกของไฟล์ระบุชัดว่า schema นี้มีไว้ดู context เท่านั้น ลำดับตารางและ constraints อาจไม่สามารถ execute ได้ นอกจากนี้ไม่พบ SQL สำหรับ indexes, unique constraints, triggers, RLS, publications, RPC และ cron functions

ผลกระทบ:

- สร้าง environment ใหม่ให้เหมือน production ไม่ได้
- ไม่สามารถ reproduce/test transaction และ concurrency ได้
- RPC ใช้ `.limit(1)` กับ layout/floor แต่ schema ไม่มี uniqueness รับประกันว่ามีเพียงหนึ่งแถว

Constraints ที่ควรมีอย่างน้อย:

- unique `(venue_id, date)` บน `venue_daily_layouts`
- unique `(venue_daily_layout_id, floor_key)` บน `venue_daily_layout_floors`
- unique `(venue_daily_layout_floor_id, table_key)` บน `venue_daily_layout_tables`
- business constraint/index สำหรับ active reservation ที่ยังไม่หมดอายุต่อ user/venue/date

### BE-10 — `rls/venue_daily_layouts_rls.sql` มี policy สองชุดซ้ำและชุดหลังลดสิทธิ์ควบคุม

ระดับ: Critical/Security

ไฟล์เดียวกันมี policy ชุดแรกที่ตรวจ `layout.view`, `edit_table_status`, `edit_layout` และจำกัด DELETE ไว้เฉพาะ owner จากนั้นตั้งแต่ประมาณบรรทัด 401 มี policy ชุดที่สองซึ่ง drop/recreate ชื่อเดิมให้ staff ทุกคนอ่าน/เพิ่ม/แก้ได้ โดยไม่ตรวจ permission

ที่ร้ายกว่านั้น policy DELETE ชุดแรกใช้ชื่อ `*_delete_owner` แต่ชุดหลังใช้ `*_delete_staff` จึงอยู่พร้อมกันได้ และ PostgreSQL รวม permissive policies ด้วย OR ทำให้ staff ทั่วไปสามารถผ่าน policy DELETE ที่กว้างกว่าได้

สิ่งที่ต้องแก้:

- ส่งไฟล์ RLS canonical เพียงเวอร์ชันเดียว
- drop policy เก่าทุกชื่ออย่างชัดเจนก่อนสร้างใหม่
- เพิ่ม regression test แยก owner/manager/staff/customer/anon
- ยืนยันว่า DELETE layout/floor/table ต้องเป็น owner จริง

### BE-11 — Public RLS เปิดเผย customer/bill identifiers

ระดับ: Critical/Privacy

Policy ใน `backend_response_to_frontend.md` ให้ `TO public USING (true)` อ่านทุก row ของ `venue_daily_layout_tables` ขณะที่ schema มี `customer_uid`, `staff_bill_id`, `status_extra` และอาจมี `reservation_bill_id` ข้อมูลเหล่านี้ไม่ควรถูกเปิดให้ anon หรือผู้ใช้ทุกคนอ่านผ่าน `.select()`

Policy ของ `venues` ก็เปิดทุก column รวมข้อมูลที่อาจไม่ตั้งใจเผยแพร่ เช่น `promptpay` และข้อมูล operation อื่น

สิ่งที่ต้องแก้:

- สร้าง public view/RPC ที่คืนเฉพาะ geometry, capacity, display name และสถานะที่ผ่านการ sanitize
- ไม่ส่ง `customer_uid`, bill IDs หรือ status metadata ภายในให้ผู้ใช้คนอื่น
- แยก policy/column grants สำหรับ anon, customer, staff

### BE-12 — Secure RPC ที่ส่งมายังไม่ใช่ SQL ที่ execute ได้

ระดับ: Blocker/Security

เอกสารมีเพียงส่วนหัวของ `toggle_table_reservation` และ `auth.uid()` check แต่ body เป็น `...` และ `-- การทำงานจองโต๊ะเดิม...` ส่วนไฟล์ `FIX_TOGGLE_TABLE_RESERVATION.sql` ที่ลิงก์ไปยัง path ในเครื่องผู้ส่งไม่ได้อยู่ในโฟลเดอร์นี้

ยังต้องขอ SQL ตัวเต็มที่ระบุ:

- `SECURITY DEFINER`/`SECURITY INVOKER` และ fixed `search_path`
- `GRANT/REVOKE EXECUTE`
- row locking/concurrency behavior
- normalized และ legacy update behavior
- atomic update ของ table status, `active_reservations` และ `users.pending_reservations`
- stable success/error codes และ expiry rule

### BE-13 — Cleanup function compile ไม่ผ่านกับ `backup.sql`

ระดับ: Blocker

`CLEANUP_EXPIRED_PENDING_STATUS.sql` อ่านและเขียน `venue_daily_layouts.floors` แต่ schema ที่ส่งมามีเพียง `walls` และ `other_data` ไม่มี `floors` นอกจากนี้ function อัปเดต `updated_time` แต่ schema ใช้ `updated_at`

Function นี้รองรับเฉพาะ JSONB legacy และไม่ได้ cleanup `venue_daily_layout_tables` ซึ่งเป็น normalized schema ที่ helper เลือกใช้ก่อน

### BE-14 — Cleanup ทำให้ข้อมูล reservation ไม่สอดคล้องกัน

ระดับ: Critical/Data integrity

เมื่อ cleanup เปลี่ยน table จาก `pending` เป็น `available` function ไม่ได้ลบ/อัปเดต:

- `active_reservations`
- `users.pending_reservations`
- bill/reservation record ที่เกี่ยวข้อง

ผลคือ UI กับข้อมูลการจองอาจแสดงคนละสถานะ แม้ table จะถูกปล่อยแล้ว

### BE-15 — TTL ขัดกันระหว่างเอกสารและ cleanup

ระดับ: High

State document ระบุ `pending` ล็อก 5 นาที แต่ cleanup ใช้ 15 นาที และ cron comment ระบุ reset ทั้ง pending/payment_pending หลัง 15 นาที จึงยังไม่มี single source of truth สำหรับเวลาหมดอายุ

ขอให้ Backend กำหนด TTL ในจุดเดียว เช่น `expires_at` และให้ RPC/cleanup/UI ใช้ค่าเดียวกัน

### BE-16 — Cron เรียก function ที่ไม่ได้ส่งมา

ระดับ: Blocker

`SETUP_CLEANUP_CRON.sql` เรียก `cleanup_expired_payment_pending_status()` แต่ไม่มี function นี้ในไฟล์ชุดใหม่ และไฟล์ cleanup pending ระบุเองว่าไม่จัดการ `payment_pending`

นอกจากนี้ `CREATE EXTENSION IF NOT EXISTS pg_cron` ถูก comment ไว้ และ job รันทุกหนึ่งนาทีขณะที่ function loop พร้อม `FOR UPDATE` ทุก layout ทำให้เสี่ยง lock กว้าง, job overlap และ load สูงเมื่อข้อมูลโตขึ้น

### BE-17 — Cleanup เปิดสิทธิ์และซ่อนความล้มเหลวกว้างเกินไป

ระดับ: High/Security/Operations

Function cleanup ให้ authenticated เรียก global cleanup ได้ ซึ่งไม่จำเป็นสำหรับ customer app และมี exception handler ที่แปลง error เป็น JSON `success: false` แทนการ raise ทำให้ระบบ cron/monitoring อาจมอง job ว่าสำเร็จแม้ทำงานล้มเหลว

ควรให้ execute เฉพาะ service role/cron owner, จำกัด batch/row ที่หมดอายุจริง และให้ failure ปรากฏใน job monitoring

### BE-18 — Seed SQL ใช้ชื่อ column ไม่ตรง schema

ระดับ: High/QA Blocker

Seed ใน Markdown ใช้:

- `venues.name`, `venues.location` แต่ schema คือ `venue_name`, `position`
- `users.name` แต่ schema คือ `display_name`

จึงไม่สามารถนำ seed ไปรันทดสอบได้ และการ insert `users` ต้องสอดคล้องกับ foreign key ไป `auth.users(id)` ด้วย

### BE-19 — Legacy JSON example ไม่ตรง contract ของ widget/helper

ระดับ: High

ตัวอย่าง legacy ใช้ `x`, `y`, `width`, `height` และเก็บ `table_name`/capacity ใน `meta` แต่ widget ที่ส่งมาอ่านพิกัดแบบ `xi`, `yi` และ helper legacy คืน raw JSON โดยไม่แปลง geometry จึงไม่สามารถรับรองว่าจะ render layout ตัวอย่างนี้ได้ถูกต้อง

ต้องขอ payload จริงจาก production พร้อม JSON Schema หรือ fixture ที่ผ่าน automated test

### BE-20 — Realtime migration ยังไม่ idempotent และ helper ต้นฉบับ subscribe กว้าง

ระดับ: High

`ALTER PUBLICATION ... ADD TABLE` จะ error เมื่อ table ถูกเพิ่มไว้แล้ว และไม่มี down migration/verification query ส่วน helper ต้นฉบับ subscribe change ของ normalized table โดยไม่ filter venue/layout/floor ทำให้ทุก client refetch เมื่อโต๊ะใด ๆ ในระบบเปลี่ยน

ทีม Munday scope subscription ให้แคบลงชั่วคราวแล้ว แต่ Backend ควรยืนยัน publication, replica identity, RLS behavior และ filter strategy ที่รองรับ production scale

### BE-21 — Direct CRUD policy ของ `active_reservations` กว้างกว่าที่ client จำเป็นต้องใช้

ระดับ: High/Security

RLS ที่ส่งมาอนุญาต authenticated user INSERT/UPDATE/DELETE reservation ของตัวเองโดยตรง แต่ไม่ได้จำกัด column/state/expires/table IDs หาก flow ที่ตั้งใจคือให้ RPC ดูแล transaction ควรให้ client อ่านของตัวเองได้ และให้การเปลี่ยนแปลงผ่าน RPC ที่ validate business rules เท่านั้น

### BE-22 — Staff bill RLS ให้สิทธิ์แก้และลบกว้าง

ระดับ: High/Security

`staff_bills_rls.sql` ตรวจ permission `bill.view` เฉพาะ SELECT แต่ UPDATE และ DELETE อนุญาต staff active ทุกคนของ venue เอกสารยังระบุว่า void/refund ไปตรวจที่ app/RPC ซึ่งไม่ป้องกัน direct REST request ได้

ควร enforce permission และ state transition ที่ database/RPC ไม่ใช่พึ่ง UI

### BE-23 — Helper ที่ส่งมาไม่สามารถแทนไฟล์ใน Munday ตรง ๆ

ระดับ: Medium/Integration

Helper ต้นฉบับใช้ `static SupabaseClient get _client => supabase;` แต่ `supabase_config.dart` ของ Munday ใช้ `Supabase.instance.client` และไม่มี global `supabase` การคัดลอกทั้งไฟล์จึง compile ไม่ผ่าน และมี helper API อื่นจำนวนมากที่อาจชนกับ architecture ปัจจุบัน

ทีม Munday จึงนำมาเฉพาะ mapping ที่ยืนยันกับ schema ได้แก่:

- `shape_type` → `type`
- `display_name` → `table_name`
- `status_extra` รวมเข้า status
- `staff_bill_id`
- `bounds`, `label`, `sort_order`, `table_key` ordering

### BE-24 — Helper ต้นฉบับกลบ permission/network error เป็น “ไม่พบ layout”

ระดับ: Medium/Observability

`layoutUsesNormalized` catch ทุก error แล้วคืน `false` และ `fetchVenueDailyLayoutOnce` catch ทุก error แล้วคืน `null` จึงแยกไม่ได้ว่าไม่มีข้อมูล, RLS ปฏิเสธ, network error หรือ schema ผิด ทีม Munday คง error propagation ไว้เพื่อให้ UI แสดง retry/error ได้ถูกต้อง

## 13. สิ่งที่ integrate จากไฟล์ชุดใหม่แล้ว

- ปรับ normalized mapping ใน `lib/backend/supabase/supabase_helper.dart` ให้ตรง `backup.sql` และ helper ต้นฉบับ
- รองรับ `shape_type`, `display_name`, `status_extra`, `staff_bill_id`, floor `label`/`bounds`
- เรียง floor ด้วย `sort_order` และโต๊ะด้วย `table_key`
- รักษา Supabase client configuration และ error handling ของโปรเจกต์ Munday
- ตรวจ analyzer แล้วไม่มี compile error จาก helper/widget ที่แก้ใหม่; analyzer พบ lint เดิมจำนวนมากใน Booking/widget และ dead code ใน Booking ซึ่งไม่ใช่ error จาก mapping รอบนี้

สิ่งที่ยังไม่ integrate โดยตั้งใจ:

- SQL ใน `rls.zip` เพราะ policy ซ้ำและลดสิทธิ์
- Public RLS เพราะมี privacy exposure
- Cleanup/Cron เพราะไม่ตรง schema และขาด function
- Secure RPC snippet เพราะไม่ใช่ function ตัวเต็ม
- Seed data เพราะ column ไม่ตรง schema

## 14. รายการที่ต้องขอ Backend ส่งกลับรอบแก้ไข

### P0 — ต้องได้ก่อน QA booking

- [ ] `FIX_TOGGLE_TABLE_RESERVATION.sql` ตัวเต็ม ไม่มี placeholder พร้อม auth check, locking, grants และ error contract
- [ ] RLS migration canonical ที่ไม่มี policy ซ้ำ และไม่เปิด customer/bill identifiers ต่อ public
- [ ] Cleanup migration ที่รองรับ normalized schema และ sync ทุก reservation store แบบ atomic
- [ ] `cleanup_expired_payment_pending_status()` หรือยืนยันอย่างเป็นทางการว่าไม่ควรมี job นี้
- [ ] TTL ที่ยืนยันค่าเดียวกันสำหรับ RPC, `expires_at`, cleanup และ UI
- [ ] Seed migration ที่รันได้จริง พร้อม auth test users และ fixtures ทั้ง legacy/normalized

### P1 — ต้องได้ก่อน production

- [ ] Ordered migrations ตั้งแต่ schema, constraints, indexes, functions, RLS, grants, Realtime ถึง cron พร้อม rollback
- [ ] Unique constraints/indexes สำหรับ layout/floor/table/reservation keys
- [ ] Sanitized public layout API/view และ privacy contract
- [ ] State transition matrix ที่ระบุ actor, precondition, timeout, rollback และ terminal state
- [ ] Realtime scale/filter strategy และ verification query
- [ ] Automated database tests สำหรับ authorization, concurrency, expiry และ data consistency

## 15. ข้อความอัปเดตพร้อมส่งให้ทีม Backend

> ทีม Munday ได้รับและตรวจครบทั้ง `backup.sql`, helper, RLS, cleanup/cron และเอกสารตอบกลับแล้ว ข้อมูลชุดนี้ช่วยให้เราปรับ normalized mapping ให้ตรง schema ได้ แต่ SQL ยังไม่พร้อม deploy: layout RLS มี policy สองชุดซ้ำและชุดหลังเปิดสิทธิ์ staff กว้างขึ้น, public RLS เปิด `customer_uid`/bill metadata, secure toggle RPC มีเพียง snippet และขาดไฟล์ตัวเต็ม, cleanup อ้าง `floors`/`updated_time` ที่ไม่มีใน schema และไม่รองรับ normalized tables, cron เรียก payment cleanup function ที่ไม่ได้ส่งมา, TTL 5/15 นาทีขัดกัน และ seed ใช้ชื่อ column ไม่ตรง schema กรุณาส่ง migration ชุด canonical ตาม P0/P1 โดยเฉพาะ secure RPC ตัวเต็ม, RLS ที่ผ่าน role test, normalized cleanup แบบ atomic และ seed ที่ execute ได้ ก่อนนัด QA end-to-end

## 16. Re-audit แบบ End-to-End (7 สิงหาคม 2026)

คำตอบตรงไปตรงมา: **ยัง integrate ไม่ครบทุกอย่าง และยังยืนยันความถูกต้องแบบ end-to-end ไม่ได้**

ส่วนที่พร้อมในระดับ frontend component คือการโหลด/วาด layout, normalized mapping, floor selector, RPC wrapper และ Realtime บางส่วน แต่ booking flow ตั้งแต่เลือกวัน → เลือกโต๊ะ → สรุปราคา → ชำระเงิน → ยืนยันการจอง รวมถึง database security/deployment ยังไม่ครบ

### 16.1 Integration matrix ล่าสุด

| ส่วนงาน | สถานะ | หลักฐาน/ข้อจำกัด |
|---|---|---|
| Widget อยู่ใน shared widgets และ export แล้ว | ครบ | `lib/shared/widgets/layout/layout_preview_widget.dart`, `lib/shared/widgets/index.dart` |
| Booking page เรียก widget | ครบแบบมีข้อผิดพลาด | ส่ง venue/auth UID ได้ แต่ใช้วันที่ route เดิมและ hardcode `F1` |
| Supabase initialization | ครบ | ใช้ `SupabaseService` และ project `xdhhlxpysugtzkqrtdzp` |
| Normalized layout reader | ครบตาม schema ที่ได้รับ | รองรับ floor/table mapping, status/meta และ ordering |
| Legacy layout reader | บางส่วน | ส่ง raw `other_data`; payload ตัวอย่าง `x/y/width/height` ไม่ตรง widget `xi/yi` |
| Initial loading/error/retry | ครบ | มี loading, error UI, retry และ stale-request generation guard |
| Realtime table status | บางส่วน | scope table rows ตาม floor IDs แต่ยังไม่ฟัง floor insert/update/delete และ wall changes ครบ |
| Toggle RPC client wrapper | ครบเฉพาะการเรียก | ไม่ validate response `success`; server function local ยังไม่ปลอดภัย |
| Secure database RPC | ไม่ครบ | local migration ไม่มี `auth.uid()`, fixed search path, grants และใช้ default SECURITY INVOKER |
| Customer RLS/GRANT | ไม่พร้อม | SQL ที่ได้รับไม่ปลอดภัย และ environment จริงยังตอบ `42501` สำหรับ anon layout reads |
| Schema migrations/constraints/indexes | ไม่ครบ | มีเพียง context dump ไม่ใช่ ordered migrations |
| Cleanup/expiry | ไม่ครบ | SQL ไม่ตรง schema, ไม่รองรับ normalized, cron ขาด function |
| Booking summary | ไม่ครบ | `SeatSelect` และ `Totlepricebooking` ไม่ถูก update จาก RPC/DB |
| Payment flow | ไม่ครบ | `PayreservenormdayPage` เป็นหน้าเปล่าและไม่มี parameters/logic |
| Automated layout tests | ไม่มี | ไม่มี test สำหรับ mapping, widget states, RPC contract, Realtime หรือ date/floor flow |

## 17. ปัญหาเพิ่มเติมที่พบจาก Re-audit

### APP-01 — เปลี่ยนวันที่แล้ว layout/RPC ยังใช้วันเดิม

ระดับ: Blocker/Functional

`Calendarslide` อัปเดต `context.appState.dateclick` แต่ `LayoutPreviewWidget` รับ `date: widget.date!` จาก route และ `_handleTableTap` ก็ใช้ `widget.date` ค่าเดิม ดังนั้นหลังผู้ใช้กดวันใหม่:

- หัวหน้าจอและปฏิทินแสดงวันใหม่
- layout ยังเป็นวันเดิม
- RPC จองลงวันเดิม

นี่เป็นความเสี่ยงจองผิดวัน ไม่ใช่เพียง UI ไม่ refresh

### APP-02 — Route `floorId` ไม่มีผลจริง

ระดับ: High/Functional

Booking page รับ `floorId` จาก router แต่ตอนสร้าง widget hardcode `floorId: 'F1'` เสมอ ขณะที่ caller บางจุดส่ง string ว่างมา การเลือก floor ภายใน widget ยังใช้งานได้ แต่ initial floor จาก navigation contract ไม่ทำงาน

### APP-03 — Route parameters nullable แต่ถูก force unwrap

ระดับ: High/Reliability

Router สามารถสร้าง Booking page โดย `id`, `date`, `currentuid` เป็น null ได้ แต่หน้าใช้ `widget.id!` และ `widget.date!` หากเปิด deep link หรือ caller ส่ง parameter ไม่ครบจะ crash ก่อนแสดง error ที่เข้าใจได้

Booking page ยังไม่ใช้ `widget.currentuid` และส่ง global `currentUserUid` ให้ widget ทำให้ parameter contract กับ call sites ไม่สอดคล้องกัน

### APP-04 — Summary โต๊ะและราคาไม่เชื่อมกับการเลือกจริง

ระดับ: Blocker/Functional

Booking page reset `SeatSelect=[]` และ `Totlepricebooking=0` ตอนเปิดหน้า แต่ LayoutPreviewWidget ไม่เคยเพิ่ม/ลบค่าเหล่านี้หลัง RPC และไม่มี subscriber อ่าน `users.pending_reservations` หรือ `active_reservations` มา sync

ผลคือสามารถเปลี่ยนสถานะโต๊ะในฐานข้อมูลได้ แต่ summary ยังแสดงไม่มีโต๊ะ/ราคา 0

### APP-05 — Payment page ยังเป็นหน้าเปล่า

ระดับ: Blocker/End-to-end

ปุ่มดำเนินการต่อเปิด `PayreservenormdayPage` โดยไม่ส่ง venue/date/table IDs/amount/reservation ID และ body ของหน้า payment เป็น `Column(children: [])` จึงยังไม่มี booking confirmation/payment flow

### APP-06 — `reserved` และ `ready_to_pay` แสดงผลกำกวม

ระดับ: High/UX/State correctness

State document ของ Backend มี `reserved` และ `ready_to_pay` แต่ TableWidget/ChairWidget รู้จักเพียง `available`, `pending`, `payment_pending`, `occupied` สถานะอื่นตกเข้า default color ซึ่งดูคล้าย available แต่กดไม่ได้และไม่มี overlay/label ทำให้ผู้ใช้เข้าใจผิดว่าโต๊ะว่าง

### APP-07 — Client ไม่ตรวจ RPC response `success`

ระดับ: High/Error handling

หลังเรียก RPC widget ถือว่าสำเร็จทันทีและ refetch โดยไม่ตรวจ `result['success']` หาก Backend เปลี่ยนมาใช้ contract แบบ `{success:false,error:...}` แทน exception UI จะรายงานสำเร็จผิดและไม่แสดง error

### APP-08 — Realtime ยังไม่ครอบคลุม layout structure changes

ระดับ: Medium/Realtime correctness

Widget ฟัง:

- `venue_daily_layouts` filter เฉพาะ venue (ไม่ filter date)
- `venue_daily_layout_tables` เฉพาะ floor row IDs ที่มีตอน initial fetch

แต่ไม่ฟัง `venue_daily_layout_floors` จึงไม่เห็น floor/walls/bounds ใหม่หรือถูกลบแบบ realtime และเมื่อเพิ่ม floor ใหม่ channel เดิมก็ไม่ได้ subscribe table rows ของ floor นั้น

### APP-09 — `UsersRecord` ไม่มี `pending_reservations`

ระดับ: Medium/Data integration

Schema มี `users.pending_reservations` แต่ generated model ไม่ parse หรือ expose field นี้ ทำให้หน้า summary/payment ไม่สามารถใช้ record model ปัจจุบันเป็น data source ได้

### APP-10 — ไม่มี automated tests สำหรับ Layout Preview

ระดับ: High/QA

ใน `test/` ไม่มี test ที่อ้าง `LayoutPreviewWidget`, helper, layout tables หรือ toggle RPC จึงยังไม่มี regression proof สำหรับ:

- normalized/legacy fixtures
- ทุก table status
- multiple floors
- date change
- RPC success/failure
- Realtime refetch/dispose/race
- malformed/empty geometry

### RPC-08 — Local RPC ใช้ default SECURITY INVOKER ซึ่งขัดกับ RLS flow

ระดับ: Blocker/Functional/Security

Migration ใน repo ไม่ระบุ `SECURITY DEFINER` จึงเป็น SECURITY INVOKER โดย default แต่ RLS ที่ Backend เสนอให้ customer มีเพียง SELECT บน layout ส่วน UPDATE layout/table เป็น staff policy ดังนั้น authenticated customer ที่เรียก RPC จะไม่มีสิทธิ์ update table/users ภายใน function หาก RLS ทำงานตามที่เอกสารระบุ

Backend ต้องส่ง RPC ตัวเต็มที่เป็น security boundary ที่ชัดเจน เช่น SECURITY DEFINER พร้อม fixed `search_path`, `auth.uid()` validation, restricted execute grants และ database tests หรือออกแบบ RLS UPDATE ที่ปลอดภัยและพิสูจน์ได้

### RPC-09 — Legacy price/capacity path ไม่ตรง payload ที่ Backend ส่ง

ระดับ: High/Data correctness

Legacy sample เก็บ `price`, `min_capacity`, `max_capacity`, `table_name` ไว้ใน `meta` แต่ RPC local อ่าน `v_table_data->>'price'`, `min_seat`, `max_seat` ระดับบนสุด จึงคำนวณ total price/capacity เป็น 0 สำหรับ payload ตัวอย่างของ Backend

Widget legacy ก็อ่าน `price` และ `table_name` ระดับบนสุดเช่นกัน จึงไม่แสดงชื่อ/ราคาใน `meta` ตาม sample

### RPC-10 — Normalized toggle ไม่จัดการ stale status metadata

ระดับ: High/Data integrity

ตอนเปลี่ยน normalized table RPC อัปเดตเพียง `status_code`, `customer_uid`, timestamp แต่ไม่ clear/update `status_extra` และ `staff_bill_id` เมื่อปล่อยหรือจองโต๊ะใหม่ จึงอาจเหลือ reservation/bill metadata จากสถานะก่อนหน้า

### RPC-11 — RPC อนุญาตลูกค้าปล่อย `occupied` และ guard active reservation ใช้เงื่อนไขผิดเป้าหมาย

ระดับ: Critical/Business rule

RPC อนุญาต `occupied → available` เมื่อ `customer_uid` ตรงกับ `p_user_id` แม้ state document ระบุว่า `occupied` ถูกจัดการตอนพนักงาน check-in ส่วน guard แรก block สถานะอื่นเฉพาะเมื่อ `user_id != p_user_id`; row ID กลับถูก derive จาก `p_user_id` เอง ทำให้ own `payment_pending/occupied` ไม่ถูก block ที่ server

Frontend block บางสถานะได้ แต่ direct RPC request สามารถข้าม frontend ได้ โดยเฉพาะเมื่อ local RPC ยังไม่ตรวจ `auth.uid()`

### OPS-01 — Supabase environment ปัจจุบันยังอ่าน layout ด้วย anon ไม่ได้

ระดับ: Blocker หากต้องการ public preview

Read-only probe วันที่ 7 สิงหาคม 2026 ได้ผล:

- `venue_daily_layouts`: `42501 permission denied`
- `venue_daily_layout_floors`: `42501 permission denied`
- `venue_daily_layout_tables`: `42501 permission denied`
- `active_reservations` และ `users`: HTTP 200 สำหรับ anon แต่ผลนี้ยืนยันได้เพียง endpoint/RLS behavior ไม่ได้ยืนยันว่าเปิดเผย row

จึงสรุปได้ว่า Customer/Public layout policy หรือ table grants ใน Markdown ยังไม่มีผลกับ anon environment นี้ ส่วน authenticated customer ยังต้องทดสอบด้วย QA account แยกต่างหาก

### OPS-02 — Whole-project analyzer ยังไม่ผ่าน

ระดับ: Medium/Build hygiene

Integrated helper/widget วิเคราะห์แยกแล้วไม่มี compile error แต่ analyzer ทั้ง repo พบ compile errors จาก:

- ไฟล์ต้นฉบับ `layout_preview_widget.dart` ที่วางไว้ root และใช้ package-root imports นอก `lib/`
- dependency `qr_flutter` ไม่ได้ประกาศ แต่ `ticket_view.dart` import และใช้งาน

ไฟล์ต้นฉบับควรย้ายไป docs/archive ที่ analyzer ไม่สแกน หรือ exclude อย่างชัดเจนหลังยืนยันว่า integrated copy ถูกต้อง

### OPS-03 — Test suite ยังไม่ผ่านและไม่ทดสอบ layout

ระดับ: High/QA

ผล `flutter test`:

- ticket test compile ไม่ผ่านเพราะไม่มี `qr_flutter`
- default widget test fail เพราะไม่ได้ initialize Supabase ก่อนสร้าง `MyApp`
- ไม่มี Layout Preview test

ดังนั้นผล analyzer เฉพาะไฟล์ยืนยันได้เพียง compile compatibility ไม่ใช่ correctness ของ booking flow

## 18. ข้อสรุปความถูกต้อง

### ยืนยันว่าถูกต้องได้

- Widget ถูกวาง/export และเรียกใช้ใน Booking page แล้ว
- Supabase client ใช้ project เดียวกับแอป
- helper API ที่ widget เรียกมีครบ
- normalized column mapping ตรงกับ `backup.sql` สำหรับ geometry, display/type, status และ meta หลัก
- initial loading/error/retry, channel disposal และ stale fetch guard มีอยู่
- integrated helper/widget ไม่มี compile error เมื่อ analyze เฉพาะไฟล์

### ยังยืนยันไม่ได้หรือยืนยันว่าไม่ครบ

- authenticated customer อ่าน layout และเรียก RPC สำเร็จภายใต้ RLS จริง
- RPC production เป็นเวอร์ชันใดและตรวจ `auth.uid()` แล้วหรือไม่
- booking ถูกวันหลังเปลี่ยนปฏิทิน
- summary/price/payment ทำงานครบ
- expiry cleanup และ data stores สอดคล้องกัน
- Realtime รองรับ floor/layout changes ครบ
- state transitions ทั้งหมดแสดงผลและ enforce ถูก actor
- legacy payload ตามตัวอย่าง render/คิดราคาถูก
- concurrency, multi-client และ rollback behavior

## 19. ลำดับแก้ไขที่แนะนำก่อนประกาศว่า Integration เสร็จ

1. แก้ date source ให้ Booking และ widget ใช้วันเดียวกัน และ reset/refetch reservation เมื่อเปลี่ยนวัน
2. ให้ Backend ส่ง/deploy secure RPC + canonical RLS/grants แล้วทดสอบด้วย customer A/customer B/staff/anon
3. เชื่อม selected tables/price จาก server state เข้า Booking summary
4. ทำ payment/confirmation page พร้อม reservation identifier และ expiry handling
5. รองรับ `reserved`/`ready_to_pay` และยืนยันว่า customer ห้ามปล่อย `occupied`
6. แก้ cleanup normalized + active/user reservation consistency
7. เพิ่ม floor-table Realtime lifecycle และ authenticated QA test
8. เพิ่ม layout unit/widget/integration tests และทำ test suite ให้เขียว

## 20. Implementation close-out (อัปเดต 7 สิงหาคม 2026)

ส่วนนี้เป็นผลหลังดำเนินการแก้ไขตาม audit และให้ถือว่า supersede สถานะ
"ยังไม่ครบ" ในหัวข้อ 17–19 สำหรับงานที่อยู่ใน repository นี้

### 20.1 สิ่งที่ integrate และแก้แล้วในแอป

- Booking page ใช้ selected date เดียวกันกับ calendar, layout query และ payment route
- layout widget ส่ง selected table IDs, display names, total price และ minimum party size
  กลับเข้า Booking summary จาก server-derived layout state
- รองรับ normalized และ legacy payload รวม geometry `x/y/width/height`, nested
  `meta.price`, capacity และ table name
- รองรับ status `available`, `pending`, `payment_pending`, `reserved`, `occupied`
  และ `ready_to_pay`; ลูกค้า toggle ได้เฉพาะโต๊ะว่างหรือ pending ของตนเอง
- ตรวจ RPC response `success` และไม่ส่ง user id ว่าง
- Realtime ฟัง layouts, floors และ tables พร้อม rebuild subscriptions เมื่อโครงชั้นเปลี่ยน
- Payment page รับ reservation context จริง, โหลด active reservation และ authoritative
  server quote ก่อนแสดงยอด, จำกัดชนิดสลิป, upload ไป private bucket และ submit ผ่าน server RPC
- Router ส่ง `venueId`, `date`, `tableIds`, `amount` และ `partySize` ครบ
- `UsersRecord` รองรับ `pending_reservations` และ `pending_bills`
- เพิ่ม dependency `qr_flutter` และแก้ ticket QR API; exclude เฉพาะไฟล์ handoff ที่ root
  จาก analyzer (ตัวที่ integrate จริงใน `lib/` ยังถูก analyze ตามปกติ)

### 20.2 สิ่งที่เตรียมแล้วฝั่ง Supabase

- reapply migration ของ `toggle_table_reservation` แบบ `SECURITY DEFINER`, fixed
  `search_path`, ตรวจ `auth.uid()`, ห้ามวันย้อนหลัง, ห้าม customer ปล่อย occupied,
  clear stale metadata และ restrict execute grant
- canonical RLS/grants แยก customer/staff/owner ตาม operation; การลบ layout/floor/table
  จำกัด owner และ staff bill policy ตรงกับ permissions contract ที่ทีมหลังบ้านส่งมา
- unique constraints สำหรับ layout/floor/active reservation และ trigger กัน `table_key`
  ซ้ำข้าม floor ใน daily layout เดียวกัน
- private `reservation-slips` bucket จำกัด owner folder, ขนาด 10 MB และ MIME type
- `get_reservation_payment_quote` คำนวณยอดก่อนโอนจาก layout จริง และ
  `submit_reservation_payment` คำนวณซ้ำจาก server state, lock active
  reservation และเปลี่ยนสถานะเป็น `payment_pending` แบบ transaction เดียว
- `verify_reservation_payment` สำหรับ trusted service และ webhook bridge ที่ตรวจ shared
  secret ก่อนใช้ service-role key
- cleanup RPC รองรับ normalized/legacy state และ cron ทุกหนึ่งนาทีเมื่อมี `pg_cron`
- Realtime publication แบบ idempotent สำหรับ layouts/floors/tables

ไฟล์ deploy/runbook อยู่ที่ `supabase/LAYOUT_RESERVATION_DEPLOYMENT.md` และ migrations
อยู่ใน `supabase/migrations/` ตาม timestamp order

### 20.3 ผลตรวจใน repository

- `flutter test`: ผ่านทั้งหมด 15 tests (ผลล่าสุด 12 สิงหาคม 2026)
- `flutter analyze --no-fatal-infos --no-fatal-warnings`: exit code 0 และไม่มี compile
  error; repo เดิมยังมี warning/info 5,704 รายการซึ่งไม่ใช่ compile blocker
- เพิ่ม tests สำหรับ legacy normalization, cross-floor selection summary, unauthenticated
  behavior, secure migration contract, verification webhook และ app-root smoke test

### 20.4 งานที่ต้องให้ทีมหลังบ้าน/ผู้ดูแล production ดำเนินการ

ยังไม่ถือว่า production rollout เสร็จจนกว่าจะทำรายการต่อไปนี้ เพราะต้องใช้สิทธิ์ Supabase
production และระบบตรวจสลิปภายนอก ซึ่งไม่มี credential อยู่ใน repository:

1. สำรองฐานข้อมูลและรัน preflight duplicate queries ใน deployment runbook
2. แก้ duplicate ที่พบโดยอิง source of truth แล้ว apply migrations ตามลำดับ
3. ตั้ง `SLIP_VERIFICATION_WEBHOOK_SECRET` และ deploy Edge Function
   `verify-payment-for-reservation`
4. ให้บริการตรวจสลิปจริงส่งผล approved/rejected, tx ref และ slip hash เข้า webhook
5. ทดสอบ staging ด้วย customer A/customer B/staff/owner รวม concurrency, expiry,
   approve/reject และ Realtime ก่อน deploy production

ข้อ 4 สำคัญ: โค้ดใน repo เป็น secure webhook/finalization bridge ไม่ใช่ engine อ่านหรือ
ยืนยันสลิปธนาคารเอง ทีมหลังบ้านต้องเชื่อม verifier/provider ที่ใช้งานจริง

หมายเหตุด้าน product/security: migration เปิด layout ให้เฉพาะ `authenticated` โดยตั้งใจ
ไม่เปิด `anon` ตามตัวอย่างแรกของทีมหลังบ้าน เนื่องจาก Booking route ต้อง login และ table row
มี `customer_uid` อยู่ หากอนาคตต้องมี public preview ควรเพิ่ม read model/view ที่ตัดข้อมูลลูกค้า
ออก แทนการ grant `SELECT *` บนตารางจริงให้ anon

## 21. Incident: พบ F1 แต่ customer เห็นโต๊ะ 0 ตัว (12 สิงหาคม 2026)

หน้าจอของ venue `02bbf696-17e4-4d9b-9be8-1e46abcd5ddf` วันที่ `2026-08-12`
ยืนยันว่า customer อ่าน daily layout และ floor row `F1` ได้ แต่ query ที่แอปได้รับมี table row
ที่มองเห็นได้เป็นศูนย์ หรือ normalized floor shell ไปซ่อนโต๊ะใน legacy `other_data`

แก้ฝั่งแอปแล้วโดย merge legacy และ normalized layout ระหว่าง migration:

- โต๊ะที่ยังอยู่ใน `other_data` ไม่ถูก floor shell ว่างเขียนทับอีก
- normalized table row override โต๊ะ key เดียวกัน เพื่อให้สถานะจองล่าสุดเป็น source of truth
- เพิ่ม log `_layout_inventory` แยกจำนวน `legacy_tables`, `normalized_tables` และ
  `merged_tables`
- เพิ่ม unit tests สำหรับ floor shell ว่าง, hybrid table override และ direct legacy layout

หากหลังติดตั้งแอปเวอร์ชันนี้ log ยังเป็น
`legacy_tables: 0, normalized_tables: 0, merged_tables: 0` แปลว่าไม่ใช่ปัญหาการวาด UI:
ฐานข้อมูลของ venue/date นี้ไม่มีโต๊ะ หรือ RLS ของ authenticated customer ซ่อน table rows

ทีม Backend ต้องรัน query นี้ด้วยสิทธิ์ service role/SQL Editor และส่งผลกลับ:

```sql
SELECT
  layout.id AS layout_id,
  layout.venue_id,
  layout.date,
  floor.id AS floor_row_id,
  floor.floor_key,
  count(table_row.id) AS normalized_table_count,
  jsonb_object_length(
    COALESCE(
      layout.other_data->'floors'->floor.floor_key->'table_layout',
      layout.other_data->floor.floor_key->'table_layout',
      layout.other_data->'table_layout',
      '{}'::jsonb
    )
  ) AS legacy_table_count
FROM public.venue_daily_layouts AS layout
LEFT JOIN public.venue_daily_layout_floors AS floor
  ON floor.venue_daily_layout_id = layout.id
LEFT JOIN public.venue_daily_layout_tables AS table_row
  ON table_row.venue_daily_layout_floor_id = floor.id
WHERE layout.venue_id = '02bbf696-17e4-4d9b-9be8-1e46abcd5ddf'::uuid
  AND layout.date = '2026-08-12'::date
GROUP BY layout.id, layout.venue_id, layout.date, floor.id, floor.floor_key;
```

พร้อมทดสอบด้วย customer JWT ว่า `SELECT` ตาราง `venue_daily_layout_tables` คืนจำนวนเท่ากับ
service role และยืนยันว่า migration `table_customer_read`/`GRANT SELECT ... TO authenticated`
ถูก deploy แล้ว เอกสาร seed ที่ได้รับมีเพียง layout ว่างของ `2026-08-05` และไม่มีคำสั่ง
insert floor/table row จึงใช้เป็นหลักฐานว่า production วันที่ `2026-08-12` มีโต๊ะไม่ได้
