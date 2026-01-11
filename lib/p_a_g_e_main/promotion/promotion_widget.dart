import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/filter_widget.dart';
import '/components/nav_bar_widget.dart';
import '/components/rowpromotion_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'promotion_model.dart';
export 'promotion_model.dart';

class PromotionWidget extends StatefulWidget {
  const PromotionWidget({super.key});

  static String routeName = 'Promotion';
  static String routePath = 'promotion';

  @override
  State<PromotionWidget> createState() => _PromotionWidgetState();
}

class _PromotionWidgetState extends State<PromotionWidget>
    with TickerProviderStateMixin {
  late PromotionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PromotionModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      FFAppState().locationsearch = currentUserLocationValue;
      FFAppState().dateclick = getCurrentTimestamp;
      safeSetState(() {});
      _model.mapon = false;
      safeSetState(() {});
      FFAppState().MoveMap = false;
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.textFieldFocusNode!.addListener(
      () async {
        _model.page = 1;
        safeSetState(() {});
      },
    );
    animationsMap.addAll({
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(320.0, 0.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(0, 0),
            end: Offset(0, 0.436),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(0.85, 0.85),
          ),
        ],
      ),
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
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'carouselOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(-20.0, 0.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(40.0, 0.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 800.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(-20.0, 0.0),
          ),
        ],
      ),
      'rowpromotionOnPageLoadAnimation': AnimationInfo(
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

    return StreamBuilder<List<VenuesRecord>>(
      stream: queryVenuesRecord(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.transparent,
                  ),
                ),
              ),
            ),
          );
        }
        List<VenuesRecord> promotionVenuesRecordList = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.black,
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 50.0,
                            color: Color(0xC0000000),
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            if (_model.mapon ?? true)
                              AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: custom_widgets.MapVenuse(
                                    width: double.infinity,
                                    height: double.infinity,
                                    zoomStart: 10.5,
                                    zoomMin: 9.0,
                                    zoomMax: 18.0,
                                    markerIcon:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/4ukflr1mlkc1/beer_(3).png',
                                    markerMeIcon:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/lkzyscp6kupj/map-marker_(2).png',
                                    compassEnabled: false,
                                    makerSelectedIcon:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/ugva4ht8jron/beer_(2).png',
                                    moveMapCondition: false,
                                    radian: FFAppState().Filterdistance,
                                    items: functions.dataVenuseDocref(
                                        FFAppState().Filterdistance,
                                        FFAppState().locationsearch,
                                        (currentUserDocument?.loveVenuse
                                                    .toList() ??
                                                [])
                                            .toList(),
                                        FFAppState().StyleMusic.toList(),
                                        FFAppState().StyleVenuse.toList(),
                                        promotionVenuesRecordList
                                            .where((e) =>
                                                functions.showsearch(
                                                    _model.textController.text,
                                                    e.nameVenuse)! &&
                                                (e.listpromotion.length != 0) &&
                                                (!_model.selectdate!
                                                    ? functions.checkday(
                                                        e.listpromotion
                                                            .toList(),
                                                        getCurrentTimestamp)!
                                                    : true))
                                            .toList()),
                                    locationStart: FFAppState().locationsearch,
                                    itemClick: FFAppState().VenuseSelection,
                                    currentLocation:
                                        FFAppState().locationsearch,
                                    whenSelect: () async {
                                      _model.slide = false;
                                      safeSetState(() {});
                                      await _model.carouselController
                                          ?.animateToPage(
                                        functions.searchIndexVenuse(
                                            functions
                                                .dataVenuseDocref(
                                                    FFAppState().Filterdistance,
                                                    FFAppState().locationsearch,
                                                    (currentUserDocument
                                                                ?.loveVenuse
                                                                .toList() ??
                                                            [])
                                                        .toList(),
                                                    FFAppState()
                                                        .StyleMusic
                                                        .toList(),
                                                    FFAppState()
                                                        .StyleVenuse
                                                        .toList(),
                                                    promotionVenuesRecordList
                                                        .where((e) =>
                                                            functions.showsearch(
                                                                _model
                                                                    .textController
                                                                    .text,
                                                                e
                                                                    .nameVenuse)! &&
                                                            (e.listpromotion
                                                                    .length !=
                                                                0) &&
                                                            (!_model.selectdate!
                                                                ? functions.checkday(
                                                                    e.listpromotion
                                                                        .toList(),
                                                                    getCurrentTimestamp)!
                                                                : true))
                                                        .toList())
                                                ?.toList(),
                                            FFAppState().VenuseSelection)!,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                      _model.slide = true;
                                      safeSetState(() {});
                                    },
                                    whenSetStyleSuccess: () async {},
                                  ),
                                ),
                              ),
                            if (_model.mapon ?? true)
                              Container(
                                width: double.infinity,
                                height: _model.selectdate! ? 235.0 : 170.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                      Colors.transparent
                                    ],
                                    stops: [0.0, 0.7, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                ),
                              ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Container(
                                width: double.infinity,
                                height: 300.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                      Colors.black
                                    ],
                                    stops: [0.0, 0.9, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 12.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20.0, 0.0, 0.0, 0.0),
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
                                                      context.pushNamed(
                                                        ProfileWidget.routeName,
                                                        queryParameters: {
                                                          'fromSeting':
                                                              serializeParam(
                                                            false,
                                                            ParamType.bool,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Stack(
                                                        children: [
                                                          AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  currentUserPhoto,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.0, 1.0),
                                                            child: Container(
                                                              width: 18.0,
                                                              height: 18.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFFF0005),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            45.0),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Stack(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .settings,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            13.0,
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
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(18.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      2.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 13.0,
                                                                height: 20.0,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                6.0,
                                                                            height:
                                                                                6.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              borderRadius: BorderRadius.circular(45.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .location_pin,
                                                                          color:
                                                                              Color(0xFFFF0000),
                                                                          size:
                                                                              14.0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '2bv6uviu' /* ดอนเมือง,สงค์ประภา */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFFBCBCBC),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        2.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: InkWell(
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
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'k71hd6bj' /* Promotions */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .openSans(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          17.0,
                                                                      letterSpacing:
                                                                          0.2,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 17.0, 0.0),
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
                                                      context.pushNamed(
                                                          TicketWidget
                                                              .routeName);
                                                    },
                                                    child: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        border: Border.all(
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child:
                                                                Image.network(
                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/vkqck67kmjo7/22.png',
                                                              width: 40.0,
                                                              height: 40.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          if ((currentUserDocument
                                                                          ?.usermassage
                                                                          .toList() ??
                                                                      [])
                                                                  .length !=
                                                              0)
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.2,
                                                                      -1.2),
                                                              child:
                                                                  AuthUserStreamWidget(
                                                                builder:
                                                                    (context) =>
                                                                        Container(
                                                                  width: 18.0,
                                                                  height: 18.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFF0000),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            180.0),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          1.0,
                                                                          0.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'nhgg0eae' /* 5 */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 20.0, 0.0),
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
                                                      context.pushNamed(
                                                          HomePageWidget
                                                              .routeName);
                                                    },
                                                    child: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        border: Border.all(
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child:
                                                                Image.network(
                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/ucvx51dhc4gx/message2.png',
                                                              width: 36.0,
                                                              height: 36.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          if ((currentUserDocument
                                                                          ?.usermassage
                                                                          .toList() ??
                                                                      [])
                                                                  .length !=
                                                              0)
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.2,
                                                                      -1.2),
                                                              child:
                                                                  AuthUserStreamWidget(
                                                                builder:
                                                                    (context) =>
                                                                        Container(
                                                                  width: 18.0,
                                                                  height: 18.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFF0000),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            180.0),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.1,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '50bt8hhj' /* 5 */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                10.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
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
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 45.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x981D1D1D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    0.0,
                                                                    15.0,
                                                                    2.0),
                                                        child: Icon(
                                                          Icons.search,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBtnText,
                                                          size: 22.0,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: TextFormField(
                                                            controller: _model
                                                                .textController,
                                                            focusNode: _model
                                                                .textFieldFocusNode,
                                                            onChanged: (_) =>
                                                                EasyDebounce
                                                                    .debounce(
                                                              '_model.textController',
                                                              Duration(
                                                                  milliseconds:
                                                                      500),
                                                              () =>
                                                                  safeSetState(
                                                                      () {}),
                                                            ),
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: false,
                                                              hintText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                'ez53ir4h' /* ชื่อร้าน */,
                                                              ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFF9D9D9D),
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              errorBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              focusedErrorBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              suffixIcon: _model
                                                                      .textController!
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        _model
                                                                            .textController
                                                                            ?.clear();
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: Color(
                                                                            0xFF757575),
                                                                        size:
                                                                            22.0,
                                                                      ),
                                                                    )
                                                                  : null,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Color(
                                                                      0xFFBDBDBD),
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                            validator: _model
                                                                .textControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 24.0,
                                                        child: VerticalDivider(
                                                          thickness: 1.0,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: InkWell(
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
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          FilterWidget(),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));

                                                              _model.page = 1;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child:
                                                                Image.network(
                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4mhd403jg5z2/fillter.png',
                                                              width: 30.0,
                                                              height: 28.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          if (_model
                                                                  .lovefilter ==
                                                              true) {
                                                            _model.lovefilter =
                                                                false;
                                                            _model.page = 1;
                                                            safeSetState(() {});
                                                          } else {
                                                            _model.lovefilter =
                                                                true;
                                                            _model.selectdate =
                                                                false;
                                                            _model.page = 1;
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x981D1D1D),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 5.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  2.0,
                                                                  2.0,
                                                                ),
                                                                spreadRadius:
                                                                    4.0,
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .favorite_border_rounded,
                                                                  color: _model
                                                                          .lovefilter
                                                                      ? Color(
                                                                          0xFFFF0000)
                                                                      : Colors
                                                                          .white,
                                                                  size: 30.0,
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
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
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
                                                    if (_model.mapon!) {
                                                      _model.mapon = false;
                                                      safeSetState(() {});
                                                    } else {
                                                      FFAppState().VenuseSelection = functions
                                                          .dataVenuseDocref(
                                                              FFAppState()
                                                                  .Filterdistance,
                                                              FFAppState()
                                                                  .locationsearch,
                                                              (currentUserDocument
                                                                          ?.loveVenuse
                                                                          .toList() ??
                                                                      [])
                                                                  .toList(),
                                                              FFAppState()
                                                                  .StyleMusic
                                                                  .toList(),
                                                              FFAppState()
                                                                  .StyleVenuse
                                                                  .toList(),
                                                              promotionVenuesRecordList
                                                                  .where((e) =>
                                                                      functions.showsearch(
                                                                          _model
                                                                              .textController
                                                                              .text,
                                                                          e
                                                                              .nameVenuse)! &&
                                                                      (e.listpromotion
                                                                              .length !=
                                                                          0) &&
                                                                      (!_model.selectdate!
                                                                          ? functions.checkday(
                                                                              e.listpromotion.toList(),
                                                                              getCurrentTimestamp)!
                                                                          : true))
                                                                  .toList())
                                                          ?.elementAtOrNull(0)
                                                          ?.reference;
                                                      safeSetState(() {});
                                                      _model.mapon = true;
                                                      safeSetState(() {});
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 45.0,
                                                    height: 45.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x981D1D1D),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                        color: _model.mapon!
                                                            ? Color(0xFFA5A5A5)
                                                            : Color(0x981D1D1D),
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                            child: Image.asset(
                                                              'assets/images/7089161_google_maps_icon.png',
                                                              width: 32.0,
                                                              height: 32.0,
                                                              fit: BoxFit.cover,
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
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-0.8, 0.11),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 0.0, 10.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 20.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x00FFFFFF),
                                              ),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                controller:
                                                    _model.rowController,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (_model.selectdate ??
                                                        true)
                                                      Expanded(
                                                        child: Container(
                                                          height: 30.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, -1.3),
                                                            child: Stack(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            15.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions
                                                                            .month(FFAppState().dateclick),
                                                                        'ไม่ระบุ',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                1.2,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            lineHeight:
                                                                                0.9,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'containerOnPageLoadAnimation1']!),
                                                      ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      7.0,
                                                                      0.0),
                                                          child: InkWell(
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
                                                              _model.selectdate =
                                                                  !(_model.selectdate ??
                                                                      true);
                                                              safeSetState(
                                                                  () {});
                                                              FFAppState()
                                                                      .dateclick =
                                                                  getCurrentTimestamp;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _model
                                                                        .selectdate!
                                                                    ? Color(
                                                                        0xFF222222)
                                                                    : Color(
                                                                        0xFFFF0000),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            6.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              2.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'o4wwef6a' /* Today */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  7.0,
                                                                  0.0),
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
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      FilterWidget(),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                        child: Container(
                                                          height:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF1C1C1C),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFF757575),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8.0,
                                                                        0.0,
                                                                        8.0,
                                                                        1.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    FFAppState()
                                                                        .Filterdistance
                                                                        .toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'w7vyug83' /* km */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (_model.selectdate ?? true)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 0.0, 15.0, 10.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 70.0,
                                              decoration: BoxDecoration(),
                                              child: Container(
                                                width: 45.0,
                                                height: 60.0,
                                                child: custom_widgets
                                                    .CalendarslideEvent(
                                                  width: 45.0,
                                                  height: 60.0,
                                                  colorPicker:
                                                      Color(0xFFFF0000),
                                                  dateNow: getCurrentTimestamp,
                                                  dateclickwidget:
                                                      FFAppState().dateclick,
                                                  onselect: () async {
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'containerOnPageLoadAnimation2']!),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (!_model.mapon!)
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(),
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: SingleChildScrollView(
                                          controller: _model.columnController,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (functions
                                                      .dataVenuse(
                                                          promotionVenuesRecordList
                                                              .where((e) =>
                                                                  functions.showsearch(
                                                                      _model
                                                                          .textController
                                                                          .text,
                                                                      e
                                                                          .nameVenuse)! &&
                                                                  (e.listpromotion
                                                                          .length !=
                                                                      0) &&
                                                                  (!_model.selectdate!
                                                                      ? functions.checkday(
                                                                          e.listpromotion
                                                                              .toList(),
                                                                          getCurrentTimestamp)!
                                                                      : true))
                                                              .toList(),
                                                          FFAppState()
                                                              .Filterdistance,
                                                          (currentUserDocument
                                                                      ?.loveVenuse
                                                                      .toList() ??
                                                                  [])
                                                              .toList(),
                                                          FFAppState()
                                                              .locationsearch,
                                                          FFAppState()
                                                              .StyleMusic
                                                              .toList(),
                                                          FFAppState()
                                                              .StyleVenuse
                                                              .toList(),
                                                          _model.page,
                                                          _model.mapon,
                                                          _model.lovefilter)
                                                      ?.length ==
                                                  0)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10.0, 5.0, 10.0,
                                                          20.0),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    35.0,
                                                                    0.0,
                                                                    30.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .notifications_none,
                                                              color:
                                                                  Colors.white,
                                                              size: 72.0,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          16.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '555r3j0f' /* No Promotion */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .outfit(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'cbaj3ek2' /* Please reschedule or change th... */,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .plusJakartaSans(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(
                                                                          0xFF8A8A8A),
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              AuthUserStreamWidget(
                                                builder: (context) => Builder(
                                                  builder: (context) {
                                                    final datapromotion = functions
                                                            .dataVenuse(
                                                                promotionVenuesRecordList
                                                                    .where((e) =>
                                                                        functions.showsearch(_model.textController.text, e.nameVenuse)! &&
                                                                        (e.listpromotion.length !=
                                                                            0) &&
                                                                        (!_model.selectdate!
                                                                            ? functions.checkday(
                                                                                e.listpromotion
                                                                                    .toList(),
                                                                                getCurrentTimestamp)!
                                                                            : true))
                                                                    .toList(),
                                                                FFAppState()
                                                                    .Filterdistance,
                                                                (currentUserDocument
                                                                            ?.loveVenuse
                                                                            .toList() ??
                                                                        [])
                                                                    .toList(),
                                                                FFAppState()
                                                                    .locationsearch,
                                                                FFAppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                FFAppState()
                                                                    .StyleVenuse
                                                                    .toList(),
                                                                _model.page,
                                                                _model.mapon,
                                                                _model
                                                                    .lovefilter)
                                                            ?.toList() ??
                                                        [];

                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          datapromotion.length,
                                                          (datapromotionIndex) {
                                                        final datapromotionItem =
                                                            datapromotion[
                                                                datapromotionIndex];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      10.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 250.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            25.0,
                                                                        height:
                                                                            25.0,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          DataVenuesStruct.maybeFromMap(datapromotionItem)!
                                                                              .logo,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 2.5, 0.0, 0.0),
                                                                              child: Text(
                                                                                valueOrDefault<String>(
                                                                                  DataVenuesStruct.maybeFromMap(datapromotionItem)?.nameVenuse,
                                                                                  '-',
                                                                                ).maybeHandleOverflow(
                                                                                  maxChars: 13,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.openSans(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 17.0,
                                                                                      letterSpacing: 0.3,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 7.0, 0.0),
                                                                              child: Container(
                                                                                height: 20.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFF222222),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  shape: BoxShape.rectangle,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 1.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 5.0, 1.0),
                                                                                        child: Text(
                                                                                          valueOrDefault<String>(
                                                                                            formatNumber(
                                                                                              DataVenuesStruct.maybeFromMap(datapromotionItem)?.distance,
                                                                                              formatType: FormatType.custom,
                                                                                              format: '.0',
                                                                                              locale: '',
                                                                                            ),
                                                                                            '-',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: Colors.white,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          '3vjcbwd5' /* km */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.openSans(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: Colors.white,
                                                                                              fontSize: 12.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 7.0, 0.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  if ((currentUserDocument?.loveVenuse.toList() ?? []).contains(DataVenuesStruct.maybeFromMap(datapromotionItem)?.iDVenuse)) {
                                                                                    await currentUserReference!.update({
                                                                                      ...mapToSupabase(
                                                                                        {
                                                                                          'loveVenuse': FieldValue.arrayRemove([
                                                                                            DataVenuesStruct.maybeFromMap(datapromotionItem)?.iDVenuse
                                                                                          ]),
                                                                                        },
                                                                                      ),
                                                                                    });
                                                                                  } else {
                                                                                    await currentUserReference!.update({
                                                                                      ...mapToSupabase(
                                                                                        {
                                                                                          'loveVenuse': FieldValue.arrayUnion([
                                                                                            DataVenuesStruct.maybeFromMap(datapromotionItem)?.iDVenuse
                                                                                          ]),
                                                                                        },
                                                                                      ),
                                                                                    });
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  width: 20.0,
                                                                                  height: 20.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: (currentUserDocument?.loveVenuse.toList() ?? []).contains(DataVenuesStruct.maybeFromMap(datapromotionItem)?.iDVenuse) ? Color(0xFFFF0000) : Color(0xFF222222),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                    shape: BoxShape.rectangle,
                                                                                  ),
                                                                                  child: Stack(
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Icon(
                                                                                          Icons.favorite_sharp,
                                                                                          color: Colors.white,
                                                                                          size: 13.0,
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
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                context.pushNamed(
                                                                                  InVenuseWidget.routeName,
                                                                                  queryParameters: {
                                                                                    'idVenues': serializeParam(
                                                                                      DataVenuesStruct.maybeFromMap(datapromotionItem)?.iDVenuse,
                                                                                      ParamType.SupabaseDocRef,
                                                                                    ),
                                                                                    'distance': serializeParam(
                                                                                      DataVenuesStruct.maybeFromMap(datapromotionItem)?.distance.toString(),
                                                                                      ParamType.String,
                                                                                    ),
                                                                                    'dateclick': serializeParam(
                                                                                      FFAppState().dateclick,
                                                                                      ParamType.DateTime,
                                                                                    ),
                                                                                    'index': serializeParam(
                                                                                      1,
                                                                                      ParamType.int,
                                                                                    ),
                                                                                  }.withoutNulls,
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFFFF0000),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  shape: BoxShape.rectangle,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 1.0, 8.0, 1.5),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'kwswtvn9' /* Book */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: Colors.white,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'phyd3j8s' /* Now */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.openSans(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: Colors.white,
                                                                                              fontSize: 12.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                  ],
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            13.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        RowpromotionWidget(
                                                                      key: Key(
                                                                          'Key9ts_${datapromotionIndex}_of_${datapromotion.length}'),
                                                                      dataPro: promotionVenuesRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              DataVenuesStruct.maybeFromMap(datapromotionItem)?.iDVenuse)
                                                                          .toList()
                                                                          .firstOrNull!
                                                                          .listpromotion,
                                                                      todaycheck:
                                                                          _model
                                                                              .selectdate!,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                              if (functions
                                                      .dataVenuse(
                                                          promotionVenuesRecordList
                                                              .where((e) =>
                                                                  functions.showsearch(
                                                                      _model
                                                                          .textController
                                                                          .text,
                                                                      e
                                                                          .nameVenuse)! &&
                                                                  (e.listpromotion
                                                                          .length !=
                                                                      0) &&
                                                                  (!_model.selectdate!
                                                                      ? functions.checkday(
                                                                          e.listpromotion
                                                                              .toList(),
                                                                          getCurrentTimestamp)!
                                                                      : true))
                                                              .toList(),
                                                          FFAppState()
                                                              .Filterdistance,
                                                          (currentUserDocument
                                                                      ?.loveVenuse
                                                                      .toList() ??
                                                                  [])
                                                              .toList(),
                                                          FFAppState()
                                                              .locationsearch,
                                                          FFAppState()
                                                              .StyleMusic
                                                              .toList(),
                                                          FFAppState()
                                                              .StyleVenuse
                                                              .toList(),
                                                          _model.page,
                                                          true,
                                                          _model.lovefilter)!
                                                      .length >
                                                  20)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 20.0, 0.0, 0.0),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) => Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: InkWell(
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
                                                              if (_model.page !=
                                                                  1) {
                                                                _model.page =
                                                                    _model.page! +
                                                                        -1;
                                                                safeSetState(
                                                                    () {});
                                                                await _model
                                                                    .columnController
                                                                    ?.animateTo(
                                                                  0,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          200),
                                                                  curve: Curves
                                                                      .ease,
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 44.0,
                                                              height: 44.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF1C1C1C),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .chevron_left,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 44.0,
                                                                height: 44.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFFFF0000),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          _model
                                                                              .page
                                                                              ?.toString(),
                                                                          '0',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 20.0,
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
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.page =
                                                                _model.page! +
                                                                    1;
                                                            safeSetState(() {});
                                                            await _model
                                                                .columnController
                                                                ?.animateTo(
                                                              0,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      200),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          },
                                                          child: Container(
                                                            width: 44.0,
                                                            height: 44.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF1C1C1C),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .navigate_next,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 24.0,
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
                                            ].addToEnd(SizedBox(height: 120.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (!_model.mapon!)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (currentUserDocument?.loginVenuesRoom !=
                                        null)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 10.0, 0.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => StreamBuilder<
                                                UserInVenuesRecord>(
                                              stream: UserInVenuesRecord
                                                  .getDocument(
                                                      (currentUserDocument
                                                                  ?.iDROOMVenues
                                                                  .toList() ??
                                                              [])
                                                          .firstOrNull!),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          Colors.transparent,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                final containerUserInVenuesRecord =
                                                    snapshot.data!;

                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                        HomeWidget.routeName);

                                                    FFAppState().StyleVenuse =
                                                        [];
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90.0),
                                                    ),
                                                    child: Container(
                                                      width: 70.0,
                                                      height: 70.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Container(
                                                              width: 70.0,
                                                              height: 70.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: Image
                                                                      .network(
                                                                    valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.logoRoom,
                                                                        ''),
                                                                  ).image,
                                                                ),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x34000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.05, -1.0),
                                                            child: Container(
                                                              width: 25.0,
                                                              height: 25.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          25.0,
                                                                      height:
                                                                          25.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          if (containerUserInVenuesRecord.user.where((e) => functions.checkdate(e.date, getCurrentTimestamp)!).toList().length !=
                                                                              0)
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Container(
                                                                                width: 23.0,
                                                                                height: 23.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFFFF0000),
                                                                                  image: DecorationImage(
                                                                                    fit: BoxFit.cover,
                                                                                    image: Image.network(
                                                                                      '',
                                                                                    ).image,
                                                                                  ),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 4.0,
                                                                                      color: Color(0x4C000000),
                                                                                      offset: Offset(
                                                                                        0.0,
                                                                                        2.0,
                                                                                      ),
                                                                                      spreadRadius: 0.5,
                                                                                    )
                                                                                  ],
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                                                                                        child: Text(
                                                                                          containerUserInVenuesRecord.user.where((e) => functions.checkdate(e.date, getCurrentTimestamp)!).toList().length.toString(),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: 11.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
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
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.05, 1.0),
                                                            child: Container(
                                                              width: 25.0,
                                                              height: 25.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          25.0,
                                                                      height:
                                                                          25.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 27.0,
                                                                              height: 27.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF07B53B),
                                                                                image: DecorationImage(
                                                                                  fit: BoxFit.cover,
                                                                                  image: Image.network(
                                                                                    '',
                                                                                  ).image,
                                                                                ),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    blurRadius: 4.0,
                                                                                    color: Color(0x4C000000),
                                                                                    offset: Offset(
                                                                                      0.0,
                                                                                      2.0,
                                                                                    ),
                                                                                    spreadRadius: 0.0,
                                                                                  )
                                                                                ],
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Stack(
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 0.0, 0.0),
                                                                                      child: Image.network(
                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/ucvx51dhc4gx/message2.png',
                                                                                        width: 16.0,
                                                                                        height: 16.0,
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: wrapWithModel(
                                        model: _model.navBarModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: NavBarWidget(
                                          items: FFAppState().menuItems,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (_model.mapon ?? true)
                              Align(
                                alignment: AlignmentDirectional(-1.0, 1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 273.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xE0000000),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                ),
                              ),
                            if (_model.mapon ?? true)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 335.0,
                                  decoration: BoxDecoration(),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(),
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  17.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
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
                                                              FFAppState()
                                                                      .locationsearch =
                                                                  FFAppState()
                                                                      .MapCenter;
                                                              FFAppState().VenuseSelection = functions
                                                                  .dataVenuseDocref(
                                                                      FFAppState()
                                                                          .Filterdistance,
                                                                      FFAppState()
                                                                          .locationsearch,
                                                                      (currentUserDocument?.loveVenuse.toList() ??
                                                                              [])
                                                                          .toList(),
                                                                      FFAppState()
                                                                          .StyleMusic
                                                                          .toList(),
                                                                      FFAppState()
                                                                          .StyleVenuse
                                                                          .toList(),
                                                                      promotionVenuesRecordList
                                                                          .where((e) =>
                                                                              functions.showsearch(_model.textController.text, e.nameVenuse)! &&
                                                                              (e.listpromotion.length != 0) &&
                                                                              (!_model.selectdate! ? functions.checkday(e.listpromotion.toList(), getCurrentTimestamp)! : true))
                                                                          .toList())
                                                                  ?.elementAtOrNull(0)
                                                                  ?.reference;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xFF757575),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        2.0,
                                                                        15.0,
                                                                        3.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'cywub16n' /* Search this Area */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15.0,
                                                                        letterSpacing:
                                                                            0.3,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  7.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 120.0,
                                                        height: 2.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFFF0000),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        13.0, 0.0, 10.0, 13.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (_model.mapon!) {
                                                          _model.mapon = false;
                                                          safeSetState(() {});
                                                        } else {
                                                          FFAppState().VenuseSelection = functions
                                                              .dataVenuseDocref(
                                                                  FFAppState()
                                                                      .Filterdistance,
                                                                  FFAppState()
                                                                      .locationsearch,
                                                                  (currentUserDocument
                                                                              ?.loveVenuse
                                                                              .toList() ??
                                                                          [])
                                                                      .toList(),
                                                                  FFAppState()
                                                                      .StyleMusic
                                                                      .toList(),
                                                                  FFAppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  promotionVenuesRecordList
                                                                      .where((e) =>
                                                                          functions.showsearch(_model.textController.text, e.nameVenuse)! &&
                                                                          (e.listpromotion.length !=
                                                                              0) &&
                                                                          (!_model.selectdate!
                                                                              ? functions.checkday(e.listpromotion.toList(), getCurrentTimestamp)!
                                                                              : true))
                                                                      .toList())
                                                              ?.elementAtOrNull(0)
                                                              ?.reference;
                                                          safeSetState(() {});
                                                          _model.mapon = true;
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 27.0,
                                                        height: 27.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFFF0000),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.close,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        FlutterFlowIconButton(
                                                          borderColor: Colors
                                                              .transparent,
                                                          borderRadius: 90.0,
                                                          buttonSize: 50.0,
                                                          fillColor:
                                                              Color(0xCC000000),
                                                          icon: Icon(
                                                            Icons.my_location,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 29.0,
                                                          ),
                                                          onPressed: () async {
                                                            currentUserLocationValue =
                                                                await getCurrentUserLocation(
                                                                    defaultLocation:
                                                                        LatLng(
                                                                            0.0,
                                                                            0.0));
                                                            FFAppState()
                                                                    .locationsearch =
                                                                currentUserLocationValue;
                                                            FFAppState().VenuseSelection = functions
                                                                .dataVenuseDocref(
                                                                    FFAppState()
                                                                        .Filterdistance,
                                                                    FFAppState()
                                                                        .locationsearch,
                                                                    (currentUserDocument?.loveVenuse.toList() ??
                                                                            [])
                                                                        .toList(),
                                                                    FFAppState()
                                                                        .StyleMusic
                                                                        .toList(),
                                                                    FFAppState()
                                                                        .StyleVenuse
                                                                        .toList(),
                                                                    promotionVenuesRecordList
                                                                        .where((e) =>
                                                                            functions.showsearch(_model.textController.text, e.nameVenuse)! &&
                                                                            (e.listpromotion.length !=
                                                                                0) &&
                                                                            (!_model.selectdate!
                                                                                ? functions.checkday(e.listpromotion.toList(), getCurrentTimestamp)!
                                                                                : true))
                                                                        .toList())
                                                                ?.elementAtOrNull(0)
                                                                ?.reference;
                                                            safeSetState(() {});
                                                            FFAppState()
                                                                .MoveMap = true;
                                                            safeSetState(() {});
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                AuthUserStreamWidget(
                                                  builder: (context) => Builder(
                                                    builder: (context) {
                                                      final dataVenuseMap = functions
                                                              .dataVenuse(
                                                                  promotionVenuesRecordList
                                                                      .where((e) =>
                                                                          functions.showsearch(_model.textController.text, e.nameVenuse)! &&
                                                                          (e.listpromotion.length !=
                                                                              0) &&
                                                                          (!_model.selectdate!
                                                                              ? functions.checkday(
                                                                                  e.listpromotion
                                                                                      .toList(),
                                                                                  getCurrentTimestamp)!
                                                                              : true))
                                                                      .toList(),
                                                                  FFAppState()
                                                                      .Filterdistance,
                                                                  (currentUserDocument
                                                                              ?.loveVenuse
                                                                              .toList() ??
                                                                          [])
                                                                      .toList(),
                                                                  FFAppState()
                                                                      .locationsearch,
                                                                  FFAppState()
                                                                      .StyleMusic
                                                                      .toList(),
                                                                  FFAppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  _model.page,
                                                                  _model.mapon,
                                                                  _model
                                                                      .lovefilter)
                                                              ?.toList() ??
                                                          [];

                                                      return Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        child: CarouselSlider
                                                            .builder(
                                                          itemCount:
                                                              dataVenuseMap
                                                                  .length,
                                                          itemBuilder: (context,
                                                              dataVenuseMapIndex,
                                                              _) {
                                                            final dataVenuseMapItem =
                                                                dataVenuseMap[
                                                                    dataVenuseMapIndex];
                                                            return Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12.0),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        -1.0),
                                                                child: Stack(
                                                                  children: [
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        context
                                                                            .pushNamed(
                                                                          InVenuseWidget
                                                                              .routeName,
                                                                          queryParameters:
                                                                              {
                                                                            'idVenues':
                                                                                serializeParam(
                                                                              DataVenuesStruct.maybeFromMap(dataVenuseMapItem)?.iDVenuse,
                                                                              ParamType.SupabaseDocRef,
                                                                            ),
                                                                            'distance':
                                                                                serializeParam(
                                                                              DataVenuesStruct.maybeFromMap(dataVenuseMapItem)?.distance.toString(),
                                                                              ParamType.String,
                                                                            ),
                                                                            'dateclick':
                                                                                serializeParam(
                                                                              FFAppState().dateclick,
                                                                              ParamType.DateTime,
                                                                            ),
                                                                            'index':
                                                                                serializeParam(
                                                                              1,
                                                                              ParamType.int,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            double.infinity,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(0.0),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await _model.carouselController?.previousPage(
                                                                                        duration: Duration(milliseconds: 300),
                                                                                        curve: Curves.ease,
                                                                                      );
                                                                                    },
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(0.0),
                                                                                        shape: BoxShape.rectangle,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 11.5, 0.0, 1.0),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                              child: Icon(
                                                                                                Icons.chevron_left_rounded,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                size: 22.0,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                  child: Container(
                                                                                    width: 25.0,
                                                                                    height: 25.0,
                                                                                    clipBehavior: Clip.antiAlias,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Image.network(
                                                                                      DataVenuesStruct.maybeFromMap(dataVenuseMapItem)!.logo,
                                                                                      fit: BoxFit.cover,
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
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            valueOrDefault<String>(
                                                                                              DataVenuesStruct.maybeFromMap(dataVenuseMapItem)?.nameVenuse,
                                                                                              '-',
                                                                                            ).maybeHandleOverflow(
                                                                                              maxChars: 13,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  fontSize: 17.0,
                                                                                                  letterSpacing: 0.3,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(7.0, 5.0, 0.0, 4.0),
                                                                                          child: Container(
                                                                                            height: 20.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: Color(0xFF222222),
                                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                                              shape: BoxShape.rectangle,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 1.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 5.0, 1.0),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        formatNumber(
                                                                                                          DataVenuesStruct.maybeFromMap(dataVenuseMapItem)?.distance,
                                                                                                          formatType: FormatType.custom,
                                                                                                          format: '.0',
                                                                                                          locale: '',
                                                                                                        ),
                                                                                                        '-',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: Colors.white,
                                                                                                            fontSize: 12.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'sf7p9ehg' /* km */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: Colors.white,
                                                                                                          fontSize: 12.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                Expanded(
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await _model.carouselController?.nextPage(
                                                                                          duration: Duration(milliseconds: 300),
                                                                                          curve: Curves.ease,
                                                                                        );
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(0.0),
                                                                                          shape: BoxShape.rectangle,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 11.5, 0.0, 1.0),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 10.0, 0.0),
                                                                                                child: Icon(
                                                                                                  Icons.navigate_next_rounded,
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  size: 22.0,
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
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          carouselController: _model
                                                                  .carouselController ??=
                                                              CarouselSliderController(),
                                                          options:
                                                              CarouselOptions(
                                                            initialPage: max(
                                                                0,
                                                                min(
                                                                    0,
                                                                    dataVenuseMap
                                                                            .length -
                                                                        1)),
                                                            viewportFraction:
                                                                1.0,
                                                            disableCenter: true,
                                                            enlargeCenterPage:
                                                                true,
                                                            enlargeFactor: 0.25,
                                                            enableInfiniteScroll:
                                                                false,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            autoPlay: false,
                                                            onPageChanged:
                                                                (index,
                                                                    _) async {
                                                              _model.carouselCurrentIndex =
                                                                  index;
                                                              if (_model
                                                                      .slide ==
                                                                  true) {
                                                                FFAppState()
                                                                    .VenuseSelection = DataVenuesStruct.maybeFromMap(
                                                                        dataVenuseMap
                                                                            .elementAtOrNull(_model.carouselCurrentIndex))
                                                                    ?.iDVenuse;
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'carouselOnPageLoadAnimation']!);
                                                    },
                                                  ),
                                                ),
                                                if (!(functions.dataVenuse(
                                                            promotionVenuesRecordList
                                                                .where((e) =>
                                                                    functions.showsearch(_model.textController.text, e.nameVenuse)! &&
                                                                    (e.listpromotion.length !=
                                                                        0) &&
                                                                    (!_model.selectdate!
                                                                        ? functions.checkday(
                                                                            e.listpromotion
                                                                                .toList(),
                                                                            getCurrentTimestamp)!
                                                                        : true))
                                                                .toList(),
                                                            FFAppState()
                                                                .Filterdistance,
                                                            (currentUserDocument?.loveVenuse.toList() ?? [])
                                                                .toList(),
                                                            FFAppState()
                                                                .locationsearch,
                                                            FFAppState()
                                                                .StyleMusic
                                                                .toList(),
                                                            FFAppState()
                                                                .StyleVenuse
                                                                .toList(),
                                                            _model.page,
                                                            _model.mapon,
                                                            _model
                                                                .lovefilter) !=
                                                        null &&
                                                    (functions.dataVenuse(
                                                            promotionVenuesRecordList.where((e) => functions.showsearch(_model.textController.text, e.nameVenuse)! && (e.listpromotion.length != 0) && (!_model.selectdate! ? functions.checkday(e.listpromotion.toList(), getCurrentTimestamp)! : true)).toList(),
                                                            FFAppState().Filterdistance,
                                                            (currentUserDocument?.loveVenuse.toList() ?? []).toList(),
                                                            FFAppState().locationsearch,
                                                            FFAppState().StyleMusic.toList(),
                                                            FFAppState().StyleVenuse.toList(),
                                                            _model.page,
                                                            _model.mapon,
                                                            _model.lovefilter))!
                                                        .isNotEmpty))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 35.0,
                                                                0.0, 30.0),
                                                    child: AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_none,
                                                            color: Colors.white,
                                                            size: 72.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        16.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'fxsoj2vd' /* No Promotion */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .outfit(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        4.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'ijdk14y1' /* Please reschedule or change th... */,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .plusJakartaSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFF8A8A8A),
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
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
                            if (_model.mapon! &&
                                (FFAppState().VenuseSelection?.id != null &&
                                    FFAppState().VenuseSelection?.id != ''))
                              Align(
                                alignment: AlignmentDirectional(-1.0, 1.0),
                                child: Container(
                                  height: 220.0,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    child: wrapWithModel(
                                      model: _model.rowpromotionModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      updateOnChange: true,
                                      child: RowpromotionWidget(
                                        dataPro: promotionVenuesRecordList
                                            .where((e) =>
                                                e.reference ==
                                                FFAppState().VenuseSelection)
                                            .toList()
                                            .firstOrNull!
                                            .listpromotion,
                                        todaycheck: _model.selectdate!,
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'rowpromotionOnPageLoadAnimation']!),
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
            ),
          ),
        );
      },
    );
  }
}
