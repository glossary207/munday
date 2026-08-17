import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toggle RPC is an authenticated security boundary', () {
    final sql = File(
      'supabase/migrations/20260808000000_reapply_secure_toggle_table_reservation.sql',
    ).readAsStringSync();

    expect(sql, contains('auth.uid() IS DISTINCT FROM p_user_id'));
    expect(sql, contains('SECURITY DEFINER'));
    expect(sql, contains('SET search_path = public, pg_temp'));
    expect(sql, contains('REVOKE ALL ON FUNCTION'));
    expect(sql, contains('TO authenticated'));
    expect(sql, contains('WHERE user_id = p_user_id'));
    expect(
      sql,
      isNot(contains('EXCEPTION WHEN unique_violation')),
      reason:
          'Existing non-deterministic reservation ids must still be updated.',
    );
    expect(
      sql,
      isNot(contains("v_current_status = 'occupied'")),
      reason: 'Customers must not release occupied tables through toggle RPC.',
    );
  });

  test('infrastructure includes payment, cleanup, RLS and realtime', () {
    final sql = File(
      'supabase/migrations/20260808010000_layout_reservation_infrastructure.sql',
    ).readAsStringSync();

    for (final requirement in [
      'CREATE OR REPLACE FUNCTION public.submit_reservation_payment',
      'CREATE OR REPLACE FUNCTION public.verify_reservation_payment',
      'CREATE OR REPLACE FUNCTION public.cleanup_expired_layout_reservations',
      'CREATE OR REPLACE FUNCTION public.enforce_layout_table_key_uniqueness',
      'pg_advisory_xact_lock',
      'CREATE OR REPLACE FUNCTION public.legacy_reservation_totals',
      'CREATE OR REPLACE FUNCTION public.get_reservation_payment_quote',
      'CREATE POLICY active_reservations_read_own',
      'CREATE POLICY floor_owner_delete',
      'CREATE POLICY table_owner_delete',
      'minimum_party_size',
      'maximum_party_size',
      'cleanup_expired_payment_pending_status()',
      "'reservation-slips'",
      'ALTER PUBLICATION supabase_realtime ADD TABLE',
    ]) {
      expect(sql, contains(requirement));
    }

    expect(
      sql,
      isNot(contains('CREATE POLICY floor_staff_write')),
      reason: 'A broad FOR ALL policy would allow non-owners to delete floors.',
    );
    expect(
      sql,
      isNot(contains('CREATE POLICY table_staff_write')),
      reason: 'A broad FOR ALL policy would allow non-owners to delete tables.',
    );
    expect(
      sql,
      isNot(
        contains("server_amount := COALESCE((pending_data->>'totalPrice')"),
      ),
      reason: 'Billing must be recalculated from locked layout rows.',
    );
  });

  test('verification webhook requires the shared service secret', () {
    final function = File(
      'supabase/functions/verify-payment-for-reservation/index.ts',
    ).readAsStringSync();
    final config = File('supabase/config.toml').readAsStringSync();

    expect(function, contains('SLIP_VERIFICATION_WEBHOOK_SECRET'));
    expect(function, contains('x-verification-secret'));
    expect(function, contains('SUPABASE_SERVICE_ROLE_KEY'));
    expect(function, contains('verify_reservation_payment'));
    expect(
      function.indexOf('x-verification-secret'),
      lessThan(function.indexOf('SUPABASE_SERVICE_ROLE_KEY')),
    );
    expect(config, contains('verify_jwt = false'));
  });
}
