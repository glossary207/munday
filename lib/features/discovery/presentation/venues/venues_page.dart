import 'package:provider/provider.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/shared/widgets/dialogs/filter_widget.dart';
import '/shared/widgets/layout/nav_bar_widget.dart';
import '/shared/widgets/misc/review_widget.dart';
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
import 'venues_model.dart';
import 'package:munday/core/theme/theme.dart';

DecorationImage? _safeDecorationImage(
  String? url, {
  BoxFit fit = BoxFit.cover,
}) {
  if (url == null || url.isEmpty) return null;
  final uri = Uri.tryParse(url);
  if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
    return null;
  }
  return DecorationImage(fit: fit, image: NetworkImage(url));
}

class VenuesPage extends ConsumerStatefulWidget {
  const VenuesPage({super.key});

  static String routeName = 'Venues';
  static String routePath = 'venues';

  @override
  ConsumerState<VenuesPage> createState() => _VenuesWidgetState();
}

class _VenuesWidgetState extends ConsumerState<VenuesPage>
    with TickerProviderStateMixin {
  late VenuesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = VenuesModel()..internalInit(context);

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue = await getCurrentUserLocation(
        defaultLocation: LatLng(0.0, 0.0),
      );
      _model.map = false;
      safeSetState(() {});
      context.appState.locationsearch = currentUserLocationValue;
      safeSetState(() {});
      context.appState.MoveMap = false;
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.textFieldFocusNode!.addListener(() async {
      _model.page = 1;
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

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                ),
              ),
            ),
          );
        }
        List<VenuesRecord> venuesVenuesRecordList = snapshot.data!;

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
                            if (_model.map ?? true)
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
                                    radian: context.appState.Filterdistance,
                                    items: functions.dataVenuseDocref(
                                      context.appState.Filterdistance,
                                      context.appState.locationsearch,
                                      (currentUserDocument?.loveVenuse
                                                  .toList() ??
                                              [])
                                          .toList(),
                                      context.appState.StyleMusic.toList(),
                                      context.appState.StyleVenuse.toList(),
                                      venuesVenuesRecordList.toList(),
                                    ),
                                    locationStart: context.appState.locationsearch,
                                    itemClick: context.appState.VenuseSelection,
                                    currentLocation: context.appState.locationsearch,
                                    whenSelect: () async {
                                      _model.slide = false;
                                      safeSetState(() {});
                                      await _model.carouselController
                                          ?.animateToPage(
                                            functions.searchIndexVenuse(
                                              functions
                                                  .dataVenuseDocref(
                                                    context.appState.Filterdistance,
                                                    context.appState.locationsearch,
                                                    (currentUserDocument
                                                                ?.loveVenuse
                                                                .toList() ??
                                                            [])
                                                        .toList(),
                                                    context.appState.StyleMusic
                                                        .toList(),
                                                    context.appState.StyleVenuse
                                                        .toList(),
                                                    venuesVenuesRecordList
                                                        .where(
                                                          (e) => functions
                                                              .showsearch(
                                                                _model
                                                                    .textController
                                                                    .text,
                                                                e.nameVenuse,
                                                              )!,
                                                        )
                                                        .toList(),
                                                  )
                                                  ?.toList(),
                                              context.appState.VenuseSelection,
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
                            if (_model.map ?? true)
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
                                        Colors.black,
                                      ],
                                      stops: [0.0, 0.9, 1.0],
                                      begin: AlignmentDirectional(0.0, -1.0),
                                      end: AlignmentDirectional(0, 1.0),
                                    ),
                                  ),
                                ),
                              ),
                            if (_model.map ?? true)
                              Container(
                                width: double.infinity,
                                height: 170.0,
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
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  height: 145.0,
                                  decoration: BoxDecoration(),
                                ),
                                if (!_model.map!)
                                  Flexible(
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: SingleChildScrollView(
                                        controller: _model.columnController,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (functions
                                                    .dataVenuse(
                                                      venuesVenuesRecordList
                                                          .where(
                                                            (e) => functions
                                                                .showsearch(
                                                                  _model
                                                                      .textController
                                                                      .text,
                                                                  e.nameVenuse,
                                                                )!,
                                                          )
                                                          .toList(),
                                                      context.appState.Filterdistance,
                                                      (currentUserDocument
                                                                  ?.loveVenuse
                                                                  .toList() ??
                                                              [])
                                                          .toList(),
                                                      context.appState.locationsearch,
                                                      context.appState.StyleMusic
                                                          .toList(),
                                                      context.appState.StyleVenuse
                                                          .toList(),
                                                      _model.page,
                                                      _model.map,
                                                      _model.lovefilter,
                                                    )
                                                    ?.length ==
                                                0)
                                              Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                      10.0,
                                                      5.0,
                                                      10.0,
                                                      10.0,
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
                                                                  16.0,
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_sas13dus,
                                                              style: Theme.of(context).textTheme.headlineMedium!.override(
                                                                font: GoogleFonts.outfit(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .headlineMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24.0,
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
                                                                        .headlineMedium!
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  4.0,
                                                                  0.0,
                                                                  30.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_x4tfqa1w,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(context).textTheme.labelMedium!.override(
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
                                                                  0xFF8A8A8A,
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            AuthUserStreamWidget(
                                              builder: (context) => Builder(
                                                builder: (context) {
                                                  final dataVenuse =
                                                      functions
                                                          .dataVenuse(
                                                            venuesVenuesRecordList
                                                                .where(
                                                                  (
                                                                    e,
                                                                  ) => functions.showsearch(
                                                                    _model
                                                                        .textController
                                                                        .text,
                                                                    e.nameVenuse,
                                                                  )!,
                                                                )
                                                                .toList(),
                                                            AppState()
                                                                .Filterdistance,
                                                            (currentUserDocument
                                                                        ?.loveVenuse
                                                                        .toList() ??
                                                                    [])
                                                                .toList(),
                                                            AppState()
                                                                .locationsearch,
                                                            AppState()
                                                                .StyleMusic
                                                                .toList(),
                                                            AppState()
                                                                .StyleVenuse
                                                                .toList(),
                                                            _model.page,
                                                            _model.map,
                                                            _model.lovefilter,
                                                          )
                                                          ?.toList() ??
                                                      [];

                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: List.generate(dataVenuse.length, (
                                                      dataVenuseIndex,
                                                    ) {
                                                      final dataVenuseItem =
                                                          dataVenuse[dataVenuseIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              10.0,
                                                              0.0,
                                                              10.0,
                                                              10.0,
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
                                                            context.pushNamed(
                                                              InVenusePage
                                                                  .routeName,
                                                              queryParameters: {
                                                                'idVenues': serializeParam(
                                                                  DataVenuesStruct.maybeFromMap(
                                                                    dataVenuseItem,
                                                                  )?.iDVenuse,
                                                                  ParamType
                                                                      .SupabaseDocRef,
                                                                ),
                                                                'distance': serializeParam(
                                                                  DataVenuesStruct.maybeFromMap(
                                                                        dataVenuseItem,
                                                                      )
                                                                      ?.distance
                                                                      .toString(),
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'index':
                                                                    serializeParam(
                                                                      2,
                                                                      ParamType
                                                                          .int,
                                                                    ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 197.4,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  Colors
                                                                      .transparent,
                                                                  Colors.black,
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
                                                                    12.0,
                                                                  ),
                                                              border: Border.all(
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                    1.0,
                                                                    -1.0,
                                                                  ),
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        MediaQuery.sizeOf(
                                                                          context,
                                                                        ).width *
                                                                        1.0,
                                                                    height:
                                                                        MediaQuery.sizeOf(
                                                                          context,
                                                                        ).height *
                                                                        0.99,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(
                                                                        0xFE000000,
                                                                      ),
                                                                      image: _safeDecorationImage(
                                                                        DataVenuesStruct.maybeFromMap(
                                                                          dataVenuseItem,
                                                                        )?.bg,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        MediaQuery.sizeOf(
                                                                          context,
                                                                        ).width *
                                                                        1.0,
                                                                    height:
                                                                        MediaQuery.sizeOf(
                                                                          context,
                                                                        ).height *
                                                                        1.0,
                                                                    decoration: BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                        colors: [
                                                                          Colors
                                                                              .transparent,
                                                                          Color(
                                                                            0xDD000000,
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
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12.0,
                                                                          ),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.11,
                                                                          ),
                                                                          child: Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                              15.0,
                                                                              10.0,
                                                                              0.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Container(
                                                                              width: 200.0,
                                                                              height: 18.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(
                                                                                  0x00FFFFFF,
                                                                                ),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          0.0,
                                                                                          0.0,
                                                                                          7.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Container(
                                                                                          height: double.infinity,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Color(
                                                                                              0xFFFF0000,
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            shape: BoxShape.rectangle,
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                        10.0,
                                                                                                        0.0,
                                                                                                        10.0,
                                                                                                        0.0,
                                                                                                      ),
                                                                                                      child: Text(
                                                                                                        AppLocalizations.of(
                                                                                                          context,
                                                                                                        )!.k_bzok1v08,
                                                                                                        textAlign: TextAlign.center,
                                                                                                        maxLines: 1,
                                                                                                        style:
                                                                                                            Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.displaySmall!.override(
                                                                                                              font: GoogleFonts.roboto(
                                                                                                                fontWeight: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.displaySmall!.fontWeight,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.displaySmall!.fontStyle,
                                                                                                              ),
                                                                                                              color: Colors.white,
                                                                                                              fontSize: 12.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.displaySmall!.fontWeight,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.displaySmall!.fontStyle,
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
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          0.0,
                                                                                          0.0,
                                                                                          7.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Container(
                                                                                          height: double.infinity,
                                                                                          decoration: BoxDecoration(
                                                                                            color:
                                                                                                Theme.of(
                                                                                                      context,
                                                                                                    )
                                                                                                    .extension<
                                                                                                      CustomColors
                                                                                                    >()!
                                                                                                    .primaryText,
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            shape: BoxShape.rectangle,
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                        10.0,
                                                                                                        0.0,
                                                                                                        10.0,
                                                                                                        0.0,
                                                                                                      ),
                                                                                                      child: Text(
                                                                                                        AppLocalizations.of(
                                                                                                          context,
                                                                                                        )!.k_40wk9ahf,
                                                                                                        textAlign: TextAlign.center,
                                                                                                        maxLines: 1,
                                                                                                        style:
                                                                                                            Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.displaySmall!.override(
                                                                                                              font: GoogleFonts.roboto(
                                                                                                                fontWeight: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.displaySmall!.fontWeight,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.displaySmall!.fontStyle,
                                                                                                              ),
                                                                                                              color: Color(
                                                                                                                0xFF15161E,
                                                                                                              ),
                                                                                                              fontSize: 12.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.displaySmall!.fontWeight,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.displaySmall!.fontStyle,
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
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                15.0,
                                                                                14.0,
                                                                                0.0,
                                                                                2.0,
                                                                              ),
                                                                              child: Text(
                                                                                valueOrDefault<
                                                                                      String
                                                                                    >(
                                                                                      DataVenuesStruct.maybeFromMap(
                                                                                        dataVenuseItem,
                                                                                      )?.nameVenuse,
                                                                                      'ไม่ระบุ',
                                                                                    )
                                                                                    .maybeHandleOverflow(
                                                                                      maxChars: 20,
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
                                                                                      color:
                                                                                          Theme.of(
                                                                                                context,
                                                                                              )
                                                                                              .extension<
                                                                                                CustomColors
                                                                                              >()!
                                                                                              .primaryBtnText,
                                                                                      fontSize: 24.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: Theme.of(
                                                                                        context,
                                                                                      ).textTheme.bodyMedium!.fontStyle,
                                                                                      shadows: [
                                                                                        Shadow(
                                                                                          color: Colors.black,
                                                                                          offset: Offset(
                                                                                            0.0,
                                                                                            0.0,
                                                                                          ),
                                                                                          blurRadius: 5.0,
                                                                                        ),
                                                                                        Shadow(
                                                                                          color: Colors.black,
                                                                                          offset: Offset(
                                                                                            0.0,
                                                                                            0.0,
                                                                                          ),
                                                                                          blurRadius: 8.0,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            if (DataVenuesStruct.maybeFromMap(
                                                                                  dataVenuseItem,
                                                                                )!.rating >
                                                                                3.0)
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  0.22,
                                                                                  -0.49,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    8.0,
                                                                                    9.5,
                                                                                    0.0,
                                                                                    0.0,
                                                                                  ),
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
                                                                                        builder:
                                                                                            (
                                                                                              context,
                                                                                            ) {
                                                                                              return GestureDetector(
                                                                                                onTap: () {
                                                                                                  FocusScope.of(
                                                                                                    context,
                                                                                                  ).unfocus();
                                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                                },
                                                                                                child: Padding(
                                                                                                  padding: MediaQuery.viewInsetsOf(
                                                                                                    context,
                                                                                                  ),
                                                                                                  child: ReviewWidget(
                                                                                                    idVenues: DataVenuesStruct.maybeFromMap(
                                                                                                      dataVenuseItem,
                                                                                                    )?.iDVenuse,
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                      ).then(
                                                                                        (
                                                                                          value,
                                                                                        ) => safeSetState(
                                                                                          () {},
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 22.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(
                                                                                          0xFFFF0000,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(
                                                                                          90.0,
                                                                                        ),
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
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Icon(
                                                                                              Icons.star_rounded,
                                                                                              color:
                                                                                                  Theme.of(
                                                                                                        context,
                                                                                                      )
                                                                                                      .extension<
                                                                                                        CustomColors
                                                                                                      >()!
                                                                                                      .primaryText,
                                                                                              size: 15.0,
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              0.0,
                                                                                              1.5,
                                                                                              7.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Text(
                                                                                              formatNumber(
                                                                                                DataVenuesStruct.maybeFromMap(
                                                                                                  dataVenuseItem,
                                                                                                )!.rating,
                                                                                                formatType: FormatType.custom,
                                                                                                format: '.0',
                                                                                                locale: '',
                                                                                              ).maybeHandleOverflow(
                                                                                                maxChars: 3,
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
                                                                                                    color:
                                                                                                        Theme.of(
                                                                                                              context,
                                                                                                            )
                                                                                                            .extension<
                                                                                                              CustomColors
                                                                                                            >()!
                                                                                                            .primaryText,
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 1.0,
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
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            0.0,
                                                                          ),
                                                                          child: Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              10.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(
                                                                                    -0.9,
                                                                                    -1.0,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                      15.0,
                                                                                      0.0,
                                                                                      15.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Text(
                                                                                      valueOrDefault<
                                                                                        String
                                                                                      >(
                                                                                        DataVenuesStruct.maybeFromMap(
                                                                                          dataVenuseItem,
                                                                                        )?.openCloseTime,
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
                                                                                              0xFFF1F1F1,
                                                                                            ),
                                                                                            fontSize: 13.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(
                                                                                              context,
                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                            shadows: [
                                                                                              Shadow(
                                                                                                color: Colors.black,
                                                                                                offset: Offset(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                blurRadius: 5.0,
                                                                                              ),
                                                                                              Shadow(
                                                                                                color: Colors.black,
                                                                                                offset: Offset(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                blurRadius: 8.0,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Image.network(
                                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                  width: 20.0,
                                                                                  height: 20.0,
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
                                                                                        DataVenuesStruct.maybeFromMap(
                                                                                          dataVenuseItem,
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
                                                                                              0xFFF1F1F1,
                                                                                            ),
                                                                                            fontSize: 13.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(
                                                                                              context,
                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                            shadows: [
                                                                                              Shadow(
                                                                                                color: Colors.black,
                                                                                                offset: Offset(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                blurRadius: 5.0,
                                                                                              ),
                                                                                              Shadow(
                                                                                                color: Colors.black,
                                                                                                offset: Offset(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                blurRadius: 8.0,
                                                                                              ),
                                                                                            ],
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
                                                                                    )!.k_64vssocb,
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
                                                                                            0xFFF1F1F1,
                                                                                          ),
                                                                                          fontSize: 13.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: Theme.of(
                                                                                            context,
                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color: Colors.black,
                                                                                              offset: Offset(
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              blurRadius: 5.0,
                                                                                            ),
                                                                                            Shadow(
                                                                                              color: Colors.black,
                                                                                              offset: Offset(
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              blurRadius: 8.0,
                                                                                            ),
                                                                                          ],
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
                                                                                      DataVenuesStruct.maybeFromMap(
                                                                                        dataVenuseItem,
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
                                                                                            0xFFF1F1F1,
                                                                                          ),
                                                                                          fontSize: 13.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: Theme.of(
                                                                                            context,
                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color: Colors.black,
                                                                                              offset: Offset(
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              blurRadius: 5.0,
                                                                                            ),
                                                                                            Shadow(
                                                                                              color: Colors.black,
                                                                                              offset: Offset(
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              blurRadius: 8.0,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(
                                                                                    0.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                      15.0,
                                                                                      0.0,
                                                                                      0.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Text(
                                                                                      valueOrDefault<
                                                                                        String
                                                                                      >(
                                                                                        DataVenuesStruct.maybeFromMap(
                                                                                          dataVenuseItem,
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
                                                                                              0xFFF1F1F1,
                                                                                            ),
                                                                                            fontSize: 13.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(
                                                                                              context,
                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                            shadows: [
                                                                                              Shadow(
                                                                                                color: Colors.black,
                                                                                                offset: Offset(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                blurRadius: 5.0,
                                                                                              ),
                                                                                              Shadow(
                                                                                                color: Colors.black,
                                                                                                offset: Offset(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                blurRadius: 8.0,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    5.0,
                                                                                    0.0,
                                                                                    8.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.k_uspi5h7x,
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
                                                                                            0xFFF1F1F1,
                                                                                          ),
                                                                                          fontSize: 13.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: Theme.of(
                                                                                            context,
                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color: Colors.black,
                                                                                              offset: Offset(
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              blurRadius: 5.0,
                                                                                            ),
                                                                                            Shadow(
                                                                                              color: Colors.black,
                                                                                              offset: Offset(
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              blurRadius: 8.0,
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
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            9.0,
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                          child: Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  0.0,
                                                                                  0.0,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    15.0,
                                                                                    0.0,
                                                                                    0.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Container(
                                                                                    width: 80.0,
                                                                                    height: 80.0,
                                                                                    clipBehavior: Clip.antiAlias,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Image.network(
                                                                                      valueOrDefault<
                                                                                        String
                                                                                      >(
                                                                                        DataVenuesStruct.maybeFromMap(
                                                                                          dataVenuseItem,
                                                                                        )?.logo,
                                                                                        'ไม่ระบุ',
                                                                                      ),
                                                                                      fit: BoxFit.cover,
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
                                                                        AlignmentDirectional(
                                                                          1.0,
                                                                          1.0,
                                                                        ),
                                                                    child: Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child: Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          10.0,
                                                                        ),
                                                                        child: Container(
                                                                          width:
                                                                              200.0,
                                                                          height:
                                                                              50.0,
                                                                          child: Stack(
                                                                            alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0,
                                                                            ),
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  -0.2,
                                                                                  0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  width: 40.0,
                                                                                  height: 40.0,
                                                                                  clipBehavior: Clip.antiAlias,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Image.asset(
                                                                                    'assets/images/20240515154627-Create_an_image_of_a.png',
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  0.2,
                                                                                  0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  width: 40.0,
                                                                                  height: 40.0,
                                                                                  clipBehavior: Clip.antiAlias,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Image.asset(
                                                                                    'assets/images/1-1-3.jpg',
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  0.6,
                                                                                  0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  width: 40.0,
                                                                                  height: 40.0,
                                                                                  clipBehavior: Clip.antiAlias,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Image.asset(
                                                                                    'assets/images/20240515161820-Create_an_image_of_a.png',
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  1.0,
                                                                                  0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  width: 40.0,
                                                                                  height: 40.0,
                                                                                  clipBehavior: Clip.antiAlias,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Image.asset(
                                                                                    'assets/images/20240515182857-Create_an_image_of_a.png',
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0,
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
                                                                        if ((currentUserDocument?.loveVenuse.toList() ??
                                                                                [])
                                                                            .contains(
                                                                              DataVenuesStruct.maybeFromMap(
                                                                                dataVenuseItem,
                                                                              )?.iDVenuse,
                                                                            )) {
                                                                          await currentUserReference!.update({
                                                                            ...mapToSupabase({
                                                                              'loveVenuse': FieldValue.arrayRemove(
                                                                                [
                                                                                  DataVenuesStruct.maybeFromMap(
                                                                                    dataVenuseItem,
                                                                                  )?.iDVenuse,
                                                                                ],
                                                                              ),
                                                                            }),
                                                                          });
                                                                        } else {
                                                                          await currentUserReference!.update({
                                                                            ...mapToSupabase({
                                                                              'loveVenuse': FieldValue.arrayUnion(
                                                                                [
                                                                                  DataVenuesStruct.maybeFromMap(
                                                                                    dataVenuseItem,
                                                                                  )?.iDVenuse,
                                                                                ],
                                                                              ),
                                                                            }),
                                                                          });
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                        width:
                                                                            42.0,
                                                                        height:
                                                                            42.0,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                            10.0,
                                                                          ),
                                                                        ),
                                                                        child: Stack(
                                                                          children: [
                                                                            if (!(currentUserDocument?.loveVenuse.toList() ??
                                                                                    [])
                                                                                .contains(
                                                                                  DataVenuesStruct.maybeFromMap(
                                                                                    dataVenuseItem,
                                                                                  )?.iDVenuse,
                                                                                ))
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
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
                                                                            if ((currentUserDocument?.loveVenuse.toList() ??
                                                                                    [])
                                                                                .contains(
                                                                                  DataVenuesStruct.maybeFromMap(
                                                                                    dataVenuseItem,
                                                                                  )?.iDVenuse,
                                                                                ))
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
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
                                                    }),
                                                  );
                                                },
                                              ),
                                            ),
                                            if (functions
                                                    .dataVenuse(
                                                      venuesVenuesRecordList
                                                          .where(
                                                            (e) => functions
                                                                .showsearch(
                                                                  _model
                                                                      .textController
                                                                      .text,
                                                                  e.nameVenuse,
                                                                )!,
                                                          )
                                                          .toList(),
                                                      context.appState.Filterdistance,
                                                      (currentUserDocument
                                                                  ?.loveVenuse
                                                                  .toList() ??
                                                              [])
                                                          .toList(),
                                                      context.appState.locationsearch,
                                                      context.appState.StyleMusic
                                                          .toList(),
                                                      context.appState.StyleVenuse
                                                          .toList(),
                                                      _model.page,
                                                      true,
                                                      _model.lovefilter,
                                                    )!
                                                    .length >
                                                20)
                                              Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                      0.0,
                                                      10.0,
                                                      0.0,
                                                      0.0,
                                                    ),
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
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              10.0,
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
                                                            if (_model.page !=
                                                                1) {
                                                              _model.page =
                                                                  _model.page! +
                                                                  -1;
                                                              safeSetState(
                                                                () {},
                                                              );
                                                              await _model
                                                                  .columnController
                                                                  ?.animateTo(
                                                                    0,
                                                                    duration: Duration(
                                                                      milliseconds:
                                                                          200,
                                                                    ),
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
                                                              decoration:
                                                                  BoxDecoration(
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
                                                                        _model
                                                                            .page
                                                                            ?.toString(),
                                                                        '0',
                                                                      ),
                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                        font: GoogleFonts.openSans(
                                                                          fontWeight: Theme.of(
                                                                            context,
                                                                          ).textTheme.bodyMedium!.fontWeight,
                                                                          fontStyle: Theme.of(
                                                                            context,
                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
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
                                                                  milliseconds:
                                                                      200,
                                                                ),
                                                                curve:
                                                                    Curves.ease,
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
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            if (!_model.map!)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (currentUserDocument?.loginVenuesRoom != null &&
                                        (currentUserDocument?.iDROOMVenues.isNotEmpty ?? false))
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
                                            builder: (context) => StreamBuilder<UserInVenuesRecord>(
                                              stream:
                                                  UserInVenuesRecord.getDocument(
                                                    (currentUserDocument
                                                                ?.iDROOMVenues
                                                                .toList() ??
                                                            [])
                                                        .firstOrNull!,
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

                                                    context.appState.StyleVenuse = [];
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
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
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
                                                                    valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.logoRoom,
                                                                      '',
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
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Stack(
                                                                        children: [
                                                                          if (containerUserInVenuesRecord.user
                                                                                  .where(
                                                                                    (
                                                                                      e,
                                                                                    ) => functions.checkdate(
                                                                                      (e as dynamic)?.date,
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
                                                                                  image: DecorationImage(
                                                                                    fit: BoxFit.cover,
                                                                                    image: Image.network(
                                                                                      '',
                                                                                    ).image,
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
                                                                                                  (e as dynamic)?.date,
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
                                                                        shape: BoxShape
                                                                            .circle,
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
                                                                                image: DecorationImage(
                                                                                  fit: BoxFit.cover,
                                                                                  image: Image.network(
                                                                                    '',
                                                                                  ).image,
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
                                            ),
                                          ),
                                        ),
                                      ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: ChangeNotifierProvider.value(
                                        value: _model.navBarModel.setOnUpdate(
                                          onUpdate: () => safeSetState(() {}),
                                        ),
                                        child: NavBarWidget(
                                          items: context.appState.menuItems,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (_model.map ?? true)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 300.0,
                                  decoration: BoxDecoration(),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                                                  )!.k_llm1xn4n,
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
                                                      13.0,
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
                                                        if (_model.map!) {
                                                          _model.map = false;
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.map = true;
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
                                                              Theme.of(context)
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
                                                        color: Theme.of(context)
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
                                                        context.appState.MoveMap =
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
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                0.0,
                                                5.0,
                                              ),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => Builder(
                                              builder: (context) {
                                                final dataVenuseMap =
                                                    functions
                                                        .dataVenuse(
                                                          venuesVenuesRecordList
                                                              .where(
                                                                (e) => functions
                                                                    .showsearch(
                                                                      _model
                                                                          .textController
                                                                          .text,
                                                                      e.nameVenuse,
                                                                    )!,
                                                              )
                                                              .toList(),
                                                          AppState()
                                                              .Filterdistance,
                                                          (currentUserDocument
                                                                      ?.loveVenuse
                                                                      .toList() ??
                                                                  [])
                                                              .toList(),
                                                          AppState()
                                                              .locationsearch,
                                                          context.appState.StyleMusic
                                                              .toList(),
                                                          context.appState.StyleVenuse
                                                              .toList(),
                                                          _model.page,
                                                          _model.map,
                                                          _model.lovefilter,
                                                        )
                                                        ?.toList() ??
                                                    [];

                                                return Container(
                                                  width: double.infinity,
                                                  height: 210.0,
                                                  child: CarouselSlider.builder(
                                                    itemCount:
                                                        dataVenuseMap.length,
                                                    itemBuilder:
                                                        (
                                                          context,
                                                          dataVenuseMapIndex,
                                                          _,
                                                        ) {
                                                          final dataVenuseMapItem =
                                                              dataVenuseMap[dataVenuseMapIndex];
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  10.0,
                                                                ),
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
                                                                context.pushNamed(
                                                                  InVenusePage
                                                                      .routeName,
                                                                  queryParameters: {
                                                                    'idVenues': serializeParam(
                                                                      DataVenuesStruct.maybeFromMap(
                                                                        dataVenuseMapItem,
                                                                      )?.iDVenuse,
                                                                      ParamType
                                                                          .SupabaseDocRef,
                                                                    ),
                                                                    'distance': serializeParam(
                                                                      DataVenuesStruct.maybeFromMap(
                                                                        dataVenuseMapItem,
                                                                      )?.distance.toString(),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'index': serializeParam(
                                                                      2,
                                                                      ParamType
                                                                          .int,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 160.0,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                    colors: [
                                                                      Colors
                                                                          .transparent,
                                                                      Colors
                                                                          .black,
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
                                                                        12.0,
                                                                      ),
                                                                  border: Border.all(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                        1.0,
                                                                        -1.0,
                                                                      ),
                                                                  child: Stack(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            MediaQuery.sizeOf(
                                                                              context,
                                                                            ).width *
                                                                            1.0,
                                                                        height:
                                                                            MediaQuery.sizeOf(
                                                                              context,
                                                                            ).height *
                                                                            0.99,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(
                                                                            0xFE000000,
                                                                          ),
                                                                          image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: Image.network(
                                                                              DataVenuesStruct.maybeFromMap(
                                                                                dataVenuseMapItem,
                                                                              )!.bg,
                                                                            ).image,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(
                                                                            12.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            MediaQuery.sizeOf(
                                                                              context,
                                                                            ).width *
                                                                            1.0,
                                                                        height:
                                                                            MediaQuery.sizeOf(
                                                                              context,
                                                                            ).height *
                                                                            1.0,
                                                                        decoration: BoxDecoration(
                                                                          gradient: LinearGradient(
                                                                            colors: [
                                                                              Colors.transparent,
                                                                              Color(
                                                                                0xDD000000,
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
                                                                          borderRadius: BorderRadius.circular(
                                                                            12.0,
                                                                          ),
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(
                                                                                -1.0,
                                                                                0.11,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                  15.0,
                                                                                  10.0,
                                                                                  0.0,
                                                                                  0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  width: 200.0,
                                                                                  height: 18.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(
                                                                                      0x00FFFFFF,
                                                                                    ),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              0.0,
                                                                                              0.0,
                                                                                              7.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Container(
                                                                                              height: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color(
                                                                                                  0xFFFF0000,
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(
                                                                                                  10.0,
                                                                                                ),
                                                                                                shape: BoxShape.rectangle,
                                                                                              ),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            10.0,
                                                                                                            0.0,
                                                                                                            10.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!.k_x1d4qe53,
                                                                                                            textAlign: TextAlign.center,
                                                                                                            maxLines: 1,
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.displaySmall!.override(
                                                                                                                  font: GoogleFonts.roboto(
                                                                                                                    fontWeight: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.displaySmall!.fontWeight,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.displaySmall!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Colors.white,
                                                                                                                  fontSize: 12.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.displaySmall!.fontWeight,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.displaySmall!.fontStyle,
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
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              0.0,
                                                                                              0.0,
                                                                                              7.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Container(
                                                                                              height: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                color:
                                                                                                    Theme.of(
                                                                                                          context,
                                                                                                        )
                                                                                                        .extension<
                                                                                                          CustomColors
                                                                                                        >()!
                                                                                                        .primaryText,
                                                                                                borderRadius: BorderRadius.circular(
                                                                                                  10.0,
                                                                                                ),
                                                                                                shape: BoxShape.rectangle,
                                                                                              ),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            10.0,
                                                                                                            0.0,
                                                                                                            10.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!.k_463p001w,
                                                                                                            textAlign: TextAlign.center,
                                                                                                            maxLines: 1,
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.displaySmall!.override(
                                                                                                                  font: GoogleFonts.roboto(
                                                                                                                    fontWeight: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.displaySmall!.fontWeight,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.displaySmall!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFF15161E,
                                                                                                                  ),
                                                                                                                  fontSize: 12.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.displaySmall!.fontWeight,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.displaySmall!.fontStyle,
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
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    15.0,
                                                                                    14.0,
                                                                                    0.0,
                                                                                    2.0,
                                                                                  ),
                                                                                  child: Text(
                                                                                    valueOrDefault<
                                                                                          String
                                                                                        >(
                                                                                          DataVenuesStruct.maybeFromMap(
                                                                                            dataVenuseMapItem,
                                                                                          )?.nameVenuse,
                                                                                          'ไม่ระบุ',
                                                                                        )
                                                                                        .maybeHandleOverflow(
                                                                                          maxChars: 20,
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
                                                                                          color:
                                                                                              Theme.of(
                                                                                                    context,
                                                                                                  )
                                                                                                  .extension<
                                                                                                    CustomColors
                                                                                                  >()!
                                                                                                  .primaryBtnText,
                                                                                          fontSize: 24.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: Theme.of(
                                                                                            context,
                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                if (DataVenuesStruct.maybeFromMap(
                                                                                      dataVenuseMapItem,
                                                                                    )!.rating >
                                                                                    3.0)
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      0.22,
                                                                                      -0.49,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        8.0,
                                                                                        9.5,
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
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
                                                                                            builder:
                                                                                                (
                                                                                                  context,
                                                                                                ) {
                                                                                                  return GestureDetector(
                                                                                                    onTap: () {
                                                                                                      FocusScope.of(
                                                                                                        context,
                                                                                                      ).unfocus();
                                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                                    },
                                                                                                    child: Padding(
                                                                                                      padding: MediaQuery.viewInsetsOf(
                                                                                                        context,
                                                                                                      ),
                                                                                                      child: ReviewWidget(
                                                                                                        idVenues: DataVenuesStruct.maybeFromMap(
                                                                                                          dataVenuseMapItem,
                                                                                                        )?.iDVenuse,
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                          ).then(
                                                                                            (
                                                                                              value,
                                                                                            ) => safeSetState(
                                                                                              () {},
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 22.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Color(
                                                                                              0xFFFF0000,
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              90.0,
                                                                                            ),
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
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Icon(
                                                                                                  Icons.star_rounded,
                                                                                                  color:
                                                                                                      Theme.of(
                                                                                                            context,
                                                                                                          )
                                                                                                          .extension<
                                                                                                            CustomColors
                                                                                                          >()!
                                                                                                          .primaryText,
                                                                                                  size: 15.0,
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  0.0,
                                                                                                  1.5,
                                                                                                  7.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  formatNumber(
                                                                                                    DataVenuesStruct.maybeFromMap(
                                                                                                      dataVenuseMapItem,
                                                                                                    )!.rating,
                                                                                                    formatType: FormatType.custom,
                                                                                                    format: '.0',
                                                                                                    locale: '',
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
                                                                                                        color:
                                                                                                            Theme.of(
                                                                                                                  context,
                                                                                                                )
                                                                                                                .extension<
                                                                                                                  CustomColors
                                                                                                                >()!
                                                                                                                .primaryText,
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 1.0,
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
                                                                                    ),
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(
                                                                                1.0,
                                                                                0.0,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                  0.0,
                                                                                  0.0,
                                                                                  10.0,
                                                                                  0.0,
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(
                                                                                        -0.9,
                                                                                        -1.0,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          15.0,
                                                                                          0.0,
                                                                                          15.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Text(
                                                                                          valueOrDefault<
                                                                                            String
                                                                                          >(
                                                                                            DataVenuesStruct.maybeFromMap(
                                                                                              dataVenuseMapItem,
                                                                                            )?.openCloseTime,
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
                                                                                    Image.network(
                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                      width: 20.0,
                                                                                      height: 20.0,
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
                                                                                            DataVenuesStruct.maybeFromMap(
                                                                                              dataVenuseMapItem,
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
                                                                                        )!.k_v2gfpxfo,
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
                                                                                        2.0,
                                                                                        0.0,
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Text(
                                                                                        valueOrDefault<
                                                                                          String
                                                                                        >(
                                                                                          DataVenuesStruct.maybeFromMap(
                                                                                            dataVenuseMapItem,
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
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          15.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Text(
                                                                                          valueOrDefault<
                                                                                                String
                                                                                              >(
                                                                                                DataVenuesStruct.maybeFromMap(
                                                                                                  dataVenuseMapItem,
                                                                                                )?.distance.toString(),
                                                                                                'ไม่ระบุ',
                                                                                              )
                                                                                              .maybeHandleOverflow(
                                                                                                maxChars: 4,
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
                                                                                        8.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Text(
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!.k_p5358ybs,
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
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                9.0,
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      0.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        15.0,
                                                                                        0.0,
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Container(
                                                                                        width: 80.0,
                                                                                        height: 80.0,
                                                                                        clipBehavior: Clip.antiAlias,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          valueOrDefault<
                                                                                            String
                                                                                          >(
                                                                                            DataVenuesStruct.maybeFromMap(
                                                                                              dataVenuseMapItem,
                                                                                            )?.logo,
                                                                                            'ไม่ระบุ',
                                                                                          ),
                                                                                          fit: BoxFit.cover,
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
                                                                            AlignmentDirectional(
                                                                              1.0,
                                                                              1.0,
                                                                            ),
                                                                        child: Container(
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                        ),
                                                                      ),
                                                                      if (false)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0,
                                                                          ),
                                                                          child: Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              10.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Icon(
                                                                              Icons.favorite_outlined,
                                                                              color: Color(
                                                                                0xFFFF0000,
                                                                              ),
                                                                              size: 25.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      if (true)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0,
                                                                          ),
                                                                          child: Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              9.0,
                                                                              10.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Icon(
                                                                              Icons.favorite_border_sharp,
                                                                              color: Color(
                                                                                0xFFFDFDFD,
                                                                              ),
                                                                              size: 25.0,
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
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child: Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              10.0,
                                                                              10.0,
                                                                            ),
                                                                            child: Container(
                                                                              width: 200.0,
                                                                              height: 50.0,
                                                                              child: Stack(
                                                                                alignment: AlignmentDirectional(
                                                                                  -1.0,
                                                                                  0.0,
                                                                                ),
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      -0.2,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 40.0,
                                                                                      height: 40.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.asset(
                                                                                        'assets/images/20240515154627-Create_an_image_of_a.png',
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      0.2,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 40.0,
                                                                                      height: 40.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.asset(
                                                                                        'assets/images/1-1-3.jpg',
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      0.6,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 40.0,
                                                                                      height: 40.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.asset(
                                                                                        'assets/images/20240515161820-Create_an_image_of_a.png',
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      1.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 40.0,
                                                                                      height: 40.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.asset(
                                                                                        'assets/images/20240515182857-Create_an_image_of_a.png',
                                                                                        fit: BoxFit.cover,
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
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                    carouselController:
                                                        _model.carouselController ??=
                                                            CarouselSliderController(),
                                                    options: CarouselOptions(
                                                      initialPage: max(
                                                        0,
                                                        min(
                                                          0,
                                                          dataVenuseMap.length -
                                                              1,
                                                        ),
                                                      ),
                                                      viewportFraction: 1.0,
                                                      disableCenter: true,
                                                      enlargeCenterPage: true,
                                                      enlargeFactor: 0.25,
                                                      enableInfiniteScroll:
                                                          false,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      autoPlay: false,
                                                      onPageChanged: (index, _) async {
                                                        _model.carouselCurrentIndex =
                                                            index;
                                                        if (_model.slide ==
                                                            true) {
                                                          AppState()
                                                                  .VenuseSelection =
                                                              DataVenuesStruct.maybeFromMap(
                                                                dataVenuseMap
                                                                    .elementAtOrNull(
                                                                      _model
                                                                          .carouselCurrentIndex,
                                                                    ),
                                                              )?.iDVenuse;
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            90.0,
                                                          ),
                                                      border: Border.all(
                                                        color: Color(
                                                          0x98757575,
                                                        ),
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                15.0,
                                                                2.0,
                                                                5.0,
                                                                2.0,
                                                              ),
                                                          child: Text(
                                                            functions
                                                                .add1(
                                                                  _model
                                                                      .carouselCurrentIndex,
                                                                )
                                                                .toString(),
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                                2.0,
                                                                0.0,
                                                                2.0,
                                                              ),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.k_a9sq8iz0,
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
                                                              color: Color(
                                                                0xFF757575,
                                                              ),
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
                                                                5.0,
                                                                2.0,
                                                                15.0,
                                                                2.0,
                                                              ),
                                                          child: AuthUserStreamWidget(
                                                            builder: (context) => Text(
                                                              functions
                                                                  .add1(
                                                                    functions
                                                                        .dataVenuse(
                                                                          venuesVenuesRecordList
                                                                              .where(
                                                                                (
                                                                                  e,
                                                                                ) => functions.showsearch(
                                                                                  _model.textController.text,
                                                                                  e.nameVenuse,
                                                                                )!,
                                                                              )
                                                                              .toList(),
                                                                          AppState()
                                                                              .Filterdistance,
                                                                          (currentUserDocument?.loveVenuse.toList() ??
                                                                                  [])
                                                                              .toList(),
                                                                          AppState()
                                                                              .locationsearch,
                                                                          AppState()
                                                                              .StyleMusic
                                                                              .toList(),
                                                                          AppState()
                                                                              .StyleVenuse
                                                                              .toList(),
                                                                          _model
                                                                              .page,
                                                                          _model
                                                                              .map,
                                                                          _model
                                                                              .lovefilter,
                                                                        )
                                                                        ?.length,
                                                                  )
                                                                  .toString(),
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                  0xFF757575,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                                          valueOrDefault<
                                                            String
                                                          >(
                                                            currentUserPhoto,
                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
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
                                                            0xFFFF0000,
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
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_nvcmanls,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
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
                                                              color: Theme.of(context)
                                                                  .extension<
                                                                    CustomColors
                                                                  >()!
                                                                  .primaryText,
                                                              fontSize: 17.0,
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
                                      8.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 100.0,
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
                                                    Icons.search,
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
                                                          0.5,
                                                          0.8,
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
                                                            safeSetState(() {});
                                                          },
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        isDense: false,
                                                        hintText:
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.k_wtlekh8b,
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
                                                            color: Theme.of(context)
                                                                .extension<
                                                                  CustomColors
                                                                >()!
                                                                .secondaryText,
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
                                                          blurRadius: 4.0,
                                                          color: Color(
                                                            0x33000000,
                                                          ),
                                                          offset: Offset(
                                                            2.0,
                                                            2.0,
                                                          ),
                                                          spreadRadius: 3.0,
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
                                              if (_model.map!) {
                                                _model.map = false;
                                                safeSetState(() {});
                                              } else {
                                                _model.map = true;
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
                                                  color: _model.map!
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
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0,
                                        0.0,
                                        0.0,
                                        10.0,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x00FFFFFF),
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          controller: _model.rowController,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
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
                                                            8.0,
                                                            0.0,
                                                            8.0,
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
                                                                  0.0,
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
                                                          Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.k_9v2v1ujq,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                              color:
                                                                  Colors.white,
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
                                ],
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
