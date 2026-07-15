import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  final String? logo;

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
    this.logo,
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
    nameEvent: 'THE GLASS HOUSE',
    nameVenues: 'Pattaya',
    bg: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=900',
    poster: '',
    dateEvent: DateTime(2026, 6, 21),
    timeEvent: '18:00',
    zone: 'REGULAR',
    seatCode: 'T-042',
    price: '0',
    quantity: 4,
    status: TicketStatus.upcoming,
    isEvent: false,
    logo: 'https://images.unsplash.com/photo-1599305445671-ac291c95aaa9?w=200',
  ),
  MockTicket(
    nameEvent: 'SUSHI DEN (RESERVATION)',
    nameVenues: 'Siam Paragon',
    bg: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=900',
    poster: '',
    dateEvent: DateTime(2026, 7, 12),
    timeEvent: '19:30',
    zone: 'TABLE',
    seatCode: 'S-03',
    price: '0',
    quantity: 2,
    status: TicketStatus.upcoming,
    isEvent: false,
    logo: 'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=200',
  ),
];

// ─── Widget ───────────────────────────────────────────────────────────────────

class TicketMockPage extends ConsumerStatefulWidget {
  const TicketMockPage({super.key});

  static String routeName = 'ticket';
  static String routePath = 'ticket';

  @override
  ConsumerState<TicketMockPage> createState() => _TicketMockWidgetState();
}

class _TicketMockWidgetState extends ConsumerState<TicketMockPage> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  List<MockTicket> get _tickets {
    return kMockTickets.where((t) => t.status == TicketStatus.upcoming).toList();
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  static const _monthTH = [
    'ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.',
    'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.',
  ];

  String _day(DateTime d) => d.day.toString();
  String _month(DateTime d) => _monthTH[d.month - 1];
  String _year(DateTime d) => (d.year + 543).toString().substring(2);

  Color _statusColor(MockTicket ticket) {
    switch (ticket.status) {
      case TicketStatus.upcoming:
        return const Color(0xFF00C853);
      case TicketStatus.used:
        return const Color(0xFF888888);
      case TicketStatus.cancelled:
        return const Color(0xFFFF4444);
    }
  }

  String _statusLabel(MockTicket ticket) {
    switch (ticket.status) {
      case TicketStatus.upcoming:
        return 'VALID';
      case TicketStatus.used:
        return 'USED';
      case TicketStatus.cancelled:
        return 'CANCELLED';
    }
  }

  // ── build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final tickets = _tickets;
    final safeIndex = (_currentIndex < tickets.length) ? _currentIndex : 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, tickets.length),
            Expanded(
              child: tickets.isEmpty
                  ? _buildEmpty(context)
                  : Column(
                      children: [
                        const SizedBox(height: 16),
                        _buildCarousel(context, tickets),
                        const SizedBox(height: 24),
                        _buildTicketTitles(tickets[safeIndex]),
                        const SizedBox(height: 32),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                            ),
                            child: _buildDetailsArea(tickets[safeIndex]),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 16),
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
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 15,
              ),
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
                  '$count upcoming',
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
                const Icon(
                  Icons.confirmation_num_rounded,
                  color: Color(0xFFFF4444),
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  count.toString(),
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

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.confirmation_num_outlined,
            color: Color(0xFF333333),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'ไม่มี Ticket ในขณะนี้',
            style: GoogleFonts.openSans(
              color: const Color(0xFF555555),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, List<MockTicket> tickets) {
    return SizedBox(
      height: 290,
      width: double.infinity,
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        itemCount: tickets.length,
        itemBuilder: (context, index, realIndex) {
          return _buildCardImage(tickets[index]);
        },
        options: CarouselOptions(
          height: 290,
          viewportFraction: 0.65, // <--- Key to overlapping! 0.65 makes side cards slide behind the center
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom, // Smooth scaling
          enlargeFactor: 0.25, // How much the side cards shrink
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildCardImage(MockTicket ticket) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 8),
          )
        ],
        image: DecorationImage(
          image: NetworkImage(ticket.isEvent ? ticket.poster : ticket.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Dark gradient overlay to make text/logo pop slightly
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Colors.transparent, Colors.black45],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          if (!ticket.isEvent && ticket.logo != null)
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  image: DecorationImage(
                    image: NetworkImage(ticket.logo!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTicketTitles(MockTicket ticket) {
    return Column(
      children: [
        Text(
          ticket.nameEvent,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          ticket.nameVenues,
          style: GoogleFonts.openSans(
            color: const Color(0xFFAAAAAA),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDetailsArea(MockTicket ticket) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Date', '${_day(ticket.dateEvent)} ${_month(ticket.dateEvent)} ${_year(ticket.dateEvent)}'),
              _buildDetailItem('Time', ticket.timeEvent),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Zone', ticket.zone),
              _buildDetailItem('Seat', ticket.seatCode),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Price', ticket.price == '0' ? 'Free' : '฿${ticket.price}'),
              _buildDetailItem('Quantity', 'x${ticket.quantity}'),
            ],
          ),
          const Spacer(),
          // Status indicator and QR button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: GoogleFonts.openSans(
                      color: const Color(0xFF666666),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: _statusColor(ticket).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _statusColor(ticket), width: 1.5),
                    ),
                    child: Text(
                      _statusLabel(ticket),
                      style: GoogleFonts.openSans(
                        color: _statusColor(ticket),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.qr_code_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.openSans(
              color: const Color(0xFF666666),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.openSans(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
