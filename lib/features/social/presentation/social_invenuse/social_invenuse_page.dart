import 'package:provider/provider.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/shared/widgets/layout/appbarmenu_copy_widget.dart';
import '/shared/widgets/layout/appbarsilver_widget.dart';
import '/shared/widgets/cards/card33_user_grid_widget.dart';
import '/shared/widgets/dialogs/filter_widget.dart';
import '/shared/widgets/misc/joinroom_widget.dart';
import '/shared/widgets/dialogs/popupuser_widget.dart';
import '/shared/widgets/dialogs/profilepopup_widget.dart';
import '/shared/widgets/misc/review_widget.dart';
import '/shared/widgets/media/showphoto_copy_widget.dart';
import '/shared/widgets/misc/showpromotion_widget.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/shared/widgets/core/munday_count_controller.dart';
import '/core/utils/app_util.dart';
import 'dart:ui';
import '/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'social_invenuse_model.dart';
import 'package:munday/core/theme/theme.dart';

part "components/social_invenues_header_widget.dart";
part "components/social_invenues_chat_tab_widget.dart";
part "components/social_invenues_tickets_tab_widget.dart";
part "components/social_invenues_menu_tab_widget.dart";

class SocialInVenusePage extends ConsumerStatefulWidget {
  const SocialInVenusePage({super.key});

  static String routeName = 'socialInvenuse';
  static String routePath = 'socialInvenuse';

  @override
  ConsumerState<SocialInVenusePage> createState() => _SocialInVenuseWidgetState();
}

@NowaGenerated()
class _SocialInVenuseWidgetState extends ConsumerState<SocialInVenusePage>
    with TickerProviderStateMixin {
  late SocialInVenuseModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = SocialInVenuseModel()..internalInit(context);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (context.appState.readyshowcheers == true) {
        _model.cheersshow = functions
            .nonIntersectList(
              (currentUserDocument?.cheersEnd.toList() ?? []).toList(),
              (currentUserDocument?.showprofilecheers.toList() ?? []).toList(),
            )
            ?.toList()
            .cast<SupabaseDocRef>() ?? [];
        _model.numshow = 0;
        _model.showAd = context.appState.ActivePromotion;
        context.appState.ActivePromotion = false;
      }
      if (!context.appState.relock) {
        context.appState.namestorelink = valueOrDefault(
          currentUserDocument?.checkin,
          '',
        );
        context.appState.relock = true;
        context.appState.apiready = true;
        safeSetState(() {});
      }
      if (context.appState.apiready == true) {
        await Future.wait([
          Future(() async {
            _model.apiResult3xtone = await CreatecheckoutoneCall.call(
              uid: currentUserUid,
              email: currentUserEmail,
              storeId: context.appState.storedoc?.id,
            );
            context.appState.apione = getJsonField(
              (_model.apiResult3xtone?.jsonBody ?? ''),
              '\$.url',
            ).toString();
            safeSetState(() {});
          }),
          Future(() async {
            _model.apiResult3xttwo = await CreatecheckouttwoCall.call(
              uid: currentUserUid,
              email: currentUserEmail,
              storeId: context.appState.storedoc?.id,
            );
            context.appState.apitwo = getJsonField(
              (_model.apiResult3xttwo?.jsonBody ?? ''),
              '\$.url',
            ).toString();
            safeSetState(() {});
          }),
          Future(() async {
            _model.apiResult3xtthree = await CreatecheckoutthreeCall.call(
              uid: currentUserUid,
              email: currentUserEmail,
              storeId: context.appState.storedoc?.id,
            );
            context.appState.apithree = getJsonField(
              (_model.apiResult3xtthree?.jsonBody ?? ''),
              '\$.url',
            ).toString();
            safeSetState(() {});
          }),
        ]);
        context.appState.apiready = false;
      }
      if (valueOrDefault<bool>(currentUserDocument?.popupEditProfile, false) &&
          context.appState.lockeditprofilepopup) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: const ProfilepopupWidget(),
            ),
          ),
        ).then((value) => safeSetState(() {}));
        context.appState.lockeditprofilepopup = false;
        safeSetState(() {});
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: const ShowphotoCopyWidget(),
            ),
          ),
        ).then((value) => safeSetState(() {}));
      }
      context.appState.lockfuctionadd = false;
      safeSetState(() {});
      if (!valueOrDefault<bool>(currentUserDocument?.setCheers, false)) {
        await currentUserReference?.update(
          createUsersRecordData(cheersLimit: 20, setCheers: true),
        );
      }
    });
    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
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

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          body: Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, -1.0),
                            child: Container(
                              height: 5000.0,
                              decoration: const BoxDecoration(),
                              child: AuthUserStreamWidget(
                                builder: (context) {
                                  final venueRef =
                                      currentUserDocument?.loginVenuesRoom;
                                  if (currentUserDocument == null ||
                                      venueRef == null) {
                                    return const Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.transparent,
                                              ),
                                        ),
                                      ),
                                    );
                                  }
                                  return StreamBuilder<VenuesRecord>(
                                    stream: VenuesRecord.getDocument(venueRef),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.transparent,
                                                  ),
                                            ),
                                          ),
                                        );
                                      }
                                      final stackVenuesRecord = snapshot.data!;
                                      return Stack(
                                        alignment: const AlignmentDirectional(
                                          0.0,
                                          0.0,
                                        ),
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  -1.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  height:
                                                      MediaQuery.sizeOf(
                                                        context,
                                                      ).height *
                                                      1.0,
                                                  child: Stack(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                          0.0,
                                                          -1.0,
                                                        ),
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                              0.0,
                                                              -1.0,
                                                            ),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              1.0,
                                                          height: 339.0,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: Image.network(
                                                                stackVenuesRecord
                                                                    .bg,
                                                              ).image,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                              0.0,
                                                              -1.0,
                                                            ),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              1.0,
                                                          height: 340.0,
                                                          decoration: BoxDecoration(
                                                            gradient: const LinearGradient(
                                                              colors: [
                                                                Colors
                                                                    .transparent,
                                                                Colors.black,
                                                              ],
                                                              stops: [0.0, 1.0],
                                                              begin:
                                                                  AlignmentDirectional(
                                                                    0.0,
                                                                    -1.0,
                                                                  ),
                                                              end:
                                                                  AlignmentDirectional(
                                                                    0,
                                                                    1.0,
                                                                  ),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  -1.01,
                                                ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 90.0,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black,
                                                    Colors.transparent,
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                    0.0,
                                                    -1.0,
                                                  ),
                                                  end: AlignmentDirectional(
                                                    0,
                                                    1.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SocialInvenuesHeaderWidget(
                                                  model: _model,
                                                  stackVenuesRecord:
                                                      stackVenuesRecord,
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            5.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const Alignment(
                                                                  0.0,
                                                                  0,
                                                                ),
                                                            child: TabBar(
                                                              isScrollable:
                                                                  true,
                                                              labelColor:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
                                                              unselectedLabelColor:
                                                                  const Color(
                                                                    0xFFA2A2A2,
                                                                  ),
                                                              labelStyle: Theme.of(context).textTheme.titleMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .titleMedium!
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .titleMedium!
                                                                        .fontStyle,
                                                              ),
                                                              unselectedLabelStyle: Theme.of(context).textTheme.titleMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .titleMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .titleMedium!
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .titleMedium!
                                                                        .fontWeight,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .titleMedium!
                                                                        .fontStyle,
                                                              ),
                                                              indicatorColor:
                                                                  const Color(
                                                                    0xFFFF0000,
                                                                  ),
                                                              padding:
                                                                  const EdgeInsetsDirectional.fromSTEB(
                                                                    20.0,
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                  ),
                                                              tabs: [
                                                                Tab(
                                                                  text: AppLocalizations.of(
                                                                    context,
                                                                  )!.k_zrv1h23o,
                                                                ),
                                                                Tab(
                                                                  text: AppLocalizations.of(
                                                                    context,
                                                                  )!.k_nmf23spl,
                                                                ),
                                                                Tab(
                                                                  text: AppLocalizations.of(
                                                                    context,
                                                                  )!.k_53y13stq,
                                                                ),
                                                              ],
                                                              controller: _model
                                                                  .tabBarController,
                                                              onTap: (i) async {
                                                                [
                                                                  () async {},
                                                                  () async {},
                                                                  () async {},
                                                                ][i]();
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: TabBarView(
                                                              controller: _model
                                                                  .tabBarController,
                                                              children: [
                                                                SocialInvenuesChatTabWidget(
                                                                  model: _model,
                                                                  stackVenuesRecord:
                                                                      stackVenuesRecord,
                                                                  animationsMap:
                                                                      animationsMap,
                                                                ),
                                                                SocialInvenuesTicketsTabWidget(
                                                                  model: _model,
                                                                  stackVenuesRecord:
                                                                      stackVenuesRecord,
                                                                  animationsMap:
                                                                      animationsMap,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.01),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                  ),
                ),
                if (((currentUserDocument?.cheersEnd.toList() ?? []).length !=
                        (currentUserDocument?.showprofilecheers.toList() ?? [])
                            .length) &&
                    ((currentUserDocument?.cheersEnd.toList() ?? [])
                        .isNotEmpty))
                  AuthUserStreamWidget(
                    builder: (context) => StreamBuilder<UsersRecord>(
                      stream: UsersRecord.getDocument(
                        (currentUserDocument?.cheersEnd.toList() ?? [])
                            .elementAtOrNull(
                              (currentUserDocument?.showprofilecheers
                                          .toList() ??
                                      [])
                                  .length,
                            )!,
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.transparent,
                                ),
                              ),
                            ),
                          );
                        }
                        final card33UserGridUsersRecord = snapshot.data!;
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(MainChatPage.routeName);
                            await currentUserReference!.update({
                              ...mapToSupabase({
                                'showprofilecheers': FieldValue.arrayUnion([
                                  card33UserGridUsersRecord.reference,
                                ]),
                              }),
                            });
                          },
                          child: ChangeNotifierProvider.value(
                            value: _model.card33UserGridModel.setOnUpdate(
                              onUpdate: () => safeSetState(() {}),
                              updateOnChange: true,
                            ),
                            child: Card33UserGridWidget(
                              name: valueOrDefault<String>(
                                card33UserGridUsersRecord.displayName,
                                'ไม่ระบุ',
                              ),
                              image: valueOrDefault<String>(
                                card33UserGridUsersRecord.photoUrl,
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png',
                              ),
                              uid: card33UserGridUsersRecord.reference,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: SizedBox(
                      width: double.infinity,
                      height: 130.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0,
                                10.0,
                                10.0,
                                30.0,
                              ),
                              child: Container(
                                height: 65.0,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x33000000),
                                      offset: Offset(0.0, 2.0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(45.0),
                                ),
                                child: Stack(
                                  children: [
                                    AuthUserStreamWidget(
                                      builder: (context) {
                                        final venueRef = currentUserDocument
                                            ?.loginVenuesRoom;
                                        if (venueRef == null) {
                                          return const SizedBox.shrink();
                                        }
                                        return StreamBuilder<VenuesRecord>(
                                          stream: VenuesRecord.getDocument(
                                            venueRef,
                                          ),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(Colors.transparent),
                                                  ),
                                                ),
                                              );
                                            }
                                            final rowVenuesRecord =
                                                snapshot.data!;
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                if (false)
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                            0.0,
                                                            -1.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              8.0,
                                                              0.0,
                                                              0.0,
                                                              2.0,
                                                            ),
                                                        child: StreamBuilder<UserInVenuesRecord>(
                                                          stream: UserInVenuesRecord.getDocument(
                                                            rowVenuesRecord
                                                                .refUserInVenues!,
                                                          ),
                                                          builder: (context, snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return const Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child: CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                          Color
                                                                        >(
                                                                          Colors
                                                                              .transparent,
                                                                        ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            final containerBodyUserInVenuesRecord =
                                                                snapshot.data!;
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context:
                                                                      context,
                                                                  builder: (context) {
                                                                    return GestureDetector(
                                                                      onTap: () {
                                                                        FocusScope.of(
                                                                          context,
                                                                        ).unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child: Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(
                                                                              context,
                                                                            ),
                                                                        child: PopupuserWidget(
                                                                          offchat:
                                                                              false,
                                                                          show:
                                                                              false,
                                                                          listref: containerBodyUserInVenuesRecord
                                                                              .user
                                                                              .where(
                                                                                (
                                                                                  e,
                                                                                ) => functions.checkdate(
                                                                                  (e as dynamic)?.date,
                                                                                  getCurrentTimestamp,
                                                                                )!,
                                                                              )
                                                                              .toList()
                                                                              .sortedList(
                                                                                keyOf: (e) => ((e as dynamic)?.user?.view as num?),
                                                                                desc: false,
                                                                              )
                                                                              .map(
                                                                                (
                                                                                  e,
                                                                                ) => (e as dynamic)?.user?.userinstore,
                                                                              )
                                                                              .withoutNulls.toList().cast<SupabaseDocRef>(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then(
                                                                  (value) =>
                                                                      safeSetState(
                                                                        () {},
                                                                      ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                decoration: BoxDecoration(
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          5.0,
                                                                      color: Color(
                                                                        0x5A000000,
                                                                      ),
                                                                      offset:
                                                                          Offset(
                                                                            2.0,
                                                                            2.0,
                                                                          ),
                                                                      spreadRadius:
                                                                          4.0,
                                                                    ),
                                                                  ],
                                                                  gradient: const LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                        0xFFFF0000,
                                                                      ),
                                                                      Color(
                                                                        0xFFC10000,
                                                                      ),
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      1.0,
                                                                    ],
                                                                    begin:
                                                                        AlignmentDirectional(
                                                                          0.0,
                                                                          -1.0,
                                                                        ),
                                                                    end:
                                                                        AlignmentDirectional(
                                                                          0,
                                                                          1.0,
                                                                        ),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        45.0,
                                                                      ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0,
                                                                        ),
                                                                        child: Container(
                                                                          width:
                                                                              50.0,
                                                                          height:
                                                                              50.0,
                                                                          decoration: const BoxDecoration(
                                                                            color: Color(
                                                                              0xFFFF0000,
                                                                            ),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                blurRadius: 4.0,
                                                                                color: Color(
                                                                                  0x33000000,
                                                                                ),
                                                                                offset: Offset(
                                                                                  0.0,
                                                                                  2.0,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child: Stack(
                                                                            children: [
                                                                              Align(
                                                                                alignment: const AlignmentDirectional(
                                                                                  0.0,
                                                                                  0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  width: 30.0,
                                                                                  height: 30.0,
                                                                                  decoration: BoxDecoration(
                                                                                    image: DecorationImage(
                                                                                      fit: BoxFit.cover,
                                                                                      image: Image.network(
                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/tpcoeg4f3ab4/iconmain.png',
                                                                                      ).image,
                                                                                    ),
                                                                                    shape: BoxShape.rectangle,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                        context,
                                                                      )!.k_220hsncj,
                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                        font: GoogleFonts.openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(
                                                                            context,
                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            18.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
