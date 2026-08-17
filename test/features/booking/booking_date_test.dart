import 'package:flutter_test/flutter_test.dart';
import 'package:munday/features/booking/domain/booking_date.dart';

void main() {
  test('route date is authoritative and normalized to a stable local day', () {
    final resolved = resolveBookingDate(
      routeDate: DateTime(2026, 8, 12, 23, 59),
      selectedDate: DateTime(2026, 8, 13),
      fallback: DateTime(2026, 8, 10),
    );

    expect(resolved, DateTime(2026, 8, 12, 12));
  });

  test('selected date is used when the route date is null', () {
    final resolved = resolveBookingDate(
      selectedDate: DateTime(2026, 8, 15, 7),
      fallback: DateTime(2026, 8, 14),
    );

    expect(resolved, DateTime(2026, 8, 15, 12));
  });

  test('fallback guarantees a non-null booking date', () {
    final resolved = resolveBookingDate(fallback: DateTime(2026, 8, 17, 1));

    expect(resolved, DateTime(2026, 8, 17, 12));
  });

  test('stale past date is replaced by the current booking day', () {
    final resolved = resolveBookingDate(
      selectedDate: DateTime(2023, 6, 30),
      fallback: DateTime(2026, 8, 15, 7),
    );

    expect(resolved, DateTime(2026, 8, 15, 12));
  });
}
