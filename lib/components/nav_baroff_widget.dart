import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nav_baroff_model.dart';
export 'nav_baroff_model.dart';

class NavBaroffWidget extends StatefulWidget {
  const NavBaroffWidget({
    super.key,
    required this.items,
  });

  final List<String>? items;

  @override
  State<NavBaroffWidget> createState() => _NavBaroffWidgetState();
}

class _NavBaroffWidgetState extends State<NavBaroffWidget>
    with TickerProviderStateMixin {
  late NavBaroffModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBaroffModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 100.ms),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 200.0.ms,
            begin: Offset(0.0, 22.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 18.0),
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
    context.watch<FFAppState>();
    context.watch<f_f_story_view_live_zhm3f3_app_state.FFAppState>();

    return Container(
      width: double.infinity,
      height: 110.0,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                stops: [0.0, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 4.0,
                ),
              ),
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 30.0),
            child: Container(
              width: double.infinity,
              height: 65.0,
              decoration: BoxDecoration(
                color: Color(0x00FFFFFF),
              ),
              child: Container(
                width: double.infinity,
                height: 75.0,
                child: Stack(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.75,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF2C2C2C), Color(0xFF0C0C0C)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final menuItem = widget.items!.toList();

                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(menuItem.length,
                                      (menuItemIndex) {
                                    final menuItemItem =
                                        menuItem[menuItemIndex];
                                    return Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if ((menuItemItem ==
                                                        'Events') &&
                                                    (FFAppState()
                                                            .menuActiveitem !=
                                                        'Events')) {
                                                  context.goNamed(
                                                      EventsWidget.routeName);
                                                } else {
                                                  if ((menuItemItem ==
                                                          'Venues') &&
                                                      (FFAppState()
                                                              .menuActiveitem !=
                                                          'Venues')) {
                                                    context.goNamed(
                                                        VenuesWidget.routeName);
                                                  } else {
                                                    if ((menuItemItem ==
                                                            'Promotion') &&
                                                        (FFAppState()
                                                                .menuActiveitem !=
                                                            'Promotion')) {
                                                      context.goNamed(
                                                          PromotionWidget
                                                              .routeName);
                                                    } else {
                                                      if ((menuItemItem ==
                                                              'Home') &&
                                                          (FFAppState()
                                                                  .menuActiveitem !=
                                                              'Home')) {
                                                        context.goNamed(
                                                            MainWidget
                                                                .routeName);
                                                      }
                                                    }
                                                  }
                                                }

                                                FFAppState().menuActiveitem =
                                                    menuItemItem;
                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: 60.0,
                                                height: double.infinity,
                                                decoration: BoxDecoration(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          if (menuItemItem ==
                                                              FFAppState()
                                                                  .menuActiveitem)
                                                            Container(
                                                              width: 1.0,
                                                              height: 7.0,
                                                              decoration:
                                                                  BoxDecoration(),
                                                            ),
                                                          Stack(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            children: [
                                                              if (menuItemItem ==
                                                                  FFAppState()
                                                                      .menuActiveitem)
                                                                Container(
                                                                  width: 35.0,
                                                                  height: 35.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0x00FFFFFF),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            12.0,
                                                                        color: Color(
                                                                            0x00FFFFFF),
                                                                        offset:
                                                                            Offset(
                                                                          0.0,
                                                                          0.0,
                                                                        ),
                                                                      )
                                                                    ],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14.0),
                                                                  ),
                                                                ),
                                                              Container(
                                                                width: 35.0,
                                                                height: 35.0,
                                                                child: Stack(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  children: [
                                                                    if (menuItemItem ==
                                                                        'Home')
                                                                      Image
                                                                          .network(
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/2nj8yl2yaelb/21.png',
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            1.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    if (menuItemItem ==
                                                                        'Events')
                                                                      Image
                                                                          .network(
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/dutfa1nii34m/20.png',
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            1.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    if (menuItemItem ==
                                                                        'Venues')
                                                                      Image
                                                                          .network(
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/lgesbg9egut8/toast.png',
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            1.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    if (menuItemItem ==
                                                                        'Promotion')
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            2.0,
                                                                            2.0,
                                                                            2.0,
                                                                            2.0),
                                                                        child: Image
                                                                            .network(
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/biv861aii9ne/promotions.png',
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 1.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          if (menuItemItem ==
                                                              FFAppState()
                                                                  .menuActiveitem)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          2.0),
                                                              child: Text(
                                                                menuItemItem,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .displaySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .displaySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .fontStyle,
                                                                    ),
                                                              ).animateOnPageLoad(
                                                                  animationsMap[
                                                                      'textOnPageLoadAnimation']!),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (menuItemItem ==
                                              FFAppState().menuActiveitem)
                                            Container(
                                              width: 45.0,
                                              height: 3.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'containerOnPageLoadAnimation2']!),
                                        ],
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
