# คู่มือการติดตั้งและใช้งาน LayoutPreviewWidget ในโปรเจกต์ใหม่ (Integration Guide)

เอกสารนี้รวบรวมรายละเอียดพารามิเตอร์, โครงสร้างฐานข้อมูล (Database Schema), ฟังก์ชัน PostgreSQL (RPC), และตัวอย่างการนำ [layout_preview_widget.dart](file:///Users/romporatchanon/Downloads/mundaymanager_off/lib/widgets/layout_preview_widget.dart) ไปประยุกต์ใช้ในโปรเจกต์ Flutter อื่นๆ

---

## 1. ข้อมูลพารามิเตอร์ของ Widget

เวลาเรียกใช้ `LayoutPreviewWidget` จากหน้าหลัก (Parent Page) จะต้องส่งพารามิเตอร์ที่จำเป็นดังนี้:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `width` | `double` | ✅ Yes | ความกว้างของพื้นที่วาดแผนที่โต๊ะ (เช่น กว้างเต็มหน้าจอ) |
| `height` | `double` | ✅ Yes | ความสูงของพื้นที่วาดแผนที่โต๊ะ (เช่น `500` หรือความสูงคงที่อื่นๆ) |
| `currentuid` | `String` | ✅ Yes | Database User ID ของผู้ใช้งานที่ล็อกอินปัจจุบัน (ใช้เพื่อเช็คสิทธิ์จอง/ปล่อยโต๊ะตัวเอง) |
| `venueId` | `String` | ✅ Yes | ID ของสถานที่/ร้านอาหาร (UUID) |
| `date` | `DateTime` | ✅ Yes | วันที่สำหรับเรียกดูหรือจองเลย์เอาต์โต๊ะ |
| `floorId` | `String` | ❌ No | ID ของชั้นที่ต้องการแสดงเริ่มต้น (มีค่าเริ่มต้นเป็น `'F1'`) |

---

## 2. สิ่งที่โปรเจกต์ใหม่ต้องเตรียม (System & Database Requirements)

เพื่อให้ฟังก์ชันการทำงานด้านแผนที่และระบบการจองทำงานได้สมบูรณ์ โปรเจกต์ใหม่ต้องเตรียมโครงสร้างเหล่านี้ในระบบ:

### 🅰️ ฝั่งฐานข้อมูล Supabase (Database Schema & RPC)

ต้องทำการสร้างตารางแผนที่โต๊ะเหล่านี้ใน Supabase Instance ใหม่ (สคริปต์แบบเต็มดูได้จากไฟล์ [backup.sql](file:///Users/romporatchanon/Downloads/mundaymanager_off/backup.sql) ในโครงการปัจจุบัน):

1. **ตารางหลักและตารางย่อยสำหรับ Normalized Layout:**
   * **`venue_daily_layouts`**: ตารางเก็บ ID และวันที่ใช้งานเลย์เอาต์
   * **`venue_daily_layout_floors`**: ตารางเก็บ ID และรายละเอียดชั้น/กำแพง
   * **`venue_daily_layout_tables`**: ตารางเก็บพิกัด (`xi`, `yi`), รูปแบบ, และสถานะของแต่ละโต๊ะ
   * **`active_reservations`**: ตารางตรวจสอบและจองโต๊ะชั่วคราว
   * **`users`**: ตารางข้อมูลผู้ใช้ (ต้องการคอลัมน์ `pending_reservations` ประเภท `jsonb`)

2. **สร้าง PostgreSQL Function (RPC) ใน Supabase:**
   ต้องนำสคริปต์ SQL ของฟังก์ชัน `toggle_table_reservation` (ด้านล่างนี้) ไปกดรันใน **Supabase SQL Editor** ของโปรเจกต์ใหม่ เพื่อให้ฟังก์ชันการจองทำงานได้อย่างถูกต้อง

<details>
<summary><b>คลิกเพื่อดูสคริปต์ SQL ฟังก์ชัน toggle_table_reservation</b></summary>

```sql
DROP FUNCTION IF EXISTS toggle_table_reservation(uuid, text, text, uuid, text);

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
  v_layout_data JSONB;
  v_other_data JSONB;
  v_table_data JSONB;
  v_table_layout JSONB;
  v_available_keys TEXT;
  v_top_level_keys TEXT;
  v_floor_keys TEXT;
  v_debug_structure TEXT;
  v_has_floors BOOLEAN := false;
  v_has_floor_id BOOLEAN := false;
  v_floors_has_floor_id BOOLEAN := false;
  v_floor_has_table_layout BOOLEAN := false;
  v_sample_structure TEXT;
  v_floors_jsonb TEXT;
  v_status JSONB;
  v_current_status TEXT;
  v_current_uid TEXT;
  v_price NUMERIC := 0;
  v_min_capacity INTEGER := 0;
  v_max_capacity INTEGER := 0;
  v_new_status JSONB;
  v_should_update_user BOOLEAN := false;
  v_is_adding BOOLEAN := false;
  v_pending_reservations JSONB;
  v_reservation_key TEXT;
  v_reservation JSONB;
  v_table_ids TEXT[];
  v_capacity_pairs JSONB;
  v_active_reservation_status TEXT;
  v_active_reservation_user_id UUID;
  
  v_is_normalized BOOLEAN := false;
  v_floor_row_id UUID;
  v_meta JSONB;
BEGIN
  -- 0. ตรวจสอบ active_reservations
  DECLARE
    v_active_reservation_id UUID;
    v_hash_string TEXT;
  BEGIN
    v_hash_string := p_user_id::TEXT || '_' || p_venue_id::TEXT || '_' || p_date;
    v_active_reservation_id := (
      substring(md5(v_hash_string), 1, 8) || '-' ||
      substring(md5(v_hash_string), 9, 4) || '-' ||
      substring(md5(v_hash_string), 13, 4) || '-' ||
      substring(md5(v_hash_string), 17, 4) || '-' ||
      substring(md5(v_hash_string), 21, 12)
    )::uuid;
    
    SELECT status, user_id INTO v_active_reservation_status, v_active_reservation_user_id
    FROM active_reservations WHERE id = v_active_reservation_id;
    
    IF v_active_reservation_status IS NOT NULL THEN
      IF v_active_reservation_status NOT IN ('available', 'pending') 
         AND v_active_reservation_user_id != p_user_id THEN
        RAISE EXCEPTION 'Cannot toggle table. Active reservation status is % and belongs to another user', 
          v_active_reservation_status;
      END IF;
    END IF;
  END;
  
  -- 1. อ่าน daily_layout
  SELECT vdl.id, vdl.other_data INTO v_layout_id, v_other_data
  FROM venue_daily_layouts vdl
  WHERE vdl.venue_id = p_venue_id AND vdl.date = p_date::date FOR UPDATE;
  
  IF v_layout_id IS NULL THEN
    RAISE EXCEPTION 'Layout not found for venue % and date %', p_venue_id, p_date;
  END IF;

  SELECT EXISTS (
    SELECT 1 FROM venue_daily_layout_floors WHERE venue_daily_layout_id = v_layout_id
  ) INTO v_is_normalized;

  -- 2. ดึงข้อมูลโต๊ะ
  IF v_is_normalized THEN
    SELECT id INTO v_floor_row_id FROM venue_daily_layout_floors
    WHERE venue_daily_layout_id = v_layout_id AND floor_key = p_floor_id;
    
    IF v_floor_row_id IS NULL THEN
      RAISE EXCEPTION 'Floor % not found in normalized layout', p_floor_id;
    END IF;
    
    SELECT status_code, COALESCE(customer_uid, ''), min_capacity, max_capacity, meta
    INTO v_current_status, v_current_uid, v_min_capacity, v_max_capacity, v_meta
    FROM venue_daily_layout_tables
    WHERE venue_daily_layout_floor_id = v_floor_row_id AND table_key = p_table_id;
    
    IF v_current_status IS NULL THEN
      RAISE EXCEPTION 'Table % not found in normalized floor %', p_table_id, p_floor_id;
    END IF;
    
    v_price := COALESCE((v_meta->>'price')::NUMERIC, 0);
    v_min_capacity := COALESCE(v_min_capacity, 0);
    v_max_capacity := COALESCE(v_max_capacity, 0);
    
  ELSE
    IF v_other_data IS NOT NULL AND jsonb_typeof(v_other_data) = 'object' THEN
      v_layout_data := v_other_data;
    ELSE
      v_layout_data := '{}'::jsonb;
    END IF;

    IF v_layout_data IS NOT NULL AND jsonb_typeof(v_layout_data) = 'object' THEN
      IF v_layout_data ? 'floors' THEN
        IF jsonb_typeof(v_layout_data->'floors') = 'object' AND (v_layout_data->'floors') ? p_floor_id THEN
          IF (v_layout_data->'floors'->p_floor_id) ? 'table_layout' THEN
            v_table_layout := v_layout_data->'floors'->p_floor_id->'table_layout';
            IF v_table_layout IS NOT NULL AND jsonb_typeof(v_table_layout) = 'object' THEN
              v_table_data := v_table_layout->p_table_id;
            END IF;
          END IF;
        END IF;
      ELSIF v_layout_data ? p_floor_id THEN
        IF jsonb_typeof(v_layout_data->p_floor_id) = 'object' AND (v_layout_data->p_floor_id) ? 'table_layout' THEN
          v_table_layout := v_layout_data->p_floor_id->'table_layout';
          IF v_table_layout IS NOT NULL AND jsonb_typeof(v_table_layout) = 'object' THEN
            v_table_data := v_table_layout->p_table_id;
          END IF;
        END IF;
      ELSIF v_layout_data ? 'table_layout' THEN
        v_table_layout := v_layout_data->'table_layout';
        IF v_table_layout IS NOT NULL AND jsonb_typeof(v_table_layout) = 'object' THEN
          v_table_data := v_table_layout->p_table_id;
        END IF;
      END IF;
    END IF;
    
    IF v_table_data IS NULL THEN
      RAISE EXCEPTION 'Table % not found in floor %', p_table_id, p_floor_id;
    END IF;
    
    v_status := v_table_data->'status';
    v_current_status := COALESCE(v_status->>'status_code', 'available');
    v_current_uid := COALESCE(v_status->>'customer_uid', '');
    v_price := COALESCE((v_table_data->>'price')::NUMERIC, 0);
    v_min_capacity := COALESCE((v_table_data->>'min_seat')::INTEGER, 0);
    v_max_capacity := COALESCE((v_table_data->>'max_seat')::INTEGER, 0);
  END IF;
  
  -- 3. คำนวณ new status
  IF v_current_status = 'available' THEN
    v_new_status := jsonb_build_object(
      'status_code', 'pending',
      'customer_uid', p_user_id::TEXT,
      'booking_id', '',
      'customer_name', '',
      'status_action_timestamp', (extract(epoch from now()) * 1000)::bigint
    );
    v_should_update_user := true;
    v_is_adding := true;
  ELSIF v_current_status = 'pending' AND v_current_uid = p_user_id::TEXT THEN
    v_new_status := jsonb_build_object(
      'status_code', 'available',
      'customer_uid', '',
      'booking_id', '',
      'customer_name', '',
      'status_action_timestamp', (extract(epoch from now()) * 1000)::bigint
    );
    v_should_update_user := true;
    v_is_adding := false;
  ELSIF v_current_status = 'occupied' AND v_current_uid = p_user_id::TEXT THEN
    v_new_status := jsonb_build_object(
      'status_code', 'available',
      'customer_uid', '',
      'booking_id', '',
      'customer_name', '',
      'status_action_timestamp', (extract(epoch from now()) * 1000)::bigint
    );
    v_should_update_user := true;
    v_is_adding := false;
  ELSE
    RAISE EXCEPTION 'Cannot toggle this table. Current status: %, Current UID: %', v_current_status, v_current_uid;
  END IF;
  
  -- 4. อัปเดต Table Status
  IF v_is_normalized THEN
    UPDATE venue_daily_layout_tables
    SET status_code = v_new_status->>'status_code',
        customer_uid = CASE WHEN v_new_status->>'customer_uid' = '' THEN NULL ELSE v_new_status->>'customer_uid' END,
        status_action_timestamp = (v_new_status->>'status_action_timestamp')::numeric::bigint,
        updated_at = now()
    WHERE venue_daily_layout_floor_id = v_floor_row_id AND table_key = p_table_id;
    
    UPDATE venue_daily_layouts SET updated_at = now() WHERE id = v_layout_id;
  ELSE
    IF v_layout_data ? p_floor_id AND jsonb_typeof(v_layout_data->p_floor_id) = 'object' THEN
      v_layout_data := jsonb_set(v_layout_data, ARRAY[p_floor_id, 'table_layout', p_table_id, 'status'], v_new_status);
    ELSIF v_layout_data ? 'floors' AND jsonb_typeof(v_layout_data->'floors') = 'object' THEN
      v_layout_data := jsonb_set(v_layout_data, ARRAY['floors', p_floor_id, 'table_layout', p_table_id, 'status'], v_new_status);
    ELSE
      v_layout_data := jsonb_set(v_layout_data, ARRAY['table_layout', p_table_id, 'status'], v_new_status);
    END IF;
    v_layout_data := jsonb_set(v_layout_data, ARRAY['updated_at'], to_jsonb(now()));
    
    UPDATE venue_daily_layouts SET other_data = v_layout_data, updated_at = now() WHERE id = v_layout_id;
  END IF;
  
  -- 5. อัปเดต user pending_reservations
  IF v_should_update_user THEN
    SELECT COALESCE(pending_reservations, '{}'::jsonb) as pending_reservations_data
    INTO v_pending_reservations FROM users WHERE id = p_user_id FOR UPDATE;
    
    IF v_pending_reservations IS NULL THEN
      RAISE EXCEPTION 'User not found: %', p_user_id;
    END IF;
    
    v_reservation_key := p_venue_id::TEXT || '_' || p_date;
    
    IF v_is_adding THEN
      IF v_pending_reservations ? v_reservation_key THEN
        v_reservation := v_pending_reservations->v_reservation_key;
        v_table_ids := ARRAY(SELECT jsonb_array_elements_text(v_reservation->'tableIds'));
        v_capacity_pairs := v_reservation->'table_capacity_pairs';
        
        IF NOT (p_table_id = ANY(v_table_ids)) THEN
          v_table_ids := array_append(v_table_ids, p_table_id);
          v_capacity_pairs := jsonb_insert(v_capacity_pairs, '{-1}', jsonb_build_object('min', v_min_capacity, 'max', v_max_capacity));
          v_reservation := jsonb_set(
            jsonb_set(jsonb_set(v_reservation, '{tableIds}', to_jsonb(v_table_ids)), '{table_capacity_pairs}', v_capacity_pairs),
            '{totalPrice}', to_jsonb(COALESCE((v_reservation->>'totalPrice')::NUMERIC, 0) + v_price)
          );
          v_reservation := jsonb_set(v_reservation, '{updatedAt}', to_jsonb(now()));
        END IF;
      ELSE
        v_reservation := jsonb_build_object(
          'venueId', p_venue_id::TEXT,
          'date', p_date,
          'tableIds', jsonb_build_array(p_table_id),
          'table_capacity_pairs', jsonb_build_array(jsonb_build_object('min', v_min_capacity, 'max', v_max_capacity)),
          'totalPrice', v_price,
          'createdAt', now(),
          'updatedAt', now()
        );
      END IF;
      v_pending_reservations := jsonb_set(v_pending_reservations, ARRAY[v_reservation_key], v_reservation);
    ELSE
      IF v_pending_reservations ? v_reservation_key THEN
        v_reservation := v_pending_reservations->v_reservation_key;
        v_table_ids := ARRAY(SELECT jsonb_array_elements_text(v_reservation->'tableIds'));
        v_capacity_pairs := v_reservation->'table_capacity_pairs';
        
        DECLARE
          v_idx INTEGER;
        BEGIN
          v_idx := array_position(v_table_ids, p_table_id);
          IF v_idx IS NOT NULL THEN
            v_table_ids := array_remove(v_table_ids, p_table_id);
            v_capacity_pairs := (
              SELECT jsonb_agg(elem) FROM jsonb_array_elements(v_capacity_pairs) WITH ORDINALITY AS t(elem, idx) WHERE idx != v_idx
            );
            IF array_length(v_table_ids, 1) IS NULL THEN
              v_pending_reservations := v_pending_reservations - v_reservation_key;
            ELSE
              v_reservation := jsonb_set(
                jsonb_set(jsonb_set(v_reservation, '{tableIds}', to_jsonb(v_table_ids)), '{table_capacity_pairs}', v_capacity_pairs),
                '{totalPrice}', to_jsonb(COALESCE((v_reservation->>'totalPrice')::NUMERIC, 0) - v_price)
              );
              v_reservation := jsonb_set(v_reservation, '{updatedAt}', to_jsonb(now()));
              v_pending_reservations := jsonb_set(v_pending_reservations, ARRAY[v_reservation_key], v_reservation);
            END IF;
          END IF;
        END;
      END IF;
    END IF;
    
    UPDATE users SET pending_reservations = v_pending_reservations WHERE id = p_user_id;
  END IF;
  
  -- 6. อัปเดต/สร้าง active_reservations
  IF v_should_update_user THEN
    DECLARE
      v_active_reservation_id UUID;
      v_hash_string TEXT;
    BEGIN
      v_hash_string := p_user_id::TEXT || '_' || p_venue_id::TEXT || '_' || p_date;
      v_active_reservation_id := (
        substring(md5(v_hash_string), 1, 8) || '-' ||
        substring(md5(v_hash_string), 9, 4) || '-' ||
        substring(md5(v_hash_string), 13, 4) || '-' ||
        substring(md5(v_hash_string), 17, 4) || '-' ||
        substring(md5(v_hash_string), 21, 12)
      )::uuid;
      
      IF v_is_adding THEN
        BEGIN
          INSERT INTO active_reservations (
            id, user_id, venue_id, date, table_ids, status, expires_at, updated_at
          ) VALUES (
            v_active_reservation_id, p_user_id, p_venue_id, date(p_date), ARRAY[p_table_id], 'pending', now() + INTERVAL '5 minutes', now()
          );
        EXCEPTION WHEN unique_violation THEN
          UPDATE active_reservations
          SET table_ids = CASE WHEN p_table_id = ANY(table_ids) THEN table_ids ELSE table_ids || ARRAY[p_table_id] END,
              status = 'pending',
              expires_at = now() + INTERVAL '5 minutes',
              updated_at = now()
          WHERE id = v_active_reservation_id;
        END;
      ELSE
        DECLARE
          v_updated_table_ids TEXT[];
        BEGIN
          UPDATE active_reservations
          SET table_ids = array_remove(table_ids, p_table_id), updated_at = now()
          WHERE id = v_active_reservation_id RETURNING table_ids INTO v_updated_table_ids;
          
          IF v_updated_table_ids IS NULL OR array_length(v_updated_table_ids, 1) IS NULL THEN
            DELETE FROM active_reservations WHERE id = v_active_reservation_id;
          END IF;
        END;
      END IF;
    END;
  END IF;
  
  RETURN jsonb_build_object(
    'success', true,
    'new_status', v_new_status->>'status_code',
    'table_id', p_table_id,
    'venue_id', p_venue_id::TEXT,
    'date', p_date
  );
END;
$$;
```
</details>

### 🅱️ ฝั่งโค้ด Flutter (การย้ายไฟล์ช่วยเหลือ)

ย้ายหรือนำโค้ดในไฟล์ [supabase_helper.dart](file:///Users/romporatchanon/Downloads/mundaymanager_off/lib/backend/supabase/supabase_helper.dart) ในส่วนฟังก์ชันที่เกี่ยวข้องกับ Layout ไปยังโปรเจกต์ใหม่:

1. **`fetchVenueDailyLayoutOnce(venueId, date)`**: ฟังก์ชันดึงเลย์เอาต์ครั้งแรกจากระบบ (เลือกดึงจาก Normalized tables หรือ legacy JSONB อัตโนมัติ)
2. **`fetchLayoutFromNormalizedTables(venueId, date)`**: ฟังก์ชันประกอบเลย์เอาต์จากตารางแยก `venue_daily_layout_floors` และ `venue_daily_layout_tables` ส่งกลับไปเป็น JSON เพื่อวาด UI
3. **`toggleTableReservation(...)`**: ฟังก์ชันสำหรับสั่งยิง RPC `toggle_table_reservation` ใน Supabase (ที่ได้นำมาใส่โค้ดในฝั่ง Flutter)

---

## 3. โค้ดตัวอย่างในหน้า Parent Page สำหรับเรียกใช้

เพื่อนของคุณสามารถนำโค้ดนี้ไปตั้งต้นเป็นหน้าจอหลักสำหรับเรียกใช้งานแผนที่โต๊ะ `LayoutPreviewWidget` ได้เลย:

```dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// แก้ path การ import ไปยัง widget และ helper ของโปรเจกต์ใหม่
import 'package:new_project/widgets/layout_preview_widget.dart'; 

class TableSelectionScreen extends StatefulWidget {
  final String venueId; // ID ของร้าน/คลับ ที่ผู้ใช้งานเลือกเข้ามาก่อนหน้านี้

  const TableSelectionScreen({super.key, required this.venueId});

  @override
  State<TableSelectionScreen> createState() => _TableSelectionScreenState();
}

class _TableSelectionScreenState extends State<TableSelectionScreen> {
  String? currentUserId;
  DateTime selectedDate = DateTime.now(); // วันที่จอง (เริ่มต้นเป็นวันนี้)

  @override
  void initState() {
    super.initState();
    // ดึง User ID ผู้ใช้ปัจจุบันจาก Supabase Auth 
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      currentUserId = user?.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (currentUserId == null) {
      return const Scaffold(
        body: Center(
          child: Text('กรุณาเข้าสู่ระบบก่อนเลือกโต๊ะ'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('เลือกโต๊ะสำหรับจอง'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // แสดงแผนที่และโต๊ะอาหารแบบ Interactive
            SizedBox(
              width: screenWidth,
              height: 500,
              child: LayoutPreviewWidget(
                width: screenWidth,
                height: 500,
                currentuid: currentUserId!,   // Database User ID
                venueId: widget.venueId,       // ID ของร้าน
                date: selectedDate,            // วันที่ต้องการดูแผนที่
                floorId: 'F1',                 // กำหนดชั้นเริ่มต้น (เช่น F1)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
