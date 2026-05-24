import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/shared/widgets/cards/card33_user_grid_widget.dart';
import '/shared/widgets/layout/containerborder.dart';
import '/shared/widgets/dialogs/add_friend_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_chat_model.dart';
export 'main_chat_model.dart';

class MainChatWidget extends StatefulWidget {
  const MainChatWidget({super.key});

  static String routeName = 'mainChat';
  static String routePath = 'mainChat';

  @override
  State<MainChatWidget> createState() => _MainChatWidgetState();
}

class _MainChatWidgetState extends State<MainChatWidget>
    with TickerProviderStateMixin {
  static const bool _mockMode = false;
  int _selectedTab = 0; // 0=All, 1=Chats, 2=Cheers

  late MainChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainChatModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!FFAppState().relock) {
        FFAppState().namestorelink =
            valueOrDefault(currentUserDocument?.checkin, '');
        FFAppState().ActivePromotion = false;
        FFAppState().apiready = true;
        FFAppState().relock = true;
        safeSetState(() {});
      }

      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildMainBody(
    BuildContext context,
    List<ChatRoomsRecord> containerChatRoomsRecordList,
    dynamic checkinRef,
    StoreRecord? stackStoreRecord,
    ChatRoomsRecord? containerChatRoomsRecord,
  ) {
    final groupChats =
        containerChatRoomsRecordList.where((r) => r.groupChat).toList();
    final dmRooms =
        containerChatRoomsRecordList.where((r) => !r.groupChat).toList();
    final dmData = functions
            .jsonDataRoomAndStore(
                currentUserReference, dmRooms, stackStoreRecord)
            ?.toList() ??
        [];

    final cheersEndSet = {
      for (final r in currentUserDocument?.cheersEnd ?? []) r.id
    };
    final unreadSet = {
      for (final r in currentUserDocument?.usermassage ?? []) r.id
    };

    int unreadChats = 0, unreadCheers = 0;
    for (final d in dmData) {
      final p = DatainstoreStruct.maybeFromMap(d);
      if (p == null) continue;
      final uid = p.userRef?.id;
      if (uid == null) continue;
      if (!unreadSet.contains(uid)) continue;
      if (cheersEndSet.contains(uid)) {
        unreadCheers++;
      } else {
        unreadChats++;
      }
    }

    const cardColors = [
      Color(0xFFD4EE8C),
      Color(0xFFD0B8F0),
      Color(0xFFFFC5A0),
      Color(0xFF98E4D0)
    ];
    final storeName = stackStoreRecord?.namestore ?? '';
    final storeLogo = stackStoreRecord?.logo ?? '';
    final isCheckedIn = checkinRef != null && stackStoreRecord != null;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => context.safePop(),
                      child: const SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: Icon(Icons.arrow_back_ios_outlined,
                            color: Colors.white, size: 24.0),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    if (isCheckedIn)
                      Row(children: [
                        Container(
                          width: 38.0,
                          height: 38.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF1D1D1D),
                            border: Border.all(
                                color: const Color(0xFF333333), width: 1.5),
                            image: storeLogo.isNotEmpty
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(storeLogo))
                                : null,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(storeName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 2.0),
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              Container(
                                  width: 7.0,
                                  height: 7.0,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF00D333),
                                      shape: BoxShape.circle)),
                              const SizedBox(width: 4.0),
                              const Text('Checked In',
                                  style: TextStyle(
                                      color: Color(0xFF00D333),
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500)),
                            ]),
                          ],
                        ),
                      ])
                    else
                      const Text(
                        'Messages',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ]),
                  Row(children: [
                    GestureDetector(
                      onTap: () => _showSearchModal(context),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Center(
                          child: Image.asset('assets/images/icon_search.png',
                              width: 19.0, height: 19.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    AuthUserStreamWidget(
                      builder: (context) => NotificationBadgeButton(
                        onTap: () =>
                            context.pushNamed(NotificationPageWidget.routeName),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => context.pushNamed(ProfileWidget.routeName,
                          queryParameters: {
                            'fromSeting': serializeParam(false, ParamType.bool)
                          }.withoutNulls),
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D1D1D),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(valueOrDefault<String>(
                                currentUserPhoto,
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png')),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                    ),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- TIER 1: FRIENDS ---
                    if (_selectedTab != 2) ...[
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 8.0, 20.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Text('friends ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                          font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0)),
                              Text('(${dmData.length})',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                          font: GoogleFonts.openSans(),
                                          color: const Color(0xFF9E9E9E),
                                          fontSize: 14.0)),
                            ]),
                            Text('See All',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                        font: GoogleFonts.openSans(),
                                        color: Colors.white,
                                        fontSize: 13.0)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 85.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          itemCount: dmData.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    barrierColor: const Color(0x88000000),
                                    context: context,
                                    builder: (ctx) => Padding(
                                      padding: MediaQuery.viewInsetsOf(ctx),
                                      child: const AddFriendWidget(),
                                    ),
                                  ),
                                  child: Column(children: [
                                    const Containerborder(
                                      width: 60.0,
                                      height: 60.0,
                                      dashWidth: 8.0,
                                      dashSpace: 4.0,
                                      borderColor: Colors.white,
                                      borderWidth: 1.5,
                                      icon: Icons.add,
                                      iconColor: Color(0xFFFF0000),
                                      iconSize: 28.0,
                                    ),
                                    const SizedBox(height: 5.0),
                                    const Text('Add friend',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500)),
                                  ]),
                                ),
                              );
                            }
                            final parsed = DatainstoreStruct.maybeFromMap(
                                dmData[index - 1]);
                            if (parsed == null) return const SizedBox.shrink();
                            final uid = parsed.userRef?.id;
                            final hasUnread =
                                uid != null && unreadSet.contains(uid);
                            final photo = valueOrDefault<String>(
                                parsed.photoprofile,
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png');
                            final name =
                                valueOrDefault<String>(parsed.name, '?');
                            return GestureDetector(
                              onTap: () => context.pushNamed(
                                  ChatsWidget.routeName,
                                  queryParameters: {
                                    'userProfile':
                                        serializeParam(photo, ParamType.String),
                                    'roomref': serializeParam(parsed.roomRef,
                                        ParamType.SupabaseDocRef),
                                    'name':
                                        serializeParam(name, ParamType.String),
                                    'online': serializeParam(
                                        parsed.online, ParamType.bool),
                                    'openchat':
                                        serializeParam(false, ParamType.bool),
                                  }.withoutNulls),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Column(children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(photo)),
                                        ),
                                      ),
                                      if (hasUnread)
                                        Positioned(
                                          top: -2,
                                          right: -2,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 2.0),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFF0000),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2.5),
                                            ),
                                            constraints: const BoxConstraints(
                                                minWidth: 20.0,
                                                minHeight: 20.0),
                                            child: const Center(
                                              child: Text('1',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500)),
                                ]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    // --- TIER 2: GROUPS ---
                    if (_selectedTab != 2) ...[
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 15.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Groups',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                        font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0)),
                            GestureDetector(
                              onTap: () {},
                              child: Text('+ New',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                          font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w500),
                                          color: const Color(0xFFFF0000),
                                          fontSize: 13.0)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 195.0,
                        child: groupChats.isEmpty
                            ? ListView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10.0, bottom: 6.0),
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    margin: const EdgeInsets.only(right: 12.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A1A1A),
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: const Color(0xFF333333),
                                          width: 1.5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add_circle_outline,
                                            color: Color(0xFF555555),
                                            size: 28.0),
                                        const SizedBox(height: 8.0),
                                        Text('Create a Group',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                    font: GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    color:
                                                        const Color(0xFF555555),
                                                    fontSize: 13.0)),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10.0, bottom: 6.0),
                                itemCount: groupChats.length,
                                itemBuilder: (context, index) {
                                  final group = groupChats[index];
                                  final cardColor =
                                      cardColors[index % cardColors.length];
                                  final isMyGroup = group.userIds
                                      .contains(currentUserReference?.id);
                                  return GestureDetector(
                                    onTap: () => context.pushNamed(
                                        ChatsWidget.routeName,
                                        queryParameters: {
                                          'userProfile': serializeParam(
                                              group.imageUrl, ParamType.String),
                                          'roomref': serializeParam(
                                              group.reference,
                                              ParamType.SupabaseDocRef),
                                          'name': serializeParam(
                                              group.name, ParamType.String),
                                          'online': serializeParam(
                                              true, ParamType.bool),
                                          'openchat': serializeParam(
                                              true, ParamType.bool),
                                        }.withoutNulls),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      margin:
                                          const EdgeInsets.only(right: 12.0),
                                      decoration: BoxDecoration(
                                          color: cardColor,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  group.name.isNotEmpty
                                                      ? group.name
                                                      : 'Group Chat',
                                                  style: const TextStyle(
                                                      color: Color(0xFF1A1A1A),
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 4.0),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0x1F000000),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: Text(
                                                    group.imageUrl.isNotEmpty
                                                        ? 'Venue'
                                                        : 'Normal',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF1A1A1A),
                                                        fontSize: 11.0,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12.0),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 8.0),
                                            decoration: BoxDecoration(
                                              color: const Color(0x1A000000),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Row(children: [
                                              const Icon(
                                                  Icons.chat_bubble_outline,
                                                  color: Color(0x881A1A1A),
                                                  size: 20.0),
                                              const SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  group.lastMessage.isNotEmpty
                                                      ? (group.lastMessageSenderId ==
                                                              currentUserReference
                                                                  ?.id
                                                          ? 'You: ${group.lastMessage}'
                                                          : group.lastMessage)
                                                      : 'No messages yet',
                                                  style: const TextStyle(
                                                      color: Color(0x881A1A1A),
                                                      fontSize: 13.0),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]),
                                          ),
                                          const SizedBox(height: 12.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  '${group.userIds.length} members',
                                                  style: const TextStyle(
                                                      color: Color(0x991A1A1A),
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 7.0),
                                                decoration: BoxDecoration(
                                                  color: isMyGroup
                                                      ? Colors.black
                                                      : const Color(0xFFFF0000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Text(
                                                    isMyGroup ? 'Open' : 'Join',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],

                    // --- TIER 3: MESSAGES ---
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 15.0, 20.0, 4.0),
                      child: Text('Messages',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                  font:
                                      GoogleFonts.openSans(
                                          fontWeight: FontWeight.w600),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0)),
                    ),

                    // Venue chat pinned at top
                    if (_selectedTab != 2 &&
                        isCheckedIn &&
                        containerChatRoomsRecord != null)
                      GestureDetector(
                        onTap: () async {
                          context.pushNamed(ChatsWidget.routeName,
                              queryParameters: {
                                'userProfile': serializeParam(
                                    stackStoreRecord.logo, ParamType.String),
                                'roomref': serializeParam(
                                    stackStoreRecord.iDroom,
                                    ParamType.SupabaseDocRef),
                                'name': serializeParam(
                                    stackStoreRecord.namestore,
                                    ParamType.String),
                                'online': serializeParam(false, ParamType.bool),
                                'openchat':
                                    serializeParam(true, ParamType.bool),
                              }.withoutNulls);
                          if (stackStoreRecord.iDroom != null) {
                            await stackStoreRecord.iDroom!.update(
                                createChatRoomsRecordData(
                                    lastMessageTime: getCurrentTimestamp));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 14.0, 20.0, 14.0),
                          child: Row(children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF1D1D1D),
                                image: storeLogo.isNotEmpty
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(storeLogo))
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0, vertical: 2.0),
                                      margin: const EdgeInsets.only(right: 6.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0x26FF0000),
                                          borderRadius:
                                              BorderRadius.circular(4.0)),
                                      child: const Text('Venue',
                                          style: TextStyle(
                                              color: Color(0xFFFF0000),
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Flexible(
                                      child: Text(storeName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ]),
                                  const SizedBox(height: 3.0),
                                  Text(
                                    containerChatRoomsRecord
                                            .lastMessage.isNotEmpty
                                        ? (containerChatRoomsRecord
                                                    .lastMessageSenderId ==
                                                currentUserReference?.id
                                            ? 'You: ${containerChatRoomsRecord.lastMessage}'
                                            : containerChatRoomsRecord
                                                .lastMessage)
                                        : 'Say hello! 👋',
                                    style: const TextStyle(
                                        color: Color(0xFF9E9E9E),
                                        fontSize: 13.0),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  containerChatRoomsRecord.lastMessageTime !=
                                          null
                                      ? dateTimeFormat(
                                          'Hm',
                                          containerChatRoomsRecord
                                              .lastMessageTime!,
                                          locale: FFLocalizations.of(context)
                                              .languageCode)
                                      : '',
                                  style: const TextStyle(
                                      color: Color(0xFF9E9E9E), fontSize: 12.0),
                                ),
                                const SizedBox(height: 5.0),
                                const Icon(Icons.done_all,
                                    size: 16.0, color: Color(0xFF4FC3F7)),
                              ],
                            ),
                          ]),
                        ),
                      ),

                    // DM list (filtered by tab)
                    Builder(builder: (context) {
                      final filteredDms = dmData.where((d) {
                        final p = DatainstoreStruct.maybeFromMap(d);
                        if (p == null) return false;
                        final uid = p.userRef?.id;
                        final isCheers =
                            uid != null && cheersEndSet.contains(uid);
                        if (_selectedTab == 1) return !isCheers;
                        if (_selectedTab == 2) return isCheers;
                        return true;
                      }).toList();

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredDms.length,
                        itemBuilder: (context, index) {
                          final parsed = DatainstoreStruct.maybeFromMap(
                              filteredDms[index]);
                          if (parsed == null) return const SizedBox.shrink();
                          final searchText = _model.textController?.text ?? '';
                          if (searchText.isNotEmpty &&
                              !(functions.showsearch(searchText, parsed.name) ??
                                  true)) {
                            return const SizedBox.shrink();
                          }
                          final uid = parsed.userRef?.id;
                          final hasUnread =
                              uid != null && unreadSet.contains(uid);
                          final isCheers =
                              uid != null && cheersEndSet.contains(uid);
                          final photo = valueOrDefault<String>(
                              parsed.photoprofile,
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png');
                          final name =
                              valueOrDefault<String>(parsed.name, 'ไม่ระบุ');

                          return GestureDetector(
                            onTap: () async {
                              context.pushNamed(ChatsWidget.routeName,
                                  queryParameters: {
                                    'userProfile':
                                        serializeParam(photo, ParamType.String),
                                    'roomref': serializeParam(parsed.roomRef,
                                        ParamType.SupabaseDocRef),
                                    'name':
                                        serializeParam(name, ParamType.String),
                                    'online': serializeParam(
                                        parsed.online, ParamType.bool),
                                    'openchat':
                                        serializeParam(false, ParamType.bool),
                                  }.withoutNulls);
                              if (parsed.roomRef != null) {
                                await parsed.roomRef!.update(
                                    createChatRoomsRecordData(
                                        lastMessageTime: getCurrentTimestamp));
                              }
                              if (parsed.userRef != null) {
                                await currentUserReference!.update({
                                  ...mapToSupabase({
                                    'usermassageRead':
                                        FieldValue.arrayUnion([parsed.userRef])
                                  })
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 14.0, 20.0, 14.0),
                              child: Row(children: [
                                Stack(children: [
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF1D1D1D),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(photo)),
                                    ),
                                  ),
                                  if (parsed.online)
                                    Positioned(
                                      bottom: 1.0,
                                      right: 1.0,
                                      child: Container(
                                        width: 13.0,
                                        height: 13.0,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF00D333),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2.0)),
                                      ),
                                    ),
                                ]),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        if (isCheers)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6.0, vertical: 2.0),
                                            margin: const EdgeInsets.only(
                                                right: 6.0),
                                            decoration: BoxDecoration(
                                                color: const Color(0x33FF0000),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: const Icon(Icons.favorite,
                                                size: 10.0,
                                                color: Color(0xFFFF0000)),
                                          ),
                                        Flexible(
                                          child: Text(name,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                      color: Colors.white,
                                                      fontSize: 14.0)),
                                        ),
                                      ]),
                                      const SizedBox(height: 3.0),
                                      Text(
                                        parsed.lastmassage.isNotEmpty
                                            ? (parsed.lastpersonUpdate ==
                                                    currentUserReference
                                                ? 'You: ${parsed.lastmassage}'
                                                : parsed.lastmassage)
                                            : '',
                                        style: TextStyle(
                                          color: hasUnread
                                              ? Colors.white
                                              : const Color(0xFF9E9E9E),
                                          fontSize: 13.0,
                                          fontWeight: hasUnread
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      parsed.timeupdate != null
                                          ? dateTimeFormat(
                                              'Hm', parsed.timeupdate!,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode)
                                          : '',
                                      style: const TextStyle(
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 12.0),
                                    ),
                                    const SizedBox(height: 5.0),
                                    if (hasUnread)
                                      Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFFF0000),
                                            shape: BoxShape.circle),
                                        child: const Center(
                                            child: Text('1',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      )
                                    else
                                      const Icon(Icons.done_all,
                                          size: 16.0, color: Color(0xFF4FC3F7)),
                                  ],
                                ),
                              ]),
                            ),
                          );
                        },
                      );
                    }),

                    const SizedBox(height: 80.0),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Cheers pop-up (unchanged)
        if (((currentUserDocument?.cheersEnd.toList() ?? []).length !=
                (currentUserDocument?.showprofilecheers.toList() ?? [])
                    .length) &&
            ((currentUserDocument?.cheersEnd.toList() ?? []).length != 0))
          StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(
                (currentUserDocument?.cheersEnd.toList() ?? []).elementAtOrNull(
                    (currentUserDocument?.showprofilecheers.toList() ?? [])
                        .length)!),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              final card33UserGridUsersRecord = snapshot.data!;
              return InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(MainChatWidget.routeName);
                  await currentUserReference!.update({
                    ...mapToSupabase({
                      'showprofilecheers': FieldValue.arrayUnion(
                          [card33UserGridUsersRecord.reference]),
                    }),
                  });
                },
                child: wrapWithModel(
                  model: _model.card33UserGridModel,
                  updateCallback: () => safeSetState(() {}),
                  updateOnChange: true,
                  child: Card33UserGridWidget(
                    name: valueOrDefault<String>(
                        card33UserGridUsersRecord.displayName, 'ไม่ระบุ'),
                    image: valueOrDefault<String>(
                        card33UserGridUsersRecord.photoUrl,
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png'),
                    uid: card33UserGridUsersRecord.reference,
                  ),
                ),
              );
            },
          ),

        // Fade gradient behind floating tab bar
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 100.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                stops: [0.0, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        _buildLiveFloatingTabBar(unreadChats, unreadCheers),
      ],
    );
  }

  // ── Mock data ──
  static const _mockStore = 'Levels Club';
  static const _mockStoreLogo =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/tpcoeg4f3ab4/iconmain.png';

  static const _mockCheers = [
    {
      'name': 'Anna',
      'photo': 'https://i.pravatar.cc/150?img=5',
      'online': true,
      'unreadCount': 3
    },
    {
      'name': 'Lisa',
      'photo': 'https://i.pravatar.cc/150?img=9',
      'online': true,
      'unreadCount': 0
    },
    {
      'name': 'Mark',
      'photo': 'https://i.pravatar.cc/150?img=11',
      'online': false,
      'unreadCount': 12
    },
    {
      'name': 'Sara',
      'photo': 'https://i.pravatar.cc/150?img=12',
      'online': true,
      'unreadCount': 0
    },
    {
      'name': 'John',
      'photo': 'https://i.pravatar.cc/150?img=13',
      'online': false,
      'unreadCount': 1
    },
  ];

  static const _mockGroups = [
    {
      'name': 'Friday Night Vibes 🔥',
      'members': 14,
      'color': 0xFFD4EE8C,
      'lastMsg': 'ใครจะเอาโต๊ะที่ร้าน',
      'senderName': 'Addie',
      'senderPhoto': 'https://i.pravatar.cc/150?img=1',
      'isVenue': true,
      'canJoin': false,
      'avatars': [
        'https://i.pravatar.cc/150?img=11',
        'https://i.pravatar.cc/150?img=12',
        'https://i.pravatar.cc/150?img=13',
        'https://i.pravatar.cc/150?img=14',
      ],
    },
    {
      'name': 'Rooftop Session',
      'members': 7,
      'color': 0xFFD0B8F0,
      'lastMsg': 'See you at 10pm 🌙',
      'senderName': 'Mike',
      'senderPhoto': 'https://i.pravatar.cc/150?img=4',
      'isVenue': false,
      'canJoin': true,
      'avatars': [
        'https://i.pravatar.cc/150?img=15',
        'https://i.pravatar.cc/150?img=16',
        'https://i.pravatar.cc/150?img=17',
      ],
    },
  ];
  static const _mockChats = [
    {
      'name': 'Addie',
      'msg': 'What time do you want to order lunch...?',
      'time': '09:21',
      'unread': true,
      'me': false,
      'online': true,
      'type': 'friend',
      'photo': 'https://i.pravatar.cc/150?img=1'
    },
    {
      'name': 'SLP',
      'msg': 'https://youtu.be/LjHcHTJ8D5k?t=1204',
      'time': '09:20',
      'unread': false,
      'me': false,
      'online': false,
      'type': 'friend',
      'photo': 'https://i.pravatar.cc/150?img=2'
    },
    {
      'name': 'Rose',
      'msg': 'Hahaha that is so true!',
      'time': '09:12',
      'unread': false,
      'me': true,
      'online': true,
      'type': 'cheers',
      'photo': 'https://i.pravatar.cc/150?img=3'
    },
  ];

  Widget _buildMockBody(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar — checkin mode
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: Icon(Icons.arrow_back_ios_outlined,
                          color: Colors.white, size: 24.0),
                    ),
                    const SizedBox(width: 10.0),
                    Row(children: [
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1D1D1D),
                          border: Border.all(
                              color: const Color(0xFF333333), width: 1.5),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_mockStoreLogo)),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(_mockStore,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2.0),
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Container(
                                width: 7.0,
                                height: 7.0,
                                decoration: const BoxDecoration(
                                    color: Color(0xFF00D333),
                                    shape: BoxShape.circle)),
                            const SizedBox(width: 4.0),
                            const Text('Checked In',
                                style: TextStyle(
                                    color: Color(0xFF00D333),
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500)),
                          ]),
                        ],
                      ),
                    ]),
                  ]),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showSearchModal(context),
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: const BoxDecoration(
                            color: Color(0x651D1D1D),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.search_sharp,
                            color: Colors.white,
                            size: 22.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1D1D1D),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://i.pravatar.cc/150?img=10')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- TIER 1: FRIENDS ---
                    if (_selectedTab != 2) ...[
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 8.0, 20.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('friends ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                            font: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w600),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0)),
                                Text('(20)',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                            font: GoogleFonts.openSans(
                                                fontWeight: FontWeight.normal),
                                            color: const Color(0xFF9E9E9E),
                                            fontSize: 14.0)),
                              ],
                            ),
                            Text('See All',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                        font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.normal),
                                        color: Colors.white,
                                        fontSize: 13.0)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 85.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          itemCount: _mockCheers.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      barrierColor: const Color(0x88000000),
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: const AddFriendWidget(),
                                        );
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      const Containerborder(
                                        width: 60.0,
                                        height: 60.0,
                                        dashWidth: 8.0,
                                        dashSpace: 4.0,
                                        borderColor: Colors.white,
                                        borderWidth: 1.5,
                                        icon: Icons.add,
                                        iconColor: Color(0xFFFF0000),
                                        iconSize: 28.0,
                                      ),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        'Add friend',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }

                            final cheer = _mockCheers[index - 1];
                            return GestureDetector(
                              onTap: () => context.pushNamed(
                                  ChatsWidget.routeName,
                                  queryParameters: {
                                    'userProfile': serializeParam(
                                        cheer['photo'] as String,
                                        ParamType.String),
                                    'name': serializeParam(
                                        cheer['name'] as String,
                                        ParamType.String),
                                    'online': serializeParam(
                                        cheer['online'] as bool,
                                        ParamType.bool),
                                    'openchat':
                                        serializeParam(false, ParamType.bool),
                                  }.withoutNulls),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: 60.0,
                                          height: 60.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  cheer['photo'] as String),
                                            ),
                                          ),
                                        ),
                                        if ((cheer['unreadCount'] as int? ??
                                                0) >
                                            0)
                                          Positioned(
                                            top: -2,
                                            right: -2,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 2.0),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF0000),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFF000000),
                                                  width: 2.5,
                                                ),
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 20.0,
                                                minHeight: 20.0,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  (cheer['unreadCount'] as int)
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      cheer['name'] as String,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    // --- TIER 2: GROUPS ---
                    if (_selectedTab != 2) ...[
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 15.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Groups',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                        font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0)),
                            Text('+ New',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                        font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500),
                                        color: const Color(0xFFFF0000),
                                        fontSize: 13.0)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 195.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 10.0, bottom: 6.0),
                          itemCount: _mockGroups.length,
                          itemBuilder: (context, index) {
                            final group = _mockGroups[index];
                            final cardColor = Color(group['color'] as int);
                            final isVenue = group['isVenue'] as bool;
                            final canJoin = group['canJoin'] as bool;
                            final avatars = group['avatars'] as List;
                            final extraMembers =
                                (group['members'] as int) - avatars.length;
                            final stackWidth =
                                (avatars.length - 1) * 20.0 + 36.0;
                            return GestureDetector(
                              onTap: () => context.pushNamed(
                                  ChatsWidget.routeName,
                                  queryParameters: {
                                    'userProfile': serializeParam(
                                        group['senderPhoto'] as String,
                                        ParamType.String),
                                    'name': serializeParam(
                                        group['name'] as String,
                                        ParamType.String),
                                    'online':
                                        serializeParam(true, ParamType.bool),
                                    'openchat':
                                        serializeParam(true, ParamType.bool),
                                  }.withoutNulls),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                margin: const EdgeInsets.only(right: 12.0),
                                decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.circular(20.0)),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            group['name'] as String,
                                            style: const TextStyle(
                                                color: Color(0xFF1A1A1A),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        if (isVenue)
                                          Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0x1F000000),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      _mockStoreLogo)),
                                            ),
                                          )
                                        else
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 4.0),
                                            decoration: BoxDecoration(
                                                color: const Color(0x1F000000),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: const Text('Normal',
                                                style: TextStyle(
                                                    color: Color(0xFF1A1A1A),
                                                    fontSize: 11.0,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0x1A000000),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 38.0,
                                            height: 38.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      group['senderPhoto']
                                                          as String)),
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  group['senderName'] as String,
                                                  style: const TextStyle(
                                                      color: Color(0xFF1A1A1A),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 2.0),
                                                Text(
                                                  group['lastMsg'] as String,
                                                  style: const TextStyle(
                                                      color: Color(0x881A1A1A),
                                                      fontSize: 13.0),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: stackWidth,
                                              height: 36.0,
                                              child: Stack(
                                                children: List.generate(
                                                    avatars.length,
                                                    (i) => Positioned(
                                                          left: i * 20.0,
                                                          child: Container(
                                                            width: 36.0,
                                                            height: 36.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color:
                                                                      cardColor,
                                                                  width: 2.0),
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(
                                                                      avatars[i]
                                                                          as String)),
                                                            ),
                                                          ),
                                                        )),
                                              ),
                                            ),
                                            if (extraMembers > 0) ...[
                                              const SizedBox(width: 8.0),
                                              Text('+$extraMembers',
                                                  style: const TextStyle(
                                                      color: Color(0x991A1A1A),
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 7.0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFF0000),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Text(
                                            canJoin ? 'Join' : '+ Add',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    // --- TIER 3: MESSAGES (Direct Messages) ---
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 15.0, 20.0, 4.0),
                      child: Text('Messages',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                  font:
                                      GoogleFonts.openSans(
                                          fontWeight: FontWeight.w600),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0)),
                    ),
                    // Venue chat pinned at the top
                    if (_selectedTab != 2)
                      GestureDetector(
                        onTap: () => context.pushNamed(ChatsWidget.routeName,
                            queryParameters: {
                              'userProfile': serializeParam(
                                  _mockStoreLogo, ParamType.String),
                              'name':
                                  serializeParam(_mockStore, ParamType.String),
                              'online': serializeParam(true, ParamType.bool),
                              'openchat': serializeParam(true, ParamType.bool),
                            }.withoutNulls),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 14.0, 20.0, 14.0),
                          child: Row(children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF1D1D1D),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(_mockStoreLogo))),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0, vertical: 2.0),
                                      margin: const EdgeInsets.only(right: 6.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0x26FF0000),
                                          borderRadius:
                                              BorderRadius.circular(4.0)),
                                      child: const Text('Venue',
                                          style: TextStyle(
                                              color: Color(0xFFFF0000),
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    const Text(_mockStore,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600)),
                                  ]),
                                  const SizedBox(height: 3.0),
                                  const Text(
                                      'You: Welcome everyone to Levels! 🎉',
                                      style: TextStyle(
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 13.0),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ])),
                            const SizedBox(width: 8.0),
                            const Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('09:00',
                                      style: TextStyle(
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 12.0)),
                                  SizedBox(height: 5.0),
                                  Icon(Icons.done_all,
                                      size: 16.0, color: Color(0xFF4FC3F7)),
                                ]),
                          ]),
                        ),
                      ),

                    // Normal Chats
                    Builder(
                      builder: (context) {
                        List<Map<String, Object>> filteredChats = [];
                        if (_selectedTab == 0) {
                          filteredChats = List.from(_mockChats);
                        } else if (_selectedTab == 1) {
                          filteredChats = _mockChats
                              .where((c) => c['type'] != 'cheers')
                              .toList();
                        } else if (_selectedTab == 2) {
                          filteredChats = _mockChats
                              .where((c) => c['type'] == 'cheers')
                              .toList();
                        }

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filteredChats.length,
                          itemBuilder: (context, index) {
                            final chat = filteredChats[index];
                            final hasUnread = chat['unread'] as bool;
                            final isOnline = chat['online'] as bool;
                            final isCheers = chat['type'] == 'cheers';
                            return GestureDetector(
                              onTap: () => context.pushNamed(
                                  ChatsWidget.routeName,
                                  queryParameters: {
                                    'userProfile': serializeParam(
                                        chat['photo'] as String,
                                        ParamType.String),
                                    'name': serializeParam(
                                        chat['name'] as String,
                                        ParamType.String),
                                    'online': serializeParam(
                                        chat['online'] as bool, ParamType.bool),
                                    'openchat':
                                        serializeParam(false, ParamType.bool),
                                  }.withoutNulls),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 14.0, 20.0, 14.0),
                                child: Row(children: [
                                  Stack(children: [
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFF1D1D1D),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                chat['photo'] as String)),
                                      ),
                                    ),
                                    if (isOnline)
                                      Positioned(
                                          bottom: 1.0,
                                          right: 1.0,
                                          child: Container(
                                            width: 13.0,
                                            height: 13.0,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF00D333),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0)),
                                          )),
                                  ]),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Row(children: [
                                          if (isCheers)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6.0,
                                                      vertical: 2.0),
                                              margin: const EdgeInsets.only(
                                                  right: 6.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x33FF0000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0)),
                                              child: const Icon(Icons.favorite,
                                                  size: 10.0,
                                                  color: Color(0xFFFF0000)),
                                            ),
                                          Text(chat['name'] as String,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                      color: Colors.white,
                                                      fontSize: 14.0)),
                                        ]),
                                        const SizedBox(height: 3.0),
                                        Text(chat['msg'] as String,
                                            style: TextStyle(
                                                color: hasUnread
                                                    ? Colors.white
                                                    : const Color(0xFF9E9E9E),
                                                fontSize: 13.0,
                                                fontWeight: hasUnread
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ])),
                                  const SizedBox(width: 8.0),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(chat['time'] as String,
                                            style: const TextStyle(
                                                color: Color(0xFF9E9E9E),
                                                fontSize: 12.0)),
                                        const SizedBox(height: 5.0),
                                        if (hasUnread)
                                          Container(
                                              width: 20.0,
                                              height: 20.0,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFFFF0000),
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                  child: Text('1',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11.0,
                                                          fontWeight: FontWeight
                                                              .bold))))
                                        else
                                          const Icon(Icons.done_all,
                                              size: 16.0,
                                              color: Color(0xFF4FC3F7)),
                                      ]),
                                ]),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Fade gradient behind the floating tab bar
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 100.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                stops: [0.0, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        _buildFloatingTabBar(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<f_f_story_view_live_zhm3f3_app_state.FFAppState>();

    if (_mockMode) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: SafeArea(
          top: true,
          child: _buildMockBody(context),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: true,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          body: SafeArea(
            top: true,
            child: AuthUserStreamWidget(
              builder: (context) {
                final checkinRef = currentUserDocument?.checkinID;

                return StreamBuilder<List<ChatRoomsRecord>>(
                  stream: queryChatRoomsRecord(
                    queryBuilder: (chatRoomsQuery) => chatRoomsQuery
                        .where('user_ids', arrayContains: currentUserReference)
                        .orderBy('last_message_time', descending: true),
                  ),
                  builder: (context, roomListSnapshot) {
                    if (roomListSnapshot.hasError) {
                      return Center(
                          child: Text(
                              'Error RoomList: ${roomListSnapshot.error}',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16)));
                    }
                    if (!roomListSnapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    }
                    final containerChatRoomsRecordList = roomListSnapshot.data!;

                    if (checkinRef != null) {
                      return StreamBuilder<StoreRecord>(
                        stream: StoreRecord.getDocument(checkinRef),
                        builder: (context, storeSnapshot) {
                          if (storeSnapshot.hasError) {
                            return Center(
                                child: Text(
                                    'Error Store: ${storeSnapshot.error}',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16)));
                          }
                          if (!storeSnapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            );
                          }
                          final stackStoreRecord = storeSnapshot.data!;

                          if (stackStoreRecord.iDroom != null) {
                            return StreamBuilder<ChatRoomsRecord>(
                              stream: ChatRoomsRecord.getDocument(
                                  stackStoreRecord.iDroom!),
                              builder: (context, storeRoomSnapshot) {
                                if (storeRoomSnapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          'Error StoreRoom: ${storeRoomSnapshot.error}',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16)));
                                }
                                if (!storeRoomSnapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  );
                                }
                                final containerChatRoomsRecord =
                                    storeRoomSnapshot.data!;
                                return _buildMainBody(
                                    context,
                                    containerChatRoomsRecordList,
                                    checkinRef,
                                    stackStoreRecord,
                                    containerChatRoomsRecord);
                              },
                            );
                          } else {
                            return _buildMainBody(
                                context,
                                containerChatRoomsRecordList,
                                checkinRef,
                                stackStoreRecord,
                                null);
                          }
                        },
                      );
                    } else {
                      return _buildMainBody(context,
                          containerChatRoomsRecordList, null, null, null);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.88,
          decoration: const BoxDecoration(
            color: Color(0xFF141414),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12.0, bottom: 20.0),
                  width: 40.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF333333),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              // Search input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF222222),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12.0),
                            const Icon(Icons.search_sharp,
                                color: Color(0xFF9E9E9E)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: 'Search for user or group...',
                                  hintStyle:
                                      TextStyle(color: Color(0xFF9E9E9E)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text('Cancel',
                          style: TextStyle(
                              color: Color(0xFFFF0000), fontSize: 15.0)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              // Recent & Popular
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Recent and Popular',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    _buildSearchTag('Mike', true),
                    _buildSearchTag('Levels Club', true),
                    _buildSearchTag('Friday Night Vibes', false),
                    _buildSearchTag('Rose', false),
                    _buildSearchTag('Afterparty', true),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchTag(String text, bool trending) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trending) ...[
            const Icon(Icons.trending_up, color: Color(0xFFFF9800), size: 16.0),
            const SizedBox(width: 6.0),
          ],
          Text(text,
              style: const TextStyle(color: Color(0xFFE0E0E0), fontSize: 13.0)),
        ],
      ),
    );
  }

  Widget _buildFloatingTabBar() {
    int unreadChats = _mockChats
        .where((c) => c['unread'] == true && c['type'] != 'cheers')
        .length;
    int unreadCheers = _mockChats
        .where((c) => c['unread'] == true && c['type'] == 'cheers')
        .length;

    const double tabWidth = 95.0; // Compact fixed width per tab
    const double padding = 4.0;
    const double height = 44.0;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: true,
        child: Center(
          child: Container(
            height: height,
            padding: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: const Color(0xFFE52020), // Elegant red
              borderRadius: BorderRadius.circular(height / 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Slider
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  left: _selectedTab * tabWidth,
                  top: 0,
                  bottom: 0,
                  width: tabWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular((height - padding * 2) / 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                // Items
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFloatingTabItem('All', 0, 0, tabWidth),
                    _buildFloatingTabItem('Chats', 1, unreadChats, tabWidth),
                    _buildFloatingTabItem('Cheers', 2, unreadCheers, tabWidth),
                  ],
                ),
              ],
            ),
          ), // Container
        ), // Center
      ), // SafeArea
    ); // Positioned
  }

  Widget _buildLiveFloatingTabBar(int unreadChats, int unreadCheers) {
    const double tabWidth = 95.0;
    const double padding = 4.0;
    const double height = 44.0;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: true,
        child: Center(
          child: Container(
            height: height,
            padding: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: const Color(0xFFE52020),
              borderRadius: BorderRadius.circular(height / 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  left: _selectedTab * tabWidth,
                  top: 0,
                  bottom: 0,
                  width: tabWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular((height - padding * 2) / 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFloatingTabItem('All', 0, 0, tabWidth),
                    _buildFloatingTabItem('Chats', 1, unreadChats, tabWidth),
                    _buildFloatingTabItem('Cheers', 2, unreadCheers, tabWidth),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingTabItem(
      String title, int index, int unreadCount, double width) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  color: isSelected ? const Color(0xFFE52020) : Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.openSans().fontFamily,
                ),
                child: Text(title),
              ),
              if (unreadCount > 0) ...[
                const SizedBox(width: 4.0),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFE52020) : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFFE52020),
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
