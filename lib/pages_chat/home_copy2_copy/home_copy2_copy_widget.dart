import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/card33_user_grid_widget.dart';
import '/components/items_widget.dart';
import '/components/popupuser_widget.dart';
import '/components/profilepopup_widget.dart';
import '/components/showphoto_copy_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_copy2_copy_model.dart';
export 'home_copy2_copy_model.dart';

class HomeCopy2CopyWidget extends StatefulWidget {
  const HomeCopy2CopyWidget({super.key});

  static String routeName = 'homeCopy2Copy';
  static String routePath = 'homeCopy2Copy';

  @override
  State<HomeCopy2CopyWidget> createState() => _HomeCopy2CopyWidgetState();
}

class _HomeCopy2CopyWidgetState extends State<HomeCopy2CopyWidget>
    with TickerProviderStateMixin {
  late HomeCopy2CopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeCopy2CopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().readyshowcheers == true) {
        _model.cheersshow = functions
            .nonIntersectList(
                (currentUserDocument?.cheersEnd.toList() ?? []).toList(),
                (currentUserDocument?.showprofilecheers.toList() ?? [])
                    .toList())!
            .toList()
            .cast<SupabaseDocRef>();
        _model.numshow = 0;
        _model.showAd = FFAppState().ActivePromotion;
        FFAppState().ActivePromotion = false;
      }
      if (!FFAppState().relock) {
        FFAppState().namestorelink =
            valueOrDefault(currentUserDocument?.checkin, '');
        FFAppState().relock = true;
        FFAppState().apiready = true;
        safeSetState(() {});
      }
      if (FFAppState().apiready == true) {
        await Future.wait([
          Future(() async {
            _model.apiResult3xtone = await CreatecheckoutoneCall.call(
              uid: currentUserUid,
              email: currentUserEmail,
              storeId: FFAppState().storedoc?.id,
            );

            FFAppState().apione = getJsonField(
              (_model.apiResult3xtone?.jsonBody ?? ''),
              r'''$.url''',
            ).toString();
            safeSetState(() {});
          }),
          Future(() async {
            _model.apiResult3xttwo = await CreatecheckouttwoCall.call(
              uid: currentUserUid,
              email: currentUserEmail,
              storeId: FFAppState().storedoc?.id,
            );

            FFAppState().apitwo = getJsonField(
              (_model.apiResult3xttwo?.jsonBody ?? ''),
              r'''$.url''',
            ).toString();
            safeSetState(() {});
          }),
          Future(() async {
            _model.apiResult3xtthree = await CreatecheckoutthreeCall.call(
              uid: currentUserUid,
              email: currentUserEmail,
              storeId: FFAppState().storedoc?.id,
            );

            FFAppState().apithree = getJsonField(
              (_model.apiResult3xtthree?.jsonBody ?? ''),
              r'''$.url''',
            ).toString();
            safeSetState(() {});
          }),
        ]);
        FFAppState().apiready = false;
      }
      if (valueOrDefault<bool>(currentUserDocument?.popupEditProfile, false) &&
          FFAppState().lockeditprofilepopup) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: ProfilepopupWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));

        FFAppState().lockeditprofilepopup = false;
        safeSetState(() {});
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: ShowphotoCopyWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
      FFAppState().lockfuctionadd = false;
      safeSetState(() {});
      if (!valueOrDefault<bool>(currentUserDocument?.setCheers, false)) {
        await currentUserReference!.update(createUsersRecordData(
          cheersLimit: 20,
          setCheers: true,
        ));
      }
      await _model.listViewController?.animateTo(
        _model.listViewController!.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
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
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 150.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(0.9, 0.9),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 150.0.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<f_f_story_view_live_zhm3f3_app_state.FFAppState>();

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
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Container(
                            height: 5000.0,
                            decoration: BoxDecoration(),
                            child: AuthUserStreamWidget(
                              builder: (context) => StreamBuilder<VenuesRecord>(
                                stream: VenuesRecord.getDocument(
                                    currentUserDocument!.loginVenuesRoom!),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
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
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.01),
                                        child: Container(
                                          width: double.infinity,
                                          height: 90.0,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.transparent
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 12.5),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.safePop();
                                                      },
                                                      child: Container(
                                                        width: 40.0,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Container(
                                                                width: 25.0,
                                                                height: 25.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0x98FF0000),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          4.0,
                                                                      color: Color(
                                                                          0x7A000000),
                                                                      offset:
                                                                          Offset(
                                                                        2.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0x98FF0000),
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            2.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_back_ios_new_sharp,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          size:
                                                                              14.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  41.0,
                                                                  2.0,
                                                                  0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                            sigmaX: 4.5,
                                                            sigmaY: 4.5,
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF111111),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            45.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            45.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10.0),
                                                                  ),
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xFF2D2D2D),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          7.5,
                                                                          0.0,
                                                                          7.5),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              50.0,
                                                                          height:
                                                                              50.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    ProfileWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'fromSeting': serializeParam(
                                                                                        false,
                                                                                        ParamType.bool,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  clipBehavior: Clip.antiAlias,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: CachedNetworkImage(
                                                                                    fadeInDuration: Duration(milliseconds: 500),
                                                                                    fadeOutDuration: Duration(milliseconds: 500),
                                                                                    imageUrl: valueOrDefault<String>(
                                                                                      currentUserPhoto,
                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment(0.0, 0),
                                                      child: TabBar(
                                                        isScrollable: true,
                                                        labelColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        unselectedLabelColor:
                                                            Color(0xFFA2A2A2),
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                        unselectedLabelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                        indicatorColor:
                                                            Color(0xFFFF0000),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    0.0,
                                                                    20.0,
                                                                    0.0),
                                                        tabs: [
                                                          Tab(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'w2wh6a9n' /* Online Chat Room */,
                                                            ),
                                                          ),
                                                          Tab(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'v2kzvykl' /* My Tickets */,
                                                            ),
                                                          ),
                                                        ],
                                                        controller: _model
                                                            .tabBarController,
                                                        onTap: (i) async {
                                                          [
                                                            () async {},
                                                            () async {}
                                                          ][i]();
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: TabBarView(
                                                        controller: _model
                                                            .tabBarController,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child: StreamBuilder<
                                                                        UserInVenuesRecord>(
                                                                      stream: UserInVenuesRecord.getDocument(
                                                                          stackVenuesRecord
                                                                              .refUserInVenues!),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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

                                                                        final columnUserInVenuesRecord =
                                                                            snapshot.data!;

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 7.0, 0.0, 0.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    valueOrDefault<String>(
                                                                                                      columnUserInVenuesRecord.nameVenues,
                                                                                                      'ณ บางเขน',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: 15.0,
                                                                                                          letterSpacing: 0.3,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                                                                                            child: Container(
                                                                                              height: 30.0,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                                border: Border.all(
                                                                                                  color: Color(0xFF1D1D1D),
                                                                                                  width: 2.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                                    child: Icon(
                                                                                                      Icons.people_rounded,
                                                                                                      color: Colors.white,
                                                                                                      size: 20.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                    child: Text(
                                                                                                      columnUserInVenuesRecord.user.where((e) => functions.checkdate(e.date, getCurrentTimestamp)!).toList().length.toString(),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                                            fontSize: 14.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0.0, -1.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                  child: Container(
                                                                                    width: double.infinity,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                                      border: Border.all(
                                                                                        width: 2.0,
                                                                                      ),
                                                                                    ),
                                                                                    child: Builder(
                                                                                      builder: (context) {
                                                                                        final userinroom = columnUserInVenuesRecord.user.where((e) => functions.checkdate(e.date, getCurrentTimestamp)!).toList().sortedList(keyOf: (e) => e.user.view, desc: true).toList();

                                                                                        return RefreshIndicator(
                                                                                          color: Colors.transparent,
                                                                                          backgroundColor: Colors.transparent,
                                                                                          onRefresh: () async {},
                                                                                          child: GridView.builder(
                                                                                            padding: EdgeInsets.fromLTRB(
                                                                                              0,
                                                                                              0,
                                                                                              0,
                                                                                              100.0,
                                                                                            ),
                                                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                              crossAxisCount: 4,
                                                                                              childAspectRatio: 0.8,
                                                                                            ),
                                                                                            primary: false,
                                                                                            shrinkWrap: true,
                                                                                            scrollDirection: Axis.vertical,
                                                                                            itemCount: userinroom.length,
                                                                                            itemBuilder: (context, userinroomIndex) {
                                                                                              final userinroomItem = userinroom[userinroomIndex];
                                                                                              return InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  if (userinroomItem.user.userinstore != currentUserReference) {
                                                                                                    await showModalBottomSheet(
                                                                                                      isScrollControlled: true,
                                                                                                      backgroundColor: Colors.transparent,
                                                                                                      context: context,
                                                                                                      builder: (context) {
                                                                                                        return GestureDetector(
                                                                                                          onTap: () {
                                                                                                            FocusScope.of(context).unfocus();
                                                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                                                          },
                                                                                                          child: Padding(
                                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                                            child: PopupuserWidget(
                                                                                                              offchat: true,
                                                                                                              show: true,
                                                                                                              listref: functions.addref1(columnUserInVenuesRecord.user.where((e) => functions.checkdate(e.date, getCurrentTimestamp)!).toList().sortedList(keyOf: (e) => e.user.view, desc: true).map((e) => e.user.userinstore).withoutNulls.toList(), userinroomItem.user.userinstore)!,
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    ).then((value) => safeSetState(() {}));

                                                                                                    FFAppState().addToAddviewID(userinroomItem.user.userinstore!.id);
                                                                                                    safeSetState(() {});
                                                                                                    if (FFAppState().addviewID.length > 5) {
                                                                                                      await UpdateotheruserviewCall.call(
                                                                                                        viewsList: FFAppState().addviewID,
                                                                                                      );

                                                                                                      FFAppState().addviewID = [];
                                                                                                      FFAppState().update(() {});
                                                                                                    }
                                                                                                  } else {
                                                                                                    await showModalBottomSheet(
                                                                                                      isScrollControlled: true,
                                                                                                      backgroundColor: Colors.transparent,
                                                                                                      context: context,
                                                                                                      builder: (context) {
                                                                                                        return GestureDetector(
                                                                                                          onTap: () {
                                                                                                            FocusScope.of(context).unfocus();
                                                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                                                          },
                                                                                                          child: Padding(
                                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                                            child: PopupuserWidget(
                                                                                                              offchat: false,
                                                                                                              show: true,
                                                                                                              listref: functions.addref1(columnUserInVenuesRecord.user.where((e) => functions.checkdate(e.date, getCurrentTimestamp)!).toList().sortedList(keyOf: (e) => e.user.view, desc: true).map((e) => e.user.userinstore).withoutNulls.toList(), userinroomItem.user.userinstore)!,
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    ).then((value) => safeSetState(() {}));
                                                                                                  }
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: double.infinity,
                                                                                                  height: double.infinity,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: MediaQuery.sizeOf(context).width * 0.17,
                                                                                                        height: MediaQuery.sizeOf(context).width * 0.17,
                                                                                                        decoration: BoxDecoration(
                                                                                                          shape: BoxShape.circle,
                                                                                                        ),
                                                                                                        child: Stack(
                                                                                                          children: [
                                                                                                            ClipRRect(
                                                                                                              borderRadius: BorderRadius.only(
                                                                                                                bottomLeft: Radius.circular(90.0),
                                                                                                                bottomRight: Radius.circular(90.0),
                                                                                                                topLeft: Radius.circular(90.0),
                                                                                                                topRight: Radius.circular(90.0),
                                                                                                              ),
                                                                                                              child: Image.network(
                                                                                                                valueOrDefault<String>(
                                                                                                                  userinroomItem.user.photoprofile,
                                                                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                                                                                                ),
                                                                                                                width: 100.0,
                                                                                                                height: 100.0,
                                                                                                                fit: BoxFit.cover,
                                                                                                              ),
                                                                                                            ),
                                                                                                            Align(
                                                                                                              alignment: AlignmentDirectional(1.0, -1.0),
                                                                                                              child: Container(
                                                                                                                width: 22.0,
                                                                                                                height: 22.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  image: DecorationImage(
                                                                                                                    fit: BoxFit.cover,
                                                                                                                    image: Image.network(
                                                                                                                      () {
                                                                                                                        if ((currentUserDocument?.usercheerme.toList() ?? []).contains(userinroomItem.user.userinstore) && valueOrDefault<bool>(currentUserDocument?.seeusercheers, false)) {
                                                                                                                          return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/lcvfw7ee3qy1/null.png';
                                                                                                                        } else if (userinroomIndex == 0) {
                                                                                                                          return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wm7l2b47grzw/fire.png';
                                                                                                                        } else if (userinroomIndex == 1) {
                                                                                                                          return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wm7l2b47grzw/fire.png';
                                                                                                                        } else if (userinroomIndex == 2) {
                                                                                                                          return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wm7l2b47grzw/fire.png';
                                                                                                                        } else {
                                                                                                                          return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/lcvfw7ee3qy1/null.png';
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                    ).image,
                                                                                                                  ),
                                                                                                                  shape: BoxShape.rectangle,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            if (userinroomItem.user.online)
                                                                                                              Align(
                                                                                                                alignment: AlignmentDirectional(0.97, 0.97),
                                                                                                                child: Container(
                                                                                                                  width: 17.0,
                                                                                                                  height: 17.0,
                                                                                                                  decoration: BoxDecoration(),
                                                                                                                  child: Stack(
                                                                                                                    children: [
                                                                                                                      Align(
                                                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                        child: Container(
                                                                                                                          width: 17.0,
                                                                                                                          height: 17.0,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            color: Colors.black,
                                                                                                                            shape: BoxShape.circle,
                                                                                                                          ),
                                                                                                                          child: Stack(
                                                                                                                            children: [
                                                                                                                              Align(
                                                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                                child: Container(
                                                                                                                                  width: 11.0,
                                                                                                                                  height: 11.0,
                                                                                                                                  decoration: BoxDecoration(
                                                                                                                                    color: Color(0xFF00D333),
                                                                                                                                    image: DecorationImage(
                                                                                                                                      fit: BoxFit.cover,
                                                                                                                                      image: Image.network(
                                                                                                                                        '',
                                                                                                                                      ).image,
                                                                                                                                    ),
                                                                                                                                    shape: BoxShape.circle,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<String>(
                                                                                                            userinroomItem.user.name,
                                                                                                            'ไม่ระบุ',
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: 10.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                            controller: _model.gridViewController,
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child: StreamBuilder<
                                                                    RoomVenuesLiveChatRecord>(
                                                                  stream: RoomVenuesLiveChatRecord
                                                                      .getDocument(
                                                                          stackVenuesRecord
                                                                              .idLiveChat!),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              50.0,
                                                                          height:
                                                                              50.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            valueColor:
                                                                                AlwaysStoppedAnimation<Color>(
                                                                              Colors.transparent,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }

                                                                    final containerRoomVenuesLiveChatRecord =
                                                                        snapshot
                                                                            .data!;

                                                                    return Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: valueOrDefault<
                                                                          double>(
                                                                        _model.expandlive
                                                                            ? MediaQuery.sizeOf(context).height
                                                                            : 320.0,
                                                                        320.0,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.06),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0.0, 1.0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 72.0),
                                                                                    child: Builder(
                                                                                      builder: (context) {
                                                                                        final datachat = containerRoomVenuesLiveChatRecord.chat.toList();

                                                                                        return ListView.builder(
                                                                                          padding: EdgeInsets.fromLTRB(
                                                                                            0,
                                                                                            10.0,
                                                                                            0,
                                                                                            10.0,
                                                                                          ),
                                                                                          primary: false,
                                                                                          shrinkWrap: true,
                                                                                          scrollDirection: Axis.vertical,
                                                                                          itemCount: datachat.length,
                                                                                          itemBuilder: (context, datachatIndex) {
                                                                                            final datachatItem = datachat[datachatIndex];
                                                                                            return Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.5, 0.0, 0.0),
                                                                                                        child: Container(
                                                                                                          width: 34.0,
                                                                                                          height: 34.0,
                                                                                                          clipBehavior: Clip.antiAlias,
                                                                                                          decoration: BoxDecoration(
                                                                                                            shape: BoxShape.circle,
                                                                                                          ),
                                                                                                          child: Image.network(
                                                                                                            valueOrDefault<String>(
                                                                                                              datachatItem.photo,
                                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                                                                                            ),
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                                        child: Container(
                                                                                                          width: 300.0,
                                                                                                          constraints: BoxConstraints(
                                                                                                            maxWidth: 260.0,
                                                                                                          ),
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.only(
                                                                                                              bottomLeft: Radius.circular(0.0),
                                                                                                              bottomRight: Radius.circular(0.0),
                                                                                                              topLeft: Radius.circular(0.0),
                                                                                                              topRight: Radius.circular(0.0),
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                            children: [
                                                                                                              Column(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    datachatItem.name,
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          font: GoogleFonts.openSans(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                          color: Color(0xFFBDBDBD),
                                                                                                                          fontSize: 11.5,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                  Container(
                                                                                                                    width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                                                    constraints: BoxConstraints(
                                                                                                                      maxWidth: 260.0,
                                                                                                                    ),
                                                                                                                    decoration: BoxDecoration(),
                                                                                                                    child: Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                                                                                                                      child: Text(
                                                                                                                        datachatItem.message,
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.openSans(
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 15.0,
                                                                                                                              letterSpacing: 0.0,
                                                                                                                              fontWeight: FontWeight.w600,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                          controller: _model.listViewController,
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              if (!_model.expandlive)
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                                  child: Container(
                                                                                    width: double.infinity,
                                                                                    height: 2.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFF1D1D1D),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              Stack(
                                                                                children: [
                                                                                  Container(
                                                                                    width: double.infinity,
                                                                                    height: 40.0,
                                                                                    decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(
                                                                                        colors: [
                                                                                          Colors.black,
                                                                                          Colors.transparent
                                                                                        ],
                                                                                        stops: [0.0, 1.0],
                                                                                        begin: AlignmentDirectional(0.0, -1.0),
                                                                                        end: AlignmentDirectional(0, 1.0),
                                                                                      ),
                                                                                    ),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 25.0, 0.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              _model.expandlive = !_model.expandlive;
                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 30.0,
                                                                                              height: 30.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color(0xFF1D1D1D),
                                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  if (!_model.expandlive)
                                                                                                    Align(
                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                      child: Icon(
                                                                                                        Icons.zoom_out_map,
                                                                                                        color: Colors.white,
                                                                                                        size: 20.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  if (_model.expandlive)
                                                                                                    Align(
                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                      child: Icon(
                                                                                                        Icons.zoom_in_map,
                                                                                                        color: Colors.white,
                                                                                                        size: 20.0,
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
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 1.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                gradient: LinearGradient(
                                                                                  colors: [
                                                                                    Colors.transparent,
                                                                                    Colors.black,
                                                                                    Colors.black
                                                                                  ],
                                                                                  stops: [
                                                                                    0.0,
                                                                                    0.2,
                                                                                    1.0
                                                                                  ],
                                                                                  begin: AlignmentDirectional(0.0, -1.0),
                                                                                  end: AlignmentDirectional(0, 1.0),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: double.infinity,
                                                                                      height: 10.0,
                                                                                      decoration: BoxDecoration(
                                                                                        gradient: LinearGradient(
                                                                                          colors: [
                                                                                            Colors.transparent,
                                                                                            Colors.black
                                                                                          ],
                                                                                          stops: [0.0, 1.0],
                                                                                          begin: AlignmentDirectional(0.0, -1.0),
                                                                                          end: AlignmentDirectional(0, 1.0),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                              child: Container(
                                                                                                height: 38.0,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(0xFF111111),
                                                                                                  borderRadius: BorderRadius.circular(45.0),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 12.0, 6.0),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Expanded(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                          child: TextFormField(
                                                                                                            controller: _model.textController,
                                                                                                            focusNode: _model.textFieldFocusNode,
                                                                                                            onChanged: (_) => EasyDebounce.debounce(
                                                                                                              '_model.textController',
                                                                                                              Duration(milliseconds: 2000),
                                                                                                              () => safeSetState(() {}),
                                                                                                            ),
                                                                                                            autofocus: false,
                                                                                                            obscureText: false,
                                                                                                            decoration: InputDecoration(
                                                                                                              hintText: FFLocalizations.of(context).getText(
                                                                                                                '2v1nt967' /* พิมพ์... */,
                                                                                                              ),
                                                                                                              enabledBorder: InputBorder.none,
                                                                                                              focusedBorder: InputBorder.none,
                                                                                                              errorBorder: InputBorder.none,
                                                                                                              focusedErrorBorder: InputBorder.none,
                                                                                                              suffixIcon: _model.textController!.text.isNotEmpty
                                                                                                                  ? InkWell(
                                                                                                                      onTap: () async {
                                                                                                                        _model.textController?.clear();
                                                                                                                        safeSetState(() {});
                                                                                                                      },
                                                                                                                      child: Icon(
                                                                                                                        Icons.clear,
                                                                                                                        color: Color(0xFF757575),
                                                                                                                        size: 22.0,
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  : null,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                            validator: _model.textControllerValidator.asValidator(context),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: 24.0,
                                                                                                        child: VerticalDivider(
                                                                                                          thickness: 1.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                                        child: InkWell(
                                                                                                          splashColor: Colors.transparent,
                                                                                                          focusColor: Colors.transparent,
                                                                                                          hoverColor: Colors.transparent,
                                                                                                          highlightColor: Colors.transparent,
                                                                                                          onTap: () async {
                                                                                                            await showModalBottomSheet(
                                                                                                              isScrollControlled: true,
                                                                                                              backgroundColor: Colors.transparent,
                                                                                                              context: context,
                                                                                                              builder: (context) {
                                                                                                                return GestureDetector(
                                                                                                                  onTap: () {
                                                                                                                    FocusScope.of(context).unfocus();
                                                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                  },
                                                                                                                  child: Padding(
                                                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                                                    child: ItemsWidget(),
                                                                                                                  ),
                                                                                                                );
                                                                                                              },
                                                                                                            ).then((value) => safeSetState(() {}));
                                                                                                          },
                                                                                                          child: Image.network(
                                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/w5g3s4lkc5m8/%E0%B9%80%E0%B8%9E%E0%B8%B4%E0%B9%88%E0%B8%A1%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%E0%B9%83%E0%B8%99%E0%B8%AA%E0%B9%88%E0%B8%A7%E0%B8%99%E0%B9%80%E0%B8%99%E0%B8%B7%E0%B9%89%E0%B8%AD%E0%B8%AB%E0%B8%B2%E0%B9%80%E0%B8%A5%E0%B9%87%E0%B8%81%E0%B8%99%E0%B9%89%E0%B8%AD%E0%B8%A2_(3).png',
                                                                                                            width: 20.0,
                                                                                                            height: 20.0,
                                                                                                            fit: BoxFit.contain,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              await stackVenuesRecord.idLiveChat!.update({
                                                                                                ...mapToSupabase(
                                                                                                  {
                                                                                                    'chat': FieldValue.arrayUnion([
                                                                                                      getChatElementLivechatFirestoreData(
                                                                                                        createChatElementLivechatStruct(
                                                                                                          id: currentUserReference,
                                                                                                          name: currentUserDisplayName,
                                                                                                          message: _model.textController.text,
                                                                                                          photo: currentUserPhoto,
                                                                                                          clearUnsetFields: false,
                                                                                                        ),
                                                                                                        true,
                                                                                                      )
                                                                                                    ]),
                                                                                                  },
                                                                                                ),
                                                                                              });
                                                                                              safeSetState(() {
                                                                                                _model.textController?.clear();
                                                                                              });
                                                                                              await _model.listViewController?.animateTo(
                                                                                                _model.listViewController!.position.maxScrollExtent,
                                                                                                duration: Duration(milliseconds: 100),
                                                                                                curve: Curves.ease,
                                                                                              );
                                                                                              if (animationsMap['containerOnActionTriggerAnimation'] != null) {
                                                                                                await animationsMap['containerOnActionTriggerAnimation']!.controller.forward(from: 0.0);
                                                                                              }
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 38.0,
                                                                                              height: 38.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color(0xFFFF0000),
                                                                                                shape: BoxShape.circle,
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                      child: Icon(
                                                                                                        Icons.send_rounded,
                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                        size: 20.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ).animateOnActionTrigger(
                                                                                            animationsMap['containerOnActionTriggerAnimation']!,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, -1.0),
                                                                            child:
                                                                                Container(
                                                                              width: 120.0,
                                                                              height: 2.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, -1.07),
                                                                            child:
                                                                                Container(
                                                                              width: 70.0,
                                                                              height: 20.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFFFF0000),
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'hlnyfwtv' /* LIVE chat */,
                                                                                  ),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        fontSize: 13.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SingleChildScrollView(
                                                            controller: _model
                                                                .columnController1,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                SingleChildScrollView(
                                                                  controller: _model
                                                                      .columnController2,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(15.0),
                                                                                  border: Border.all(
                                                                                    color: Color(0xFF2A2A2A),
                                                                                    width: 2.0,
                                                                                  ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      if (false)
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: 102.0,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                            ),
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            stackVenuesRecord.bg,
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Opacity(
                                                                                                  opacity: 0.5,
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        height: 100.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          image: DecorationImage(
                                                                                                            fit: BoxFit.cover,
                                                                                                            image: Image.network(
                                                                                                              '',
                                                                                                            ).image,
                                                                                                          ),
                                                                                                          gradient: LinearGradient(
                                                                                                            colors: [
                                                                                                              Color(0xFFFF0000),
                                                                                                              Colors.transparent
                                                                                                            ],
                                                                                                            stops: [0.0, 1.0],
                                                                                                            begin: AlignmentDirectional(-1.0, -0.64),
                                                                                                            end: AlignmentDirectional(1.0, 0.64),
                                                                                                          ),
                                                                                                          borderRadius: BorderRadius.circular(15.0),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            '',
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        gradient: LinearGradient(
                                                                                                          colors: [
                                                                                                            Colors.transparent,
                                                                                                            Color(0xCB000000)
                                                                                                          ],
                                                                                                          stops: [0.0, 1.0],
                                                                                                          begin: AlignmentDirectional(0.0, -1.0),
                                                                                                          end: AlignmentDirectional(0, 1.0),
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                          child: Container(
                                                                                                            width: 80.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: Color(0xFFD8181B),
                                                                                                              borderRadius: BorderRadius.only(
                                                                                                                bottomLeft: Radius.circular(15.0),
                                                                                                                bottomRight: Radius.circular(0.0),
                                                                                                                topLeft: Radius.circular(15.0),
                                                                                                                topRight: Radius.circular(0.0),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              width: 3.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Container(
                                                                                                  height: 102.0,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 30.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                  borderRadius: BorderRadius.only(
                                                                                                                    bottomLeft: Radius.circular(90.0),
                                                                                                                    bottomRight: Radius.circular(90.0),
                                                                                                                    topLeft: Radius.circular(0.0),
                                                                                                                    topRight: Radius.circular(0.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 30.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                                borderRadius: BorderRadius.only(
                                                                                                                  bottomLeft: Radius.circular(0.0),
                                                                                                                  bottomRight: Radius.circular(0.0),
                                                                                                                  topLeft: Radius.circular(90.0),
                                                                                                                  topRight: Radius.circular(90.0),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(105.0, 10.0, 0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        stackVenuesRecord.nameVenuse,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 20.0,
                                                                                                              letterSpacing: 0.5,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'gft872n2' /* Zone : */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.22, -0.49),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFFD8181B),
                                                                                                                  borderRadius: BorderRadius.circular(90.0),
                                                                                                                ),
                                                                                                                child: Row(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                  children: [
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                                                      child: Icon(
                                                                                                                        Icons.star_rounded,
                                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                        size: 15.0,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                                                      child: Text(
                                                                                                                        FFLocalizations.of(context).getText(
                                                                                                                          'xvgvp5b6' /* VVIP */,
                                                                                                                        ),
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.openSans(
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 11.0,
                                                                                                                              letterSpacing: 1.0,
                                                                                                                              fontWeight: FontWeight.w600,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                                            child: Image.network(
                                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                              width: 12.0,
                                                                                                              height: 12.0,
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '0iiv5xxw' /* :  */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 1.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'ekzj9n9p' /* A31 */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'wrt9jrnn' /* :  */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '7sg9h4fd' /* 4 */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                            child: Icon(
                                                                                                              Icons.people_sharp,
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              size: 15.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.0, 1.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 10.0),
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Color(0xFFD8181B),
                                                                                                        borderRadius: BorderRadius.circular(45.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 1.0, 10.0, 1.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            '5vq81do6' /* ฿ 2,500 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 54.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.asset(
                                                                                                          'assets/images/_(27).png',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.06, -1.25),
                                                                                                  child: Container(
                                                                                                    width: 23.0,
                                                                                                    height: 23.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFFFF2D38),
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 4.0,
                                                                                                          color: Color(0x33000000),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                          spreadRadius: 1.0,
                                                                                                        )
                                                                                                      ],
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: Icon(
                                                                                                      Icons.close,
                                                                                                      color: Colors.white,
                                                                                                      size: 18.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      if (false)
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: 102.0,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                            ),
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            stackVenuesRecord.bg,
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Opacity(
                                                                                                  opacity: 0.5,
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(50.0, 1.0, 0.0, 1.0),
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        height: 100.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          image: DecorationImage(
                                                                                                            fit: BoxFit.cover,
                                                                                                            image: Image.network(
                                                                                                              '',
                                                                                                            ).image,
                                                                                                          ),
                                                                                                          gradient: LinearGradient(
                                                                                                            colors: [
                                                                                                              Color(0xFFFA9207),
                                                                                                              Colors.transparent
                                                                                                            ],
                                                                                                            stops: [0.0, 1.0],
                                                                                                            begin: AlignmentDirectional(-1.0, -0.64),
                                                                                                            end: AlignmentDirectional(1.0, 0.64),
                                                                                                          ),
                                                                                                          borderRadius: BorderRadius.circular(15.0),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            '',
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        gradient: LinearGradient(
                                                                                                          colors: [
                                                                                                            Colors.transparent,
                                                                                                            Color(0xB7000000)
                                                                                                          ],
                                                                                                          stops: [0.0, 1.0],
                                                                                                          begin: AlignmentDirectional(0.0, -1.0),
                                                                                                          end: AlignmentDirectional(0, 1.0),
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          width: 80.0,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: Color(0xFFFA9207),
                                                                                                            borderRadius: BorderRadius.only(
                                                                                                              bottomLeft: Radius.circular(15.0),
                                                                                                              bottomRight: Radius.circular(0.0),
                                                                                                              topLeft: Radius.circular(15.0),
                                                                                                              topRight: Radius.circular(0.0),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              width: 3.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 30.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                  borderRadius: BorderRadius.only(
                                                                                                                    bottomLeft: Radius.circular(90.0),
                                                                                                                    bottomRight: Radius.circular(90.0),
                                                                                                                    topLeft: Radius.circular(0.0),
                                                                                                                    topRight: Radius.circular(0.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 30.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                                borderRadius: BorderRadius.only(
                                                                                                                  bottomLeft: Radius.circular(0.0),
                                                                                                                  bottomRight: Radius.circular(0.0),
                                                                                                                  topLeft: Radius.circular(90.0),
                                                                                                                  topRight: Radius.circular(90.0),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.0, 1.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 10.0),
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Color(0xFFFA9207),
                                                                                                        borderRadius: BorderRadius.circular(45.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 1.0, 10.0, 1.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            '9uyxq2cp' /* ฿ 1,500 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 54.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.asset(
                                                                                                          'assets/images/_(27).png',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(105.0, 10.0, 0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        stackVenuesRecord.nameVenuse,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 20.0,
                                                                                                              letterSpacing: 0.5,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '4agscpws' /* Zone : */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.22, -0.49),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFFFA9207),
                                                                                                                  borderRadius: BorderRadius.circular(90.0),
                                                                                                                ),
                                                                                                                child: Row(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                  children: [
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                                                      child: Icon(
                                                                                                                        Icons.star_rounded,
                                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                        size: 15.0,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                                                      child: Text(
                                                                                                                        FFLocalizations.of(context).getText(
                                                                                                                          '8n4z6077' /* VIP */,
                                                                                                                        ),
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.openSans(
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 11.0,
                                                                                                                              letterSpacing: 1.0,
                                                                                                                              fontWeight: FontWeight.w600,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                                            child: Image.network(
                                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                              width: 12.0,
                                                                                                              height: 12.0,
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '71auxs7t' /* :  */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 1.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '0u417nvy' /* B31 */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'a7aao6m3' /* :  */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'i0i6rs12' /* 4 */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                            child: Icon(
                                                                                                              Icons.people_rounded,
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              size: 15.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.06, -1.25),
                                                                                                  child: Container(
                                                                                                    width: 23.0,
                                                                                                    height: 23.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFFFF2D38),
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 4.0,
                                                                                                          color: Color(0x33000000),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                          spreadRadius: 1.0,
                                                                                                        )
                                                                                                      ],
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: Icon(
                                                                                                      Icons.close,
                                                                                                      color: Colors.white,
                                                                                                      size: 18.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      if (false)
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: 102.0,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                            ),
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            stackVenuesRecord.bg,
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Opacity(
                                                                                                  opacity: 0.5,
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(50.0, 1.0, 0.0, 1.0),
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        height: 100.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          image: DecorationImage(
                                                                                                            fit: BoxFit.cover,
                                                                                                            image: Image.network(
                                                                                                              '',
                                                                                                            ).image,
                                                                                                          ),
                                                                                                          gradient: LinearGradient(
                                                                                                            colors: [
                                                                                                              Color(0xFFE42F7D),
                                                                                                              Colors.transparent
                                                                                                            ],
                                                                                                            stops: [0.0, 1.0],
                                                                                                            begin: AlignmentDirectional(-1.0, -0.64),
                                                                                                            end: AlignmentDirectional(1.0, 0.64),
                                                                                                          ),
                                                                                                          borderRadius: BorderRadius.circular(15.0),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            '',
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        gradient: LinearGradient(
                                                                                                          colors: [
                                                                                                            Colors.transparent,
                                                                                                            Color(0xB7000000)
                                                                                                          ],
                                                                                                          stops: [0.0, 1.0],
                                                                                                          begin: AlignmentDirectional(0.0, -1.0),
                                                                                                          end: AlignmentDirectional(0, 1.0),
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                          child: Container(
                                                                                                            width: 80.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: Color(0xFFE42F7D),
                                                                                                              borderRadius: BorderRadius.only(
                                                                                                                bottomLeft: Radius.circular(15.0),
                                                                                                                bottomRight: Radius.circular(0.0),
                                                                                                                topLeft: Radius.circular(15.0),
                                                                                                                topRight: Radius.circular(0.0),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              width: 3.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 30.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                  borderRadius: BorderRadius.only(
                                                                                                                    bottomLeft: Radius.circular(90.0),
                                                                                                                    bottomRight: Radius.circular(90.0),
                                                                                                                    topLeft: Radius.circular(0.0),
                                                                                                                    topRight: Radius.circular(0.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 30.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                                borderRadius: BorderRadius.only(
                                                                                                                  bottomLeft: Radius.circular(0.0),
                                                                                                                  bottomRight: Radius.circular(0.0),
                                                                                                                  topLeft: Radius.circular(90.0),
                                                                                                                  topRight: Radius.circular(90.0),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.0, 1.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 10.0),
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Color(0xFFE42F7D),
                                                                                                        borderRadius: BorderRadius.circular(45.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 1.0, 10.0, 1.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'dq1k0zb7' /* ฿ 1,000 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 54.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.asset(
                                                                                                          'assets/images/_(27).png',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(105.0, 10.0, 0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        stackVenuesRecord.nameVenuse,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 20.0,
                                                                                                              letterSpacing: 0.5,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '6b9r8wok' /* Zone : */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.22, -0.49),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFFE42F7D),
                                                                                                                  borderRadius: BorderRadius.circular(90.0),
                                                                                                                ),
                                                                                                                child: Row(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                  children: [
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                                                      child: Icon(
                                                                                                                        Icons.star_rounded,
                                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                        size: 15.0,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                                                      child: Text(
                                                                                                                        FFLocalizations.of(context).getText(
                                                                                                                          'bn1ckzq3' /* A */,
                                                                                                                        ),
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.openSans(
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 11.0,
                                                                                                                              letterSpacing: 1.0,
                                                                                                                              fontWeight: FontWeight.w600,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.06, -1.25),
                                                                                                  child: Container(
                                                                                                    width: 23.0,
                                                                                                    height: 23.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFFFF2D38),
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 4.0,
                                                                                                          color: Color(0x33000000),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                          spreadRadius: 1.0,
                                                                                                        )
                                                                                                      ],
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: Icon(
                                                                                                      Icons.close,
                                                                                                      color: Colors.white,
                                                                                                      size: 18.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      if (false)
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: 102.0,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                            ),
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.network(
                                                                                                          stackVenuesRecord.bg,
                                                                                                        ).image,
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(15.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Opacity(
                                                                                                  opacity: 0.5,
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(50.0, 1.0, 0.0, 1.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            '',
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        gradient: LinearGradient(
                                                                                                          colors: [
                                                                                                            Color(0xFF0171BC),
                                                                                                            Colors.transparent
                                                                                                          ],
                                                                                                          stops: [0.0, 1.0],
                                                                                                          begin: AlignmentDirectional(-1.0, -0.64),
                                                                                                          end: AlignmentDirectional(1.0, 0.64),
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.network(
                                                                                                          '',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                      gradient: LinearGradient(
                                                                                                        colors: [
                                                                                                          Colors.transparent,
                                                                                                          Color(0xB7000000)
                                                                                                        ],
                                                                                                        stops: [0.0, 1.0],
                                                                                                        begin: AlignmentDirectional(0.0, -1.0),
                                                                                                        end: AlignmentDirectional(0, 1.0),
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(15.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                          child: Container(
                                                                                                            width: 80.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: Color(0xFF0171BC),
                                                                                                              borderRadius: BorderRadius.only(
                                                                                                                bottomLeft: Radius.circular(15.0),
                                                                                                                bottomRight: Radius.circular(0.0),
                                                                                                                topLeft: Radius.circular(15.0),
                                                                                                                topRight: Radius.circular(0.0),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              width: 3.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 30.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                  borderRadius: BorderRadius.only(
                                                                                                                    bottomLeft: Radius.circular(90.0),
                                                                                                                    bottomRight: Radius.circular(90.0),
                                                                                                                    topLeft: Radius.circular(0.0),
                                                                                                                    topRight: Radius.circular(0.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 30.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                                borderRadius: BorderRadius.only(
                                                                                                                  bottomLeft: Radius.circular(0.0),
                                                                                                                  bottomRight: Radius.circular(0.0),
                                                                                                                  topLeft: Radius.circular(90.0),
                                                                                                                  topRight: Radius.circular(90.0),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.0, 1.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 10.0),
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Color(0xFF0171BC),
                                                                                                        borderRadius: BorderRadius.circular(45.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 1.0, 10.0, 1.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'zgdlc1ls' /* ฿ 500 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 54.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.asset(
                                                                                                          'assets/images/_(27).png',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(105.0, 10.0, 0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        stackVenuesRecord.nameVenuse,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 20.0,
                                                                                                              letterSpacing: 0.5,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '8nhm2kar' /* Zone : */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.22, -0.49),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF0171BC),
                                                                                                                  borderRadius: BorderRadius.circular(90.0),
                                                                                                                ),
                                                                                                                child: Row(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                  children: [
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                                                      child: Icon(
                                                                                                                        Icons.star_rounded,
                                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                        size: 15.0,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                                                      child: Text(
                                                                                                                        FFLocalizations.of(context).getText(
                                                                                                                          'yry045go' /* B */,
                                                                                                                        ),
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.openSans(
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 11.0,
                                                                                                                              letterSpacing: 1.0,
                                                                                                                              fontWeight: FontWeight.w600,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.06, -1.25),
                                                                                                  child: Container(
                                                                                                    width: 23.0,
                                                                                                    height: 23.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFFFF2D38),
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 4.0,
                                                                                                          color: Color(0x33000000),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                          spreadRadius: 1.0,
                                                                                                        )
                                                                                                      ],
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: Icon(
                                                                                                      Icons.close,
                                                                                                      color: Colors.white,
                                                                                                      size: 18.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      if (false)
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: 102.0,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                            ),
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.network(
                                                                                                          stackVenuesRecord.bg,
                                                                                                        ).image,
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(15.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Opacity(
                                                                                                  opacity: 0.5,
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(50.0, 1.0, 0.0, 1.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            '',
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        gradient: LinearGradient(
                                                                                                          colors: [
                                                                                                            Color(0xFF333333),
                                                                                                            Colors.transparent
                                                                                                          ],
                                                                                                          stops: [0.0, 1.0],
                                                                                                          begin: AlignmentDirectional(-1.0, -0.64),
                                                                                                          end: AlignmentDirectional(1.0, 0.64),
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.network(
                                                                                                          '',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                      gradient: LinearGradient(
                                                                                                        colors: [
                                                                                                          Colors.transparent,
                                                                                                          Color(0xB7000000)
                                                                                                        ],
                                                                                                        stops: [0.0, 1.0],
                                                                                                        begin: AlignmentDirectional(0.0, -1.0),
                                                                                                        end: AlignmentDirectional(0, 1.0),
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(15.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                          child: Container(
                                                                                                            width: 80.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: Color(0xFF333333),
                                                                                                              borderRadius: BorderRadius.only(
                                                                                                                bottomLeft: Radius.circular(15.0),
                                                                                                                bottomRight: Radius.circular(0.0),
                                                                                                                topLeft: Radius.circular(15.0),
                                                                                                                topRight: Radius.circular(0.0),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              width: 3.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 30.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                  borderRadius: BorderRadius.only(
                                                                                                                    bottomLeft: Radius.circular(90.0),
                                                                                                                    bottomRight: Radius.circular(90.0),
                                                                                                                    topLeft: Radius.circular(0.0),
                                                                                                                    topRight: Radius.circular(0.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 30.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                                borderRadius: BorderRadius.only(
                                                                                                                  bottomLeft: Radius.circular(0.0),
                                                                                                                  bottomRight: Radius.circular(0.0),
                                                                                                                  topLeft: Radius.circular(90.0),
                                                                                                                  topRight: Radius.circular(90.0),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.0, 1.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 10.0),
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Color(0xFF333333),
                                                                                                        borderRadius: BorderRadius.circular(45.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 1.0, 10.0, 1.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'soors5ex' /* ฿ 300 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 54.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.asset(
                                                                                                          'assets/images/_(27).png',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(105.0, 10.0, 0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        stackVenuesRecord.nameVenuse,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 20.0,
                                                                                                              letterSpacing: 0.5,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '60xpx86y' /* Zone : */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.22, -0.49),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF333333),
                                                                                                                  borderRadius: BorderRadius.circular(90.0),
                                                                                                                ),
                                                                                                                child: Row(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                  children: [
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                                                      child: Icon(
                                                                                                                        Icons.star_rounded,
                                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                        size: 15.0,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                                                      child: Text(
                                                                                                                        FFLocalizations.of(context).getText(
                                                                                                                          'gmknknyt' /* C */,
                                                                                                                        ),
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.openSans(
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 11.0,
                                                                                                                              letterSpacing: 1.0,
                                                                                                                              fontWeight: FontWeight.w600,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                                            child: Image.network(
                                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                              width: 12.0,
                                                                                                              height: 12.0,
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '1zy28w2f' /* :  */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 1.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'ggiokpn4' /* C31 */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '6z502j02' /* :  */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'l3nzym2i' /* 4 */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                            child: Icon(
                                                                                                              Icons.people_rounded,
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              size: 15.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.06, -1.25),
                                                                                                  child: Container(
                                                                                                    width: 23.0,
                                                                                                    height: 23.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFFFF2D38),
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 4.0,
                                                                                                          color: Color(0x33000000),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                          spreadRadius: 1.0,
                                                                                                        )
                                                                                                      ],
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: Icon(
                                                                                                      Icons.close,
                                                                                                      color: Colors.white,
                                                                                                      size: 18.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      if (true)
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: 102.0,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                            ),
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.network(
                                                                                                          stackVenuesRecord.bg,
                                                                                                        ).image,
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(15.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(15.0),
                                                                                                    child: BackdropFilter(
                                                                                                      filter: ImageFilter.blur(
                                                                                                        sigmaX: 15.0,
                                                                                                        sigmaY: 15.0,
                                                                                                      ),
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        height: 100.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          borderRadius: BorderRadius.circular(15.0),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Opacity(
                                                                                                  opacity: 0.3,
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(50.0, 1.0, 0.0, 1.0),
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        height: 100.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          image: DecorationImage(
                                                                                                            fit: BoxFit.cover,
                                                                                                            image: Image.network(
                                                                                                              '',
                                                                                                            ).image,
                                                                                                          ),
                                                                                                          gradient: LinearGradient(
                                                                                                            colors: [
                                                                                                              Color(0xFF58BB2F),
                                                                                                              Colors.transparent
                                                                                                            ],
                                                                                                            stops: [0.0, 1.0],
                                                                                                            begin: AlignmentDirectional(-1.0, -0.64),
                                                                                                            end: AlignmentDirectional(1.0, 0.64),
                                                                                                          ),
                                                                                                          borderRadius: BorderRadius.circular(15.0),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 1.0),
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: 100.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          image: Image.network(
                                                                                                            '',
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        gradient: LinearGradient(
                                                                                                          colors: [
                                                                                                            Colors.transparent,
                                                                                                            Color(0xB7000000)
                                                                                                          ],
                                                                                                          stops: [0.0, 1.0],
                                                                                                          begin: AlignmentDirectional(0.0, -1.0),
                                                                                                          end: AlignmentDirectional(0, 1.0),
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          width: 80.0,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: Color(0xFF58BB2F),
                                                                                                            borderRadius: BorderRadius.only(
                                                                                                              bottomLeft: Radius.circular(15.0),
                                                                                                              bottomRight: Radius.circular(0.0),
                                                                                                              topLeft: Radius.circular(15.0),
                                                                                                              topRight: Radius.circular(0.0),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              width: 3.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Color(0xFF131313),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 3.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF131313),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 30.0,
                                                                                                                height: 15.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Colors.black,
                                                                                                                  borderRadius: BorderRadius.only(
                                                                                                                    bottomLeft: Radius.circular(90.0),
                                                                                                                    bottomRight: Radius.circular(90.0),
                                                                                                                    topLeft: Radius.circular(0.0),
                                                                                                                    topRight: Radius.circular(0.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(65.0, 0.0, 0.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 30.0,
                                                                                                              height: 15.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Colors.black,
                                                                                                                borderRadius: BorderRadius.only(
                                                                                                                  bottomLeft: Radius.circular(0.0),
                                                                                                                  bottomRight: Radius.circular(0.0),
                                                                                                                  topLeft: Radius.circular(90.0),
                                                                                                                  topRight: Radius.circular(90.0),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(1.0, 1.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 10.0),
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Color(0xFF58BB2F),
                                                                                                        borderRadius: BorderRadius.circular(45.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 1.0, 10.0, 1.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'j6a85dww' /* ฿ Free */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 54.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.asset(
                                                                                                          'assets/images/_(27).png',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(105.0, 10.0, 0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        stackVenuesRecord.nameVenuse,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 20.0,
                                                                                                              letterSpacing: 0.5,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'haba2hgu' /* Zone : */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(0.22, -0.49),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0xFF58BB2F),
                                                                                                                  borderRadius: BorderRadius.circular(90.0),
                                                                                                                ),
                                                                                                                child: Row(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                  children: [
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                                                      child: Icon(
                                                                                                                        Icons.star_rounded,
                                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                        size: 15.0,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                                                      child: Text(
                                                                                                                        FFLocalizations.of(context).getText(
                                                                                                                          'orfq0mn7' /* Regular */,
                                                                                                                        ),
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.openSans(
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 11.0,
                                                                                                                              letterSpacing: 1.0,
                                                                                                                              fontWeight: FontWeight.w600,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                                            child: Image.network(
                                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                              width: 12.0,
                                                                                                              height: 12.0,
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '7lyn96ig' /* :  */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 1.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'vu6065xm' /* B31 */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'xwpv7x6l' /* :  */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '5bhcwqof' /* 4 */,
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                            child: Icon(
                                                                                                              Icons.people_rounded,
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              size: 15.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 3.0),
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'ypg8wzob' /* Check In */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          fontSize: 18.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(90.0),
                                                                                  border: Border.all(
                                                                                    color: Color(0xFF2A2A2A),
                                                                                    width: 2.0,
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        child: Image.asset(
                                                                                          'assets/images/22.png',
                                                                                          width: 23.0,
                                                                                          height: 23.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                      child: Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'tf3dnkge' /* 3 */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.openSans(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              fontSize: 16.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                      child: Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'juurp6dq' /* / */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.openSans(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              fontSize: 16.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 10.0, 0.0),
                                                                                      child: Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'is3r5xqn' /* 4 */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.openSans(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              fontSize: 16.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            15.0,
                                                                            7.0,
                                                                            15.0,
                                                                            10.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              95.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            scrollDirection:
                                                                                Axis.horizontal,
                                                                            controller:
                                                                                _model.rowController,
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Container(
                                                                                    width: 75.0,
                                                                                    height: 100.0,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.rectangle,
                                                                                    ),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Stack(
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 75.0,
                                                                                                    height: 75.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFF1D1D1D),
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.network(
                                                                                                          currentUserPhoto,
                                                                                                        ).image,
                                                                                                      ),
                                                                                                      shape: BoxShape.circle,
                                                                                                      border: Border.all(
                                                                                                        width: 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    's6r2ykml' /* You */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 10.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Container(
                                                                                    width: 75.0,
                                                                                    height: 100.0,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.rectangle,
                                                                                    ),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Stack(
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 75.0,
                                                                                                    height: 75.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFF1D1D1D),
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.asset(
                                                                                                          'assets/images/20240515182857-Create_an_image_of_a.png',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                      shape: BoxShape.circle,
                                                                                                      border: Border.all(
                                                                                                        width: 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'ywjx9289' /* PANK */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 10.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Container(
                                                                                    width: 75.0,
                                                                                    height: 100.0,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.rectangle,
                                                                                    ),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Stack(
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 75.0,
                                                                                                    height: 75.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFF1D1D1D),
                                                                                                      image: DecorationImage(
                                                                                                        fit: BoxFit.cover,
                                                                                                        image: Image.asset(
                                                                                                          'assets/images/20240515154627-Create_an_image_of_a.png',
                                                                                                        ).image,
                                                                                                      ),
                                                                                                      shape: BoxShape.circle,
                                                                                                      border: Border.all(
                                                                                                        width: 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'cgj1fm77' /* PUK_66 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 10.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
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
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 150.0),
                                                                                  child: Container(
                                                                                    width: double.infinity,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(15.0),
                                                                                      border: Border.all(
                                                                                        color: Color(0xFF2A2A2A),
                                                                                        width: 2.0,
                                                                                      ),
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 10.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'eo64n89p' /* เงื่อนไขการจอง
เงื่อนไขการจองค... */
                                                                                              ,
                                                                                            ),
                                                                                            textAlign: TextAlign.start,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ].addToEnd(SizedBox(
                                                                        height:
                                                                            120.0)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, -1.01),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
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
                    ((currentUserDocument?.cheersEnd.toList() ?? []).length !=
                        0))
                  AuthUserStreamWidget(
                    builder: (context) => StreamBuilder<UsersRecord>(
                      stream: UsersRecord.getDocument(
                          (currentUserDocument?.cheersEnd.toList() ?? [])
                              .elementAtOrNull((currentUserDocument
                                          ?.showprofilecheers
                                          .toList() ??
                                      [])
                                  .length)!),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
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
                            context.pushNamed(HomePageWidget.routeName);

                            await currentUserReference!.update({
                              ...mapToSupabase(
                                {
                                  'showprofilecheers': FieldValue.arrayUnion(
                                      [card33UserGridUsersRecord.reference]),
                                },
                              ),
                            });
                          },
                          child: wrapWithModel(
                            model: _model.card33UserGridModel,
                            updateCallback: () => safeSetState(() {}),
                            updateOnChange: true,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
