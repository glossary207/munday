import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ─── Design tokens ────────────────────────────────────────────────────────────

const _kBg = Color(0xFF000000);
const _kCard = Color(0xFF0E0E0E);
const _kCardBorder = Color(0xFF1C1C1C);
const _kRed = Color(0xFFE52020);
const _kOrange = Color(0xFFFF6B35);
const _kBlue = Color(0xFF4FC3F7);
const _kGreen = Color(0xFF00D333);
const _kPurple = Color(0xFF8B5CF6);
const _kText = Colors.white;
const _kTextSub = Color(0xFF888888);
const _kTextMuted = Color(0xFF4A4A4A);

// ─── Mock data models ─────────────────────────────────────────────────────────

class _MockNotif {
  final String name;
  final String subtitle;
  final String initials;
  final List<Color> avatarGradient;
  final String time;
  final bool isUnread;
  final IconData icon;
  final Color iconColor;
  final String? venue;

  const _MockNotif({
    required this.name,
    required this.subtitle,
    required this.initials,
    required this.avatarGradient,
    required this.time,
    required this.isUnread,
    required this.icon,
    required this.iconColor,
    this.venue,
  });
}

class _MockRequest {
  final String name;
  final String mutual;
  final String initials;
  final List<Color> avatarGradient;
  final String time;
  final String bio;

  const _MockRequest({
    required this.name,
    required this.mutual,
    required this.initials,
    required this.avatarGradient,
    required this.time,
    required this.bio,
  });
}

class _MockNews {
  final String venue;
  final String title;
  final String detail;
  final String date;
  final bool isFree;
  final String emoji;
  final String category;
  final List<Color> categoryGradient;
  final bool isHot;

  const _MockNews({
    required this.venue,
    required this.title,
    required this.detail,
    required this.date,
    required this.isFree,
    required this.emoji,
    required this.category,
    required this.categoryGradient,
    this.isHot = false,
  });
}

// ─── Static mock data ─────────────────────────────────────────────────────────

const _mockActivityItems = <_MockNotif>[
  _MockNotif(
    name: 'Alex Chen',
    subtitle: 'Cheers you at Club Onyx!',
    initials: 'AC',
    avatarGradient: [Color(0xFFFF6B35), Color(0xFFE52020)],
    time: '2m ago',
    isUnread: true,
    icon: Icons.local_bar,
    iconColor: _kOrange,
    venue: 'Club Onyx',
  ),
  _MockNotif(
    name: 'Maya K.',
    subtitle: 'Raised a glass with you!',
    initials: 'MK',
    avatarGradient: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
    time: '1h ago',
    isUnread: true,
    icon: Icons.local_bar,
    iconColor: _kOrange,
    venue: 'Sky Bar',
  ),
  _MockNotif(
    name: 'Tom S.',
    subtitle: 'Sent you a message',
    initials: 'TS',
    avatarGradient: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
    time: '3h ago',
    isUnread: false,
    icon: Icons.chat_bubble,
    iconColor: _kBlue,
  ),
  _MockNotif(
    name: 'Sara W.',
    subtitle: 'Cheers you at Levels!',
    initials: 'SW',
    avatarGradient: [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
    time: 'Yesterday',
    isUnread: false,
    icon: Icons.local_bar,
    iconColor: _kOrange,
    venue: 'Levels',
  ),
];

const _mockRequests = <_MockRequest>[
  _MockRequest(
    name: 'Nina Patel',
    mutual: '3 mutual friends',
    initials: 'NP',
    avatarGradient: [Color(0xFFFF9A9E), Color(0xFFFF6B6B)],
    time: 'Just now',
    bio: 'Nightlife enthusiast · Bangkok',
  ),
  _MockRequest(
    name: 'Jake Rivera',
    mutual: '1 mutual friend',
    initials: 'JR',
    avatarGradient: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    time: '5 min ago',
    bio: 'DJ · Club regular',
  ),
  _MockRequest(
    name: 'Lena M.',
    mutual: 'No mutual friends',
    initials: 'LM',
    avatarGradient: [Color(0xFF43E97B), Color(0xFF38F9D7)],
    time: '2h ago',
    bio: 'Event photographer',
  ),
];

const _mockNewsItems = <_MockNews>[
  _MockNews(
    venue: 'Club Onyx',
    title: 'Ladies Night Every Friday',
    detail: 'Free entry for ladies until midnight. Drinks starting ฿150.',
    date: 'Tonight',
    isFree: true,
    emoji: '🎉',
    category: 'EVENT',
    categoryGradient: [Color(0xFFE52020), Color(0xFFAA0000)],
    isHot: true,
  ),
  _MockNews(
    venue: 'Sky Bar',
    title: '2-for-1 Cocktails Weekend',
    detail: 'Buy one get one free on all signature cocktails this weekend only.',
    date: 'Tomorrow',
    isFree: false,
    emoji: '🍹',
    category: 'PROMO',
    categoryGradient: [Color(0xFFFF6B35), Color(0xFFCC4400)],
  ),
  _MockNews(
    venue: 'Levels',
    title: 'Grand Opening Party',
    detail: 'Join us for the biggest opening of the year. Live DJ sets all night.',
    date: '25 May',
    isFree: true,
    emoji: '🥂',
    category: 'EVENT',
    categoryGradient: [Color(0xFFE52020), Color(0xFFAA0000)],
  ),
  _MockNews(
    venue: 'Route 66',
    title: 'Live Band Night',
    detail: 'Local bands competing for the Khao San trophy. Free standing area.',
    date: '27 May',
    isFree: true,
    emoji: '🎸',
    category: 'MUSIC',
    categoryGradient: [Color(0xFF8B5CF6), Color(0xFF5B21B6)],
  ),
];

class _MockTicket {
  final String senderName;
  final String initials;
  final List<Color> avatarGradient;
  final String eventName;
  final String eventEmoji;
  final List<Color> eventGradient;
  final String eventDate;
  final String price;
  final String time;
  final bool isUnread;

  const _MockTicket({
    required this.senderName,
    required this.initials,
    required this.avatarGradient,
    required this.eventName,
    required this.eventEmoji,
    required this.eventGradient,
    required this.eventDate,
    required this.price,
    required this.time,
    this.isUnread = true,
  });
}

const _mockTicketItems = <_MockTicket>[
  _MockTicket(
    senderName: 'Bright T.',
    initials: 'BT',
    avatarGradient: [Color(0xFF43E97B), Color(0xFF38F9D7)],
    eventName: 'Ladies Night @ Club Onyx',
    eventEmoji: '🎉',
    eventGradient: [Color(0xFFE52020), Color(0xFFAA0000)],
    eventDate: '27 พ.ค.',
    price: 'ฟรี',
    time: '5m ago',
    isUnread: true,
  ),
  _MockTicket(
    senderName: 'Pang S.',
    initials: 'PS',
    avatarGradient: [Color(0xFFF093FB), Color(0xFFF5576C)],
    eventName: 'Grand Opening Party @ Levels',
    eventEmoji: '🥂',
    eventGradient: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    eventDate: '25 พ.ค.',
    price: '300 ฿',
    time: '2h ago',
    isUnread: false,
  ),
];

// ─── Main widget ──────────────────────────────────────────────────────────────

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  static String routeName = 'NotificationPage';
  static String routePath = 'notifications';

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {
  List<Map<String, dynamic>> _friendRequests = [];
  bool _loadingRequests = true;
  bool _mockupMode = false;

  final Set<int> _dismissedMockRequests = {};
  final Set<int> _dismissedMockTickets = {};

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetchFriendRequests();
    });
  }

  Future<void> _fetchFriendRequests() async {
    if (!mounted) return;
    setState(() => _loadingRequests = true);
    try {
      final result = await Supabase.instance.client
          .from('friend_request')
          .select('id, sender_id, status, created_at')
          .eq('receiver_id', currentUserUid)
          .eq('status', 'pending')
          .order('created_at', ascending: false);

      if (!mounted) return;

      final List<Map<String, dynamic>> enriched = [];
      for (final row in (result as List)) {
        final senderId = row['sender_id'] as String?;
        if (senderId == null) continue;
        try {
          final userSnap = await UsersRecord.collection.doc(senderId).get();
          if (userSnap.exists) {
            final userDoc = UsersRecord.fromSnapshot(userSnap);
            enriched.add({
              'requestId': row['id'],
              'senderId': senderId,
              'senderName': userDoc.displayName,
              'senderPhoto': userDoc.photoUrl,
              'createdAt': row['created_at'],
            });
          }
        } catch (_) {
          enriched.add({
            'requestId': row['id'],
            'senderId': senderId,
            'senderName': 'Unknown',
            'senderPhoto': '',
            'createdAt': row['created_at'],
          });
        }
      }
      if (mounted) {
        setState(() {
          _friendRequests = enriched;
          _loadingRequests = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingRequests = false);
    }
  }

  Future<void> _respondToRequest(
      String requestId, String senderId, bool accept) async {
    try {
      if (accept) {
        await Supabase.instance.client
            .from('friend_request')
            .update({'status': 'accepted'})
            .eq('id', requestId);
      } else {
        await Supabase.instance.client
            .from('friend_request')
            .delete()
            .eq('id', requestId);
      }

      if (accept) {
        final String lowId = currentUserUid.compareTo(senderId) < 0 ? currentUserUid : senderId;
        final String highId = currentUserUid.compareTo(senderId) > 0 ? currentUserUid : senderId;
        
        try {
          await Supabase.instance.client.from('friend').insert({
            'user_low_id': lowId,
            'user_high_id': highId,
          });
        } catch (e) {
          // Ignore unique constraint or other insertion errors if they somehow already exist
          debugPrint('Error inserting friend record: $e');
        }

        await currentUserReference!.update({
          ...mapToSupabase({
            'cheers': FieldValue.arrayUnion(
                [SupabaseFirestore.instance.doc('users/$senderId')]),
            'cheersEnd': FieldValue.arrayUnion(
                [SupabaseFirestore.instance.doc('users/$senderId')]),
          })
        });
        await SupabaseFirestore.instance.doc('users/$senderId').update({
          ...mapToSupabase({
            'cheers': FieldValue.arrayUnion([currentUserReference]),
            'cheersEnd': FieldValue.arrayUnion([currentUserReference]),
            'usermassage': FieldValue.arrayUnion([currentUserReference]),
          })
        });
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(accept ? 'Friend request accepted!' : 'Declined.'),
        backgroundColor:
            accept ? _kGreen : const Color(0xFF333333),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
      _fetchFriendRequests();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
    }
  }

  void _toggleMockup() {
    setState(() {
      _mockupMode = !_mockupMode;
      _dismissedMockRequests.clear();
      _dismissedMockTickets.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_mockupMode ? 'Mockup mode ON' : 'Mockup mode OFF'),
      backgroundColor:
          _mockupMode ? _kPurple : const Color(0xFF333333),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  int get _unreadCount => _mockupMode
      ? 2 + (_mockRequests.length - _dismissedMockRequests.length)
      : (currentUserDocument?.usermassage ?? []).length +
          (currentUserDocument?.usercheerme ?? []).length +
          _friendRequests.length;

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        top: true,
        child: AuthUserStreamWidget(
          builder: (context) => Column(
            children: [
              _buildAppBar(context),
              Expanded(child: _buildUnifiedFeed(context)),
            ],
          ),
        ),
      ),
    );
  }

  // ─── App bar ──────────────────────────────────────────────────────────────

  Widget _buildAppBar(BuildContext context) {
    final total = _unreadCount;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.safePop(),
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                shape: BoxShape.circle,
                border: Border.all(color: _kCardBorder),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: _kText, size: 16),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Notifications',
                  style: GoogleFonts.openSans(
                    color: _kText,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                if (total > 0) ...[
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFFF4444), _kRed]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      total > 99 ? '99+' : '$total',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
                if (_mockupMode) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _kPurple.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: _kPurple.withValues(alpha: 0.5), width: 1),
                    ),
                    child: Text('MOCKUP',
                        style: GoogleFonts.openSans(
                            color: _kPurple,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8)),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onLongPress: _toggleMockup,
            onTap: _fetchFriendRequests,
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                shape: BoxShape.circle,
                border: Border.all(
                    color: _mockupMode
                        ? _kPurple.withValues(alpha: 0.5)
                        : _kCardBorder),
              ),
              child: Icon(Icons.refresh_rounded,
                  color: _mockupMode ? _kPurple : _kTextSub, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Tab bar ──────────────────────────────────────────────────────────────

  // ─── Unified feed ─────────────────────────────────────────────────────────

  Widget _buildUnifiedFeed(BuildContext context) {
    if (_mockupMode) return _buildMockUnifiedFeed(context);
    return _buildRealUnifiedFeed(context);
  }

  Widget _buildMockUnifiedFeed(BuildContext context) {
    final visibleRequests = _mockRequests
        .asMap()
        .entries
        .where((e) => !_dismissedMockRequests.contains(e.key))
        .toList();
    final visibleTickets = _mockTicketItems
        .asMap()
        .entries
        .where((e) => !_dismissedMockTickets.contains(e.key))
        .toList();

    return RefreshIndicator(
      color: _kRed,
      backgroundColor: _kCard,
      onRefresh: () async => setState(() {}),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildFeedHeader('ใหม่'),
          _buildMockActivityCard(_mockActivityItems[0]),
          if (visibleTickets.isNotEmpty)
            _buildMockTicketCard(
                visibleTickets[0].key, visibleTickets[0].value),
          if (visibleRequests.isNotEmpty)
            _buildMockRequestCard(
                visibleRequests[0].key, visibleRequests[0].value),
          _buildMockActivityCard(_mockActivityItems[1]),
          _buildFeedHeader('ก่อนหน้า'),
          if (visibleTickets.length > 1)
            _buildMockTicketCard(
                visibleTickets[1].key, visibleTickets[1].value),
          if (visibleRequests.length > 1)
            _buildMockRequestCard(
                visibleRequests[1].key, visibleRequests[1].value),
          _buildMockNewsCard(_mockNewsItems[0]),
          _buildMockActivityCard(_mockActivityItems[2]),
          if (visibleRequests.length > 2)
            _buildMockRequestCard(
                visibleRequests[2].key, visibleRequests[2].value),
          _buildMockActivityCard(_mockActivityItems[3]),
          _buildMockNewsCard(_mockNewsItems[1]),
          _buildMockNewsCard(_mockNewsItems[2]),
          _buildMockNewsCard(_mockNewsItems[3]),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRealUnifiedFeed(BuildContext context) {
    if (_loadingRequests) {
      return const Center(child: CircularProgressIndicator(color: _kRed));
    }

    final usermassage = currentUserDocument?.usermassage ?? [];
    final usercheerme = currentUserDocument?.usercheerme ?? [];
    final hasActivity = _friendRequests.isNotEmpty ||
        usermassage.isNotEmpty ||
        usercheerme.isNotEmpty;

    return RefreshIndicator(
      color: _kRed,
      backgroundColor: _kCard,
      onRefresh: _fetchFriendRequests,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (hasActivity) ...[
            _buildFeedHeader('ใหม่'),
            ..._friendRequests.map((r) => _buildFriendRequestCard(context, r)),
            ...usermassage.map((ref) => _buildMessageNotifItem(context, ref)),
            ...usercheerme.map((ref) => _buildCheersNotifItem(context, ref)),
          ],
          StreamBuilder<List<EventsRecord>>(
            stream: queryEventsRecord(
              queryBuilder: (q) => q.orderBy('Date', descending: true),
              limit: 20,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                      child: CircularProgressIndicator(color: _kRed)),
                );
              }
              
              final events = snapshot.data ?? [];
              if (snapshot.hasError || events.isEmpty) {
                return const SizedBox.shrink();
              }
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeedHeader('ข่าวสารและอีเวนต์'),
                  ...events.map((e) => _buildEventNotifCard(context, e)),
                ],
              );
            },
          ),
          if (!hasActivity)
            _buildEmpty('ไม่มีการแจ้งเตือนใหม่',
                Icons.notifications_none_outlined),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildMockActivityCard(_MockNotif item) {
    return Material(
      color: item.isUnread
          ? const Color(0xFF0D0D0D)
          : Colors.transparent,
      child: InkWell(
        onTap: () {},
        splashColor: Colors.white.withValues(alpha: 0.03),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 11, 12, 11),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildGradientAvatar(
                initials: item.initials,
                gradient: item.avatarGradient,
                size: 50,
                badgeIcon: item.icon,
                badgeColor: item.iconColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: item.name,
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.45,
                          ),
                        ),
                        TextSpan(
                          text: ' ${item.subtitle}',
                          style: GoogleFonts.openSans(
                            color: const Color(0xFFCCCCCC),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.45,
                          ),
                        ),
                      ]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.isUnread
                          ? '${item.time} · ใหม่'
                          : item.time,
                      style: GoogleFonts.openSans(
                        color: item.isUnread
                            ? item.iconColor
                            : _kTextSub,
                        fontSize: 12,
                        fontWeight: item.isUnread
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (item.isUnread)
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item.iconColor,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const Icon(Icons.more_horiz_rounded,
                    color: Color(0xFF444444), size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageNotifItem(BuildContext context, SupabaseDocRef ref) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final user = snapshot.data!;
        return _buildNotifRow(
          photo: user.photoUrl,
          title: user.displayName.isNotEmpty ? user.displayName : 'Unknown',
          subtitle: 'Sent you a message',
          icon: Icons.chat_bubble,
          iconColor: _kBlue,
          time: null,
          onTap: () => context.pushNamed(MainChatWidget.routeName),
        );
      },
    );
  }

  Widget _buildCheersNotifItem(BuildContext context, SupabaseDocRef ref) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final user = snapshot.data!;
        return _buildNotifRow(
          photo: user.photoUrl,
          title: user.displayName.isNotEmpty ? user.displayName : 'Unknown',
          subtitle: 'Cheered you!',
          icon: Icons.local_bar,
          iconColor: _kOrange,
          time: null,
          onTap: () => context.pushNamed(MainChatWidget.routeName),
        );
      },
    );
  }


  Widget _buildMockRequestCard(int index, _MockRequest req) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Colors.white.withValues(alpha: 0.03),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 12, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGradientAvatar(
                    initials: req.initials,
                    gradient: req.avatarGradient,
                    size: 50,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: req.name,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.45,
                              ),
                            ),
                            TextSpan(
                              text: ' ส่งคำขอเป็นเพื่อน',
                              style: GoogleFonts.openSans(
                                color: const Color(0xFFCCCCCC),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.45,
                              ),
                            ),
                          ]),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${req.mutual} · ${req.time}',
                          style: GoogleFonts.openSans(
                            color: _kTextSub,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz_rounded,
                      color: Color(0xFF444444), size: 22),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(78, 0, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _dismissedMockRequests.add(index));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${req.name} added as friend!'),
                      backgroundColor: _kGreen,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('ยอมรับ',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      setState(() => _dismissedMockRequests.add(index)),
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('ปฏิเสธ',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.only(left: 78),
        ),
      ],
    );
  }

  Widget _buildMockTicketCard(int index, _MockTicket ticket) {
    const Color ticketColor = Color(0xFF7C3AED);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: ticket.isUnread
              ? const Color(0xFF0D0D0D)
              : Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Colors.white.withValues(alpha: 0.03),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 12, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGradientAvatar(
                    initials: ticket.initials,
                    gradient: ticket.avatarGradient,
                    size: 50,
                    badgeIcon: Icons.confirmation_number_rounded,
                    badgeColor: ticketColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: ticket.senderName,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.45,
                              ),
                            ),
                            TextSpan(
                              text: ' ส่ง ticket เข้างาน ',
                              style: GoogleFonts.openSans(
                                color: const Color(0xFFCCCCCC),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.45,
                              ),
                            ),
                            TextSpan(
                              text: ticket.eventName,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.45,
                              ),
                            ),
                          ]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 6, height: 6,
                              decoration: BoxDecoration(
                                color: ticket.isUnread
                                    ? ticketColor
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${ticket.eventDate} · ${ticket.price} · ${ticket.time}',
                              style: GoogleFonts.openSans(
                                color: ticket.isUnread
                                    ? ticketColor.withValues(alpha: 0.9)
                                    : _kTextSub,
                                fontSize: 12,
                                fontWeight: ticket.isUnread
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Event thumbnail
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: ticket.eventGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(ticket.eventEmoji,
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Accept / Decline buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(78, 0, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _dismissedMockTickets.add(index));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('รับ ticket จาก ${ticket.senderName} แล้ว!'),
                      backgroundColor: ticketColor,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('รับ ticket',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      setState(() => _dismissedMockTickets.add(index)),
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('ปฏิเสธ',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.only(left: 78),
        ),
      ],
    );
  }

  Widget _buildFriendRequestCard(
      BuildContext context, Map<String, dynamic> req) {
    final photo = (req['senderPhoto'] as String?) ?? '';
    final name = (req['senderName'] as String?) ?? 'Unknown';
    final requestId = req['requestId'] as String;
    final senderId = req['senderId'] as String;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Colors.white.withValues(alpha: 0.03),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 12, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2A2A2A),
                      image: photo.isNotEmpty
                          ? DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(photo))
                          : null,
                    ),
                    child: photo.isEmpty
                        ? const Icon(Icons.person, color: _kTextMuted, size: 28)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: name,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.45,
                              ),
                            ),
                            TextSpan(
                              text: ' ส่งคำขอเป็นเพื่อน',
                              style: GoogleFonts.openSans(
                                color: const Color(0xFFCCCCCC),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.45,
                              ),
                            ),
                          ]),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Now', // You can calculate relative time here using createdAt if desired
                          style: GoogleFonts.openSans(
                            color: _kTextSub,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz_rounded,
                      color: Color(0xFF444444), size: 22),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(78, 0, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _respondToRequest(requestId, senderId, true),
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('ยอมรับ',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => _respondToRequest(requestId, senderId, false),
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('ปฏิเสธ',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.only(left: 78),
        ),
      ],
    );
  }


  Widget _buildMockNewsCard(_MockNews news) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Colors.white.withValues(alpha: 0.03),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: news.categoryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(news.emoji,
                          style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: news.venue,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.45,
                              ),
                            ),
                            TextSpan(
                              text: ' ${news.title}',
                              style: GoogleFonts.openSans(
                                color: const Color(0xFFCCCCCC),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.45,
                              ),
                            ),
                          ]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              news.date,
                              style: GoogleFonts.openSans(
                                color: _kRed,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 6),
                            _buildCategoryChip(
                                news.category, news.categoryGradient),
                            if (news.isFree) ...[
                              const SizedBox(width: 4),
                              _buildFreePaidBadge(true),
                            ],
                            if (news.isHot) ...[
                              const SizedBox(width: 4),
                              Icon(Icons.local_fire_department_rounded,
                                  size: 13,
                                  color: _kOrange.withValues(alpha: 0.9)),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.more_horiz_rounded,
                      color: Color(0xFF444444), size: 22),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.only(left: 78),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String category, List<Color> gradient) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: gradient.map((c) => c.withValues(alpha: 0.2)).toList()),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: gradient.first.withValues(alpha: 0.3)),
      ),
      child: Text(category,
          style: TextStyle(
              color: gradient.first,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6)),
    );
  }

  Widget _buildFreePaidBadge(bool isFree) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isFree
            ? _kGreen.withValues(alpha: 0.12)
            : _kRed.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: isFree
                ? _kGreen.withValues(alpha: 0.3)
                : _kRed.withValues(alpha: 0.3)),
      ),
      child: Text(
        isFree ? 'FREE' : 'PAID',
        style: TextStyle(
            color: isFree ? _kGreen : _kRed,
            fontSize: 10,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _buildEventNotifCard(BuildContext context, EventsRecord event) {
    final dateText =
        event.date != null ? dateTimeFormat('d MMM yyyy', event.date!) : '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        splashColor: Colors.white.withValues(alpha: 0.03),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF2A2A2A),
                  image: event.poster.isNotEmpty
                      ? DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(event.poster))
                      : null,
                ),
                child: event.poster.isEmpty
                    ? const Icon(Icons.event, color: _kTextMuted, size: 26)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: event.nameStore.isNotEmpty ? event.nameStore : 'New Event',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.45,
                          ),
                        ),
                        if (event.detail.isNotEmpty)
                          TextSpan(
                            text: ' ${event.detail}',
                            style: GoogleFonts.openSans(
                              color: const Color(0xFFCCCCCC),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.45,
                            ),
                          ),
                      ]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        if (dateText.isNotEmpty) ...[
                          Text(
                            dateText,
                            style: GoogleFonts.openSans(
                              color: _kRed,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        _buildCategoryChip('EVENT', [_kRed, const Color(0xFFAA0000)]),
                        if (event.free) ...[
                          const SizedBox(width: 4),
                          _buildFreePaidBadge(true),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.more_horiz_rounded,
                  color: Color(0xFF444444), size: 22),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Shared helpers ───────────────────────────────────────────────────────

  Widget _buildGradientAvatar({
    required String initials,
    required List<Color> gradient,
    required double size,
    IconData? badgeIcon,
    Color? badgeColor,
  }) {
    return Stack(
      children: [
        Container(
          width: size, height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                  color: gradient.first.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Center(
            child: Text(initials,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: size * 0.3,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5)),
          ),
        ),
        if (badgeIcon != null && badgeColor != null)
          Positioned(
            bottom: 0, right: 0,
            child: Container(
              width: 20, height: 20,
              decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: _kBg, width: 2),
                  boxShadow: [
                    BoxShadow(
                        color: badgeColor.withValues(alpha: 0.4),
                        blurRadius: 4)
                  ]),
              child: Icon(badgeIcon, color: Colors.white, size: 10),
            ),
          ),
      ],
    );
  }

  Widget _buildFeedHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon,
      {Color? accentColor}) {
    final color = accentColor ?? _kTextMuted;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 6),
          Text(title.toUpperCase(),
              style: GoogleFonts.openSans(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2)),
          const SizedBox(width: 10),
          Expanded(
              child: Container(height: 1, color: _kCardBorder)),
        ],
      ),
    );
  }

  Widget _buildNotifRow({
    required String photo,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    DateTime? time,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white.withValues(alpha: 0.03),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 11, 12, 11),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2A2A2A),
                      image: photo.isNotEmpty
                          ? DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(photo))
                          : null,
                    ),
                    child: photo.isEmpty
                        ? const Icon(Icons.person, color: _kTextMuted, size: 28)
                        : null,
                  ),
                  Positioned(
                    bottom: -2, right: -2,
                    child: Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                        color: iconColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: _kBg, width: 2),
                      ),
                      child: Icon(icon, color: Colors.white, size: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: title,
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.45,
                          ),
                        ),
                        TextSpan(
                          text: ' $subtitle',
                          style: GoogleFonts.openSans(
                            color: const Color(0xFFCCCCCC),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.45,
                          ),
                        ),
                      ]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time != null ? dateTimeFormat('d MMM', time) : 'Now',
                      style: GoogleFonts.openSans(
                        color: _kTextSub,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.more_horiz_rounded,
                  color: Color(0xFF444444), size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                shape: BoxShape.circle,
                border: Border.all(color: _kCardBorder)),
            child: Icon(icon, color: const Color(0xFF2A2A2A), size: 36),
          ),
          const SizedBox(height: 16),
          Text(message,
              style: GoogleFonts.openSans(
                  color: _kTextMuted,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ─── Standalone Badge Widget ───────────────────────────────────────────────

class NotificationBadgeButton extends StatefulWidget {
  final VoidCallback onTap;
  const NotificationBadgeButton({super.key, required this.onTap});

  @override
  State<NotificationBadgeButton> createState() =>
      _NotificationBadgeButtonState();
}

class _NotificationBadgeButtonState extends State<NotificationBadgeButton> {
  int _pendingRequests = 0;

  @override
  void initState() {
    super.initState();
    _fetchCount();
  }

  Future<void> _fetchCount() async {
    try {
      final result = await Supabase.instance.client
          .from('friend_request')
          .select('id')
          .eq('receiver_id', currentUserUid)
          .eq('status', 'pending');
      if (mounted) {
        setState(() => _pendingRequests = (result as List).length);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final unreadMsg = (currentUserDocument?.usermassage ?? []).length;
    final cheers = (currentUserDocument?.usercheerme ?? []).length;
    final total = _pendingRequests + unreadMsg + cheers;

    return GestureDetector(
      onTap: () {
        _fetchCount();
        widget.onTap();
      },
      child: Container(
        width: 40, height: 40,
        decoration: const BoxDecoration(
            color: Colors.black, shape: BoxShape.circle),
        child: Stack(
          children: [
            Center(
              child: Image.asset('assets/images/icon_notification.png',
                  width: 22, height: 22),
            ),
            if (total > 0)
              Positioned(
                top: 6, right: 6,
                child: Container(
                  width: 14, height: 14,
                  decoration: BoxDecoration(
                    color: _kRed,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Center(
                    child: Text(total > 9 ? '9+' : '$total',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
