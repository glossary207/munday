import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/core/utils/app_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'option_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'option_model.dart';

class OptionWidget extends ConsumerStatefulWidget {
  const OptionWidget({super.key});

  @override
  ConsumerState<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends ConsumerState<OptionWidget>
    with TickerProviderStateMixin {
  late OptionModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = OptionModel()..internalInit(context);

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
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
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 620.0.ms,
            begin: Offset(-10.0, -10.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 620.0.ms,
            begin: Offset(-10.0, -10.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 620.0.ms,
            begin: Offset(-10.0, -10.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        decoration: BoxDecoration(color: Color(0xB2000000)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 592.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE20000), Color(0xFF673AB7)],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0,
                                          20.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Theme.of(context)
                                                .extension<CustomColors>()!
                                                .primaryText,
                                            size: 30.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0,
                                      30.0,
                                      0.0,
                                      0.0,
                                    ),
                                    child:
                                        Container(
                                          width: 160.0,
                                          height: 160.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.network(
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/5s0qvzhuscfm/6.png',
                                              ).image,
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          alignment: AlignmentDirectional(
                                            0.0,
                                            0.0,
                                          ),
                                        ).animateOnPageLoad(
                                          animationsMap['containerOnPageLoadAnimation1']!,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                10.0,
                                0.0,
                                0.0,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.k_u2te43sd,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium!.fontStyle,
                                      ),
                                      fontSize: 28.0,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium!.fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                5.0,
                                0.0,
                                10.0,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.k_qdjyp8zy,
                                style: Theme.of(context).textTheme.labelMedium!
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: Theme.of(
                                          context,
                                        ).textTheme.labelMedium!.fontWeight,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.labelMedium!.fontStyle,
                                      ),
                                      color: Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.primaryText,
                                      fontSize: 14.0,
                                      letterSpacing: 0.8,
                                      fontWeight: Theme.of(
                                        context,
                                      ).textTheme.labelMedium!.fontWeight,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.labelMedium!.fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                15.0,
                                0.0,
                                0.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.k_xx981ba6,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0,
                                          10.0,
                                          5.0,
                                          0.0,
                                        ),
                                        child:
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (context.appState.apione !=
                                                    '') {
                                                  await launchURL(
                                                    context.appState.apione,
                                                  );
                                                  _model.re1 =
                                                      await CreatecheckoutoneCall.call(
                                                        uid: currentUserUid,
                                                        email: currentUserEmail,
                                                      );

                                                  context.appState.apione =
                                                      getJsonField(
                                                        (_model.re1?.jsonBody ??
                                                            ''),
                                                        r'''$.url''',
                                                      ).toString();
                                                  safeSetState(() {});
                                                } else {
                                                  _model.re11 =
                                                      await CreatecheckoutoneCall.call(
                                                        uid: currentUserUid,
                                                        email: currentUserEmail,
                                                      );

                                                  context
                                                      .appState
                                                      .apione = getJsonField(
                                                    (_model.re11?.jsonBody ??
                                                        ''),
                                                    r'''$.url''',
                                                  ).toString();
                                                  safeSetState(() {});
                                                  await launchURL(
                                                    context.appState.apione,
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 115.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(0x33000000),
                                                      offset: Offset(0.0, 2.0),
                                                      spreadRadius: 3.0,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                        bottomRight:
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                        topLeft:
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                        topRight:
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                10.0,
                                                              ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      15.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8.0,
                                                                      ),
                                                                  child: Image.network(
                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/5s0qvzhuscfm/6.png',
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    fit: BoxFit
                                                                        .cover,
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
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_6d4njuve,
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
                                                                    letterSpacing:
                                                                        0.0,
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
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: AuthUserStreamWidget(
                                                                  builder: (context) =>
                                                                      StreamBuilder<
                                                                        List<
                                                                          StoreRecord
                                                                        >
                                                                      >(
                                                                        stream: queryStoreRecord(
                                                                          queryBuilder:
                                                                              (
                                                                                storeRecord,
                                                                              ) => storeRecord.where(
                                                                                'namestore',
                                                                                isEqualTo: valueOrDefault(
                                                                                  currentUserDocument?.checkin,
                                                                                  '',
                                                                                ),
                                                                              ),
                                                                          singleRecord:
                                                                              true,
                                                                        ),
                                                                        builder:
                                                                            (
                                                                              context,
                                                                              snapshot,
                                                                            ) {
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
                                                                                            Colors.transparent,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              List<
                                                                                StoreRecord
                                                                              >
                                                                              textStoreRecordList = snapshot.data!;
                                                                              // Return an empty Container when the item does not exist.
                                                                              if (snapshot.data!.isEmpty) {
                                                                                return Container();
                                                                              }
                                                                              final textStoreRecord = textStoreRecordList.isNotEmpty
                                                                                  ? textStoreRecordList.first
                                                                                  : null;

                                                                              return Text(
                                                                                valueOrDefault<
                                                                                  String
                                                                                >(
                                                                                  textStoreRecord?.iNIcheers.toString(),
                                                                                  '0',
                                                                                ),
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
                                                                                      fontSize: 22.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: Theme.of(
                                                                                        context,
                                                                                      ).textTheme.bodyMedium!.fontStyle,
                                                                                    ),
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
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            1.0,
                                                            -1.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              10.0,
                                                              15.0,
                                                              0.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_9fp2n6rz,
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
                                                                  fontSize:
                                                                      18.0,
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
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ).animateOnPageLoad(
                                              animationsMap['containerOnPageLoadAnimation2']!,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0,
                                          10.0,
                                          10.0,
                                          0.0,
                                        ),
                                        child:
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (context.appState.apitwo !=
                                                    '') {
                                                  await launchURL(
                                                    context.appState.apitwo,
                                                  );
                                                  _model.re2 =
                                                      await CreatecheckoutoneCall.call(
                                                        uid: currentUserUid,
                                                        email: currentUserEmail,
                                                      );

                                                  context.appState.apione =
                                                      getJsonField(
                                                        (_model.re2?.jsonBody ??
                                                            ''),
                                                        r'''$.url''',
                                                      ).toString();
                                                  safeSetState(() {});
                                                } else {
                                                  _model.re22 =
                                                      await CreatecheckoutoneCall.call(
                                                        uid: currentUserUid,
                                                        email: currentUserEmail,
                                                      );

                                                  context
                                                      .appState
                                                      .apione = getJsonField(
                                                    (_model.re22?.jsonBody ??
                                                        ''),
                                                    r'''$.url''',
                                                  ).toString();
                                                  safeSetState(() {});
                                                  await launchURL(
                                                    context.appState.apitwo,
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 115.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(0x33000000),
                                                      offset: Offset(0.0, 2.0),
                                                      spreadRadius: 3.0,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                        bottomRight:
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                        topLeft:
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                        topRight:
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                10.0,
                                                              ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      15.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8.0,
                                                                      ),
                                                                  child: Image.network(
                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/5s0qvzhuscfm/6.png',
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    fit: BoxFit
                                                                        .cover,
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
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_iw5wjf5x,
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
                                                                    letterSpacing:
                                                                        0.0,
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
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .infinity,
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
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            1.0,
                                                            -1.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              10.0,
                                                              15.0,
                                                              0.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_jxm19659,
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
                                                                  fontSize:
                                                                      18.0,
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
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ).animateOnPageLoad(
                                              animationsMap['containerOnPageLoadAnimation3']!,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    10.0,
                                    10.0,
                                    0.0,
                                  ),
                                  child:
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (context.appState.apithree != '') {
                                            await launchURL(
                                              context.appState.apithree,
                                            );
                                            _model.re3 =
                                                await CreatecheckoutoneCall.call(
                                                  uid: currentUserUid,
                                                  email: currentUserEmail,
                                                );

                                            context.appState.apione =
                                                getJsonField(
                                                  (_model.re3?.jsonBody ?? ''),
                                                  r'''$.url''',
                                                ).toString();
                                            safeSetState(() {});
                                          } else {
                                            _model.re33 =
                                                await CreatecheckoutoneCall.call(
                                                  uid: currentUserUid,
                                                  email: currentUserEmail,
                                                );

                                            context.appState.apione =
                                                getJsonField(
                                                  (_model.re33?.jsonBody ?? ''),
                                                  r'''$.url''',
                                                ).toString();
                                            safeSetState(() {});
                                            await launchURL(
                                              context.appState.apithree,
                                            );
                                          }

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 141.0,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4.0,
                                                color: Color(0x33000000),
                                                offset: Offset(0.0, 2.0),
                                                spreadRadius: 3.0,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(
                                                10.0,
                                              ),
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Stack(
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              5.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    15.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8.0,
                                                                    ),
                                                                child: Image.network(
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/5s0qvzhuscfm/6.png',
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_fxmmzfdq,
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
                                                                  fontSize:
                                                                      18.0,
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
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .infinity,
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
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              10.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    14.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8.0,
                                                                    ),
                                                                child: Image.network(
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/ez5qwjya52q4/eye.png',
                                                                  width: 45.0,
                                                                  height: 45.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    15.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_12bdn60y,
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
                                                                  fontSize:
                                                                      18.0,
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
                                                                    10.0,
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_y14bta82,
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
                                                                  fontSize:
                                                                      18.0,
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
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                          1.0,
                                                          -1.0,
                                                        ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            10.0,
                                                            15.0,
                                                            0.0,
                                                          ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_t766gvxc,
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
                                                                fontSize: 18.0,
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ).animateOnPageLoad(
                                        animationsMap['containerOnPageLoadAnimation4']!,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
