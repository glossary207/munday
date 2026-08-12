import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munday/backend/backend.dart';
import 'package:munday/features/auth/data/supabase_auth/auth_util.dart';
import 'package:munday/features/booking/presentation/ticket/ticket_view.dart';

TicketRecord _ticket({
  required String id,
  required String name,
  required String venue,
  required DateTime date,
}) {
  return TicketRecord.getDocumentFromData({
    'NameEvent': name,
    'NameVenues': venue,
    'EventOrNormal': false,
    'price': '590',
    'zone': 'SALON',
    'SeatCode': '08',
    'BG': '',
    'Poster': '',
    'time_event': '18:00',
    'scan_amont': 2,
    'scanned_amont': 0,
    'date_Event': date,
    'IDticket': SupabaseDocRef('Ticket', id),
  }, SupabaseDocRef('Ticket', id));
}

Widget _testApp(List<TicketRecord> tickets) {
  return MaterialApp(
    home: Scaffold(
      body: SizedBox(
        width: 390,
        height: 844,
        child: TicketCarouselView(tickets: tickets),
      ),
    ),
  );
}

void _setSurfaceSize(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
}

void main() {
  setUp(() {
    // Prevent currentUserPhoto from reaching an uninitialised Supabase client.
    currentUserDocument = UsersRecord.getDocumentFromData({
      'photo_url': '',
    }, SupabaseDocRef('users', 'widget-test-user'));
  });

  tearDown(() => currentUserDocument = null);

  testWidgets('swipes between tickets and updates the active title', (
    tester,
  ) async {
    _setSurfaceSize(tester, const Size(390, 844));
    final tickets = [
      _ticket(
        id: 'first-ticket',
        name: 'FIRST EVENT',
        venue: 'First Venue',
        date: DateTime(2099, 7, 20),
      ),
      _ticket(
        id: 'second-ticket',
        name: 'SECOND EVENT',
        venue: 'Second Venue',
        date: DateTime(2099, 7, 21),
      ),
    ];

    await tester.pumpWidget(_testApp(tickets));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('FIRST EVENT'), findsOneWidget);
    expect(find.byKey(const ValueKey('ticket-carousel')), findsOneWidget);
    expect(find.byKey(const ValueKey('ticket-dot-0')), findsOneWidget);

    await tester.drag(
      find.byKey(const ValueKey('ticket-carousel')),
      const Offset(-280, 0),
    );
    await tester.pumpAndSettle();

    expect(find.text('SECOND EVENT'), findsOneWidget);
  });

  testWidgets('opens full details after tapping a ticket', (tester) async {
    _setSurfaceSize(tester, const Size(320, 568));
    final ticket = _ticket(
      id: 'detail-ticket',
      name: 'DETAIL EVENT',
      venue: 'Real Venue',
      date: DateTime(2099, 7, 20),
    );

    await tester.pumpWidget(_testApp([ticket]));
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Ticket for 2 persons'));
    await tester.pumpAndSettle();

    expect(find.text('TICKET DETAILS'), findsOneWidget);
    expect(find.text('Real Venue'), findsWidgets);

    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('show-ticket-qr')),
      260,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();

    expect(find.text('แสดง QR สำหรับเช็กอิน'), findsOneWidget);
    expect(find.text('detail-ticket'), findsOneWidget);
  });

  testWidgets('stays constrained on a wide window', (tester) async {
    _setSurfaceSize(tester, const Size(1024, 768));
    final ticket = _ticket(
      id: 'wide-ticket',
      name: 'WIDE EVENT',
      venue: 'Wide Venue',
      date: DateTime(2099, 7, 20),
    );

    await tester.pumpWidget(_testApp([ticket]));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('WIDE EVENT'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
