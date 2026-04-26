import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/shared/widgets/cards/card33_user_grid_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:easy_debounce/easy_debounce.dart';
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
  static const bool _mockMode = true;

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

  Widget _buildChatRow({
    required BuildContext context,
    required String avatarUrl,
    required String name,
    required String lastMessage,
    required String time,
    required bool isSentByMe,
    required bool hasUnread,
    required bool isOnline,
    required bool isVenue,
    required VoidCallback onTap,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 8.0),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF1D1D1D),
                    border: Border.all(
                      color: hasUnread ? Colors.white : const Color(0xFF2A2A2A),
                      width: hasUnread ? 2.0 : 1.0,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(avatarUrl).image,
                    ),
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
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isVenue) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 2.0),
                          margin: const EdgeInsets.only(right: 6.0),
                          decoration: BoxDecoration(
                            color: const Color(0x26FF0000),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Text('Venue',
                              style: TextStyle(
                                  color: Color(0xFFFF0000),
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                      Flexible(
                        child: Text(
                          name,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w600),
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    isSentByMe && lastMessage.isNotEmpty
                        ? 'You: $lastMessage'
                        : lastMessage,
                    style: TextStyle(
                      color: hasUnread
                          ? const Color(0xFFE0E0E0)
                          : const Color(0xFF9E9E9E),
                      fontSize: 13.0,
                      fontWeight:
                          hasUnread ? FontWeight.w500 : FontWeight.normal,
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
                Text(time,
                    style: const TextStyle(
                        color: Color(0xFF9E9E9E), fontSize: 12.0)),
                const SizedBox(height: 5.0),
                if (hasUnread)
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFF0000), shape: BoxShape.circle),
                    child: const Center(
                        child:
                            Icon(Icons.circle, size: 6.0, color: Colors.white)),
                  )
                else
                  const Icon(Icons.done_all,
                      size: 16.0, color: Color(0xFF4FC3F7)),
              ],
            ),
          ],
        ),
      ),
    );
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
    final dmData = functions
            .jsonDataRoomAndStore(currentUserReference,
                containerChatRoomsRecordList.toList(), stackStoreRecord)
            ?.toList() ??
        [];
    const cardColors = [
      Color(0xFFD4EE8C),
      Color(0xFFD0B8F0),
      Color(0xFFFFC5A0),
      Color(0xFF98E4D0)
    ];

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
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: checkinRef != null && stackStoreRecord != null
                          ? Row(children: [
                              Container(
                                width: 38.0,
                                height: 38.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF1D1D1D),
                                  border: Border.all(
                                      color: const Color(0xFF333333),
                                      width: 1.5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(valueOrDefault<String>(
                                            stackStoreRecord.logo, ''))
                                        .image,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    stackStoreRecord.namestore,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 7.0,
                                        height: 7.0,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF00D333),
                                            shape: BoxShape.circle),
                                      ),
                                      const SizedBox(width: 4.0),
                                      const Text('Checked In',
                                          style: TextStyle(
                                              color: Color(0xFF00D333),
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ],
                              ),
                            ])
                          : Image.network(
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/kwg045z3snx3/Munday-logo.png',
                              width: 133.0,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ]),
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
                          image: Image.network(valueOrDefault<String>(
                                  currentUserPhoto,
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png'))
                              .image,
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ],
              ),
            ),
            // Search bar + friends button
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 20.0, 0.0),
              child: Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () =>
                        context.pushNamed(SocialInVenuseWidget.routeName),
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: const Color(0x981D1D1D),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color(0xFF3A3A3A),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.people_rounded,
                        color: Colors.white,
                        size: 26.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,
                      onChanged: (_) => EasyDebounce.debounce(
                          '_model.textController',
                          const Duration(milliseconds: 400),
                          () => safeSetState(() {})),
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        hintText: FFLocalizations.of(context)
                            .getText('1o27ut5s' /* Search for user */),
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                                font: GoogleFonts.openSans(),
                                color: const Color(0xFFBDBDBD)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0x00000000)),
                            borderRadius: BorderRadius.circular(12.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0x00000000)),
                            borderRadius: BorderRadius.circular(12.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0x00000000)),
                            borderRadius: BorderRadius.circular(12.0)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0x00000000)),
                            borderRadius: BorderRadius.circular(12.0)),
                        filled: true,
                        fillColor: const Color(0x651D1D1D),
                        prefixIcon: Icon(Icons.search_sharp,
                            color: FlutterFlowTheme.of(context).primaryText),
                      ),
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(font: GoogleFonts.openSans()),
                    ),
                  ),
                ],
              ),
            ),
            // Zone 1 header
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Groups',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font:
                              GoogleFonts.openSans(fontWeight: FontWeight.w600),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16.0)),
                  GestureDetector(
                    onTap: () {},
                    child: Text('+ New',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.openSans(
                                fontWeight: FontWeight.w500),
                            color: const Color(0xFFFF0000),
                            fontSize: 13.0)),
                  ),
                ],
              ),
            ),
            // Zone 1: Group Cards
            SizedBox(
              height: 195.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 6.0),
                itemCount: groupChats.isEmpty ? 1 : groupChats.length,
                itemBuilder: (context, index) {
                  if (groupChats.isEmpty) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        margin: const EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: const Color(0xFF333333), width: 1.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_circle_outline,
                                color: Color(0xFF555555), size: 28.0),
                            const SizedBox(height: 8.0),
                            Text('Create a Group',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                        font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500),
                                        color: const Color(0xFF555555),
                                        fontSize: 13.0)),
                          ],
                        ),
                      ),
                    );
                  }
                  final group = groupChats[index];
                  final cardColor = cardColors[index % cardColors.length];
                  final isMyGroup =
                      group.userIds.contains(currentUserReference?.id);
                  return GestureDetector(
                    onTap: () => context.pushNamed(ChatsWidget.routeName,
                        queryParameters: {
                          'userProfile':
                              serializeParam(group.imageUrl, ParamType.String),
                          'roomref': serializeParam(
                              group.reference, ParamType.SupabaseDocRef),
                          'name': serializeParam(group.name, ParamType.String),
                          'online': serializeParam(true, ParamType.bool),
                          'openchat': serializeParam(true, ParamType.bool),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  group.name.isNotEmpty
                                      ? group.name
                                      : 'Group Chat',
                                  style: const TextStyle(
                                      color: Color(0xFF1A1A1A),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                    color: const Color(0x1F000000),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const Text('Live',
                                    style: TextStyle(
                                        color: Color(0xFF1A1A1A),
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(0x1A000000),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.chat_bubble_outline,
                                    color: Color(0x881A1A1A), size: 20.0),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    group.lastMessage.isNotEmpty
                                        ? (group.lastMessageSenderId ==
                                                currentUserReference?.id
                                            ? 'You: ${group.lastMessage}'
                                            : group.lastMessage)
                                        : 'No messages yet',
                                    style: const TextStyle(
                                        color: Color(0x881A1A1A),
                                        fontSize: 13.0),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${group.userIds.length} members',
                                  style: const TextStyle(
                                      color: Color(0x991A1A1A),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500)),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 7.0),
                                decoration: BoxDecoration(
                                  color: isMyGroup
                                      ? Colors.black
                                      : const Color(0xFFFF0000),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  isMyGroup ? 'Open' : 'Join',
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
            // Zone 2 header
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 4.0),
              child: Text('Messages',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0)),
            ),
            // Zone 2: Chat list
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (checkinRef != null &&
                        stackStoreRecord != null &&
                        containerChatRoomsRecord != null)
                      _buildChatRow(
                        context: context,
                        avatarUrl:
                            valueOrDefault(currentUserDocument?.logoRoom, ''),
                        name: stackStoreRecord.namestore,
                        lastMessage: containerChatRoomsRecord.lastMessage,
                        time: containerChatRoomsRecord.lastMessageTime != null
                            ? dateTimeFormat(
                                'Hm', containerChatRoomsRecord.lastMessageTime!,
                                locale:
                                    FFLocalizations.of(context).languageCode)
                            : '',
                        isSentByMe:
                            containerChatRoomsRecord.lastMessageSenderId ==
                                currentUserReference?.id,
                        hasUnread: false,
                        isOnline: false,
                        isVenue: true,
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
                          await stackStoreRecord.iDroom!.update(
                              createChatRoomsRecordData(
                                  lastMessageTime: getCurrentTimestamp));
                        },
                      ),
                    ...List.generate(dmData.length, (index) {
                      final parsed =
                          DatainstoreStruct.maybeFromMap(dmData[index]);
                      if (parsed == null) return const SizedBox.shrink();
                      if (!(functions.showsearch(
                              _model.textController.text, parsed.name) ??
                          true)) return const SizedBox.shrink();
                      final hasUnread =
                          (currentUserDocument?.usermassage.toList() ?? [])
                              .contains(parsed.userRef);
                      return _buildChatRow(
                        context: context,
                        avatarUrl: valueOrDefault<String>(parsed.photoprofile,
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png'),
                        name: valueOrDefault<String>(parsed.name, 'ไม่ระบุ'),
                        lastMessage:
                            valueOrDefault<String>(parsed.lastmassage, ''),
                        time: parsed.timeupdate != null
                            ? dateTimeFormat('Hm', parsed.timeupdate!,
                                locale:
                                    FFLocalizations.of(context).languageCode)
                            : '',
                        isSentByMe:
                            parsed.lastpersonUpdate == currentUserReference,
                        hasUnread: hasUnread,
                        isOnline: parsed.online,
                        isVenue: false,
                        onTap: () async {
                          context.pushNamed(ChatsWidget.routeName,
                              queryParameters: {
                                'userProfile': serializeParam(
                                    parsed.photoprofile, ParamType.String),
                                'roomref': serializeParam(
                                    parsed.roomRef, ParamType.SupabaseDocRef),
                                'name': serializeParam(
                                    valueOrDefault<String>(
                                        parsed.name, 'ไม่ระบุ'),
                                    ParamType.String),
                                'online': serializeParam(
                                    parsed.online, ParamType.bool),
                                'openchat':
                                    serializeParam(false, ParamType.bool),
                              }.withoutNulls);
                          await parsed.roomRef!.update(
                              createChatRoomsRecordData(
                                  lastMessageTime: getCurrentTimestamp));
                          await currentUserReference!.update({
                            ...mapToSupabase({
                              'usermassageRead':
                                  FieldValue.arrayUnion([parsed.userRef])
                            })
                          });
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
              if (!snapshot.hasData) {
                return Center(
                    child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.transparent))));
              }
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
      ],
    );
  }

  // ── Mock data ──
  static const _mockStore = 'Levels Club';
  static const _mockStoreLogo =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/tpcoeg4f3ab4/iconmain.png';
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
      'photo': 'https://i.pravatar.cc/150?img=1'
    },
    {
      'name': 'SLP',
      'msg': 'https://youtu.be/LjHcHTJ8D5k?t=1204',
      'time': '09:20',
      'unread': false,
      'me': false,
      'online': false,
      'photo': 'https://i.pravatar.cc/150?img=2'
    },
    {
      'name': 'Sunil',
      'msg': 'Thought it would be higher tbh',
      'time': '09:12',
      'unread': false,
      'me': false,
      'online': false,
      'photo': 'https://i.pravatar.cc/150?img=3'
    },
    {
      'name': 'Mike',
      'msg': 'cheers 🥂🥂',
      'time': '08:02',
      'unread': false,
      'me': false,
      'online': true,
      'photo': 'https://i.pravatar.cc/150?img=4'
    },
    {
      'name': 'Mum',
      'msg': "That's pretty amazing!! Fingers crossed 🤞",
      'time': '22:35',
      'unread': false,
      'me': false,
      'online': false,
      'photo': 'https://i.pravatar.cc/150?img=5'
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
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1D1D1D),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage('https://i.pravatar.cc/150?img=10')),
                    ),
                  ),
                ],
              ),
            ),
            // Search bar
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 20.0, 0.0),
              child: Container(
                height: 48.0,
                decoration: BoxDecoration(
                    color: const Color(0x651D1D1D),
                    borderRadius: BorderRadius.circular(12.0)),
                child: Row(children: [
                  const SizedBox(width: 12.0),
                  Icon(Icons.search_sharp,
                      color: FlutterFlowTheme.of(context).primaryText),
                  const SizedBox(width: 8.0),
                  Text('Search for user',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.openSans(),
                          color: const Color(0xFFBDBDBD))),
                ]),
              ),
            ),
            // Zone 1 header
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Groups',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font:
                              GoogleFonts.openSans(fontWeight: FontWeight.w600),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16.0)),
                  Text('+ New',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font:
                              GoogleFonts.openSans(fontWeight: FontWeight.w500),
                          color: const Color(0xFFFF0000),
                          fontSize: 13.0)),
                ],
              ),
            ),
            // Zone 1: Group Cards — 80% width, peekable, solid pastel bg
            SizedBox(
              height: 195.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 6.0),
                itemCount: _mockGroups.length,
                itemBuilder: (context, index) {
                  final group = _mockGroups[index];
                  final cardColor = Color(group['color'] as int);
                  final isVenue = group['isVenue'] as bool;
                  final canJoin = group['canJoin'] as bool;
                  final avatars = group['avatars'] as List;
                  final extraMembers =
                      (group['members'] as int) - avatars.length;
                  final stackWidth = (avatars.length - 1) * 20.0 + 36.0;
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    margin: const EdgeInsets.only(right: 12.0),
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Group name + venue icon / Live badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      image: NetworkImage(_mockStoreLogo)),
                                ),
                              )
                            else
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                    color: const Color(0x1F000000),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const Text('Live',
                                    style: TextStyle(
                                        color: Color(0xFF1A1A1A),
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        // Row 2: Last message preview box
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: const Color(0x1A000000),
                            borderRadius: BorderRadius.circular(12.0),
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
                                          group['senderPhoto'] as String)),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      group['senderName'] as String,
                                      style: const TextStyle(
                                          color: Color(0xFF1A1A1A),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      group['lastMsg'] as String,
                                      style: const TextStyle(
                                          color: Color(0x881A1A1A),
                                          fontSize: 13.0),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        // Row 3: Stacked avatars + count | Join / + Add button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: cardColor,
                                                      width: 2.0),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
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
                                          fontWeight: FontWeight.w600)),
                                ],
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 7.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF0000),
                                borderRadius: BorderRadius.circular(20.0),
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
                  );
                },
              ),
            ),
            // Zone 2 header
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 4.0),
              child: Text('Messages',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0)),
            ),
            // Zone 2: Venue chat row
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 14.0, 20.0, 14.0),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 2.0),
                          margin: const EdgeInsets.only(right: 6.0),
                          decoration: BoxDecoration(
                              color: const Color(0x26FF0000),
                              borderRadius: BorderRadius.circular(4.0)),
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
                      const Text('You: Welcome everyone to Levels! 🎉',
                          style: TextStyle(
                              color: Color(0xFF9E9E9E), fontSize: 13.0),
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
                              color: Color(0xFF9E9E9E), fontSize: 12.0)),
                      SizedBox(height: 5.0),
                      Icon(Icons.done_all,
                          size: 16.0, color: Color(0xFF4FC3F7)),
                    ]),
              ]),
            ),
            // Zone 2: DM list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _mockChats.length,
                itemBuilder: (context, index) {
                  final chat = _mockChats[index];
                  final hasUnread = chat['unread'] as bool;
                  final isOnline = chat['online'] as bool;
                  return Padding(
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
                            border: Border.all(
                                color: hasUnread
                                    ? Colors.white
                                    : const Color(0xFF2A2A2A),
                                width: hasUnread ? 2.0 : 1.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(chat['photo'] as String)),
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
                                        color: Colors.black, width: 2.0)),
                              )),
                      ]),
                      const SizedBox(width: 12.0),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(chat['name'] as String,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                        font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                        color: Colors.white,
                                        fontSize: 14.0)),
                            const SizedBox(height: 3.0),
                            Text(chat['msg'] as String,
                                style: TextStyle(
                                    color: hasUnread
                                        ? const Color(0xFFE0E0E0)
                                        : const Color(0xFF9E9E9E),
                                    fontSize: 13.0,
                                    fontWeight: hasUnread
                                        ? FontWeight.w500
                                        : FontWeight.normal),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ])),
                      const SizedBox(width: 8.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(chat['time'] as String,
                                style: const TextStyle(
                                    color: Color(0xFF9E9E9E), fontSize: 12.0)),
                            const SizedBox(height: 5.0),
                            if (hasUnread)
                              Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFFF0000),
                                      shape: BoxShape.circle),
                                  child: const Center(
                                      child: Icon(Icons.circle,
                                          size: 6.0, color: Colors.white)))
                            else
                              const Icon(Icons.done_all,
                                  size: 16.0, color: Color(0xFF4FC3F7)),
                          ]),
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
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
          child: IgnorePointer(child: _buildMockBody(context)),
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
}
