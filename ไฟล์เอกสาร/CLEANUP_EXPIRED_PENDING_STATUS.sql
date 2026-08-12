-- ========================================================================
-- Cleanup Expired Pending Status
-- Reset pending status ที่เกิน 15 นาทีกลับเป็น available
-- payment_pending ไม่เกี่ยว (ไม่ต้อง reset)
-- ========================================================================

CREATE OR REPLACE FUNCTION cleanup_expired_pending_status()
RETURNS JSONB
LANGUAGE plpgsql
AS $$
DECLARE
  v_updated_count INTEGER := 0;
  v_layout_record RECORD;
  v_layout_data JSONB;
  v_floors_data JSONB;
  v_other_data JSONB;
  v_table_layout JSONB;
  v_table_id TEXT;
  v_table_data JSONB;
  v_status JSONB;
  v_status_code TEXT;
  v_status_timestamp BIGINT;
  v_current_timestamp BIGINT;
  v_minutes_elapsed NUMERIC;
  v_new_status JSONB;
  v_use_floors_column BOOLEAN := false;
  v_floor_id TEXT;
  v_has_floors BOOLEAN := false;
  v_updated_tables TEXT[] := ARRAY[]::TEXT[];
  v_start_time TIMESTAMPTZ;
  v_end_time TIMESTAMPTZ;
  v_execution_time_ms INTEGER;
  v_result_message TEXT;
BEGIN
  -- ✅ เริ่มจับเวลา
  v_start_time := now();
  
  -- ✅ คำนวณ current timestamp (epoch milliseconds)
  v_current_timestamp := extract(epoch from now()) * 1000;
  
  -- ✅ Loop ผ่าน venue_daily_layouts ทั้งหมด
  FOR v_layout_record IN 
    SELECT 
      id,
      venue_id,
      date,
      floors,
      other_data
    FROM venue_daily_layouts
    WHERE 
      (floors IS NOT NULL AND jsonb_typeof(floors) = 'object')
      OR (other_data IS NOT NULL AND jsonb_typeof(other_data) = 'object')
    FOR UPDATE
  LOOP
    -- ✅ กำหนด layout_data และ column ที่ใช้
    IF v_layout_record.floors IS NOT NULL AND jsonb_typeof(v_layout_record.floors) = 'object' THEN
      v_layout_data := v_layout_record.floors;
      v_use_floors_column := true;
    ELSIF v_layout_record.other_data IS NOT NULL AND jsonb_typeof(v_layout_record.other_data) = 'object' THEN
      v_layout_data := v_layout_record.other_data;
      v_use_floors_column := false;
    ELSE
      CONTINUE; -- ข้าม record นี้
    END IF;
    
    -- ✅ ตรวจสอบ structure
    v_has_floors := (v_layout_data ? 'floors');
    
    -- ✅ Loop ผ่าน tables ทั้งหมดใน layout
    -- รองรับ 3 structures:
    -- 1. { "F1": { "table_layout": { "table_A1": {...} } } }
    -- 2. { "floors": { "F1": { "table_layout": {...} } } }
    -- 3. { "table_layout": { "table_A1": {...} } } (legacy)
    
    IF v_has_floors THEN
      -- Structure: { "floors": { "F1": { "table_layout": {...} } } }
      FOR v_floor_id IN 
        SELECT jsonb_object_keys(v_layout_data->'floors')
      LOOP
        IF (v_layout_data->'floors'->v_floor_id) ? 'table_layout' THEN
          v_table_layout := v_layout_data->'floors'->v_floor_id->'table_layout';
          
          IF v_table_layout IS NOT NULL AND jsonb_typeof(v_table_layout) = 'object' THEN
            FOR v_table_id IN 
              SELECT jsonb_object_keys(v_table_layout)
            LOOP
              v_table_data := v_table_layout->v_table_id;
              v_status := v_table_data->'status';
              v_status_code := COALESCE(v_status->>'status_code', 'available');
              
              -- ✅ เช็คเฉพาะ pending (ไม่เกี่ยว payment_pending)
              IF v_status_code = 'pending' THEN
                v_status_timestamp := COALESCE((v_status->>'status_action_timestamp')::BIGINT, 0);
                
                -- ✅ คำนวณเวลาที่ผ่านมา (นาที)
                IF v_status_timestamp > 0 THEN
                  v_minutes_elapsed := (v_current_timestamp - v_status_timestamp) / 1000.0 / 60.0;
                  
                  -- ✅ ถ้าเกิน 15 นาที → reset เป็น available
                  IF v_minutes_elapsed >= 15 THEN
                    v_new_status := jsonb_build_object(
                      'status_code', 'available',
                      'customer_uid', '',
                      'booking_id', '',
                      'customer_name', '',
                      'status_action_timestamp', v_current_timestamp
                    );
                    
                    -- ✅ อัพเดท status
                    v_layout_data := jsonb_set(
                      v_layout_data,
                      ARRAY['floors', v_floor_id, 'table_layout', v_table_id, 'status'],
                      v_new_status
                    );
                    
                    v_updated_tables := array_append(v_updated_tables, v_table_id);
                    v_updated_count := v_updated_count + 1;
                  END IF;
                END IF;
              END IF;
            END LOOP;
          END IF;
        END IF;
      END LOOP;
    ELSE
      -- ✅ ตรวจสอบว่าเป็น floor-based structure หรือ legacy
      -- Structure 1: { "F1": { "table_layout": { "table_A1": {...} } } }
      -- Structure 3: { "table_layout": { "table_A1": {...} } } (legacy)
      
      -- ลองหา floor keys ก่อน
      FOR v_floor_id IN 
        SELECT jsonb_object_keys(v_layout_data)
        WHERE jsonb_typeof(v_layout_data->jsonb_object_keys(v_layout_data)) = 'object'
          AND (v_layout_data->jsonb_object_keys(v_layout_data)) ? 'table_layout'
      LOOP
        v_table_layout := v_layout_data->v_floor_id->'table_layout';
        
        IF v_table_layout IS NOT NULL AND jsonb_typeof(v_table_layout) = 'object' THEN
          FOR v_table_id IN 
            SELECT jsonb_object_keys(v_table_layout)
          LOOP
            v_table_data := v_table_layout->v_table_id;
            v_status := v_table_data->'status';
            v_status_code := COALESCE(v_status->>'status_code', 'available');
            
            IF v_status_code = 'pending' THEN
              v_status_timestamp := COALESCE((v_status->>'status_action_timestamp')::BIGINT, 0);
              
              IF v_status_timestamp > 0 THEN
                v_minutes_elapsed := (v_current_timestamp - v_status_timestamp) / 1000.0 / 60.0;
                
                IF v_minutes_elapsed >= 15 THEN
                  v_new_status := jsonb_build_object(
                    'status_code', 'available',
                    'customer_uid', '',
                    'booking_id', '',
                    'customer_name', '',
                    'status_action_timestamp', v_current_timestamp
                  );
                  
                  v_layout_data := jsonb_set(
                    v_layout_data,
                    ARRAY[v_floor_id, 'table_layout', v_table_id, 'status'],
                    v_new_status
                  );
                  
                  v_updated_tables := array_append(v_updated_tables, v_table_id);
                  v_updated_count := v_updated_count + 1;
                END IF;
              END IF;
            END IF;
          END LOOP;
        END IF;
      END LOOP;
      
      -- ✅ Legacy structure: { "table_layout": { "table_A1": {...} } }
      IF v_layout_data ? 'table_layout' THEN
        v_table_layout := v_layout_data->'table_layout';
        
        IF v_table_layout IS NOT NULL AND jsonb_typeof(v_table_layout) = 'object' THEN
          FOR v_table_id IN 
            SELECT jsonb_object_keys(v_table_layout)
          LOOP
            v_table_data := v_table_layout->v_table_id;
            v_status := v_table_data->'status';
            v_status_code := COALESCE(v_status->>'status_code', 'available');
            
            IF v_status_code = 'pending' THEN
              v_status_timestamp := COALESCE((v_status->>'status_action_timestamp')::BIGINT, 0);
              
              IF v_status_timestamp > 0 THEN
                v_minutes_elapsed := (v_current_timestamp - v_status_timestamp) / 1000.0 / 60.0;
                
                IF v_minutes_elapsed >= 15 THEN
                  v_new_status := jsonb_build_object(
                    'status_code', 'available',
                    'customer_uid', '',
                    'booking_id', '',
                    'customer_name', '',
                    'status_action_timestamp', v_current_timestamp
                  );
                  
                  v_layout_data := jsonb_set(
                    v_layout_data,
                    ARRAY['table_layout', v_table_id, 'status'],
                    v_new_status
                  );
                  
                  v_updated_tables := array_append(v_updated_tables, v_table_id);
                  v_updated_count := v_updated_count + 1;
                END IF;
              END IF;
            END IF;
          END LOOP;
        END IF;
      END IF;
    END IF;
    
    -- ✅ อัพเดท venue_daily_layouts ถ้ามีการเปลี่ยนแปลง
    IF array_length(v_updated_tables, 1) > 0 THEN
      -- อัพเดท updated_at
      v_layout_data := jsonb_set(
        v_layout_data,
        ARRAY['updated_at'],
        to_jsonb(now())
      );
      
      -- ✅ บันทึกกลับ database
      IF v_use_floors_column THEN
        UPDATE venue_daily_layouts
        SET floors = v_layout_data,
            updated_time = now()
        WHERE id = v_layout_record.id;
      ELSE
        UPDATE venue_daily_layouts
        SET other_data = v_layout_data,
            updated_time = now()
        WHERE id = v_layout_record.id;
      END IF;
      
      -- ✅ Reset array สำหรับ record ถัดไป
      v_updated_tables := ARRAY[]::TEXT[];
    END IF;
  END LOOP;
  
  -- ✅ จับเวลาสิ้นสุด
  v_end_time := now();
  v_execution_time_ms := EXTRACT(EPOCH FROM (v_end_time - v_start_time)) * 1000;
  v_result_message := format('Reset %s pending status(es) to available', v_updated_count);
  
  -- ✅ Insert log (ถ้ามี table)
  BEGIN
    INSERT INTO cleanup_logs (
      function_name,
      status,
      updated_count,
      message,
      execution_time_ms
    ) VALUES (
      'cleanup_expired_pending_status',
      'success',
      v_updated_count,
      v_result_message,
      v_execution_time_ms
    );
  EXCEPTION
    WHEN undefined_table THEN
      -- ถ้าไม่มี cleanup_logs table → ข้าม (ไม่ error)
      NULL;
    WHEN OTHERS THEN
      -- ถ้ามี error อื่น → ข้าม (ไม่ให้ function fail)
      NULL;
  END;
  
  -- ✅ Return summary
  RETURN jsonb_build_object(
    'success', true,
    'updated_count', v_updated_count,
    'message', v_result_message,
    'execution_time_ms', v_execution_time_ms
  );
  
EXCEPTION
  WHEN OTHERS THEN
    -- ✅ จับเวลาสิ้นสุด (แม้ error)
    v_end_time := now();
    v_execution_time_ms := EXTRACT(EPOCH FROM (v_end_time - v_start_time)) * 1000;
    
    -- ✅ Insert error log (ถ้ามี table)
    BEGIN
      INSERT INTO cleanup_logs (
        function_name,
        status,
        updated_count,
        error_message,
        execution_time_ms
      ) VALUES (
        'cleanup_expired_pending_status',
        'error',
        v_updated_count,
        SQLERRM,
        v_execution_time_ms
      );
    EXCEPTION
      WHEN undefined_table THEN
        NULL;
      WHEN OTHERS THEN
        NULL;
    END;
    
    RETURN jsonb_build_object(
      'success', false,
      'error', SQLERRM,
      'updated_count', v_updated_count,
      'execution_time_ms', v_execution_time_ms
    );
END;
$$;

-- ========================================================================
-- Grant execute permission
-- ========================================================================
GRANT EXECUTE ON FUNCTION cleanup_expired_pending_status() TO authenticated;
GRANT EXECUTE ON FUNCTION cleanup_expired_pending_status() TO service_role;

-- ========================================================================
-- Comment
-- ========================================================================
COMMENT ON FUNCTION cleanup_expired_pending_status() IS 
'Reset pending status ที่เกิน 15 นาทีกลับเป็น available. payment_pending ไม่เกี่ยว. ควรเรียกทุก 1-5 นาทีผ่าน pg_cron หรือ Edge Function.';
