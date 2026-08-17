import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '/backend/backend.dart';
import '/core/utils/app_util.dart';
import '/core/utils/custom_functions.dart' as functions;
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/index.dart';

/// A wallet-style ticket carousel backed by real [TicketRecord] data.
///
/// The first screen intentionally keeps only the useful at-a-glance data on
/// the ticket. Tapping a card opens the complete ticket details and check-in
/// actions without making a horizontal swipe accidentally navigate away.
class TicketCarouselView extends StatefulWidget {
  const TicketCarouselView({super.key, required this.tickets});

  final List<TicketRecord> tickets;

  @override
  State<TicketCarouselView> createState() => _TicketCarouselViewState();
}

enum _TicketStatus { valid, used, expired }

class _TicketCarouselViewState extends State<TicketCarouselView> {
  static const _ticketTop = Color(0xFFF04B49);
  static const _ticketBottom = Color(0xFFD92F34);
  static const _surface = Color(0xFF151518);
  static const _onSurfaceSoft = Color(0xB3FFFFFF);
  static const _onSurfaceFaint = Color(0xFF8A8A91);
  static const _onTicket = Colors.white;
  static const _onTicketSoft = Color(0xBFFFFFFF);
  static const _outline = Color(0x26FFFFFF);

  static const _monthTH = [
    'ม.ค.',
    'ก.พ.',
    'มี.ค.',
    'เม.ย.',
    'พ.ค.',
    'มิ.ย.',
    'ก.ค.',
    'ส.ค.',
    'ก.ย.',
    'ต.ค.',
    'พ.ย.',
    'ธ.ค.',
  ];

  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // A narrow viewport deliberately exposes the previous/next tickets.
    _pageController = PageController(viewportFraction: 0.70);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<TicketRecord> get _sortedTickets =>
      widget.tickets.toList()..sort((a, b) {
        final aDate = a.dateEvent ?? DateTime(9999);
        final bDate = b.dateEvent ?? DateTime(9999);
        return aDate.compareTo(bDate);
      });

  _TicketStatus _statusOf(TicketRecord ticket) {
    final date = ticket.dateEvent;
    if (date != null) {
      final now = DateTime.now();
      final day = DateTime(date.year, date.month, date.day);
      final today = DateTime(now.year, now.month, now.day);
      if (day.isBefore(today)) return _TicketStatus.expired;
    }
    if (ticket.scanAmont > 0 && ticket.scannedAmont >= ticket.scanAmont) {
      return _TicketStatus.used;
    }
    return _TicketStatus.valid;
  }

  String _imageOf(TicketRecord ticket) {
    if (ticket.eventOrNormal && ticket.poster.isNotEmpty) return ticket.poster;
    if (ticket.bg.isNotEmpty) return ticket.bg;
    return ticket.poster;
  }

  String _priceOf(TicketRecord ticket) {
    final price = ticket.price.trim();
    if (price.isEmpty || price == '0' || price == '0.0') return 'FREE';
    return price.startsWith('฿') ? price : '฿$price';
  }

  int _quantityOf(TicketRecord ticket) =>
      ticket.scanAmont > 0 ? ticket.scanAmont : 1;

  String _dateLabel(DateTime? date) {
    if (date == null) return '-';
    return '${date.day} ${_monthTH[date.month - 1]} ${date.year + 543}';
  }

  String _shortDateLabel(DateTime? date) {
    if (date == null) return '-';
    return '${date.day} ${_monthTH[date.month - 1]}';
  }

  String _statusLabel(_TicketStatus status) {
    switch (status) {
      case _TicketStatus.valid:
        return 'พร้อมใช้งาน';
      case _TicketStatus.used:
        return 'ใช้งานแล้ว';
      case _TicketStatus.expired:
        return 'หมดอายุ';
    }
  }

  Color _statusColor(_TicketStatus status) {
    switch (status) {
      case _TicketStatus.valid:
        return const Color(0xFF39D98A);
      case _TicketStatus.used:
        return const Color(0xFFB7B7BE);
      case _TicketStatus.expired:
        return const Color(0xFFFF8A80);
    }
  }

  String _ticketCode(TicketRecord ticket) {
    final id = ticket.iDticket?.id ?? '';
    return id.isNotEmpty ? id : ticket.reference.id;
  }

  Future<void> _openVenue(TicketRecord ticket) async {
    if (ticket.idVenues == null) return;

    final currentUserLocationValue = await getCurrentUserLocation(
      defaultLocation: const LatLng(0, 0),
    );
    if (!mounted) return;

    context.pushNamed(
      InVenusePage.routeName,
      queryParameters: {
        'idVenues': serializeParam(ticket.idVenues, ParamType.SupabaseDocRef),
        'distance': serializeParam(
          functions
              .distanceLocation(ticket.location, currentUserLocationValue)
              ?.toString(),
          ParamType.String,
        ),
        'dateclick': serializeParam(ticket.dateEvent, ParamType.DateTime),
        'index': serializeParam(0, ParamType.int),
      }.withoutNulls,
    );
  }

  void _showTicketDetails(TicketRecord ticket) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0xC9000000),
      builder: (sheetContext) => _TicketDetailsSheet(
        ticket: ticket,
        imageUrl: _imageOf(ticket),
        date: _dateLabel(ticket.dateEvent),
        price: _priceOf(ticket),
        quantity: _quantityOf(ticket),
        status: _statusLabel(_statusOf(ticket)),
        statusColor: _statusColor(_statusOf(ticket)),
        code: _ticketCode(ticket),
        onShowQr: () => _showQr(ticket),
        onOpenVenue: ticket.idVenues == null
            ? null
            : () {
                Navigator.of(sheetContext).pop();
                _openVenue(ticket);
              },
      ),
    );
  }

  void _showQr(TicketRecord ticket) {
    final code = _ticketCode(ticket);
    showDialog<void>(
      context: context,
      barrierColor: const Color(0xD9000000),
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: _outline),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    tooltip: 'ปิด',
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                  ),
                ),
                Text(
                  ticket.nameEvent,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSansThai(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'แสดง QR นี้ที่หน้างานเพื่อเช็กอิน',
                  style: GoogleFonts.notoSansThai(
                    color: _onSurfaceFaint,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: QrImageView(
                    data: code,
                    version: QrVersions.auto,
                    size: 220,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  code,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSansThai(
                    color: _onSurfaceSoft,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tickets = _sortedTickets;

    if (tickets.isEmpty) {
      return const Stack(
        children: [
          _EmptyBackground(),
          Column(
            children: [
              _TicketHeader(),
              Expanded(child: _EmptyTickets()),
            ],
          ),
        ],
      );
    }

    final safeIndex = _currentIndex.clamp(0, tickets.length - 1);
    final current = tickets[safeIndex];

    return Stack(
      fit: StackFit.expand,
      children: [
        _TicketBackdrop(imageUrl: _imageOf(current)),
        LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  children: [
                    const _TicketHeader(),
                    const SizedBox(height: 3),
                    _TicketTitle(
                      title: current.nameEvent,
                      venue: current.nameVenues,
                    ),
                    SizedBox(height: constraints.maxHeight < 680 ? 8 : 14),
                    Expanded(child: _buildCarousel(tickets)),
                    const SizedBox(height: 10),
                    _PageDots(count: tickets.length, activeIndex: safeIndex),
                    SizedBox(height: constraints.maxHeight < 680 ? 16 : 28),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCarousel(List<TicketRecord> tickets) {
    return PageView.builder(
      key: const ValueKey('ticket-carousel'),
      controller: _pageController,
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      itemCount: tickets.length,
      onPageChanged: (index) {
        HapticFeedback.selectionClick();
        setState(() => _currentIndex = index);
      },
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, _) {
            var page = _currentIndex.toDouble();
            if (_pageController.hasClients &&
                _pageController.position.haveDimensions) {
              page = _pageController.page ?? page;
            }
            final distance = (index - page).clamp(-1.5, 1.5);
            final amount = distance.abs().clamp(0.0, 1.0);

            return Transform.translate(
              offset: Offset(-distance * 18, 18 * amount),
              child: Transform.rotate(
                angle: distance * 0.075,
                alignment: Alignment.bottomCenter,
                child: Transform.scale(
                  scale: 1 - (0.12 * amount),
                  child: _TicketCard(
                    ticket: tickets[index],
                    imageUrl: _imageOf(tickets[index]),
                    date: _shortDateLabel(tickets[index].dateEvent),
                    price: _priceOf(tickets[index]),
                    quantity: _quantityOf(tickets[index]),
                    code: _ticketCode(tickets[index]),
                    sideAmount: amount,
                    onTap: () => _showTicketDetails(tickets[index]),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _TicketBackdrop extends StatelessWidget {
  const _TicketBackdrop({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 360),
      child: Stack(
        key: ValueKey(imageUrl),
        fit: StackFit.expand,
        children: [
          if (imageUrl.isNotEmpty)
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Transform.scale(
                scale: 1.04,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 180),
                  errorWidget: (_, _, _) => const _EmptyBackground(),
                ),
              ),
            )
          else
            const _EmptyBackground(),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xE0000000),
                  Color(0xB3000000),
                  Color(0xDE000000),
                ],
                stops: [0, .42, 1],
              ),
            ),
          ),
          const ColoredBox(color: Color(0x4D000000)),
        ],
      ),
    );
  }
}

class _EmptyBackground extends StatelessWidget {
  const _EmptyBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -.35),
          radius: 1.1,
          colors: [Color(0xFF302325), Color(0xFF09090A)],
        ),
      ),
    );
  }
}

class _TicketHeader extends StatelessWidget {
  const _TicketHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
      child: Row(
        children: [
          _RoundButton(
            tooltip: 'ย้อนกลับ',
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => context.pop(),
          ),
          Expanded(
            child: Text(
              'My Tickets',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansThai(
                color: Colors.white,
                fontSize: 13,
                height: 20 / 13,
                fontWeight: FontWeight.w600,
                letterSpacing: .1,
              ),
            ),
          ),
          _ProfileAvatar(imageUrl: currentUserPhoto),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: const Color(0x38FFFFFF),
        shape: CircleBorder(
          side: BorderSide(color: Colors.white.withValues(alpha: .12)),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(icon, color: Colors.white, size: 15),
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: imageUrl.isEmpty
            ? const ColoredBox(
                color: Color(0xFFEADFD9),
                child: Icon(
                  Icons.person_rounded,
                  color: Color(0xFF302522),
                  size: 20,
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => const ColoredBox(
                  color: Color(0xFFEADFD9),
                  child: Icon(
                    Icons.person_rounded,
                    color: Color(0xFF302522),
                    size: 20,
                  ),
                ),
              ),
      ),
    );
  }
}

class _TicketTitle extends StatelessWidget {
  const _TicketTitle({required this.title, required this.venue});

  final String title;
  final String venue;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: Padding(
        key: ValueKey('$title-$venue'),
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            Text(
              title.isEmpty ? 'MUNDAY TICKET' : title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSansThai(
                color: Colors.white,
                fontSize: 18,
                height: 24 / 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              venue.isEmpty ? 'MUNDAY' : venue,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSansThai(
                color: const Color(0xB8FFFFFF),
                fontSize: 12,
                height: 18 / 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({
    required this.ticket,
    required this.imageUrl,
    required this.date,
    required this.price,
    required this.quantity,
    required this.code,
    required this.sideAmount,
    required this.onTap,
  });

  final TicketRecord ticket;
  final String imageUrl;
  final String date;
  final String price;
  final int quantity;
  final String code;
  final double sideAmount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = math.max(0.0, constraints.maxWidth - 8);
        final maxHeight = math.max(0.0, constraints.maxHeight - 4);
        final width = math.min(maxWidth, maxHeight * .55).clamp(0.0, 282.0);
        final height = width / .55;

        return Center(
          child: Semantics(
            button: true,
            label: 'เปิดรายละเอียด ${ticket.nameEvent}',
            child: _Pressable(
              onTap: onTap,
              child: SizedBox(
                width: width,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x80000000),
                        blurRadius: 26,
                        spreadRadius: -5,
                        offset: Offset(0, 16),
                      ),
                    ],
                  ),
                  child: ClipPath(
                    clipper: const _TicketShapeClipper(),
                    child: _TicketCardContent(
                      ticket: ticket,
                      imageUrl: imageUrl,
                      date: date,
                      price: price,
                      quantity: quantity,
                      code: code,
                      sideAmount: sideAmount,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TicketCardContent extends StatelessWidget {
  const _TicketCardContent({
    required this.ticket,
    required this.imageUrl,
    required this.date,
    required this.price,
    required this.quantity,
    required this.code,
    required this.sideAmount,
  });

  final TicketRecord ticket;
  final String imageUrl;
  final String date;
  final String price;
  final int quantity;
  final String code;
  final double sideAmount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // All positions use the same 280 x 509 design coordinate system, so
        // the notch, tear line and barcode stub cannot drift apart when the
        // card is resized.
        final scale = constraints.maxWidth / 280;
        final tearY = 414 * scale;

        final topColor = Color.lerp(
          _TicketCarouselViewState._ticketTop,
          const Color(0x26FFFFFF),
          sideAmount,
        )!;
        final bottomColor = Color.lerp(
          _TicketCarouselViewState._ticketBottom,
          const Color(0x26FFFFFF),
          sideAmount,
        )!;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [topColor, bottomColor],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16 * scale,
                right: 16 * scale,
                top: 15 * scale,
                height: 35 * scale,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x18FFFFFF),
                    borderRadius: BorderRadius.circular(10 * scale),
                    border: Border.all(
                      color: const Color(0x52FFFFFF),
                      width: math.max(.6, .85 * scale),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Ticket for $quantity person${quantity == 1 ? '' : 's'}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSansThai(
                      color: _TicketCarouselViewState._onTicketSoft,
                      fontSize: 10.5 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16 * scale,
                right: 16 * scale,
                top: 62 * scale,
                height: 222 * scale,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15 * scale),
                  child: ColoredBox(
                    color: const Color(0x26000000),
                    child: imageUrl.isEmpty
                        ? Center(
                            child: Icon(
                              Icons.local_activity_outlined,
                              color: const Color(0x99FFFFFF),
                              size: 38 * scale,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 160),
                            errorWidget: (_, _, _) => Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: const Color(0x99FFFFFF),
                                size: 36 * scale,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Positioned(
                left: 14 * scale,
                right: 14 * scale,
                top: 299 * scale,
                height: 31 * scale,
                child: Row(
                  children: [
                    _CardFact(
                      icon: Icons.calendar_today_rounded,
                      value: date,
                      scale: scale,
                    ),
                    _CardFact(
                      icon: Icons.schedule_rounded,
                      value: ticket.timeEvent.isEmpty ? '-' : ticket.timeEvent,
                      scale: scale,
                    ),
                    _CardFact(
                      icon: Icons.sell_outlined,
                      value: price,
                      scale: scale,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 18 * scale,
                right: 18 * scale,
                top: 344 * scale,
                height: 49 * scale,
                child: _SeatFacts(ticket: ticket, scale: scale),
              ),
              Positioned(
                left: 14 * scale,
                right: 14 * scale,
                top: tearY - (8 * scale),
                height: 16 * scale,
                child: _Perforation(scale: scale),
              ),
              Positioned(
                left: 24 * scale,
                right: 24 * scale,
                top: 438 * scale,
                height: 50 * scale,
                child: _Barcode(code: code),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardFact extends StatelessWidget {
  const _CardFact({
    required this.icon,
    required this.value,
    required this.scale,
  });

  final IconData icon;
  final String value;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 17 * scale,
            height: 17 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x99FFFFFF),
                width: math.max(.6, .8 * scale),
              ),
            ),
            child: Icon(icon, color: const Color(0xE6FFFFFF), size: 9 * scale),
          ),
          SizedBox(width: 5 * scale),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                style: GoogleFonts.notoSansThai(
                  color: _TicketCarouselViewState._onTicket,
                  fontSize: 9.5 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeatFacts extends StatelessWidget {
  const _SeatFacts({required this.ticket, required this.scale});

  final TicketRecord ticket;
  final double scale;

  (String, String) get _rowAndSeat {
    final raw = ticket.seatCode.trim();
    if (raw.isEmpty) return ('-', '-');
    final parts = raw.split(RegExp(r'[-/]'));
    if (parts.length < 2) return ('-', raw);
    return (parts.first.trim(), parts.skip(1).join('-').trim());
  }

  @override
  Widget build(BuildContext context) {
    final (row, seat) = _rowAndSeat;
    return Row(
      children: [
        _StubFact(
          label: 'SALON',
          value: ticket.zone.isEmpty ? '-' : ticket.zone,
          scale: scale,
        ),
        _StubFact(label: 'ROW', value: row, scale: scale),
        _StubFact(label: 'SEAT', value: seat, scale: scale, showDivider: false),
      ],
    );
  }
}

class _StubFact extends StatelessWidget {
  const _StubFact({
    required this.label,
    required this.value,
    required this.scale,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final double scale;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: showDivider
            ? BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: const Color(0x52FFFFFF),
                    width: math.max(.6, .8 * scale),
                  ),
                ),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.notoSansThai(
                color: _TicketCarouselViewState._onTicketSoft,
                fontSize: 9 * scale,
                fontWeight: FontWeight.w500,
                letterSpacing: .65 * scale,
              ),
            ),
            SizedBox(height: 3 * scale),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  maxLines: 1,
                  style: GoogleFonts.notoSansThai(
                    color: _TicketCarouselViewState._onTicket,
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Perforation extends StatelessWidget {
  const _Perforation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PerforationPainter(
        dashWidth: 4 * scale,
        gapWidth: 5 * scale,
        strokeWidth: math.max(.7, 1.05 * scale),
      ),
    );
  }
}

class _PerforationPainter extends CustomPainter {
  const _PerforationPainter({
    required this.dashWidth,
    required this.gapWidth,
    required this.strokeWidth,
  });

  final double dashWidth;
  final double gapWidth;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x73FFFFFF)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final y = size.height / 2;
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, y),
        Offset(math.min(x + dashWidth, size.width), y),
        paint,
      );
      x += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant _PerforationPainter oldDelegate) {
    return dashWidth != oldDelegate.dashWidth ||
        gapWidth != oldDelegate.gapWidth ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}

class _Barcode extends StatelessWidget {
  const _Barcode({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _BarcodePainter(code));
  }
}

class _BarcodePainter extends CustomPainter {
  _BarcodePainter(this.code);

  final String code;

  List<int> _barWidths() {
    final source = code.isEmpty ? 'MUNDAY-TICKET' : code;
    var seed = 0x45D9F3B;
    for (final unit in source.codeUnits) {
      seed = ((seed * 31) ^ unit) & 0x7FFFFFFF;
    }

    return List.generate(58, (index) {
      seed = ((seed * 1103515245) + 12345) & 0x7FFFFFFF;
      if (index < 2 || (index >= 28 && index <= 30) || index > 55) return 1;
      return 1 + ((seed >> 16) & 3);
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final widths = _barWidths();
    const gapUnits = 1.35;
    final totalUnits =
        widths.fold<double>(0, (sum, width) => sum + width) +
        ((widths.length - 1) * gapUnits);
    final unit = size.width / totalUnits;
    final paint = Paint()..color = const Color(0xF2FFFFFF);
    var x = 0.0;

    for (var index = 0; index < widths.length; index++) {
      final barWidth = math.max(.65, widths[index] * unit);
      final isGuard = index < 2 || (index >= 28 && index <= 30) || index > 55;
      final verticalInset = isGuard ? 0.0 : size.height * .035;
      canvas.drawRect(
        Rect.fromLTWH(
          x,
          verticalInset,
          barWidth,
          size.height - (verticalInset * 2),
        ),
        paint,
      );
      x += barWidth + (gapUnits * unit);
    }
  }

  @override
  bool shouldRepaint(covariant _BarcodePainter oldDelegate) =>
      code != oldDelegate.code;
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final selected = index == activeIndex;
        return AnimatedContainer(
          key: ValueKey('ticket-dot-$index'),
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: selected ? 6 : 4,
          height: selected ? 6 : 4,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: selected ? Colors.white : const Color(0x73FFFFFF),
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _TicketDetailsSheet extends StatelessWidget {
  const _TicketDetailsSheet({
    required this.ticket,
    required this.imageUrl,
    required this.date,
    required this.price,
    required this.quantity,
    required this.status,
    required this.statusColor,
    required this.code,
    required this.onShowQr,
    this.onOpenVenue,
  });

  final TicketRecord ticket;
  final String imageUrl;
  final String date;
  final String price;
  final int quantity;
  final String status;
  final Color statusColor;
  final String code;
  final VoidCallback onShowQr;
  final VoidCallback? onOpenVenue;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .9,
      minChildSize: .62,
      maxChildSize: .96,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: _TicketCarouselViewState._surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            children: [
              Center(
                child: Container(
                  width: 34,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF55555B),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TICKET DETAILS',
                          style: GoogleFonts.notoSansThai(
                            color: const Color(0xFF8D8D94),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          ticket.nameEvent.isEmpty
                              ? 'MUNDAY TICKET'
                              : ticket.nameEvent,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.notoSansThai(
                            color: Colors.white,
                            fontSize: 22,
                            height: 28 / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: .13),
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(
                        color: statusColor.withValues(alpha: .7),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          status,
                          style: GoogleFonts.notoSansThai(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              AspectRatio(
                aspectRatio: 16 / 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: ColoredBox(
                    color: const Color(0xFF242429),
                    child: imageUrl.isEmpty
                        ? const Center(
                            child: Icon(
                              Icons.local_activity_outlined,
                              color: Color(0xFF77777E),
                              size: 44,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            errorWidget: (_, _, _) => const Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Color(0xFF77777E),
                                size: 40,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              if (ticket.nameVenues.isNotEmpty)
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFFFF6868),
                      size: 18,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        ticket.nameVenues,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSansThai(
                          color: const Color(0xFFD9D9DE),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 18),
              _DetailsGrid(
                items: [
                  _DetailData('วันที่', date, Icons.calendar_today_rounded),
                  _DetailData(
                    'เวลา',
                    ticket.timeEvent.isEmpty ? '-' : ticket.timeEvent,
                    Icons.schedule_rounded,
                  ),
                  _DetailData(
                    'โซน',
                    ticket.zone.isEmpty ? '-' : ticket.zone,
                    Icons.map_outlined,
                  ),
                  _DetailData(
                    'ที่นั่ง',
                    ticket.seatCode.isEmpty ? '-' : ticket.seatCode,
                    Icons.event_seat_outlined,
                  ),
                  _DetailData('จำนวน', '$quantity คน', Icons.group_outlined),
                  _DetailData('ราคา', price, Icons.sell_outlined),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1D21),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0x12FFFFFF)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.confirmation_num_outlined,
                      color: Color(0xFF8D8D94),
                      size: 19,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TICKET ID',
                            style: GoogleFonts.notoSansThai(
                              color: const Color(0xFF77777E),
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            code,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.notoSansThai(
                              color: const Color(0xFFD2D2D8),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                child: FilledButton.icon(
                  key: const ValueKey('show-ticket-qr'),
                  onPressed: onShowQr,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFE83D42),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.qr_code_rounded, size: 21),
                  label: Text(
                    'แสดง QR สำหรับเช็กอิน',
                    style: GoogleFonts.notoSansThai(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              if (onOpenVenue != null) ...[
                const SizedBox(height: 10),
                SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: onOpenVenue,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0x2EFFFFFF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.storefront_outlined, size: 19),
                    label: Text(
                      'ดูข้อมูลร้าน',
                      style: GoogleFonts.notoSansThai(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _DetailData {
  const _DetailData(this.label, this.value, this.icon);

  final String label;
  final String value;
  final IconData icon;
}

class _DetailsGrid extends StatelessWidget {
  const _DetailsGrid({required this.items});

  final List<_DetailData> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 520 ? 3 : 2;
        final spacing = 10.0;
        final itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (item) => SizedBox(
                  width: itemWidth,
                  child: Container(
                    height: 76,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1D21),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0x12FFFFFF)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item.icon,
                          color: const Color(0xFFFF6868),
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.label,
                                style: GoogleFonts.notoSansThai(
                                  color: const Color(0xFF7F7F86),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.notoSansThai(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _EmptyTickets extends StatelessWidget {
  const _EmptyTickets();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: const Color(0xFF18181B),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0x18FFFFFF)),
              ),
              child: const Icon(
                Icons.confirmation_num_outlined,
                color: Color(0xFF74747B),
                size: 34,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'ยังไม่มี Ticket',
              style: GoogleFonts.notoSansThai(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'เมื่อจองโต๊ะหรือซื้อบัตรแล้ว\nTicket ของคุณจะแสดงที่นี่',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansThai(
                color: const Color(0xFF8A8A91),
                fontSize: 13,
                height: 20 / 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketShapeClipper extends CustomClipper<Path> {
  const _TicketShapeClipper();

  @override
  Path getClip(Size size) {
    final cornerRadius = size.width * .09;
    final ticket = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(cornerRadius),
        ),
      );
    final notchY = size.height * .814;
    final notchRadius = size.width * .047;
    final holes = Path()
      ..addOval(Rect.fromCircle(center: Offset(0, notchY), radius: notchRadius))
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width, notchY),
          radius: notchRadius,
        ),
      );
    return Path.combine(PathOperation.difference, ticket, holes);
  }

  @override
  bool shouldReclip(covariant _TicketShapeClipper oldClipper) => false;
}

class _Pressable extends StatefulWidget {
  const _Pressable({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? .975 : 1,
        duration: const Duration(milliseconds: 110),
        child: widget.child,
      ),
    );
  }
}
