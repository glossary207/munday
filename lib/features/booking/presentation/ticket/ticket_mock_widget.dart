import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Mock Data ────────────────────────────────────────────────────────────────

enum TicketStatus { upcoming, used, cancelled }

class MockTicket {
  final String nameEvent;
  final String nameVenues;
  final String bg;
  final String poster;
  final DateTime dateEvent;
  final String timeEvent;
  final String zone;
  final String seatCode;
  final String price;
  final int quantity;
  final TicketStatus status;
  final bool isEvent;

  const MockTicket({
    required this.nameEvent,
    required this.nameVenues,
    required this.bg,
    required this.poster,
    required this.dateEvent,
    required this.timeEvent,
    required this.zone,
    required this.seatCode,
    required this.price,
    required this.quantity,
    required this.status,
    this.isEvent = true,
  });
}

final List<MockTicket> kMockTickets = [
  MockTicket(
    nameEvent: 'NEON NIGHT FESTIVAL',
    nameVenues: 'ONYX Bangkok',
    bg: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=900',
    poster: 'https://images.unsplash.com/photo-1574391884720-bbc3740c59d1?w=900',
    dateEvent: DateTime(2026, 6, 14),
    timeEvent: '22:00',
    zone: 'VIP',
    seatCode: 'A-001',
    price: '1,200',
    quantity: 2,
    status: TicketStatus.upcoming,
  ),
  MockTicket(
    nameEvent: 'DEEP HOUSE SATURDAY',
    nameVenues: 'Levels Club & Lounge',
    bg: 'https://images.unsplash.com/photo-1571266028243-d220c6a3bcf4?w=900',
    poster: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=900',
    dateEvent: DateTime(2026, 6, 21),
    timeEvent: '23:00',
    zone: 'REGULAR',
    seatCode: 'B-042',
    price: '800',
    quantity: 1,
    status: TicketStatus.upcoming,
  ),
  MockTicket(
    nameEvent: 'RED PARTY EXCLUSIVE',
    nameVenues: 'Route 66 Club',
    bg: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=900',
    poster: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=900',
    dateEvent: DateTime(2026, 5, 5),
    timeEvent: '21:30',
    zone: 'STANDARD',
    seatCode: 'C-007',
    price: '500',
    quantity: 3,
    status: TicketStatus.used,
  ),
  MockTicket(
    nameEvent: 'MIDNIGHT GROOVE',
    nameVenues: 'Sing Sing Theater',
    bg: 'https://images.unsplash.com/photo-1540039155733-5bb30b4f9c17?w=900',
    poster: 'https://images.unsplash.com/photo-1540039155733-5bb30b4f9c17?w=900',
    dateEvent: DateTime(2026, 7, 12),
    timeEvent: '22:30',
    zone: 'VIP TABLE',
    seatCode: 'T-03',
    price: '2,500',
    quantity: 4,
    status: TicketStatus.upcoming,
  ),
  MockTicket(
    nameEvent: 'TECHNO UNDERGROUND',
    nameVenues: 'Glow Bangkok',
    bg: 'https://images.unsplash.com/photo-1598387993441-a364f854cfed?w=900',
    poster: 'https://images.unsplash.com/photo-1598387993441-a364f854cfed?w=900',
    dateEvent: DateTime(2026, 4, 20),
    timeEvent: '00:00',
    zone: 'FLOOR',
    seatCode: 'F-099',
    price: '350',
    quantity: 1,
    status: TicketStatus.cancelled,
  ),
];

// ─── Widget ───────────────────────────────────────────────────────────────────

class TicketMockWidget extends StatefulWidget {
  const TicketMockWidget({super.key});

  static String routeName = 'ticket';
  static String routePath = 'ticket';

  @override
  State<TicketMockWidget> createState() => _TicketMockWidgetState();
}

class _TicketMockWidgetState extends State<TicketMockWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = ['ทั้งหมด', 'กำลังมา', 'ผ่านมาแล้ว'];

  List<MockTicket> get _filtered {
    switch (_tabController.index) {
      case 1:
        return kMockTickets
            .where((t) => t.status == TicketStatus.upcoming)
            .toList();
      case 2:
        return kMockTickets
            .where((t) =>
                t.status == TicketStatus.used ||
                t.status == TicketStatus.cancelled)
            .toList();
      default:
        return kMockTickets;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  static const _monthTH = [
    'ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.',
    'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'
  ];
  static const _dayTH = ['จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส', 'อา'];

  String _day(DateTime d) => d.day.toString();
  String _month(DateTime d) => _monthTH[d.month - 1];
  String _year(DateTime d) => (d.year + 543).toString().substring(2);
  String _weekday(DateTime d) => _dayTH[d.weekday - 1];

  // ── build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final tickets = _filtered;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTabBar(context),
            Expanded(
              child: tickets.isEmpty
                  ? _buildEmpty(context)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                      itemCount: tickets.length,
                      itemBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _TicketCard(
                          ticket: tickets[i],
                          day: _day(tickets[i].dateEvent),
                          month: _month(tickets[i].dateEvent),
                          year: _year(tickets[i].dateEvent),
                          weekday: _weekday(tickets[i].dateEvent),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final upcoming =
        kMockTickets.where((t) => t.status == TicketStatus.upcoming).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 0),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0x22FFFFFF),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0x44FFFFFF), width: 1),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 15),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Tickets',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  '$upcoming upcoming',
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFFF4444),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Ticket count badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF2A2A2A)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.confirmation_num_rounded,
                    color: Color(0xFFFF4444), size: 16),
                const SizedBox(width: 6),
                Text(
                  kMockTickets.length.toString(),
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 2),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A2A2A)),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: const Color(0xFFCC0000),
            borderRadius: BorderRadius.circular(10),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          labelStyle: GoogleFonts.openSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.openSans(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF666666),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.confirmation_num_outlined,
              color: Color(0xFF333333), size: 64),
          const SizedBox(height: 16),
          Text(
            'ไม่มี Ticket ในหมวดนี้',
            style: GoogleFonts.openSans(
                color: const Color(0xFF555555), fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// ─── Ticket Card ──────────────────────────────────────────────────────────────

class _TicketCard extends StatelessWidget {
  const _TicketCard({
    required this.ticket,
    required this.day,
    required this.month,
    required this.year,
    required this.weekday,
  });

  final MockTicket ticket;
  final String day;
  final String month;
  final String year;
  final String weekday;

  Color get _statusColor {
    switch (ticket.status) {
      case TicketStatus.upcoming:
        return const Color(0xFF00C853);
      case TicketStatus.used:
        return const Color(0xFF888888);
      case TicketStatus.cancelled:
        return const Color(0xFFFF4444);
    }
  }

  String get _statusLabel {
    switch (ticket.status) {
      case TicketStatus.upcoming:
        return 'VALID';
      case TicketStatus.used:
        return 'USED';
      case TicketStatus.cancelled:
        return 'CANCELLED';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dimmed = ticket.status != TicketStatus.upcoming;
    return Opacity(
      opacity: dimmed ? 0.6 : 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            _buildPosterHalf(context),
            _buildDetailHalf(context),
          ],
        ),
      ),
    );
  }

  // ── Top half: event poster ────────────────────────────────────────────────

  Widget _buildPosterHalf(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.network(
            ticket.isEvent ? ticket.poster : ticket.bg,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: const Color(0xFF1A1A1A)),
          ),
          // Dark overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x99000000), Color(0xCC000000)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: _statusColor.withValues(alpha: 0.6)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _statusLabel,
                            style: GoogleFonts.openSans(
                              color: _statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Quantity badge
                    if (ticket.quantity > 1)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'x${ticket.quantity}',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Text(
                  ticket.nameEvent,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: Color(0xFFFF4444), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      ticket.nameVenues,
                      style: GoogleFonts.openSans(
                        color: const Color(0xFFCCCCCC),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Perforated divider ────────────────────────────────────────────────────

  // ── Bottom half: ticket details ───────────────────────────────────────────

  Widget _buildDetailHalf(BuildContext context) {
    return Container(
      color: const Color(0xFF111111),
      child: Column(
        children: [
          // Perforated edge
          _PerforatedEdge(),
          // Details row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Date block
                Container(
                  width: 54,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCC0000),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekday,
                        style: GoogleFonts.openSans(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        day,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        '$month $year',
                        style: GoogleFonts.openSans(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                // Middle info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _InfoChip(
                            icon: Icons.star_rounded,
                            label: ticket.zone,
                            color: const Color(0xFFFFAA00),
                          ),
                          const SizedBox(width: 6),
                          _InfoChip(
                            icon: Icons.chair_alt_rounded,
                            label: ticket.seatCode,
                            color: const Color(0xFF888888),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded,
                              color: Color(0xFF666666), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            ticket.timeEvent,
                            style: GoogleFonts.openSans(
                              color: const Color(0xFF888888),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '฿${ticket.price}',
                            style: GoogleFonts.openSans(
                              color: const Color(0xFFFF4444),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // QR button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF333333)),
                    ),
                    child: const Icon(Icons.qr_code_rounded,
                        color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Info Chip ────────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.openSans(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Perforated Edge ─────────────────────────────────────────────────────────

class _PerforatedEdge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          // Left notch
          Container(
            width: 12,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          // Dashed line
          Expanded(
            child: CustomPaint(painter: _DashedLinePainter()),
          ),
          // Right notch
          Container(
            width: 12,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2A2A2A)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const gap = 4.0;
    double x = 0;
    final y = size.height / 2;

    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(math.min(x + dashWidth, size.width), y), paint);
      x += dashWidth + gap;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter old) => false;
}
