-- ========================================================================
-- Setup pg_cron for cleanup_expired_pending_status and cleanup_expired_payment_pending_status
-- รันทุก 1 นาทีเพื่อ reset pending และ payment_pending status ที่เกิน 15 นาที
-- ========================================================================

-- ========================================================================
-- 1. ตรวจสอบว่า pg_cron extension ติดตั้งแล้วหรือยัง
-- ========================================================================
-- ถ้ายังไม่มี ให้รันใน Supabase SQL Editor:
-- CREATE EXTENSION IF NOT EXISTS pg_cron;

-- ========================================================================
-- 2. ลบ cron job เก่า (ถ้ามี)
-- ========================================================================
SELECT cron.unschedule('cleanup-expired-pending-status')
WHERE EXISTS (
  SELECT 1 FROM cron.job WHERE jobname = 'cleanup-expired-pending-status'
);

SELECT cron.unschedule('cleanup-expired-payment-pending-status')
WHERE EXISTS (
  SELECT 1 FROM cron.job WHERE jobname = 'cleanup-expired-payment-pending-status'
);

-- ========================================================================
-- 3. สร้าง cron job ใหม่ - รันทุก 1 นาที
-- ========================================================================
-- Job 1: Cleanup pending status
SELECT cron.schedule(
  'cleanup-expired-pending-status',  -- job name
  '* * * * *',                        -- schedule: ทุก 1 นาที (ทุกวินาทีที่ 0)
  $$SELECT cleanup_expired_pending_status();$$  -- SQL to execute
);

-- Job 2: Cleanup payment_pending status
SELECT cron.schedule(
  'cleanup-expired-payment-pending-status',  -- job name
  '* * * * *',                                 -- schedule: ทุก 1 นาที (ทุกวินาทีที่ 0)
  $$SELECT cleanup_expired_payment_pending_status();$$  -- SQL to execute
);

-- ========================================================================
-- 4. ตรวจสอบ cron job ที่สร้างไว้
-- ========================================================================
SELECT 
  jobid,
  schedule,
  command,
  nodename,
  nodeport,
  database,
  username,
  active,
  jobname
FROM cron.job
WHERE jobname IN ('cleanup-expired-pending-status', 'cleanup-expired-payment-pending-status')
ORDER BY jobname;

-- ========================================================================
-- 5. ดู cron job history (ถ้าต้องการ)
-- ========================================================================
-- SELECT * FROM cron.job_run_details 
-- WHERE jobid IN (
--   SELECT jobid FROM cron.job 
--   WHERE jobname IN ('cleanup-expired-pending-status', 'cleanup-expired-payment-pending-status')
-- )
-- ORDER BY start_time DESC
-- LIMIT 20;

-- ========================================================================
-- หมายเหตุ:
-- ========================================================================
-- 1. pg_cron รันใน background → ไม่ block main database
-- 2. ถ้า function ใช้เวลานาน → อาจมี overlap (แต่ใช้ FOR UPDATE ป้องกัน)
-- 3. ถ้าต้องการหยุด: 
--    SELECT cron.unschedule('cleanup-expired-pending-status');
--    SELECT cron.unschedule('cleanup-expired-payment-pending-status');
-- 4. ถ้าต้องการเปลี่ยน schedule: unschedule แล้ว schedule ใหม่
-- 5. Schedule patterns:
--    - '* * * * *' = ทุก 1 นาที
--    - '*/5 * * * *' = ทุก 5 นาที
--    - '0,15,30,45 * * * *' = ทุก 15 นาที (0, 15, 30, 45)
--    - '*/15 * * * *' = ทุก 15 นาที (0, 15, 30, 45)
