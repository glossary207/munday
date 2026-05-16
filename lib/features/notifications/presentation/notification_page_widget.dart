import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  static String routeName = 'NotificationPage';
  static String routePath = 'notifications';

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _friendRequests = [];
  bool _loadingRequests = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetchFriendRequests();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

      // Fetch sender profiles
      final List<Map<String, dynamic>> enriched = [];
      for (final row in (result as List)) {
        final senderId = row['sender_id'] as String?;
        if (senderId == null) continue;
        try {
          final userResult = await UsersRecord.collection
              .where('uid', isEqualTo: senderId)
              .limit(1)
              .get();
          if (userResult.docs.isNotEmpty) {
            final userDoc = UsersRecord.fromSnapshot(userResult.docs.first);
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
      if (mounted) setState(() { _friendRequests = enriched; _loadingRequests = false; });
    } catch (e) {
      if (mounted) setState(() => _loadingRequests = false);
    }
  }

  Future<void> _respondToRequest(String requestId, String senderId, bool accept) async {
    try {
      await Supabase.instance.client
          .from('friend_request')
          .update({'status': accept ? 'accepted' : 'rejected'})
          .eq('id', requestId);

      if (accept) {
        // Update both users to be friends
        await currentUserReference!.update({
          ...mapToSupabase({
            'cheers': FieldValue.arrayUnion([SupabaseFirestore.instance.doc('users/$senderId')]),
            'cheersEnd': FieldValue.arrayUnion([SupabaseFirestore.instance.doc('users/$senderId')]),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(accept ? 'Friend request accepted!' : 'Friend request declined.'),
          backgroundColor: accept ? const Color(0xFF00D333) : const Color(0xFF555555),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      _fetchFriendRequests();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: AuthUserStreamWidget(
          builder: (context) => Column(
            children: [
              _buildAppBar(context),
              _buildTabBar(context),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildActivityTab(context),
                    _buildFriendRequestsTab(context),
                    _buildNewsTab(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final pendingCount = _friendRequests.length;
    final unreadMsgCount = (currentUserDocument?.usermassage ?? []).length;
    final cheersCount = (currentUserDocument?.usercheerme ?? []).length;
    final totalBadge = pendingCount + unreadMsgCount + cheersCount;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.safePop(),
            child: const SizedBox(
              width: 40.0,
              height: 40.0,
              child: Icon(Icons.arrow_back_ios_outlined,
                  color: Colors.white, size: 24.0),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Row(
              children: [
                Text(
                  'Notifications',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.openSans(fontWeight: FontWeight.w700),
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                ),
                if (totalBadge > 0) ...[
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE52020),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      totalBadge > 99 ? '99+' : totalBadge.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: _fetchFriendRequests,
            child: const Icon(Icons.refresh, color: Color(0xFF9E9E9E), size: 22.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final unreadMsgCount = (currentUserDocument?.usermassage ?? []).length;
    final cheersCount = (currentUserDocument?.usercheerme ?? []).length;
    final pendingCount = _friendRequests.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      height: 44.0,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9E9E9E),
        indicator: BoxDecoration(
          color: const Color(0xFFE52020),
          borderRadius: BorderRadius.circular(22.0),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: GoogleFonts.openSans(
            fontSize: 13.0, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.openSans(
            fontSize: 13.0, fontWeight: FontWeight.normal),
        tabs: [
          _buildTab('Activity', unreadMsgCount + cheersCount),
          _buildTab('Requests', pendingCount),
          _buildTab('News', 0),
        ],
      ),
    );
  }

  Tab _buildTab(String label, int count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 5.0),
            Container(
              padding: const EdgeInsets.all(3.0),
              decoration: const BoxDecoration(
                  color: Colors.white30, shape: BoxShape.circle),
              child: Text(
                count > 9 ? '9+' : count.toString(),
                style: const TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold),
              ),
            ),
          ]
        ],
      ),
    );
  }

  // ─── TAB 1: Activity ──────────────────────────────────────────────────────

  Widget _buildActivityTab(BuildContext context) {
    final usermassage = currentUserDocument?.usermassage ?? [];
    final usercheerme = currentUserDocument?.usercheerme ?? [];

    if (usermassage.isEmpty && usercheerme.isEmpty) {
      return _buildEmpty('No new activity', Icons.notifications_none_outlined);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      children: [
        if (usermassage.isNotEmpty) ...[
          _buildSectionHeader('Unread Messages', Icons.chat_bubble_outline),
          ...usermassage.map((ref) => _buildMessageNotifItem(context, ref)),
          const SizedBox(height: 16.0),
        ],
        if (usercheerme.isNotEmpty) ...[
          _buildSectionHeader('Cheers Received', Icons.favorite_outline),
          ...usercheerme.map((ref) => _buildCheersNotifItem(context, ref)),
        ],
        const SizedBox(height: 40.0),
      ],
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
          icon: Icons.chat_bubble_outline,
          iconColor: const Color(0xFF4FC3F7),
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
          icon: Icons.favorite,
          iconColor: const Color(0xFFFF0000),
          time: null,
          onTap: () => context.pushNamed(MainChatWidget.routeName),
        );
      },
    );
  }

  // ─── TAB 2: Friend Requests ───────────────────────────────────────────────

  Widget _buildFriendRequestsTab(BuildContext context) {
    if (_loadingRequests) {
      return const Center(
          child: CircularProgressIndicator(color: Color(0xFFE52020)));
    }
    if (_friendRequests.isEmpty) {
      return _buildEmpty('No pending friend requests', Icons.person_outline);
    }

    return RefreshIndicator(
      color: const Color(0xFFE52020),
      backgroundColor: const Color(0xFF1A1A1A),
      onRefresh: _fetchFriendRequests,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        itemCount: _friendRequests.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildSectionHeader(
                  '${_friendRequests.length} Pending Request${_friendRequests.length != 1 ? 's' : ''}',
                  Icons.person_add_outlined),
            );
          }
          final req = _friendRequests[index - 1];
          return _buildFriendRequestCard(context, req);
        },
      ),
    );
  }

  Widget _buildFriendRequestCard(
      BuildContext context, Map<String, dynamic> req) {
    final photo = (req['senderPhoto'] as String?) ?? '';
    final name = (req['senderName'] as String?) ?? 'Unknown';
    final requestId = req['requestId'] as String;
    final senderId = req['senderId'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFF2A2A2A), width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 52.0,
            height: 52.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2A2A2A),
              image: photo.isNotEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(photo))
                  : null,
            ),
            child: photo.isEmpty
                ? const Icon(Icons.person, color: Color(0xFF555555), size: 28.0)
                : null,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3.0),
                const Text(
                  'Wants to be your friend',
                  style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 13.0),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            children: [
              GestureDetector(
                onTap: () => _respondToRequest(requestId, senderId, true),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE52020),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text('Accept',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 6.0),
              GestureDetector(
                onTap: () => _respondToRequest(requestId, senderId, false),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text('Decline',
                      style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── TAB 3: News / Promotions ─────────────────────────────────────────────

  Widget _buildNewsTab(BuildContext context) {
    return StreamBuilder<List<EventsRecord>>(
      stream: queryEventsRecord(
        queryBuilder: (q) => q.orderBy('Date', descending: true),
        limit: 20,
      ),
      builder: (context, snapshot) {
        final events = snapshot.data ?? [];
        if (events.isEmpty && !snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0xFFE52020)));
        }
        if (events.isEmpty) {
          return _buildEmpty('No news yet', Icons.newspaper_outlined);
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          itemCount: events.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildSectionHeader('Latest Events & Promotions',
                  Icons.local_activity_outlined);
            }
            final event = events[index - 1];
            return _buildEventNotifCard(context, event);
          },
        );
      },
    );
  }

  Widget _buildEventNotifCard(BuildContext context, EventsRecord event) {
    final dateText = event.date != null
        ? dateTimeFormat('d MMM yyyy', event.date!)
        : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFF2A2A2A), width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 52.0,
            height: 52.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xFF2A2A2A),
              image: event.poster.isNotEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(event.poster))
                  : null,
            ),
            child: event.poster.isEmpty
                ? const Icon(Icons.event, color: Color(0xFF555555), size: 26.0)
                : null,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.nameStore.isNotEmpty ? event.nameStore : 'New Event',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3.0),
                if (event.detail.isNotEmpty)
                  Text(
                    event.detail,
                    style: const TextStyle(
                        color: Color(0xFF9E9E9E), fontSize: 12.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (dateText.isNotEmpty) ...[
                  const SizedBox(height: 4.0),
                  Row(children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 11.0, color: Color(0xFFE52020)),
                    const SizedBox(width: 4.0),
                    Text(dateText,
                        style: const TextStyle(
                            color: Color(0xFFE52020), fontSize: 11.0)),
                  ]),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: event.free
                  ? const Color(0x2200D333)
                  : const Color(0x22E52020),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              event.free ? 'FREE' : 'PAID',
              style: TextStyle(
                color: event.free
                    ? const Color(0xFF00D333)
                    : const Color(0xFFE52020),
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Shared helpers ───────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9E9E9E), size: 16.0),
          const SizedBox(width: 6.0),
          Text(
            title,
            style: const TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5),
          ),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: const Color(0xFF2A2A2A)),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF2A2A2A),
                    image: photo.isNotEmpty
                        ? DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(photo))
                        : null,
                  ),
                  child: photo.isEmpty
                      ? const Icon(Icons.person,
                          color: Color(0xFF555555), size: 24.0)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 18.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                        color: iconColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2.0)),
                    child: Icon(icon, color: Colors.white, size: 10.0),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2.0),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Color(0xFF9E9E9E), fontSize: 12.0)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: Color(0xFF555555), size: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF333333), size: 56.0),
          const SizedBox(height: 16.0),
          Text(message,
              style: const TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 15.0,
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
        width: 40.0,
        height: 40.0,
        decoration: const BoxDecoration(
            color: Colors.black, shape: BoxShape.circle),
        child: Stack(
          children: [
            Center(
              child: Image.asset('assets/images/icon_notification.png',
                  width: 22.0, height: 22.0),
            ),
            if (total > 0)
              Positioned(
                top: 6.0,
                right: 6.0,
                child: Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE52020),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      total > 9 ? '9+' : total.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8.0,
                          fontWeight: FontWeight.bold),
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
