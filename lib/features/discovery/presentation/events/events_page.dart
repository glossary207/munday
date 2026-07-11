import 'package:provider/provider.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/shared/widgets/dialogs/filter_widget.dart';
import '/shared/widgets/misc/joinroom_widget.dart';
import '/shared/widgets/layout/nav_bar_widget.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart' as custom_widgets;
import '/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:munday/core/routing/serialization_util.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'events_model.dart';
import 'package:munday/core/theme/theme.dart';

const _kEventsFallbackPosterUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';

const _kEventsFallbackProfileUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';

String _safeEventsImageUrl(String? url, {required String fallback}) {
  final normalized = url?.trim();
  if (normalized == null || normalized.isEmpty) {
    return fallback;
  }

  final uri = Uri.tryParse(normalized);
  if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
    return fallback;
  }

  return normalized;
}

class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  static String routeName = 'Events';
  static String routePath = 'events';

  @override
  ConsumerState<EventsPage> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends ConsumerState<EventsPage>
    with TickerProviderStateMixin {
  late EventsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = EventsModel()..internalInit(context);

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue = await getCurrentUserLocation(
        defaultLocation: LatLng(0.0, 0.0),
      );
      context.appState.locationsearch = currentUserLocationValue;
      context.appState.dateclick = getCurrentTimestamp;
      context.appState.MoveMap = false;
      safeSetState(() {});
      _model.mapOn = false;
      _model.wide = MediaQuery.sizeOf(context).width;
      safeSetState(() {});
    });

    getCurrentUserLocation(
      defaultLocation: LatLng(0.0, 0.0),
      cached: true,
    ).then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.textFieldFocusNode!.addListener(() async {
      _model.page = 1;
      _model.textinput = true;
      safeSetState(() {});
    });
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
      'columnOnPageLoadAnimation': AnimationInfo(
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
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 50.0),
            end: Offset(0.0, 0.0),
          ),
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
            duration: 400.0.ms,
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
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where(
        (anim) =>
            anim.trigger == AnimationTrigger.onActionTrigger ||
            !anim.applyInitialState,
      ),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<_EventDetailData> _loadEventDetailData(
    DataEventsStruct eventData,
  ) async {
    EventsRecord? eventRecord;
    VenuesRecord? venueRecord;

    final eventRef = eventData.docRef;
    if (eventRef != null) {
      try {
        eventRecord = await EventsRecord.getDocumentOnce(eventRef);
      } catch (error) {
        debugPrint('Unable to load selected event: $error');
      }
    }

    final venueRef = eventData.iDVenuse ?? eventRecord?.iDVenues;
    if (venueRef != null) {
      try {
        venueRecord = await VenuesRecord.getDocumentOnce(venueRef);
      } catch (error) {
        debugPrint('Unable to load event venue: $error');
      }
    }

    return _EventDetailData(
      eventData: eventData,
      eventRecord: eventRecord,
      venueRecord: venueRecord,
    );
  }

  Future<void> _showEventDetailSheet(DataEventsStruct? eventData) async {
    if (eventData == null || eventData.nameStore == '007') {
      return;
    }

    final detailFuture = _loadEventDetailData(eventData);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0xB3000000),
      builder: (bottomSheetContext) {
        return _EventDetailSheet(
          detailFuture: detailFuture,
          fallbackEventData: eventData,
          onViewVenue: (detailData) {
            Navigator.of(bottomSheetContext).pop();

            final venueRef = detailData.venueRef;
            if (venueRef == null) {
              return;
            }

            context.pushNamed(
              InVenusePage.routeName,
              queryParameters: {
                'idVenues': serializeParam(venueRef, ParamType.SupabaseDocRef),
                'distance': serializeParam(
                  detailData.distanceValue,
                  ParamType.String,
                ),
                'dateclick': serializeParam(
                  detailData.eventDate ?? context.appState.dateclick,
                  ParamType.DateTime,
                ),
                'index': serializeParam(0, ParamType.int),
              }.withoutNulls,
            );
          },
        );
      },
    );

    if (mounted) {
      safeSetState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();
    // Removed blocking location check to allow UI to render immediately
    // if (currentUserLocationValue == null) { ... }

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
          bottom: false,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                StreamBuilder<List<EventsRecord>>(
                  stream: queryEventsRecord(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<EventsRecord> homeBodyEventsRecordList =
                        snapshot.data!;
                    print(
                      "DEBUG: homeBodyEventsRecordList length = ${homeBodyEventsRecordList.length}",
                    );

                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 50.0,
                            color: Color(0xC0000000),
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            if (_model.mapOn)
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: custom_widgets.MapEvent(
                                      width: double.infinity,
                                      height: double.infinity,
                                      zoomStart: 10.5,
                                      zoomMin: 9.0,
                                      zoomMax: 18.0,
                                      markerIcon:
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/4ukflr1mlkc1/beer_(3).png',
                                      markerMeIcon:
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/lkzyscp6kupj/map-marker_(2).png',
                                      compassEnabled: true,
                                      items: functions.dataEventDocRef(
                                        context.appState.Filterdistance,
                                        context.appState.locationsearch,
                                        (currentUserDocument?.loveEvent ?? [])
                                            .toList(),
                                        _model.stylemusic.toList(),
                                        homeBodyEventsRecordList
                                            .where(
                                              (e) => functions.showsearch(
                                                _model.textController.text,
                                                functions.addName(
                                                  e.nameArtise.toList(),
                                                ),
                                              )!,
                                            )
                                            .toList(),
                                        _model.selectdate,
                                        context.appState.dateclick,
                                      ),
                                      itemClick:
                                          context.appState.EventSelection,
                                      locationStart:
                                          currentUserLocationValue ??
                                          LatLng(0.0, 0.0),
                                      currentLocation:
                                          context.appState.locationsearch,
                                      makerSelectedIcon:
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/ugva4ht8jron/beer_(2).png',
                                      moveMapCondition:
                                          context.appState.MoveMap,
                                      radian: context.appState.Filterdistance,
                                      whenSelect: () async {
                                        _model.slide = false;
                                        safeSetState(() {});
                                        await _model.carouselController
                                            ?.animateToPage(
                                              functions.searchIndexEvent(
                                                functions
                                                    .dataEventDocRef(
                                                      context
                                                          .appState
                                                          .Filterdistance,
                                                      context
                                                          .appState
                                                          .locationsearch,
                                                      (currentUserDocument
                                                                  ?.loveEvent ??
                                                              [])
                                                          .toList(),
                                                      _model.stylemusic
                                                          .toList(),
                                                      homeBodyEventsRecordList
                                                          .where(
                                                            (
                                                              e,
                                                            ) => functions.showsearch(
                                                              _model
                                                                  .textController
                                                                  .text,
                                                              functions.addName(
                                                                e.nameArtise
                                                                    .toList(),
                                                              ),
                                                            )!,
                                                          )
                                                          .toList(),
                                                      _model.selectdate,
                                                      context
                                                          .appState
                                                          .dateclick,
                                                    )
                                                    ?.toList(),
                                                context.appState.EventSelection,
                                              )!,
                                              duration: Duration(
                                                milliseconds: 500,
                                              ),
                                              curve: Curves.ease,
                                            );
                                        _model.slide = true;
                                        safeSetState(() {});
                                      },
                                      whenSetStyleSuccess: () async {},
                                    ),
                                  ),
                                ),
                              ),
                            Container(
                              width: double.infinity,
                              height: _model.selectdate ? 210.0 : 170.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
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
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                      Colors.black,
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                ),
                              ),
                            ),
                            if (!_model.mapOn)
                              Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    145.0,
                                    0.0,
                                    0.0,
                                  ),
                                  child: SingleChildScrollView(
                                    controller: _model.columnController,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (_model.selectdate && !_model.mapOn)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                  15.0,
                                                  0.0,
                                                  15.0,
                                                  5.0,
                                                ),
                                            child:
                                                Container(
                                                  width: double.infinity,
                                                  height: 70.0,
                                                  decoration: BoxDecoration(),
                                                  child: Container(
                                                    width: 45.0,
                                                    height: 60.0,
                                                    child:
                                                        custom_widgets.CalendarslideEvent(
                                                          width: 45.0,
                                                          height: 60.0,
                                                          colorPicker: Color(
                                                            0xFFFF0000,
                                                          ),
                                                          dateNow:
                                                              getCurrentTimestamp,
                                                          dateclickwidget:
                                                              AppState()
                                                                  .dateclick,
                                                          onselect: () async {
                                                            safeSetState(() {});
                                                          },
                                                        ),
                                                  ),
                                                ).animateOnPageLoad(
                                                  animationsMap['containerOnPageLoadAnimation1']!,
                                                ),
                                          ),
                                        if (functions
                                                .dataEvent(
                                                  context
                                                      .appState
                                                      .Filterdistance,
                                                  homeBodyEventsRecordList
                                                      .where(
                                                        (e) => functions
                                                            .showsearch(
                                                              _model
                                                                  .textController
                                                                  .text,
                                                              functions.addName(
                                                                e.nameArtise
                                                                    .toList(),
                                                              ),
                                                            )!,
                                                      )
                                                      .toList(),
                                                  context
                                                      .appState
                                                      .locationsearch,
                                                  _model.stylemusic.toList(),
                                                  (currentUserDocument
                                                              ?.loveEvent
                                                              ?.toList() ??
                                                          [])
                                                      .toList(),
                                                  context.appState.StyleVenuse
                                                      .toList(),
                                                  _model.page,
                                                  _model.mapOn,
                                                  _model.selectdate,
                                                  context.appState.dateclick,
                                                  false,
                                                  _model.lovefilter,
                                                )
                                                ?.length ==
                                            0)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                  10.0,
                                                  0.0,
                                                  10.0,
                                                  0.0,
                                                ),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.0,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        40.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Column(
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
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              5.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child:
                                                            currentUserReference ==
                                                                null
                                                            ? Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_sf7y15sd,
                                                                    style: Theme.of(context).textTheme.headlineMedium!.override(
                                                                      font: GoogleFonts.outfit(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.headlineMedium!.fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          30.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .headlineMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : StreamBuilder<
                                                                UsersRecord
                                                              >(
                                                                stream: UsersRecord.getDocument(
                                                                  currentUserReference!,
                                                                ),
                                                                builder:
                                                                    (
                                                                      context,
                                                                      snapshot,
                                                                    ) {
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child: SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child: CircularProgressIndicator(
                                                                              valueColor:
                                                                                  AlwaysStoppedAnimation<
                                                                                    Color
                                                                                  >(
                                                                                    Colors.transparent,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      final textUsersRecord =
                                                                          snapshot
                                                                              .data!;
                                                                      return Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_sf7y15sd,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.headlineMedium!.override(
                                                                              font: GoogleFonts.outfit(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.headlineMedium!.fontStyle,
                                                                              ),
                                                                              color: Colors.white,
                                                                              fontSize: 30.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.headlineMedium!.fontStyle,
                                                                            ),
                                                                      );
                                                                    },
                                                              ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              25.0,
                                                              4.0,
                                                              25.0,
                                                              0.0,
                                                            ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.k_z4axt11t,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .labelMedium!
                                                              .override(
                                                                font: GoogleFonts.plusJakartaSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .labelMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                  0xFFBCBCBC,
                                                                ),
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .labelMedium!
                                                                        .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              10.0,
                                                              7.0,
                                                              0.0,
                                                            ),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            if (_model
                                                                .selectdate) {
                                                              _model.selectdate =
                                                                  false;
                                                              _model.page = 1;
                                                              safeSetState(
                                                                () {},
                                                              );
                                                              await _model
                                                                  .columnController
                                                                  ?.animateTo(
                                                                    0,
                                                                    duration: Duration(
                                                                      milliseconds:
                                                                          300,
                                                                    ),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                            } else {
                                                              _model.selectdate =
                                                                  true;
                                                              _model.page = 1;
                                                              safeSetState(
                                                                () {},
                                                              );
                                                              await _model
                                                                  .columnController
                                                                  ?.animateTo(
                                                                    0,
                                                                    duration: Duration(
                                                                      milliseconds:
                                                                          300,
                                                                    ),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                            }
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  _model
                                                                      .selectdate
                                                                  ? Color(
                                                                      0xFFFF0000,
                                                                    )
                                                                  : Color(
                                                                      0xFF1C1C1C,
                                                                    ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    20.0,
                                                                  ),
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              border: Border.all(
                                                                color:
                                                                    _model
                                                                        .selectdate
                                                                    ? Color(
                                                                        0xFFFF0000,
                                                                      )
                                                                    : Color(
                                                                        0xFF1C1C1C,
                                                                      ),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                        15.0,
                                                                        4.0,
                                                                        6.0,
                                                                        5.0,
                                                                      ),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_wgbetsw7,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        15.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 16.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (functions
                                                              .dataEvent(
                                                                AppState()
                                                                    .Filterdistance,
                                                                homeBodyEventsRecordList
                                                                    .where(
                                                                      (
                                                                        e,
                                                                      ) => functions.showsearch(
                                                                        _model
                                                                            .textController
                                                                            .text,
                                                                        functions.addName(
                                                                          e.nameArtise
                                                                              .toList(),
                                                                        ),
                                                                      )!,
                                                                    )
                                                                    .toList(),
                                                                AppState()
                                                                    .locationsearch,
                                                                _model
                                                                    .stylemusic
                                                                    .toList(),
                                                                (currentUserDocument
                                                                            ?.loveEvent
                                                                            ?.toList() ??
                                                                        [])
                                                                    .toList(),
                                                                AppState()
                                                                    .StyleVenuse
                                                                    .toList(),
                                                                _model.page,
                                                                true,
                                                                false,
                                                                AppState()
                                                                    .dateclick,
                                                                false,
                                                                _model
                                                                    .lovefilter,
                                                              )!
                                                              .length >
                                                          0)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                10.0,
                                                                80.0,
                                                                10.0,
                                                                7.0,
                                                              ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Flexible(
                                                                child: Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 2.0,
                                                                  decoration: BoxDecoration(
                                                                    color: Color(
                                                                      0xFF1C1C1C,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      2.0,
                                                                    ),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_gfa27afd,
                                                                  style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 2.0,
                                                                  decoration: BoxDecoration(
                                                                    color: Color(
                                                                      0xFF1C1C1C,
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
                                              ),
                                            ),
                                          ),
                                        if (functions
                                                .dataEvent(
                                                  context
                                                      .appState
                                                      .Filterdistance,
                                                  homeBodyEventsRecordList
                                                      .where(
                                                        (e) => functions
                                                            .showsearch(
                                                              _model
                                                                  .textController
                                                                  .text,
                                                              functions.addName(
                                                                e.nameArtise
                                                                    .toList(),
                                                              ),
                                                            )!,
                                                      )
                                                      .toList(),
                                                  context
                                                      .appState
                                                      .locationsearch,
                                                  _model.stylemusic.toList(),
                                                  (currentUserDocument
                                                              ?.loveEvent
                                                              ?.toList() ??
                                                          [])
                                                      .toList(),
                                                  context.appState.StyleVenuse
                                                      .toList(),
                                                  _model.page,
                                                  _model.mapOn,
                                                  _model.selectdate,
                                                  context.appState.dateclick,
                                                  false,
                                                  _model.lovefilter,
                                                )
                                                ?.length ==
                                            0)
                                          Align(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                0.0,
                                                -1.0,
                                              ),
                                              child: Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                      5.0,
                                                      1.0,
                                                      5.0,
                                                      0.0,
                                                    ),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => Builder(
                                                    builder: (context) {
                                                      final dataEvents =
                                                          functions
                                                              .dataEvent(
                                                                AppState()
                                                                    .Filterdistance,
                                                                homeBodyEventsRecordList
                                                                    .where(
                                                                      (
                                                                        e,
                                                                      ) => functions.showsearch(
                                                                        _model
                                                                            .textController
                                                                            .text,
                                                                        functions.addName(
                                                                          e.nameArtise
                                                                              .toList(),
                                                                        ),
                                                                      )!,
                                                                    )
                                                                    .toList(),
                                                                AppState()
                                                                    .locationsearch,
                                                                _model
                                                                    .stylemusic
                                                                    .toList(),
                                                                (currentUserDocument
                                                                            ?.loveEvent
                                                                            ?.toList() ??
                                                                        [])
                                                                    .toList(),
                                                                AppState()
                                                                    .StyleVenuse
                                                                    .toList(),
                                                                _model.page,
                                                                _model.mapOn,
                                                                false,
                                                                AppState()
                                                                    .dateclick,
                                                                false,
                                                                _model
                                                                    .lovefilter,
                                                              )
                                                              ?.toList() ??
                                                          [];

                                                      return Wrap(
                                                        spacing: 1.0,
                                                        runSpacing: 1.0,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                        direction:
                                                            Axis.horizontal,
                                                        runAlignment:
                                                            WrapAlignment.start,
                                                        verticalDirection:
                                                            VerticalDirection
                                                                .down,
                                                        clipBehavior: Clip.none,
                                                        children: List.generate(dataEvents.length, (
                                                          dataEventsIndex,
                                                        ) {
                                                          final dataEventsItem =
                                                              dataEvents[dataEventsIndex];
                                                          return Opacity(
                                                            opacity:
                                                                DataEventsStruct.maybeFromMap(
                                                                      dataEventsItem,
                                                                    )?.nameStore ==
                                                                    '007'
                                                                ? 0.0
                                                                : 1.0,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                    5.0,
                                                                  ),
                                                              child: Container(
                                                                width:
                                                                    MediaQuery.sizeOf(
                                                                      context,
                                                                    ).width *
                                                                    0.446,
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        10.0,
                                                                      ),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
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
                                                                            await _showEventDetailSheet(
                                                                              DataEventsStruct.maybeFromMap(
                                                                                dataEventsItem,
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(
                                                                                  context,
                                                                                ).width *
                                                                                0.444,
                                                                            height:
                                                                                valueOrDefault<
                                                                                  double
                                                                                >(
                                                                                  functions.posterscale(
                                                                                    _model.wide,
                                                                                    false,
                                                                                  ),
                                                                                  250.0,
                                                                                ),
                                                                            decoration: BoxDecoration(
                                                                              color: Color(
                                                                                0xFF161616,
                                                                              ),
                                                                              image: DecorationImage(
                                                                                fit: BoxFit.cover,
                                                                                image: Image.network(
                                                                                  _safeEventsImageUrl(
                                                                                    DataEventsStruct.maybeFromMap(
                                                                                      dataEventsItem,
                                                                                    )?.poster,
                                                                                    fallback: _kEventsFallbackPosterUrl,
                                                                                  ),
                                                                                ).image,
                                                                              ),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(
                                                                                  10.0,
                                                                                ),
                                                                                bottomRight: Radius.circular(
                                                                                  0.0,
                                                                                ),
                                                                                topLeft: Radius.circular(
                                                                                  10.0,
                                                                                ),
                                                                                topRight: Radius.circular(
                                                                                  10.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            child: Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          10.0,
                                                                                          10.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Container(
                                                                                          width: 42.0,
                                                                                          constraints: const BoxConstraints(
                                                                                            minHeight: 42.0,
                                                                                          ),
                                                                                          decoration: BoxDecoration(
                                                                                            color: Color(
                                                                                              0xFFFF0000,
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  0.0,
                                                                                                  3.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  functions
                                                                                                      .dateEventday(
                                                                                                        DataEventsStruct.maybeFromMap(
                                                                                                          dataEventsItem,
                                                                                                        )?.date,
                                                                                                      )
                                                                                                      .toString(),
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        color:
                                                                                                            Theme.of(
                                                                                                                  context,
                                                                                                                )
                                                                                                                .extension<
                                                                                                                  CustomColors
                                                                                                                >()!
                                                                                                                .primaryText,
                                                                                                        fontSize: 17.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                        lineHeight: 1.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  0.0,
                                                                                                  2.0,
                                                                                                  0.0,
                                                                                                  2.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  valueOrDefault<
                                                                                                    String
                                                                                                  >(
                                                                                                    functions.dateMonthTH(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventsItem,
                                                                                                      )?.date,
                                                                                                    ),
                                                                                                    'ไม่ระบุ',
                                                                                                  ),
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontWeight,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        color:
                                                                                                            Theme.of(
                                                                                                                  context,
                                                                                                                )
                                                                                                                .extension<
                                                                                                                  CustomColors
                                                                                                                >()!
                                                                                                                .primaryText,
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontWeight,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                        lineHeight: 1.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        0.0,
                                                                                        0.0,
                                                                                        5.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          if (!loggedIn) {
                                                                                            context.pushNamed(
                                                                                              PhoneLoginPage.routeName,
                                                                                            );
                                                                                            return;
                                                                                          }
                                                                                          if ((currentUserDocument?.loveEvent?.toList() ??
                                                                                                  [])
                                                                                              .contains(
                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                  dataEventsItem,
                                                                                                )?.docRef,
                                                                                              )) {
                                                                                            await currentUserReference!.update(
                                                                                              {
                                                                                                ...mapToSupabase(
                                                                                                  {
                                                                                                    'loveEvent': FieldValue.arrayRemove(
                                                                                                      [
                                                                                                        DataEventsStruct.maybeFromMap(
                                                                                                          dataEventsItem,
                                                                                                        )?.docRef,
                                                                                                      ],
                                                                                                    ),
                                                                                                  },
                                                                                                ),
                                                                                              },
                                                                                            );
                                                                                          } else {
                                                                                            await currentUserReference!.update(
                                                                                              {
                                                                                                ...mapToSupabase(
                                                                                                  {
                                                                                                    'loveEvent': FieldValue.arrayUnion(
                                                                                                      [
                                                                                                        DataEventsStruct.maybeFromMap(
                                                                                                          dataEventsItem,
                                                                                                        )?.docRef,
                                                                                                      ],
                                                                                                    ),
                                                                                                  },
                                                                                                ),
                                                                                              },
                                                                                            );
                                                                                          }
                                                                                        },
                                                                                        child: Container(
                                                                                          width: 38.0,
                                                                                          height: 38.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Color(
                                                                                              0x22000000,
                                                                                            ),
                                                                                            shape: BoxShape.circle,
                                                                                          ),
                                                                                          child: Stack(
                                                                                            children: [
                                                                                              if (!(currentUserDocument?.loveEvent?.toList() ??
                                                                                                      [])
                                                                                                  .contains(
                                                                                                    DataEventsStruct.maybeFromMap(
                                                                                                      dataEventsItem,
                                                                                                    )?.docRef,
                                                                                                  ))
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                      0.0,
                                                                                                      1.5,
                                                                                                      0.0,
                                                                                                      0.0,
                                                                                                    ),
                                                                                                    child: FaIcon(
                                                                                                      FontAwesomeIcons.heart,
                                                                                                      color: Color(
                                                                                                        0xFFFDFDFD,
                                                                                                      ),
                                                                                                      size: 23.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              if ((currentUserDocument?.loveEvent?.toList() ??
                                                                                                      [])
                                                                                                  .contains(
                                                                                                    DataEventsStruct.maybeFromMap(
                                                                                                      dataEventsItem,
                                                                                                    )?.docRef,
                                                                                                  ))
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                      0.0,
                                                                                                      1.5,
                                                                                                      0.0,
                                                                                                      0.0,
                                                                                                    ),
                                                                                                    child: FaIcon(
                                                                                                      FontAwesomeIcons.solidHeart,
                                                                                                      color: Color(
                                                                                                        0xFFFF0000,
                                                                                                      ),
                                                                                                      size: 23.0,
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
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    width: double.infinity,
                                                                                    height: double.infinity,
                                                                                    decoration: BoxDecoration(),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: double.infinity,
                                                                                  height:
                                                                                      MediaQuery.sizeOf(
                                                                                        context,
                                                                                      ).height *
                                                                                      0.22,
                                                                                  decoration: BoxDecoration(
                                                                                    gradient: LinearGradient(
                                                                                      colors: [
                                                                                        Colors.transparent,
                                                                                        Color(
                                                                                          0xED000000,
                                                                                        ),
                                                                                      ],
                                                                                      stops: [
                                                                                        0.0,
                                                                                        1.0,
                                                                                      ],
                                                                                      begin: AlignmentDirectional(
                                                                                        0.0,
                                                                                        -1.0,
                                                                                      ),
                                                                                      end: AlignmentDirectional(
                                                                                        0,
                                                                                        1.0,
                                                                                      ),
                                                                                    ),
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(
                                                                                        10.0,
                                                                                      ),
                                                                                      bottomRight: Radius.circular(
                                                                                        0.0,
                                                                                      ),
                                                                                      topLeft: Radius.circular(
                                                                                        0.0,
                                                                                      ),
                                                                                      topRight: Radius.circular(
                                                                                        0.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                      5.0,
                                                                                      0.0,
                                                                                      5.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(
                                                                                            -1.0,
                                                                                            0.0,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              5.0,
                                                                                              0.0,
                                                                                              0.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Text(
                                                                                              valueOrDefault<
                                                                                                String
                                                                                              >(
                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                  dataEventsItem,
                                                                                                )?.nameArtise.firstOrNull,
                                                                                                'ไม่ระบุ',
                                                                                              ),
                                                                                              maxLines: 18,
                                                                                              style:
                                                                                                  Theme.of(
                                                                                                    context,
                                                                                                  ).textTheme.bodyMedium!.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.fontStyle,
                                                                                                    ),
                                                                                                    color:
                                                                                                        Theme.of(
                                                                                                              context,
                                                                                                            )
                                                                                                            .extension<
                                                                                                              CustomColors
                                                                                                            >()!
                                                                                                            .primaryText,
                                                                                                    fontSize: 18.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: Theme.of(
                                                                                                      context,
                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                            0.0,
                                                                                            0.0,
                                                                                            0.0,
                                                                                            5.0,
                                                                                          ),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    5.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    2.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<
                                                                                                      String
                                                                                                    >(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventsItem,
                                                                                                      )?.nameStore,
                                                                                                      'ไม่ระบุ',
                                                                                                    ),
                                                                                                    maxLines: 18,
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          color: Color(
                                                                                                            0xFFA1A1A1,
                                                                                                          ),
                                                                                                          fontSize: 14.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(
                                                                                            1.0,
                                                                                            0.0,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              5.0,
                                                                                              0.0,
                                                                                              5.0,
                                                                                              5.0,
                                                                                            ),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<
                                                                                                      String
                                                                                                    >(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventsItem,
                                                                                                      )?.distance.toString(),
                                                                                                      'ไม่ระบุ',
                                                                                                    ),
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          color: Color(
                                                                                                            0xFFE8E8E8,
                                                                                                          ),
                                                                                                          fontSize: 13.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    5.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!.k_27dxtl2j,
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          color: Color(
                                                                                                            0xFFE8E8E8,
                                                                                                          ),
                                                                                                          fontSize: 13.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  child: Container(
                                                                                                    width: 100.0,
                                                                                                    height: 1.0,
                                                                                                    decoration: BoxDecoration(),
                                                                                                  ),
                                                                                                ),
                                                                                                Image.network(
                                                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                  width: 16.0,
                                                                                                  height: 16.0,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                      8.0,
                                                                                                      0.0,
                                                                                                      0.0,
                                                                                                      0.0,
                                                                                                    ),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<
                                                                                                        String
                                                                                                      >(
                                                                                                        DataEventsStruct.maybeFromMap(
                                                                                                          dataEventsItem,
                                                                                                        )?.capacity.toString(),
                                                                                                        'ไม่ระบุ',
                                                                                                      ),
                                                                                                      style:
                                                                                                          Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                            ),
                                                                                                            color: Color(
                                                                                                              0xFFE8E8E8,
                                                                                                            ),
                                                                                                            fontSize: 13.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    2.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!.k_3fd0zq8r,
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          color: Color(
                                                                                                            0xFFE8E8E8,
                                                                                                          ),
                                                                                                          fontSize: 14.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    2.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<
                                                                                                      String
                                                                                                    >(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventsItem,
                                                                                                      )?.maxCapacity.toString(),
                                                                                                      'ไม่ระบุ',
                                                                                                    ),
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          color: Color(
                                                                                                            0xFFE8E8E8,
                                                                                                          ),
                                                                                                          fontSize: 13.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
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
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            if (!DataEventsStruct.maybeFromMap(
                                                                              dataEventsItem,
                                                                            )!.free)
                                                                              Flexible(
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(
                                                                                    1.0,
                                                                                    1.0,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                      0.0,
                                                                                      0.0,
                                                                                      1.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        gradient: LinearGradient(
                                                                                          colors: [
                                                                                            Color(
                                                                                              0xFF411010,
                                                                                            ),
                                                                                            Color(
                                                                                              0xFFDB0000,
                                                                                            ),
                                                                                            Color(
                                                                                              0xFFFF0000,
                                                                                            ),
                                                                                          ],
                                                                                          stops: [
                                                                                            0.0,
                                                                                            0.2,
                                                                                            1.0,
                                                                                          ],
                                                                                          begin: AlignmentDirectional(
                                                                                            0.0,
                                                                                            -1.0,
                                                                                          ),
                                                                                          end: AlignmentDirectional(
                                                                                            0,
                                                                                            1.0,
                                                                                          ),
                                                                                        ),
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(
                                                                                            10.0,
                                                                                          ),
                                                                                          bottomRight: Radius.circular(
                                                                                            10.0,
                                                                                          ),
                                                                                          topLeft: Radius.circular(
                                                                                            0.0,
                                                                                          ),
                                                                                          topRight: Radius.circular(
                                                                                            0.0,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        children: [
                                                                                          Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  10.0,
                                                                                                  2.0,
                                                                                                  10.0,
                                                                                                  2.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  valueOrDefault<
                                                                                                    String
                                                                                                  >(
                                                                                                    DataEventsStruct.maybeFromMap(
                                                                                                      dataEventsItem,
                                                                                                    )?.priceDetail,
                                                                                                    '1,200 ฿',
                                                                                                  ),
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.3,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            if (DataEventsStruct.maybeFromMap(
                                                                                  dataEventsItem,
                                                                                )?.free ??
                                                                                true)
                                                                              Flexible(
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(
                                                                                    1.0,
                                                                                    1.0,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                      0.0,
                                                                                      0.0,
                                                                                      1.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        gradient: LinearGradient(
                                                                                          colors: [
                                                                                            Color(
                                                                                              0xFF1E4110,
                                                                                            ),
                                                                                            Color(
                                                                                              0xFF58BB2F,
                                                                                            ),
                                                                                            Color(
                                                                                              0xFF58BB2F,
                                                                                            ),
                                                                                          ],
                                                                                          stops: [
                                                                                            0.0,
                                                                                            0.2,
                                                                                            1.0,
                                                                                          ],
                                                                                          begin: AlignmentDirectional(
                                                                                            0.0,
                                                                                            -1.0,
                                                                                          ),
                                                                                          end: AlignmentDirectional(
                                                                                            0,
                                                                                            1.0,
                                                                                          ),
                                                                                        ),
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(
                                                                                            10.0,
                                                                                          ),
                                                                                          bottomRight: Radius.circular(
                                                                                            10.0,
                                                                                          ),
                                                                                          topLeft: Radius.circular(
                                                                                            0.0,
                                                                                          ),
                                                                                          topRight: Radius.circular(
                                                                                            0.0,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: [
                                                                                          Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  10.0,
                                                                                                  2.0,
                                                                                                  10.0,
                                                                                                  2.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!.k_l73fai7v,
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.3,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Align(
                                          child: Align(
                                            alignment: AlignmentDirectional(
                                              0.0,
                                              -1.0,
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    5.0,
                                                    1.0,
                                                    5.0,
                                                    0.0,
                                                  ),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Builder(
                                                  builder: (context) {
                                                    final dataEvents =
                                                        functions
                                                            .dataEvent(
                                                              AppState()
                                                                  .Filterdistance,
                                                              homeBodyEventsRecordList
                                                                  .where(
                                                                    (
                                                                      e,
                                                                    ) => functions.showsearch(
                                                                      _model
                                                                          .textController
                                                                          .text,
                                                                      functions.addName(
                                                                        e.nameArtise
                                                                            .toList(),
                                                                      ),
                                                                    )!,
                                                                  )
                                                                  .toList(),
                                                              AppState()
                                                                  .locationsearch,
                                                              _model.stylemusic
                                                                  .toList(),
                                                              (currentUserDocument
                                                                          ?.loveEvent
                                                                          ?.toList() ??
                                                                      [])
                                                                  .toList(),
                                                              AppState()
                                                                  .StyleVenuse
                                                                  .toList(),
                                                              _model.page,
                                                              _model.mapOn,
                                                              _model.selectdate,
                                                              AppState()
                                                                  .dateclick,
                                                              false,
                                                              _model.lovefilter,
                                                            )
                                                            ?.toList() ??
                                                        [];

                                                    return Wrap(
                                                      spacing: 1.0,
                                                      runSpacing: 1.0,
                                                      alignment:
                                                          WrapAlignment.start,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      direction:
                                                          Axis.horizontal,
                                                      runAlignment:
                                                          WrapAlignment.start,
                                                      verticalDirection:
                                                          VerticalDirection
                                                              .down,
                                                      clipBehavior: Clip.none,
                                                      children: List.generate(dataEvents.length, (
                                                        dataEventsIndex,
                                                      ) {
                                                        final dataEventsItem =
                                                            dataEvents[dataEventsIndex];
                                                        return Opacity(
                                                          opacity:
                                                              DataEventsStruct.maybeFromMap(
                                                                    dataEventsItem,
                                                                  )?.nameStore ==
                                                                  '007'
                                                              ? 0.0
                                                              : 1.0,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  5.0,
                                                                ),
                                                            child: Container(
                                                              width:
                                                                  MediaQuery.sizeOf(
                                                                    context,
                                                                  ).width *
                                                                  0.446,
                                                              decoration:
                                                                  BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          10.0,
                                                                        ),
                                                                  ),
                                                              child: Stack(
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
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
                                                                          await _showEventDetailSheet(
                                                                            DataEventsStruct.maybeFromMap(
                                                                              dataEventsItem,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(
                                                                                context,
                                                                              ).width *
                                                                              0.444,
                                                                          height:
                                                                              valueOrDefault<
                                                                                double
                                                                              >(
                                                                                functions.posterscale(
                                                                                  _model.wide,
                                                                                  false,
                                                                                ),
                                                                                250.0,
                                                                              ),
                                                                          decoration: BoxDecoration(
                                                                            color: Color(
                                                                              0xFF161616,
                                                                            ),
                                                                            image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: Image.network(
                                                                                _safeEventsImageUrl(
                                                                                  DataEventsStruct.maybeFromMap(
                                                                                    dataEventsItem,
                                                                                  )?.poster,
                                                                                  fallback: _kEventsFallbackPosterUrl,
                                                                                ),
                                                                              ).image,
                                                                            ),
                                                                            borderRadius: BorderRadius.only(
                                                                              bottomLeft: Radius.circular(
                                                                                10.0,
                                                                              ),
                                                                              bottomRight: Radius.circular(
                                                                                0.0,
                                                                              ),
                                                                              topLeft: Radius.circular(
                                                                                10.0,
                                                                              ),
                                                                              topRight: Radius.circular(
                                                                                10.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child: Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      0.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        10.0,
                                                                                        10.0,
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Container(
                                                                                        width: 42.0,
                                                                                        constraints: const BoxConstraints(
                                                                                          minHeight: 42.0,
                                                                                        ),
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(
                                                                                            0xFFFF0000,
                                                                                          ),
                                                                                          borderRadius: BorderRadius.circular(
                                                                                            10.0,
                                                                                          ),
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                0.0,
                                                                                                3.0,
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              child: Text(
                                                                                                functions
                                                                                                    .dateEventday(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventsItem,
                                                                                                      )?.date,
                                                                                                    )
                                                                                                    .toString(),
                                                                                                style:
                                                                                                    Theme.of(
                                                                                                      context,
                                                                                                    ).textTheme.bodyMedium!.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                      ),
                                                                                                      color:
                                                                                                          Theme.of(
                                                                                                                context,
                                                                                                              )
                                                                                                              .extension<
                                                                                                                CustomColors
                                                                                                              >()!
                                                                                                              .primaryText,
                                                                                                      fontSize: 17.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.fontStyle,
                                                                                                      lineHeight: 1.0,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                0.0,
                                                                                                2.0,
                                                                                                0.0,
                                                                                                2.0,
                                                                                              ),
                                                                                              child: Text(
                                                                                                valueOrDefault<
                                                                                                  String
                                                                                                >(
                                                                                                  functions.dateMonthTH(
                                                                                                    DataEventsStruct.maybeFromMap(
                                                                                                      dataEventsItem,
                                                                                                    )?.date,
                                                                                                  ),
                                                                                                  'ไม่ระบุ',
                                                                                                ),
                                                                                                style:
                                                                                                    Theme.of(
                                                                                                      context,
                                                                                                    ).textTheme.bodyMedium!.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontWeight,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                      ),
                                                                                                      color:
                                                                                                          Theme.of(
                                                                                                                context,
                                                                                                              )
                                                                                                              .extension<
                                                                                                                CustomColors
                                                                                                              >()!
                                                                                                              .primaryText,
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.fontWeight,
                                                                                                      fontStyle: Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.fontStyle,
                                                                                                      lineHeight: 1.0,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                      0.0,
                                                                                      0.0,
                                                                                      5.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        if ((currentUserDocument?.loveEvent?.toList() ??
                                                                                                [])
                                                                                            .contains(
                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                dataEventsItem,
                                                                                              )?.docRef,
                                                                                            )) {
                                                                                          await currentUserReference!.update(
                                                                                            {
                                                                                              ...mapToSupabase(
                                                                                                {
                                                                                                  'loveEvent': FieldValue.arrayRemove(
                                                                                                    [
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventsItem,
                                                                                                      )?.docRef,
                                                                                                    ],
                                                                                                  ),
                                                                                                },
                                                                                              ),
                                                                                            },
                                                                                          );
                                                                                        } else {
                                                                                          await currentUserReference!.update(
                                                                                            {
                                                                                              ...mapToSupabase(
                                                                                                {
                                                                                                  'loveEvent': FieldValue.arrayUnion(
                                                                                                    [
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventsItem,
                                                                                                      )?.docRef,
                                                                                                    ],
                                                                                                  ),
                                                                                                },
                                                                                              ),
                                                                                            },
                                                                                          );
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        width: 38.0,
                                                                                        height: 38.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(
                                                                                            0x22000000,
                                                                                          ),
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Stack(
                                                                                          children: [
                                                                                            if (!(currentUserDocument?.loveEvent?.toList() ??
                                                                                                    [])
                                                                                                .contains(
                                                                                                  DataEventsStruct.maybeFromMap(
                                                                                                    dataEventsItem,
                                                                                                  )?.docRef,
                                                                                                ))
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    0.0,
                                                                                                    1.5,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: FaIcon(
                                                                                                    FontAwesomeIcons.heart,
                                                                                                    color: Color(
                                                                                                      0xFFFDFDFD,
                                                                                                    ),
                                                                                                    size: 23.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            if ((currentUserDocument?.loveEvent?.toList() ??
                                                                                                    [])
                                                                                                .contains(
                                                                                                  DataEventsStruct.maybeFromMap(
                                                                                                    dataEventsItem,
                                                                                                  )?.docRef,
                                                                                                ))
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    0.0,
                                                                                                    1.5,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: FaIcon(
                                                                                                    FontAwesomeIcons.solidHeart,
                                                                                                    color: Color(
                                                                                                      0xFFFF0000,
                                                                                                    ),
                                                                                                    size: 23.0,
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
                                                                              Expanded(
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  decoration: BoxDecoration(),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                height:
                                                                                    MediaQuery.sizeOf(
                                                                                      context,
                                                                                    ).height *
                                                                                    0.22,
                                                                                decoration: BoxDecoration(
                                                                                  gradient: LinearGradient(
                                                                                    colors: [
                                                                                      Colors.transparent,
                                                                                      Color(
                                                                                        0xED000000,
                                                                                      ),
                                                                                    ],
                                                                                    stops: [
                                                                                      0.0,
                                                                                      1.0,
                                                                                    ],
                                                                                    begin: AlignmentDirectional(
                                                                                      0.0,
                                                                                      -1.0,
                                                                                    ),
                                                                                    end: AlignmentDirectional(
                                                                                      0,
                                                                                      1.0,
                                                                                    ),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.only(
                                                                                    bottomLeft: Radius.circular(
                                                                                      10.0,
                                                                                    ),
                                                                                    bottomRight: Radius.circular(
                                                                                      0.0,
                                                                                    ),
                                                                                    topLeft: Radius.circular(
                                                                                      0.0,
                                                                                    ),
                                                                                    topRight: Radius.circular(
                                                                                      0.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    5.0,
                                                                                    0.0,
                                                                                    5.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(
                                                                                          -1.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                            5.0,
                                                                                            0.0,
                                                                                            0.0,
                                                                                            0.0,
                                                                                          ),
                                                                                          child: Text(
                                                                                            valueOrDefault<
                                                                                              String
                                                                                            >(
                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                dataEventsItem,
                                                                                              )?.nameArtise.firstOrNull,
                                                                                              'ไม่ระบุ',
                                                                                            ),
                                                                                            maxLines: 18,
                                                                                            style:
                                                                                                Theme.of(
                                                                                                  context,
                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: Theme.of(
                                                                                                      context,
                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                  ),
                                                                                                  color:
                                                                                                      Theme.of(
                                                                                                            context,
                                                                                                          )
                                                                                                          .extension<
                                                                                                            CustomColors
                                                                                                          >()!
                                                                                                          .primaryText,
                                                                                                  fontSize: 18.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: Theme.of(
                                                                                                    context,
                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          0.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                          5.0,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Container(
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(
                                                                                                  10.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  5.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                  2.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  valueOrDefault<
                                                                                                    String
                                                                                                  >(
                                                                                                    DataEventsStruct.maybeFromMap(
                                                                                                      dataEventsItem,
                                                                                                    )?.nameStore,
                                                                                                    'ไม่ระบุ',
                                                                                                  ),
                                                                                                  maxLines: 18,
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        color: Color(
                                                                                                          0xFFA1A1A1,
                                                                                                        ),
                                                                                                        fontSize: 14.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(
                                                                                          1.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                            5.0,
                                                                                            0.0,
                                                                                            5.0,
                                                                                            5.0,
                                                                                          ),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  valueOrDefault<
                                                                                                    String
                                                                                                  >(
                                                                                                    DataEventsStruct.maybeFromMap(
                                                                                                      dataEventsItem,
                                                                                                    )?.distance.toString(),
                                                                                                    'ไม่ระบุ',
                                                                                                  ),
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        color: Color(
                                                                                                          0xFFE8E8E8,
                                                                                                        ),
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  5.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!.k_hf127elb,
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        color: Color(
                                                                                                          0xFFE8E8E8,
                                                                                                        ),
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: Container(
                                                                                                  width: 100.0,
                                                                                                  height: 1.0,
                                                                                                  decoration: BoxDecoration(),
                                                                                                ),
                                                                                              ),
                                                                                              Image.network(
                                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                width: 16.0,
                                                                                                height: 16.0,
                                                                                                fit: BoxFit.cover,
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    8.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<
                                                                                                      String
                                                                                                    >(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventsItem,
                                                                                                      )?.capacity.toString(),
                                                                                                      'ไม่ระบุ',
                                                                                                    ),
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          color: Color(
                                                                                                            0xFFE8E8E8,
                                                                                                          ),
                                                                                                          fontSize: 13.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  2.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!.k_5am4kqpc,
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        color: Color(
                                                                                                          0xFFE8E8E8,
                                                                                                        ),
                                                                                                        fontSize: 14.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  2.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  valueOrDefault<
                                                                                                    String
                                                                                                  >(
                                                                                                    DataEventsStruct.maybeFromMap(
                                                                                                      dataEventsItem,
                                                                                                    )?.maxCapacity.toString(),
                                                                                                    'ไม่ระบุ',
                                                                                                  ),
                                                                                                  style:
                                                                                                      Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                        color: Color(
                                                                                                          0xFFE8E8E8,
                                                                                                        ),
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          if (!DataEventsStruct.maybeFromMap(
                                                                            dataEventsItem,
                                                                          )!.free)
                                                                            Flexible(
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  1.0,
                                                                                  1.0,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    0.0,
                                                                                    0.0,
                                                                                    1.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(
                                                                                        colors: [
                                                                                          Color(
                                                                                            0xFF411010,
                                                                                          ),
                                                                                          Color(
                                                                                            0xFFDB0000,
                                                                                          ),
                                                                                          Color(
                                                                                            0xFFFF0000,
                                                                                          ),
                                                                                        ],
                                                                                        stops: [
                                                                                          0.0,
                                                                                          0.2,
                                                                                          1.0,
                                                                                        ],
                                                                                        begin: AlignmentDirectional(
                                                                                          0.0,
                                                                                          -1.0,
                                                                                        ),
                                                                                        end: AlignmentDirectional(
                                                                                          0,
                                                                                          1.0,
                                                                                        ),
                                                                                      ),
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                        bottomRight: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                        topLeft: Radius.circular(
                                                                                          0.0,
                                                                                        ),
                                                                                        topRight: Radius.circular(
                                                                                          0.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                10.0,
                                                                                                2.0,
                                                                                                10.0,
                                                                                                2.0,
                                                                                              ),
                                                                                              child: Text(
                                                                                                valueOrDefault<
                                                                                                  String
                                                                                                >(
                                                                                                  DataEventsStruct.maybeFromMap(
                                                                                                    dataEventsItem,
                                                                                                  )?.priceDetail,
                                                                                                  '1,200 ฿',
                                                                                                ),
                                                                                                style:
                                                                                                    Theme.of(
                                                                                                      context,
                                                                                                    ).textTheme.bodyMedium!.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.3,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.fontStyle,
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
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          if (DataEventsStruct.maybeFromMap(
                                                                                dataEventsItem,
                                                                              )?.free ??
                                                                              true)
                                                                            Flexible(
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  1.0,
                                                                                  1.0,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    0.0,
                                                                                    0.0,
                                                                                    1.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(
                                                                                        colors: [
                                                                                          Color(
                                                                                            0xFF1E4110,
                                                                                          ),
                                                                                          Color(
                                                                                            0xFF58BB2F,
                                                                                          ),
                                                                                          Color(
                                                                                            0xFF58BB2F,
                                                                                          ),
                                                                                        ],
                                                                                        stops: [
                                                                                          0.0,
                                                                                          0.2,
                                                                                          1.0,
                                                                                        ],
                                                                                        begin: AlignmentDirectional(
                                                                                          0.0,
                                                                                          -1.0,
                                                                                        ),
                                                                                        end: AlignmentDirectional(
                                                                                          0,
                                                                                          1.0,
                                                                                        ),
                                                                                      ),
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                        bottomRight: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                        topLeft: Radius.circular(
                                                                                          0.0,
                                                                                        ),
                                                                                        topRight: Radius.circular(
                                                                                          0.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                10.0,
                                                                                                2.0,
                                                                                                10.0,
                                                                                                2.0,
                                                                                              ),
                                                                                              child: Text(
                                                                                                AppLocalizations.of(
                                                                                                  context,
                                                                                                )!.k_zsbddjf5,
                                                                                                style:
                                                                                                    Theme.of(
                                                                                                      context,
                                                                                                    ).textTheme.bodyMedium!.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.3,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: Theme.of(
                                                                                                        context,
                                                                                                      ).textTheme.bodyMedium!.fontStyle,
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
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (functions
                                                .dataEvent(
                                                  context
                                                      .appState
                                                      .Filterdistance,
                                                  homeBodyEventsRecordList
                                                      .where(
                                                        (e) => functions
                                                            .showsearch(
                                                              _model
                                                                  .textController
                                                                  .text,
                                                              functions.addName(
                                                                e.nameArtise
                                                                    .toList(),
                                                              ),
                                                            )!,
                                                      )
                                                      .toList(),
                                                  context
                                                      .appState
                                                      .locationsearch,
                                                  _model.stylemusic.toList(),
                                                  (currentUserDocument
                                                              ?.loveEvent
                                                              ?.toList() ??
                                                          [])
                                                      .toList(),
                                                  context.appState.StyleVenuse
                                                      .toList(),
                                                  _model.page,
                                                  _model.mapOn,
                                                  false,
                                                  context.appState.dateclick,
                                                  true,
                                                  _model.lovefilter,
                                                )!
                                                .length >
                                            20)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  20.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          10.0,
                                                          0.0,
                                                        ),
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
                                                        if (_model.page != 1) {
                                                          _model.page =
                                                              _model.page! + -1;
                                                          safeSetState(() {});
                                                          await _model
                                                              .columnController
                                                              ?.animateTo(
                                                                0,
                                                                duration: Duration(
                                                                  milliseconds:
                                                                      200,
                                                                ),
                                                                curve:
                                                                    Curves.ease,
                                                              );
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 44.0,
                                                        height: 44.0,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xFF1C1C1C,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10.0,
                                                              ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: Icon(
                                                                Icons
                                                                    .chevron_left,
                                                                color: Theme.of(context)
                                                                    .extension<
                                                                      CustomColors
                                                                    >()!
                                                                    .primaryText,
                                                                size: 24.0,
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
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              10.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 44.0,
                                                          height: 44.0,
                                                          decoration: BoxDecoration(
                                                            color: Color(
                                                              0xFFFF0000,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10.0,
                                                                ),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                    String
                                                                  >(
                                                                    _model.page
                                                                        ?.toString(),
                                                                    '0',
                                                                  ),
                                                                  style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        20.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
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
                                                      _model.page =
                                                          _model.page! + 1;
                                                      safeSetState(() {});
                                                      await _model
                                                          .columnController
                                                          ?.animateTo(
                                                            0,
                                                            duration: Duration(
                                                              milliseconds: 200,
                                                            ),
                                                            curve: Curves.ease,
                                                          );
                                                    },
                                                    child: Container(
                                                      width: 44.0,
                                                      height: 44.0,
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          0xFF1C1C1C,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10.0,
                                                            ),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                            child: Icon(
                                                              Icons
                                                                  .navigate_next,
                                                              color: Theme.of(context)
                                                                  .extension<
                                                                    CustomColors
                                                                  >()!
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
                                  ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
                                ),
                              ),
                            if (_model.mapOn)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            0.0,
                                                            -1.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              17.0,
                                                              0.0,
                                                              0.0,
                                                            ),
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
                                                                AppState()
                                                                        .locationsearch =
                                                                    AppState()
                                                                        .MapCenter;
                                                                safeSetState(
                                                                  () {},
                                                                );
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        15.0,
                                                                      ),
                                                                  border: Border.all(
                                                                    color: Color(
                                                                      0xFF757575,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                        15.0,
                                                                        2.0,
                                                                        15.0,
                                                                        3.0,
                                                                      ),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_z1r3or6y,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
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
                                                            0.0,
                                                            1.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              7.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 120.0,
                                                          height: 2.0,
                                                          decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                  0xFFFF0000,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        0.0,
                                                        10.0,
                                                        13.0,
                                                      ),
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
                                                          currentUserLocationValue =
                                                              await getCurrentUserLocation(
                                                                defaultLocation:
                                                                    LatLng(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                              );
                                                          if (_model.mapOn) {
                                                            _model.mapOn =
                                                                false;
                                                            safeSetState(() {});
                                                          } else {
                                                            _model.mapOn = true;
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 27.0,
                                                          height: 27.0,
                                                          decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                  0xFFFF0000,
                                                                ),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          child: Icon(
                                                            Icons.close,
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .extension<
                                                                      CustomColors
                                                                    >()!
                                                                    .primaryText,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                      MundayIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 90.0,
                                                        buttonSize: 50.0,
                                                        fillColor: Color(
                                                          0xCC000000,
                                                        ),
                                                        icon: Icon(
                                                          Icons.my_location,
                                                          color:
                                                              Theme.of(context)
                                                                  .extension<
                                                                    CustomColors
                                                                  >()!
                                                                  .info,
                                                          size: 29.0,
                                                        ),
                                                        onPressed: () async {
                                                          currentUserLocationValue =
                                                              await getCurrentUserLocation(
                                                                defaultLocation:
                                                                    LatLng(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                              );
                                                          AppState()
                                                                  .locationsearch =
                                                              currentUserLocationValue;
                                                          safeSetState(() {});
                                                          context
                                                                  .appState
                                                                  .MoveMap =
                                                              true;
                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                              0.0,
                                              1.0,
                                            ),
                                            child:
                                                Container(
                                                  height:
                                                      valueOrDefault<double>(
                                                        functions.posterscale(
                                                          _model.wide,
                                                          true,
                                                        ),
                                                        250.0,
                                                      ),
                                                  decoration: BoxDecoration(),
                                                  child: Stack(
                                                    children: [
                                                      AuthUserStreamWidget(
                                                        builder: (context) => Builder(
                                                          builder: (context) {
                                                            final dataEvent =
                                                                functions
                                                                    .dataEvent(
                                                                      AppState()
                                                                              .Filterdistance ??
                                                                          500.0,
                                                                      homeBodyEventsRecordList
                                                                          .where(
                                                                            (
                                                                              e,
                                                                            ) => functions.showsearch(
                                                                              _model.textController.text,
                                                                              functions.addName(
                                                                                e.nameArtise.toList(),
                                                                              ),
                                                                            )!,
                                                                          )
                                                                          .toList(),
                                                                      AppState()
                                                                              .locationsearch ??
                                                                          currentUserLocationValue ??
                                                                          LatLng(
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                      _model
                                                                          .stylemusic
                                                                          .toList(),
                                                                      (currentUserDocument?.loveEvent?.toList() ??
                                                                              [])
                                                                          .toList(),
                                                                      AppState()
                                                                          .StyleVenuse
                                                                          .toList(),
                                                                      60,
                                                                      _model
                                                                          .mapOn,
                                                                      _model
                                                                          .selectdate,
                                                                      AppState()
                                                                          .dateclick,
                                                                      false,
                                                                      _model
                                                                          .lovefilter,
                                                                    )
                                                                    ?.toList() ??
                                                                [];

                                                            return Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child: CarouselSlider.builder(
                                                                itemCount:
                                                                    dataEvent
                                                                        .length,
                                                                itemBuilder:
                                                                    (
                                                                      context,
                                                                      dataEventIndex,
                                                                      _,
                                                                    ) {
                                                                      final dataEventItem =
                                                                          dataEvent[dataEventIndex];
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Flexible(
                                                                            child: Align(
                                                                              alignment: AlignmentDirectional(
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  await _showEventDetailSheet(
                                                                                    DataEventsStruct.maybeFromMap(
                                                                                      dataEventItem,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  width:
                                                                                      MediaQuery.sizeOf(
                                                                                        context,
                                                                                      ).width *
                                                                                      0.444,
                                                                                  height: functions.posterscale(
                                                                                    _model.wide,
                                                                                    false,
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(
                                                                                      0xFF161616,
                                                                                    ),
                                                                                    image: DecorationImage(
                                                                                      fit: BoxFit.cover,
                                                                                      image: Image.network(
                                                                                        _safeEventsImageUrl(
                                                                                          DataEventsStruct.maybeFromMap(
                                                                                            dataEventItem,
                                                                                          )?.poster,
                                                                                          fallback: _kEventsFallbackPosterUrl,
                                                                                        ),
                                                                                      ).image,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(
                                                                                        10.0,
                                                                                      ),
                                                                                      bottomRight: Radius.circular(
                                                                                        0.0,
                                                                                      ),
                                                                                      topLeft: Radius.circular(
                                                                                        10.0,
                                                                                      ),
                                                                                      topRight: Radius.circular(
                                                                                        10.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(
                                                                                              0.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                10.0,
                                                                                                10.0,
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              child: Container(
                                                                                                width: 42.0,
                                                                                                constraints: const BoxConstraints(
                                                                                                  minHeight: 42.0,
                                                                                                ),
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(
                                                                                                    0xFFFF0000,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                ),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                        0.0,
                                                                                                        3.0,
                                                                                                        0.0,
                                                                                                        0.0,
                                                                                                      ),
                                                                                                      child: Text(
                                                                                                        functions
                                                                                                            .dateEventday(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventItem,
                                                                                                              )?.date,
                                                                                                            )
                                                                                                            .toString(),
                                                                                                        style:
                                                                                                            Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                              color:
                                                                                                                  Theme.of(
                                                                                                                        context,
                                                                                                                      )
                                                                                                                      .extension<
                                                                                                                        CustomColors
                                                                                                                      >()!
                                                                                                                      .primaryText,
                                                                                                              fontSize: 17.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                              lineHeight: 1.0,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                        0.0,
                                                                                                        2.0,
                                                                                                        0.0,
                                                                                                        2.0,
                                                                                                      ),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<
                                                                                                          String
                                                                                                        >(
                                                                                                          functions.dateMonthTH(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventItem,
                                                                                                            )?.date,
                                                                                                          ),
                                                                                                          'ไม่ระบุ',
                                                                                                        ),
                                                                                                        style:
                                                                                                            Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontWeight,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                              color:
                                                                                                                  Theme.of(
                                                                                                                        context,
                                                                                                                      )
                                                                                                                      .extension<
                                                                                                                        CustomColors
                                                                                                                      >()!
                                                                                                                      .primaryText,
                                                                                                              fontSize: 13.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontWeight,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                              lineHeight: 1.0,
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
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          width: double.infinity,
                                                                                          height: double.infinity,
                                                                                          decoration: BoxDecoration(),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: LinearGradient(
                                                                                            colors: [
                                                                                              Colors.transparent,
                                                                                              Color(
                                                                                                0xCB000000,
                                                                                              ),
                                                                                            ],
                                                                                            stops: [
                                                                                              0.0,
                                                                                              1.0,
                                                                                            ],
                                                                                            begin: AlignmentDirectional(
                                                                                              0.0,
                                                                                              -1.0,
                                                                                            ),
                                                                                            end: AlignmentDirectional(
                                                                                              0,
                                                                                              1.0,
                                                                                            ),
                                                                                          ),
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            bottomRight: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                            topLeft: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                            topRight: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                            5.0,
                                                                                            0.0,
                                                                                            5.0,
                                                                                            0.0,
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(
                                                                                                  -1.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    5.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<
                                                                                                      String
                                                                                                    >(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventItem,
                                                                                                      )?.nameArtise.firstOrNull,
                                                                                                      'ไม่ระบุ',
                                                                                                    ),
                                                                                                    maxLines: 18,
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          color:
                                                                                                              Theme.of(
                                                                                                                    context,
                                                                                                                  )
                                                                                                                  .extension<
                                                                                                                    CustomColors
                                                                                                                  >()!
                                                                                                                  .primaryText,
                                                                                                          fontSize: 18.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                  3.0,
                                                                                                ),
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                        5.0,
                                                                                                        0.0,
                                                                                                        0.0,
                                                                                                        2.0,
                                                                                                      ),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<
                                                                                                          String
                                                                                                        >(
                                                                                                          DataEventsStruct.maybeFromMap(
                                                                                                            dataEventItem,
                                                                                                          )?.nameStore,
                                                                                                          'ไม่ระบุ',
                                                                                                        ),
                                                                                                        maxLines: 18,
                                                                                                        style:
                                                                                                            Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                              color: Color(
                                                                                                                0xFFA1A1A1,
                                                                                                              ),
                                                                                                              fontSize: 14.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.normal,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(
                                                                                                  1.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    5.0,
                                                                                                    0.0,
                                                                                                    5.0,
                                                                                                    5.0,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Image.network(
                                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                        width: 16.0,
                                                                                                        height: 16.0,
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                                                      Align(
                                                                                                        alignment: AlignmentDirectional(
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            8.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventItem,
                                                                                                              )?.capacity.toString(),
                                                                                                              '-',
                                                                                                            ),
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          2.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!.k_djg788wu,
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color: Color(
                                                                                                                  0xFFE8E8E8,
                                                                                                                ),
                                                                                                                fontSize: 14.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          2.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<
                                                                                                            String
                                                                                                          >(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventItem,
                                                                                                            )?.maxCapacity.toString(),
                                                                                                            '-',
                                                                                                          ),
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color: Color(
                                                                                                                  0xFFE8E8E8,
                                                                                                                ),
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        child: Container(
                                                                                                          width: 100.0,
                                                                                                          height: 1.0,
                                                                                                          decoration: BoxDecoration(),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Align(
                                                                                                        alignment: AlignmentDirectional(
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            10.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventItem,
                                                                                                              )?.distance.toString(),
                                                                                                              '-',
                                                                                                            ),
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          5.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!.k_cbd0lvds,
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color: Color(
                                                                                                                  0xFFE8E8E8,
                                                                                                                ),
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
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
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              if (!DataEventsStruct.maybeFromMap(
                                                                                dataEventItem,
                                                                              )!.free)
                                                                                Flexible(
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      1.0,
                                                                                      1.0,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        0.0,
                                                                                        0.0,
                                                                                        1.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: LinearGradient(
                                                                                            colors: [
                                                                                              Color(
                                                                                                0xFF411010,
                                                                                              ),
                                                                                              Color(
                                                                                                0xFFDB0000,
                                                                                              ),
                                                                                              Color(
                                                                                                0xFFFF0000,
                                                                                              ),
                                                                                            ],
                                                                                            stops: [
                                                                                              0.0,
                                                                                              0.2,
                                                                                              1.0,
                                                                                            ],
                                                                                            begin: AlignmentDirectional(
                                                                                              0.0,
                                                                                              -1.0,
                                                                                            ),
                                                                                            end: AlignmentDirectional(
                                                                                              0,
                                                                                              1.0,
                                                                                            ),
                                                                                          ),
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            bottomRight: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            topLeft: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                            topRight: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    10.0,
                                                                                                    2.0,
                                                                                                    10.0,
                                                                                                    2.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<
                                                                                                      String
                                                                                                    >(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventItem,
                                                                                                      )?.priceDetail,
                                                                                                      '1,200 ฿',
                                                                                                    ),
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: 13.0,
                                                                                                          letterSpacing: 0.3,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
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
                                                                              Container(
                                                                                width: functions.positionprice(
                                                                                  _model.wide,
                                                                                ),
                                                                                decoration: BoxDecoration(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              if (DataEventsStruct.maybeFromMap(
                                                                                    dataEventItem,
                                                                                  )?.free ??
                                                                                  true)
                                                                                Flexible(
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      1.0,
                                                                                      1.0,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        0.0,
                                                                                        0.0,
                                                                                        1.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: LinearGradient(
                                                                                            colors: [
                                                                                              Color(
                                                                                                0xFF1E4110,
                                                                                              ),
                                                                                              Color(
                                                                                                0xFF58BB2F,
                                                                                              ),
                                                                                              Color(
                                                                                                0xFF58BB2F,
                                                                                              ),
                                                                                            ],
                                                                                            stops: [
                                                                                              0.0,
                                                                                              0.2,
                                                                                              1.0,
                                                                                            ],
                                                                                            begin: AlignmentDirectional(
                                                                                              0.0,
                                                                                              -1.0,
                                                                                            ),
                                                                                            end: AlignmentDirectional(
                                                                                              0,
                                                                                              1.0,
                                                                                            ),
                                                                                          ),
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            bottomRight: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            topLeft: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                            topRight: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    10.0,
                                                                                                    2.0,
                                                                                                    10.0,
                                                                                                    2.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!.k_ebkvitz2,
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: 13.0,
                                                                                                          letterSpacing: 0.3,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
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
                                                                              Container(
                                                                                width: functions.positionprice(
                                                                                  _model.wide,
                                                                                ),
                                                                                decoration: BoxDecoration(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                carouselController:
                                                                    _model.carouselController ??=
                                                                        CarouselSliderController(),
                                                                options: CarouselOptions(
                                                                  initialPage: max(
                                                                    0,
                                                                    min(
                                                                      1,
                                                                      dataEvent
                                                                              .length -
                                                                          1,
                                                                    ),
                                                                  ),
                                                                  viewportFraction:
                                                                      0.5,
                                                                  disableCenter:
                                                                      true,
                                                                  enlargeCenterPage:
                                                                      false,
                                                                  enlargeFactor:
                                                                      0.0,
                                                                  enableInfiniteScroll:
                                                                      false,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  autoPlay:
                                                                      false,
                                                                  onPageChanged: (index, _) async {
                                                                    _model.carouselCurrentIndex =
                                                                        index;
                                                                    if (_model
                                                                            .slide ==
                                                                        true) {
                                                                      AppState()
                                                                          .EventSelection = DataEventsStruct.maybeFromMap(
                                                                        dataEvent.elementAtOrNull(
                                                                          _model
                                                                              .carouselCurrentIndex,
                                                                        ),
                                                                      )?.docRef;
                                                                      safeSetState(
                                                                        () {},
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                              -1.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 60.0,
                                                          height:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors
                                                                    .transparent,
                                                                Colors.black,
                                                              ],
                                                              stops: [0.0, 1.0],
                                                              begin:
                                                                  AlignmentDirectional(
                                                                    1.0,
                                                                    0.0,
                                                                  ),
                                                              end:
                                                                  AlignmentDirectional(
                                                                    -1.0,
                                                                    0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                              1.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 60.0,
                                                          height:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors.black,
                                                                Colors
                                                                    .transparent,
                                                              ],
                                                              stops: [0.0, 1.0],
                                                              begin:
                                                                  AlignmentDirectional(
                                                                    1.0,
                                                                    0.0,
                                                                  ),
                                                              end:
                                                                  AlignmentDirectional(
                                                                    -1.0,
                                                                    0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (functions
                                                              .dataEvent(
                                                                AppState()
                                                                        .Filterdistance ??
                                                                    500.0,
                                                                homeBodyEventsRecordList
                                                                    .where(
                                                                      (
                                                                        e,
                                                                      ) => functions.showsearch(
                                                                        _model
                                                                            .textController
                                                                            .text,
                                                                        functions.addName(
                                                                          e.nameArtise
                                                                              .toList(),
                                                                        ),
                                                                      )!,
                                                                    )
                                                                    .toList(),
                                                                AppState()
                                                                        .locationsearch ??
                                                                    currentUserLocationValue ??
                                                                    LatLng(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                _model
                                                                    .stylemusic
                                                                    .toList(),
                                                                (currentUserDocument
                                                                            ?.loveEvent
                                                                            ?.toList() ??
                                                                        [])
                                                                    .toList(),
                                                                AppState()
                                                                    .StyleVenuse
                                                                    .toList(),
                                                                _model.page,
                                                                _model.mapOn,
                                                                _model
                                                                    .selectdate,
                                                                AppState()
                                                                    .dateclick,
                                                                false,
                                                                _model
                                                                    .lovefilter,
                                                              )
                                                              ?.length ==
                                                          0)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                10.0,
                                                                0.0,
                                                                10.0,
                                                                0.0,
                                                              ),
                                                          child: AuthUserStreamWidget(
                                                            builder: (context) => Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                color: Color(
                                                                  0x9A000000,
                                                                ),
                                                                borderRadius: BorderRadius.only(
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                        0.0,
                                                                      ),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                        0.0,
                                                                      ),
                                                                  topLeft:
                                                                      Radius.circular(
                                                                        0.0,
                                                                      ),
                                                                  topRight:
                                                                      Radius.circular(
                                                                        0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      0.0,
                                                                      25.0,
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .notifications_none,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          72.0,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_16vbnwxq,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.headlineMedium!.override(
                                                                              font: GoogleFonts.outfit(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.headlineMedium!.fontStyle,
                                                                              ),
                                                                              color: Colors.white,
                                                                              fontSize: 30.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.headlineMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                            25.0,
                                                                            4.0,
                                                                            25.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_jxcp0zzg,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.labelMedium!.override(
                                                                              font: GoogleFonts.plusJakartaSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.labelMedium!.fontStyle,
                                                                              ),
                                                                              color: Color(
                                                                                0xFFBCBCBC,
                                                                              ),
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.labelMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child: Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          7.0,
                                                                          0.0,
                                                                        ),
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
                                                                            if (_model.selectdate) {
                                                                              _model.selectdate = false;
                                                                              _model.page = 1;
                                                                              safeSetState(
                                                                                () {},
                                                                              );
                                                                              await _model.columnController?.animateTo(
                                                                                0,
                                                                                duration: Duration(
                                                                                  milliseconds: 300,
                                                                                ),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            } else {
                                                                              _model.selectdate = true;
                                                                              _model.page = 1;
                                                                              safeSetState(
                                                                                () {},
                                                                              );
                                                                              await _model.columnController?.animateTo(
                                                                                0,
                                                                                duration: Duration(
                                                                                  milliseconds: 300,
                                                                                ),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Container(
                                                                            height:
                                                                                30.0,
                                                                            decoration: BoxDecoration(
                                                                              color: _model.selectdate
                                                                                  ? Color(
                                                                                      0xFFFF0000,
                                                                                    )
                                                                                  : Color(
                                                                                      0xFF1C1C1C,
                                                                                    ),
                                                                              borderRadius: BorderRadius.circular(
                                                                                20.0,
                                                                              ),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: _model.selectdate
                                                                                    ? Color(
                                                                                        0xFFFF0000,
                                                                                      )
                                                                                    : Color(
                                                                                        0xFF1C1C1C,
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    15.0,
                                                                                    0.0,
                                                                                    6.0,
                                                                                    1.0,
                                                                                  ),
                                                                                  child: Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.k_twcppxxh,
                                                                                    style:
                                                                                        Theme.of(
                                                                                          context,
                                                                                        ).textTheme.bodyMedium!.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: Theme.of(
                                                                                              context,
                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                          ),
                                                                                          color: Colors.white,
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: Theme.of(
                                                                                            context,
                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    0.0,
                                                                                    0.0,
                                                                                    15.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Icon(
                                                                                    Icons.keyboard_arrow_down,
                                                                                    color: Colors.white,
                                                                                    size: 16.0,
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
                                                    ],
                                                  ),
                                                ).animateOnPageLoad(
                                                  animationsMap['containerOnPageLoadAnimation2']!,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Container(
                              width: double.infinity,
                              height: _model.selectdate && _model.mapOn
                                  ? 225.0
                                  : 145.0,
                              decoration: BoxDecoration(
                                color: _model.mapOn
                                    ? Colors.transparent
                                    : Colors.black,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        0.0,
                                        0.0,
                                        12.0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                  20.0,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  ProfilePage.routeName,
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
                                                decoration: BoxDecoration(),
                                                child: Stack(
                                                  children: [
                                                    AuthUserStreamWidget(
                                                      builder: (context) => Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                        child: Image.network(
                                                          _safeEventsImageUrl(
                                                            currentUserPhoto,
                                                            fallback:
                                                                _kEventsFallbackProfileUrl,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            1.0,
                                                            1.0,
                                                          ),
                                                      child: Container(
                                                        width: 18.0,
                                                        height: 18.0,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xFFFF0005,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                45.0,
                                                              ),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                0.0,
                                                                0.0,
                                                              ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: Icon(
                                                                  Icons
                                                                      .settings,
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
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
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    18.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          2.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
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
                                                                  0.0,
                                                                ),
                                                            child: Stack(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                        0.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          3.0,
                                                                        ),
                                                                    child: Container(
                                                                      width:
                                                                          6.0,
                                                                      height:
                                                                          6.0,
                                                                      decoration: BoxDecoration(
                                                                        color:
                                                                            Theme.of(
                                                                                  context,
                                                                                )
                                                                                .extension<
                                                                                  CustomColors
                                                                                >()!
                                                                                .primaryText,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              45.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                        0.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .location_pin,
                                                                    color: Color(
                                                                      0xFFFF0000,
                                                                    ),
                                                                    size: 14.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                4.0,
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                              ),
                                                          child: Container(
                                                            width: 125.0,
                                                            height: 15.0,
                                                            child: custom_widgets.LocationName(
                                                              width: 125.0,
                                                              height: 15.0,
                                                              locationNow:
                                                                  AppState()
                                                                      .locationsearch,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                          -1.0,
                                                          0.0,
                                                        ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            2.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: StreamBuilder<List<VenuesRecord>>(
                                                        stream:
                                                            queryVenuesRecord(),
                                                        builder: (context, snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
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
                                                          List<VenuesRecord>
                                                          textVenuesRecordList =
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
                                                                      child: JoinroomWidget(
                                                                        datavenuse: textVenuesRecordList
                                                                            .take(
                                                                              3,
                                                                            )
                                                                            .toList()
                                                                            .map(
                                                                              (
                                                                                e,
                                                                              ) => e.reference,
                                                                            )
                                                                            .toList(),
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
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_8in2y4rt,
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Theme.of(context)
                                                                    .extension<
                                                                      CustomColors
                                                                    >()!
                                                                    .primaryText,
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  5.0,
                                                  10.0,
                                                  0.0,
                                                ),
                                            child: GestureDetector(
                                              onTap: () => context.pushNamed(
                                                TicketPage.routeName,
                                              ),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Colors.black,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: Image.asset(
                                                          'assets/images/icon_ticket.png',
                                                          width: 27.0,
                                                          height: 27.0,
                                                        ),
                                                      ),
                                                      if ((currentUserDocument
                                                                  ?.tickets ??
                                                              [])
                                                          .isNotEmpty)
                                                        Positioned(
                                                          top: 6.0,
                                                          right: 6.0,
                                                          child: Container(
                                                            width: 14.0,
                                                            height: 14.0,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color(
                                                                    0xFFE52020,
                                                                  ),
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.5,
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
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  5.0,
                                                  10.0,
                                                  0.0,
                                                ),
                                            child: GestureDetector(
                                              onTap: () => context.pushNamed(
                                                MainChatPage.routeName,
                                              ),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Colors.black,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: Image.asset(
                                                          'assets/images/icon_message.png',
                                                          width: 22.0,
                                                          height: 22.0,
                                                        ),
                                                      ),
                                                      if ((currentUserDocument
                                                                  ?.usermassage ??
                                                              [])
                                                          .isNotEmpty)
                                                        Positioned(
                                                          top: 6.0,
                                                          right: 6.0,
                                                          child: Container(
                                                            width: 14.0,
                                                            height: 14.0,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color(
                                                                    0xFFE52020,
                                                                  ),
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.5,
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
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  5.0,
                                                  16.0,
                                                  0.0,
                                                ),
                                            child: AuthUserStreamWidget(
                                              builder: (context) =>
                                                  NotificationBadgeButton(
                                                    onTap: () =>
                                                        context.pushNamed(
                                                          NotificationPage
                                                              .routeName,
                                                        ),
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0,
                                      0.0,
                                      20.0,
                                      10.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 45.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x981D1D1D),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        15.0,
                                                        0.0,
                                                        15.0,
                                                        2.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.search_rounded,
                                                    color: Theme.of(context)
                                                        .extension<
                                                          CustomColors
                                                        >()!
                                                        .primaryBtnText,
                                                    size: 22.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: TextFormField(
                                                      controller:
                                                          _model.textController,
                                                      focusNode: _model
                                                          .textFieldFocusNode,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                            '_model.textController',
                                                            Duration(
                                                              milliseconds: 500,
                                                            ),
                                                            () => safeSetState(
                                                              () {},
                                                            ),
                                                          ),
                                                      onFieldSubmitted:
                                                          (_) async {
                                                            _model.textinput =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                      autofocus: false,
                                                      textInputAction:
                                                          TextInputAction
                                                              .search,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        isDense: false,
                                                        hintText:
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.k_k93w5ytl,
                                                        hintStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .fontStyle,
                                                              ),
                                                              color: Color(
                                                                0xFF9D9D9D,
                                                              ),
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodySmall!
                                                                      .fontStyle,
                                                            ),
                                                        enabledBorder: UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                color: Color(
                                                                  0x00000000,
                                                                ),
                                                                width: 1.0,
                                                              ),
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                      4.0,
                                                                    ),
                                                                topRight:
                                                                    Radius.circular(
                                                                      4.0,
                                                                    ),
                                                              ),
                                                        ),
                                                        focusedBorder: UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                color: Color(
                                                                  0x00000000,
                                                                ),
                                                                width: 1.0,
                                                              ),
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                      4.0,
                                                                    ),
                                                                topRight:
                                                                    Radius.circular(
                                                                      4.0,
                                                                    ),
                                                              ),
                                                        ),
                                                        errorBorder: UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                color: Color(
                                                                  0x00000000,
                                                                ),
                                                                width: 1.0,
                                                              ),
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                      4.0,
                                                                    ),
                                                                topRight:
                                                                    Radius.circular(
                                                                      4.0,
                                                                    ),
                                                              ),
                                                        ),
                                                        focusedErrorBorder:
                                                            UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                      0x00000000,
                                                                    ),
                                                                    width: 1.0,
                                                                  ),
                                                              borderRadius:
                                                                  const BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                  ),
                                                            ),
                                                        suffixIcon:
                                                            _model
                                                                .textController!
                                                                .text
                                                                .isNotEmpty
                                                            ? InkWell(
                                                                onTap: () async {
                                                                  _model
                                                                      .textController
                                                                      ?.clear();
                                                                  safeSetState(
                                                                    () {},
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons.clear,
                                                                  color: Color(
                                                                    0xFF757575,
                                                                  ),
                                                                  size: 22.0,
                                                                ),
                                                              )
                                                            : null,
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                              0xFFBDBDBD,
                                                            ),
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                      validator: _model
                                                          .textControllerValidator
                                                          .asValidator(context),
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
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          4.0,
                                                          0.0,
                                                          12.0,
                                                          0.0,
                                                        ),
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
                                                          enableDrag: false,
                                                          context: context,
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
                                                                child:
                                                                    FilterWidget(),
                                                              ),
                                                            );
                                                          },
                                                        ).then(
                                                          (value) =>
                                                              safeSetState(
                                                                () {},
                                                              ),
                                                        );

                                                        _model.page = 1;
                                                        safeSetState(() {});
                                                      },
                                                      child: Image.network(
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
                                                    if (_model.lovefilter ==
                                                        true) {
                                                      _model.lovefilter = false;
                                                      _model.page = 1;
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.lovefilter = true;
                                                      _model.selectdate = false;
                                                      _model.page = 1;
                                                      safeSetState(() {});
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 45.0,
                                                    height: 45.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x981D1D1D),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 5.0,
                                                          color: Color(
                                                            0x33000000,
                                                          ),
                                                          offset: Offset(
                                                            2.0,
                                                            2.0,
                                                          ),
                                                          spreadRadius: 4.0,
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.0,
                                                          ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                0.0,
                                                                0.0,
                                                              ),
                                                          child: Icon(
                                                            Icons
                                                                .favorite_border_rounded,
                                                            color:
                                                                _model
                                                                    .lovefilter
                                                                ? Color(
                                                                    0xFFFF0000,
                                                                  )
                                                                : Colors.white,
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                10.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (_model.mapOn) {
                                                _model.mapOn = false;
                                                safeSetState(() {});
                                              } else {
                                                _model.mapOn = true;
                                                safeSetState(() {});
                                              }

                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 45.0,
                                              height: 45.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x981D1D1D),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: _model.mapOn
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
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            0.0,
                                                          ),
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
                                    alignment: AlignmentDirectional(-0.8, 0.11),
                                    child: Container(
                                      width: double.infinity,
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        color: Color(0x00FFFFFF),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          controller: _model.rowController,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              if (_model.selectdate)
                                                Container(
                                                  constraints: BoxConstraints(
                                                    minWidth: 60.0,
                                                  ),
                                                  height: 30.0,
                                                  decoration: BoxDecoration(),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                          0.0,
                                                          -1.3,
                                                        ),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                0.0,
                                                                0.0,
                                                              ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  15.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              valueOrDefault<
                                                                String
                                                              >(
                                                                functions.month(
                                                                  AppState()
                                                                      .dateclick,
                                                                ),
                                                                'ไม่ระบุ',
                                                              ),
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    1.2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                lineHeight: 0.9,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ).animateOnPageLoad(
                                                  animationsMap['containerOnPageLoadAnimation3']!,
                                                ),
                                              Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                      0.0,
                                                      0.0,
                                                      7.0,
                                                      0.0,
                                                    ),
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
                                                    if (_model.selectdate) {
                                                      _model.selectdate = false;
                                                      _model.page = 1;
                                                      safeSetState(() {});
                                                      await _model
                                                          .columnController
                                                          ?.animateTo(
                                                            0,
                                                            duration: Duration(
                                                              milliseconds: 300,
                                                            ),
                                                            curve: Curves.ease,
                                                          );
                                                    } else {
                                                      _model.selectdate = true;
                                                      _model.page = 1;
                                                      safeSetState(() {});
                                                      await _model
                                                          .columnController
                                                          ?.animateTo(
                                                            0,
                                                            duration: Duration(
                                                              milliseconds: 300,
                                                            ),
                                                            curve: Curves.ease,
                                                          );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: _model.selectdate
                                                          ? Color(0xFFFF0000)
                                                          : Color(0xFF1C1C1C),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.0,
                                                          ),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: _model.selectdate
                                                            ? Color(0xFFFF0000)
                                                            : Color(0xFF757575),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                10.0,
                                                                0.0,
                                                                4.0,
                                                                1.0,
                                                              ),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.k_58xy52fz,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                10.0,
                                                                0.0,
                                                              ),
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color: Colors.white,
                                                            size: 16.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                      0.0,
                                                      0.0,
                                                      7.0,
                                                      0.0,
                                                    ),
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
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      context: context,
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
                                                            child:
                                                                FilterWidget(),
                                                          ),
                                                        );
                                                      },
                                                    ).then(
                                                      (value) =>
                                                          safeSetState(() {}),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF1C1C1C),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.0,
                                                          ),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Color(
                                                          0xFF757575,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            1.0,
                                                          ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppState()
                                                                  .Filterdistance
                                                                  .toString(),
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_kc51jfwx,
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
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
                                              Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                      0.0,
                                                      0.0,
                                                      7.0,
                                                      0.0,
                                                    ),
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
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      context: context,
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
                                                            child:
                                                                FilterWidget(),
                                                          ),
                                                        );
                                                      },
                                                    ).then(
                                                      (value) =>
                                                          safeSetState(() {}),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF1C1C1C),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.0,
                                                          ),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Color(
                                                          0xFF757575,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            1.0,
                                                          ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_psht3tot,
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_3b91k8ff,
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_3t9g2w44,
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
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
                                              Builder(
                                                builder: (context) {
                                                  final styVenuse = AppState()
                                                      .StyleVenuse
                                                      .toList();

                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(styVenuse.length, (
                                                      styVenuseIndex,
                                                    ) {
                                                      final styVenuseItem =
                                                          styVenuse[styVenuseIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              7.0,
                                                              0.0,
                                                            ),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            AppState()
                                                                .removeFromStyleVenuse(
                                                                  styVenuseItem,
                                                                );
                                                            safeSetState(() {});
                                                          },
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                              color: Color(
                                                                0xFF1C1C1C,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10.0,
                                                                  ),
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              border: Border.all(
                                                                color: Color(
                                                                  0xFF757575,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    2.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
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
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          1.0,
                                                                        ),
                                                                        child: Text(
                                                                          styVenuseItem,
                                                                          style:
                                                                              Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: Theme.of(
                                                                                    context,
                                                                                  ).textTheme.bodyMedium!.fontWeight,
                                                                                  fontStyle: Theme.of(
                                                                                    context,
                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                                color: Colors.white,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontWeight,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                          2.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                        ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Color(
                                                                        0xFFFF0000,
                                                                      ),
                                                                      size:
                                                                          14.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                },
                                              ),
                                              Builder(
                                                builder: (context) {
                                                  final styMusic = AppState()
                                                      .StyleMusic
                                                      .toList();

                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(styMusic.length, (
                                                      styMusicIndex,
                                                    ) {
                                                      final styMusicItem =
                                                          styMusic[styMusicIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              7.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          height:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                            color: Color(
                                                              0xFF1C1C1C,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10.0,
                                                                ),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFF757575,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  2.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                ),
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
                                                                      padding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            1.0,
                                                                          ),
                                                                      child: Text(
                                                                        styMusicItem,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.bodyMedium!.override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontWeight,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              color: Colors.white,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.fontWeight,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                        2.0,
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                      ),
                                                                  child: InkWell(
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
                                                                    onTap: () async {
                                                                      AppState()
                                                                          .removeFromStyleMusic(
                                                                            styMusicItem,
                                                                          );
                                                                      safeSetState(
                                                                        () {},
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Color(
                                                                        0xFFFF0000,
                                                                      ),
                                                                      size:
                                                                          14.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_model.selectdate && _model.mapOn)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0,
                                        10.0,
                                        15.0,
                                        0.0,
                                      ),
                                      child:
                                          Container(
                                            width: double.infinity,
                                            height: 70.0,
                                            decoration: BoxDecoration(),
                                            child: Container(
                                              width: 45.0,
                                              height: 60.0,
                                              child:
                                                  custom_widgets.CalendarslideEvent(
                                                    width: 45.0,
                                                    height: 60.0,
                                                    colorPicker: Color(
                                                      0xFFFF0000,
                                                    ),
                                                    dateNow:
                                                        getCurrentTimestamp,
                                                    dateclickwidget: context
                                                        .appState
                                                        .dateclick,
                                                    onselect: () async {
                                                      safeSetState(() {});
                                                    },
                                                  ),
                                            ),
                                          ).animateOnPageLoad(
                                            animationsMap['containerOnPageLoadAnimation4']!,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            if (!_model.mapOn)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (currentUserDocument?.loginVenuesRoom !=
                                        null)
                                      Align(
                                        alignment: AlignmentDirectional(
                                          1.0,
                                          1.0,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                10.0,
                                                0.0,
                                              ),
                                          child: AuthUserStreamWidget(
                                            builder: (context) {
                                              final firstVenueRoomRef =
                                                  (currentUserDocument
                                                              ?.iDROOMVenues
                                                              ?.toList() ??
                                                          [])
                                                      .firstOrNull;
                                              if (firstVenueRoomRef == null) {
                                                return SizedBox.shrink();
                                              }
                                              return StreamBuilder<
                                                UserInVenuesRecord
                                              >(
                                                stream:
                                                    UserInVenuesRecord.getDocument(
                                                      firstVenueRoomRef,
                                                    ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
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
                                                        SocialInVenusePage
                                                            .routeName,
                                                      );

                                                      context
                                                              .appState
                                                              .StyleVenuse =
                                                          [];
                                                      safeSetState(() {});
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              90.0,
                                                            ),
                                                      ),
                                                      child: Container(
                                                        width: 70.0,
                                                        height: 70.0,
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
                                                                    0.0,
                                                                  ),
                                                              child: Container(
                                                                width: 70.0,
                                                                height: 70.0,
                                                                decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: Image.network(
                                                                      _safeEventsImageUrl(
                                                                        currentUserDocument
                                                                            ?.logoRoom,
                                                                        fallback:
                                                                            _kEventsFallbackProfileUrl,
                                                                      ),
                                                                    ).image,
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          4.0,
                                                                      color: Color(
                                                                        0x34000000,
                                                                      ),
                                                                      offset:
                                                                          Offset(
                                                                            0.0,
                                                                            2.0,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                    1.05,
                                                                    -1.0,
                                                                  ),
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
                                                                            0.0,
                                                                          ),
                                                                      child: Container(
                                                                        width:
                                                                            25.0,
                                                                        height:
                                                                            25.0,
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Stack(
                                                                          children: [
                                                                            if (containerUserInVenuesRecord.user
                                                                                    .where(
                                                                                      (
                                                                                        e,
                                                                                      ) => functions.checkdate(
                                                                                        (e
                                                                                                as dynamic)
                                                                                            ?.date,
                                                                                        getCurrentTimestamp,
                                                                                      )!,
                                                                                    )
                                                                                    .toList()
                                                                                    .length !=
                                                                                0)
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  0.0,
                                                                                  0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  width: 23.0,
                                                                                  height: 23.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(
                                                                                      0xFFFF0000,
                                                                                    ),
                                                                                    boxShadow: [
                                                                                      BoxShadow(
                                                                                        blurRadius: 4.0,
                                                                                        color: Color(
                                                                                          0x4C000000,
                                                                                        ),
                                                                                        offset: Offset(
                                                                                          0.0,
                                                                                          2.0,
                                                                                        ),
                                                                                        spreadRadius: 0.5,
                                                                                      ),
                                                                                    ],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Stack(
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                            0.0,
                                                                                            0.0,
                                                                                            0.0,
                                                                                            1.0,
                                                                                          ),
                                                                                          child: Text(
                                                                                            containerUserInVenuesRecord.user
                                                                                                .where(
                                                                                                  (
                                                                                                    e,
                                                                                                  ) => functions.checkdate(
                                                                                                    (e
                                                                                                            as dynamic)
                                                                                                        ?.date,
                                                                                                    getCurrentTimestamp,
                                                                                                  )!,
                                                                                                )
                                                                                                .toList()
                                                                                                .length
                                                                                                .toString(),
                                                                                            style:
                                                                                                Theme.of(
                                                                                                  context,
                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontStyle: Theme.of(
                                                                                                      context,
                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                  ),
                                                                                                  fontSize: 11.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontStyle: Theme.of(
                                                                                                    context,
                                                                                                  ).textTheme.bodyMedium!.fontStyle,
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
                                                                    1.05,
                                                                    1.0,
                                                                  ),
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
                                                                            0.0,
                                                                          ),
                                                                      child: Container(
                                                                        width:
                                                                            25.0,
                                                                        height:
                                                                            25.0,
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              child: Container(
                                                                                width: 27.0,
                                                                                height: 27.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(
                                                                                    0xFF07B53B,
                                                                                  ),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 4.0,
                                                                                      color: Color(
                                                                                        0x4C000000,
                                                                                      ),
                                                                                      offset: Offset(
                                                                                        0.0,
                                                                                        2.0,
                                                                                      ),
                                                                                      spreadRadius: 0.0,
                                                                                    ),
                                                                                  ],
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          1.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
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
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ).animateOnActionTrigger(
                      animationsMap['containerOnActionTriggerAnimation']!,
                    );
                  },
                ),
                if (_model.textinput)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      110.0,
                      0.0,
                      0.0,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _model.textinput = false;
                        safeSetState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(color: Color(0x4E000000)),
                      ),
                    ),
                  ),
                if (_model.textinput)
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.textinput = false;
                      safeSetState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(color: Color(0x4E000000)),
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

class _EventDetailData {
  const _EventDetailData({
    required this.eventData,
    this.eventRecord,
    this.venueRecord,
  });

  final DataEventsStruct eventData;
  final EventsRecord? eventRecord;
  final VenuesRecord? venueRecord;

  SupabaseDocRef? get venueRef => eventData.iDVenuse ?? eventRecord?.iDVenues;

  String? get distanceValue =>
      eventData.hasDistance() ? eventData.distance.toString() : null;

  String get distanceLabel {
    if (!eventData.hasDistance()) {
      return 'ไม่ระบุ';
    }
    return '${eventData.distance.toStringAsFixed(1)} กม.';
  }

  DateTime? get eventDate => eventRecord?.date ?? eventData.date;

  String get eventDateLabel {
    final date = eventDate;
    if (date == null) {
      return 'ยังไม่ระบุวันเวลา';
    }

    final day = functions.dateEventday(date)?.toString() ?? '';
    final month = functions.dateMonthTH(date) ?? '';
    final time = dateTimeFormat('Hm', date);
    return '$day $month • $time';
  }

  List<String> get artists {
    final recordArtists = eventRecord?.nameArtise ?? const <String>[];
    final source = recordArtists.isNotEmpty
        ? recordArtists
        : eventData.nameArtise;
    return source.where((name) => name.trim().isNotEmpty).toList();
  }

  String get eventTitle {
    if (artists.isNotEmpty) {
      return artists.join(', ');
    }
    return venueName;
  }

  String get venueName {
    final venueName = venueRecord?.nameVenuse.trim();
    if (venueName != null && venueName.isNotEmpty) {
      return venueName;
    }

    final eventStore = eventRecord?.nameStore.trim();
    if (eventStore != null && eventStore.isNotEmpty) {
      return eventStore;
    }

    final dataStore = eventData.nameStore.trim();
    if (dataStore.isNotEmpty) {
      return dataStore;
    }

    return 'ร้านของ event นี้';
  }

  String get venueImageUrl {
    final logo = venueRecord?.logo.trim();
    if (logo != null && logo.isNotEmpty) {
      return _safeEventsImageUrl(logo, fallback: _kEventsFallbackProfileUrl);
    }

    final bg = venueRecord?.bg.trim();
    if (bg != null && bg.isNotEmpty) {
      return _safeEventsImageUrl(bg, fallback: _kEventsFallbackProfileUrl);
    }

    return _kEventsFallbackProfileUrl;
  }

  String get posterUrl {
    final poster = eventRecord?.poster.trim();
    if (poster != null && poster.isNotEmpty) {
      return _safeEventsImageUrl(poster, fallback: _kEventsFallbackPosterUrl);
    }

    return _safeEventsImageUrl(
      eventData.poster,
      fallback: _kEventsFallbackPosterUrl,
    );
  }

  bool get isFree =>
      eventRecord?.free ?? (eventData.hasFree() ? eventData.free : false);

  String get priceLabel {
    if (isFree) {
      return 'ฟรี';
    }

    final recordPrice = eventRecord?.priceDetail.trim();
    if (recordPrice != null && recordPrice.isNotEmpty) {
      return recordPrice;
    }

    final dataPrice = eventData.priceDetail.trim();
    if (dataPrice.isNotEmpty) {
      return dataPrice;
    }

    return 'ราคาไม่ระบุ';
  }

  String get priceSummaryLabel {
    if (isFree) {
      return 'ฟรี';
    }

    if (priceLabel == 'ราคาไม่ระบุ') {
      return priceLabel;
    }

    final normalized = priceLabel.toLowerCase();
    if (normalized.startsWith('from') || priceLabel.startsWith('เริ่ม')) {
      return priceLabel;
    }

    return 'From $priceLabel';
  }

  String get bookingButtonLabel {
    if (isFree) {
      return 'จองฟรี';
    }

    if (priceLabel == 'ราคาไม่ระบุ') {
      return 'ดูตัวเลือก';
    }

    return 'จองจาก $priceLabel';
  }

  String get availabilityLabel {
    if (isFree) {
      return 'Free entry available';
    }

    if (tableCount != null) {
      return 'Best tables available';
    }

    return 'ตรวจสอบที่นั่งว่าง';
  }

  int? get currentCapacity {
    if (eventRecord?.hasCapacity() ?? false) {
      return eventRecord!.capacity;
    }
    return eventData.hasCapacity() ? eventData.capacity : null;
  }

  int? get maxCapacity {
    if (eventRecord?.hasMaxCapacity() ?? false) {
      return eventRecord!.maxCapacity;
    }
    return eventData.hasMaxCapacity() ? eventData.maxCapacity : null;
  }

  String get capacityLabel {
    final current = currentCapacity;
    final max = maxCapacity;
    if (current != null && max != null && max > 0) {
      return '$current/$max คน';
    }
    if (max != null && max > 0) {
      return 'สูงสุด $max คน';
    }
    if (current != null) {
      return '$current คน';
    }
    return 'ไม่ระบุ';
  }

  int? get tableCount {
    final count = venueRecord?.tableId.length ?? 0;
    return count > 0 ? count : null;
  }

  String get tableCountLabel {
    final count = tableCount;
    if (count == null) {
      return 'ยังไม่ระบุ';
    }
    return '$count โต๊ะ';
  }

  String get musicStyle {
    final recordStyle = eventRecord?.musicstyle.trim();
    if (recordStyle != null && recordStyle.isNotEmpty) {
      return recordStyle;
    }

    final dataStyle = eventData.musicstyle.trim();
    if (dataStyle.isNotEmpty) {
      return dataStyle;
    }

    final venueStyles = venueRecord?.styleMusic ?? const <String>[];
    return venueStyles.isNotEmpty ? venueStyles.join(', ') : 'ไม่ระบุ';
  }

  String get detailText {
    final detail = eventRecord?.detail.trim();
    if (detail != null && detail.isNotEmpty) {
      return detail;
    }
    return 'ยังไม่มีรายละเอียดเพิ่มเติมสำหรับ event นี้';
  }

  String get openCloseTime {
    final value = venueRecord?.openCloseTime.trim();
    return value != null && value.isNotEmpty ? value : 'ยังไม่ระบุเวลาเปิด';
  }

  String get ratingLabel {
    final rating = venueRecord?.rating ?? 0.0;
    return rating > 0 ? rating.toStringAsFixed(1) : 'ยังไม่มีคะแนน';
  }

  String get doorsOpenLabel {
    if (openCloseTime != 'ยังไม่ระบุเวลาเปิด') {
      return openCloseTime;
    }

    return 'Based on venue schedule';
  }

  String get showStartsLabel {
    final date = eventDate;
    if (date == null) {
      return 'Based on selection';
    }

    return dateTimeFormat('Hm', date);
  }

  String get venueLocationLabel {
    final location =
        eventRecord?.location ?? venueRecord?.position ?? eventData.position;
    if (location == null) {
      return venueName;
    }

    return '$venueName • ${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
  }

  List<String> get detailParagraphs {
    final paragraphs = detailText
        .split(RegExp(r'\n\s*\n|\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    return paragraphs.isNotEmpty ? paragraphs : [detailText];
  }

  List<String> get highlights {
    final items = <String>[];

    if (artists.isNotEmpty) {
      items.add('การแสดงโดย ${artists.join(', ')}');
    }
    if (musicStyle != 'ไม่ระบุ') {
      items.add('แนวเพลง $musicStyle');
    }
    if (tableCount != null) {
      items.add('มีโต๊ะสำหรับ event นี้ $tableCountLabel');
    }
    final max = maxCapacity;
    if (max != null && max > 0) {
      items.add('รองรับผู้ร่วมงานสูงสุด $maxCapacityLabel');
    }
    if (venueName != 'ร้านของ event นี้') {
      items.add('จัดที่ $venueName');
    }

    return items;
  }

  String get maxCapacityLabel {
    final max = maxCapacity;
    if (max == null || max <= 0) {
      return 'ไม่ระบุ';
    }
    return '$max คน';
  }

  List<String> get includedItems {
    final items = <String>[
      isFree
          ? 'สิทธิ์เข้างานฟรีตามเงื่อนไขของร้าน'
          : 'สิทธิ์เข้างานหรือจองโต๊ะตามแพ็กเกจที่เลือก',
      'ข้อมูล event และร้านที่จัดงาน',
    ];

    if (tableCount != null) {
      items.add('ดูจำนวนโต๊ะและไปเลือกโต๊ะในหน้าร้านได้');
    }

    return items;
  }

  List<String> get importantItems {
    return [
      'จำนวนโต๊ะ ราคา และที่นั่งว่างอาจเปลี่ยนตามวันที่เลือก',
      'เงื่อนไขการเข้า event และ dress code ขึ้นกับร้าน',
      isFree
          ? 'สิทธิ์ฟรีอาจมีจำนวนจำกัดหรือมีเงื่อนไขเพิ่มเติม'
          : 'ราคาเริ่มต้นอาจยังไม่รวมเงื่อนไขอื่นของร้าน',
    ];
  }

  List<String> get howToGetThereItems {
    final items = <String>['Event นี้จัดที่ $venueName'];

    if (eventData.hasDistance()) {
      items.add('อยู่ห่างจากตำแหน่งที่เลือกประมาณ $distanceLabel');
    }

    items.add(
      'กดปุ่มจองหรือดูร้านเพื่อเปิดหน้าร้านและดูข้อมูลเส้นทางเพิ่มเติม',
    );
    return items;
  }

  List<String> get tags {
    final values = <String>[
      musicStyle,
      ...?eventRecord?.styleVenues,
      ...?venueRecord?.styleVenuse,
    ];

    final normalized = <String>[];
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty &&
          trimmed != 'ไม่ระบุ' &&
          !normalized.contains(trimmed)) {
        normalized.add(trimmed);
      }
    }
    return normalized.take(6).toList();
  }
}

class _EventDetailSheet extends StatelessWidget {
  const _EventDetailSheet({
    required this.detailFuture,
    required this.fallbackEventData,
    required this.onViewVenue,
  });

  final Future<_EventDetailData> detailFuture;
  final DataEventsStruct fallbackEventData;
  final ValueChanged<_EventDetailData> onViewVenue;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.18,
      maxChildSize: 1.0,
      shouldCloseOnMinExtent: true,
      builder: (context, scrollController) {
        return FutureBuilder<_EventDetailData>(
          future: detailFuture,
          initialData: _EventDetailData(eventData: fallbackEventData),
          builder: (context, snapshot) {
            final detailData =
                snapshot.data ?? _EventDetailData(eventData: fallbackEventData);

            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFF090A0F)),
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: _buildHero(context, detailData),
                      ),
                      SliverToBoxAdapter(
                        child: _buildContent(context, detailData),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _EventBookingBar(
                      detailData: detailData,
                      onPressed: detailData.venueRef != null
                          ? () => onViewVenue(detailData)
                          : null,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHero(BuildContext context, _EventDetailData detailData) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      height: screenHeight * 0.60,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompactHero = constraints.maxHeight < 390.0;
          final posterTopInset =
              MediaQuery.paddingOf(context).top + (isCompactHero ? 42.0 : 58.0);
          final posterBottomInset = isCompactHero ? 10.0 : 14.0;

          return Stack(
            fit: StackFit.expand,
            children: [
              _buildPosterBackdrop(detailData.posterUrl),
              Positioned.fill(
                left: 18.0,
                top: posterTopInset,
                right: 18.0,
                bottom: posterBottomInset,
                child: _buildResponsivePosterImage(detailData.posterUrl),
              ),
              SafeArea(
                bottom: false,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 44.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(99.0),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    16.0,
                    0.0,
                    16.0,
                    6.0,
                  ),
                  child: _buildPosterVenueButton(detailData),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPosterBackdrop(String posterUrl) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          posterUrl,
          fit: BoxFit.cover,
          color: const Color(0xAA090A0F),
          colorBlendMode: BlendMode.darken,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF161820),
            child: const Center(
              child: Icon(
                Icons.event_rounded,
                color: Colors.white70,
                size: 54.0,
              ),
            ),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xD9000000), Color(0x88090A0F), Color(0xF0090A0F)],
              stops: [0.0, 0.58, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsivePosterImage(String posterUrl) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 26.0,
                    color: Color(0x99000000),
                    offset: Offset(0.0, 14.0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.network(
                  posterUrl,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Container(
                      color: const Color(0xFF161820),
                      child: const Center(
                        child: Icon(
                          Icons.event_rounded,
                          color: Colors.white70,
                          size: 54.0,
                        ),
                      ),
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

  Widget _buildPosterVenueButton(_EventDetailData detailData) {
    final canOpenVenue = detailData.venueRef != null;

    return Container(
      constraints: const BoxConstraints(minHeight: 74.0),
      padding: const EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        color: const Color(0xE61C1D24),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x33FFFFFF)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18.0,
            color: Color(0x66000000),
            offset: Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13.0),
            child: Image.network(
              detailData.venueImageUrl,
              width: 54.0,
              height: 54.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 54.0,
                height: 54.0,
                color: const Color(0xFF2A2C35),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: Colors.white70,
                  size: 24.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 11.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ร้านของ event นี้',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFB7BAC7),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  detailData.venueName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.0,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  detailData.tableCountLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFE7E8EE),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 88.0,
            height: 42.0,
            child: ElevatedButton.icon(
              onPressed: canOpenVenue ? () => onViewVenue(detailData) : null,
              icon: const Icon(Icons.storefront_rounded, size: 16.0),
              label: Text(
                'ดูร้าน',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                disabledBackgroundColor: const Color(0xFF555762),
                disabledForegroundColor: const Color(0xFFC7C8CE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, _EventDetailData detailData) {
    final tags = detailData.tags;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(18.0, 18.0, 18.0, 122.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detailData.eventTitle,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              height: 1.08,
              letterSpacing: 0.0,
            ),
          ),
          const SizedBox(height: 14.0),
          _EventInfoLine(
            icon: Icons.calendar_today_rounded,
            primary: detailData.eventDateLabel,
            secondary: detailData.priceSummaryLabel,
          ),
          const SizedBox(height: 12.0),
          _EventInfoLine(
            icon: Icons.location_on_outlined,
            primary: detailData.venueName,
            secondary: detailData.distanceLabel,
          ),
          if (tags.isNotEmpty) ...[
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: tags.map((tag) => _EventTag(label: tag)).toList(),
            ),
          ],
          const SizedBox(height: 24.0),
          _buildScheduleCard(detailData),
          if (!detailData.isFree) ...[
            const SizedBox(height: 18.0),
            _buildPaymentBanner(),
          ],
          const SizedBox(height: 24.0),
          Row(
            children: [
              Expanded(
                child: _EventMetricTile(
                  icon: Icons.groups_rounded,
                  label: 'ผู้เข้าร่วม',
                  value: detailData.capacityLabel,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _EventMetricTile(
                  icon: Icons.table_bar_rounded,
                  label: 'โต๊ะของ event',
                  value: detailData.tableCountLabel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'Event info',
            child: _buildParagraphs(detailData.detailParagraphs),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'Highlights',
            child: _buildBulletList(detailData.highlights),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'What’s included',
            child: _buildBulletList(detailData.includedItems),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'Important things to know',
            child: _buildBulletList(detailData.importantItems),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'How to get there',
            child: _buildBulletList(detailData.howToGetThereItems),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'Location',
            child: _buildLocationPanel(detailData),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'Event venue',
            child: _buildVenueContextCard(detailData),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(_EventDetailData detailData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF20212B),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                color: Color(0xFFE7E8EE),
                size: 21.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Timing and schedule',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
                size: 22.0,
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          _EventScheduleRow(
            title: 'Doors open',
            subtitle: detailData.doorsOpenLabel,
          ),
          const SizedBox(height: 16.0),
          _EventScheduleRow(
            title: 'Show starts',
            subtitle: detailData.showStartsLabel,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(14.0, 12.0, 14.0, 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF4D007B),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt_rounded, color: Color(0xFFE5B7FF), size: 26.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'จองโต๊ะหรือบัตรล่วงหน้า',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.0,
                  ),
                ),
                Text(
                  'เลือกแพ็กเกจและตรวจสอบราคาในหน้าร้าน',
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFE9D6F6),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraphs(List<String> paragraphs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(paragraphs.length, (index) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            bottom: index == paragraphs.length - 1 ? 0.0 : 10.0,
          ),
          child: Text(
            paragraphs[index],
            style: GoogleFonts.openSans(
              color: const Color(0xFFE4E5EA),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.45,
              letterSpacing: 0.0,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            bottom: index == items.length - 1 ? 0.0 : 8.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8.0),
                child: Container(
                  width: 4.0,
                  height: 4.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4E5EA),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  items[index],
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFE4E5EA),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLocationPanel(_EventDetailData detailData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on_rounded,
              color: Color(0xFFFF4B4B),
              size: 18.0,
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                detailData.venueName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          detailData.venueLocationLabel,
          style: GoogleFonts.openSans(
            color: const Color(0xFF78A8FF),
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            height: 1.3,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          height: 128.0,
          decoration: BoxDecoration(
            color: const Color(0xFF151720),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0x22FFFFFF)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _EventMapPreviewPainter()),
              ),
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.location_pin,
                  color: Color(0xFFFF3030),
                  size: 38.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVenueContextCard(_EventDetailData detailData) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF151720),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Image.network(
              detailData.venueImageUrl,
              width: 64.0,
              height: 64.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 64.0,
                height: 64.0,
                color: const Color(0xFF2A2C35),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailData.venueName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${detailData.tableCountLabel} • ${detailData.openCloseTime} • ${detailData.ratingLabel}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFB8BBC7),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    letterSpacing: 0.0,
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

class _EventInfoLine extends StatelessWidget {
  const _EventInfoLine({
    required this.icon,
    required this.primary,
    required this.secondary,
  });

  final IconData icon;
  final String primary;
  final String secondary;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFFB8BBC7), size: 20.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                primary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                  letterSpacing: 0.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                secondary,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: const Color(0xFF78A8FF),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EventScheduleRow extends StatelessWidget {
  const _EventScheduleRow({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 4.0),
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: const Color(0xFF9DFF5C),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6.0,
                  color: const Color(0xFF9DFF5C).withValues(alpha: 0.45),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: GoogleFonts.openSans(
                  color: const Color(0xFFAEB1BD),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EventBookingBar extends StatelessWidget {
  const _EventBookingBar({required this.detailData, required this.onPressed});

  final _EventDetailData detailData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(18.0, 12.0, 18.0, 12.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x00090A0F), Color(0xF2090A0F), Color(0xFF090A0F)],
            stops: [0.0, 0.34, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailData.priceSummaryLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    detailData.availabilityLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: const Color(0xFF9DFF5C),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14.0),
            SizedBox(
              width: 150.0,
              height: 52.0,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  disabledBackgroundColor: const Color(0xFF555762),
                  disabledForegroundColor: const Color(0xFFC7C8CE),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  detailData.bookingButtonLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.0,
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

class _EventMapPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final waterPaint = Paint()..color = const Color(0xFFBFE7F1);
    final landPaint = Paint()..color = const Color(0xFFE9EEF0);
    final roadPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..strokeWidth = 7.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final roadAccentPaint = Paint()
      ..color = const Color(0xFFFFD86B)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawRect(Offset.zero & size, landPaint);

    final waterPath = Path()
      ..moveTo(0, size.height * 0.18)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.03,
        size.width * 0.48,
        size.height * 0.26,
      )
      ..quadraticBezierTo(
        size.width * 0.74,
        size.height * 0.58,
        size.width,
        size.height * 0.42,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    final roadOne = Path()
      ..moveTo(size.width * 0.04, size.height * 0.76)
      ..cubicTo(
        size.width * 0.26,
        size.height * 0.52,
        size.width * 0.48,
        size.height * 0.88,
        size.width * 0.96,
        size.height * 0.62,
      );
    canvas.drawPath(roadOne, roadPaint);
    canvas.drawPath(roadOne, roadAccentPaint);

    final roadTwo = Path()
      ..moveTo(size.width * 0.16, 0)
      ..lineTo(size.width * 0.32, size.height)
      ..moveTo(size.width * 0.72, 0)
      ..lineTo(size.width * 0.58, size.height);
    canvas.drawPath(roadTwo, roadPaint..strokeWidth = 4.0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EventMetricTile extends StatelessWidget {
  const _EventMetricTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 82.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF151720),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: const Color(0xFFFF4B4B), size: 22.0),
          const SizedBox(height: 9.0),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: const Color(0xFFAEB1BD),
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.0,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              height: 1.12,
              letterSpacing: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventSection extends StatelessWidget {
  const _EventSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 10.0),
        child,
      ],
    );
  }
}

class _EventTag extends StatelessWidget {
  const _EventTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(11.0, 7.0, 11.0, 7.0),
      decoration: BoxDecoration(
        color: const Color(0xFF201D22),
        borderRadius: BorderRadius.circular(99.0),
        border: Border.all(color: const Color(0x33FF4B4B)),
      ),
      child: Text(
        label,
        style: GoogleFonts.openSans(
          color: const Color(0xFFFFDADA),
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
        ),
      ),
    );
  }
}
