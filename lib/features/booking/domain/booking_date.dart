/// Converts any timestamp representing a selected calendar day to a stable
/// local date value. Noon avoids crossing a day boundary when the value is
/// serialized or interpreted by code using a different UTC offset.
DateTime normalizeBookingDate(DateTime value) {
  return DateTime(value.year, value.month, value.day, 12);
}

/// Resolves the booking day without ever returning null.
///
/// A date supplied by the route is authoritative. The shared selected date is
/// used only when the route did not provide one, followed by the caller's
/// current-day fallback.
DateTime resolveBookingDate({
  DateTime? routeDate,
  DateTime? selectedDate,
  required DateTime fallback,
}) {
  final minimumDate = normalizeBookingDate(fallback);
  final candidate = normalizeBookingDate(
    routeDate ?? selectedDate ?? minimumDate,
  );
  return candidate.isBefore(minimumDate) ? minimumDate : candidate;
}
