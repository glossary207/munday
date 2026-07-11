import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'showphoto_copy_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'showphoto_copy_model.dart';

class ShowphotoCopyWidget extends ConsumerStatefulWidget {
  const ShowphotoCopyWidget({super.key});

  @override
  ConsumerState<ShowphotoCopyWidget> createState() =>
      _ShowphotoCopyWidgetState();
}

class _ShowphotoCopyWidgetState extends ConsumerState<ShowphotoCopyWidget>
    with TickerProviderStateMixin {
  late ShowphotoCopyModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = ShowphotoCopyModel()..internalInit(context);

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(0.7, 0.7),
            end: Offset(1.0, 1.0),
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Color(0xBA000000)],
          stops: [0.0, 1.0],
          begin: AlignmentDirectional(0.0, -1.0),
          end: AlignmentDirectional(0, 1.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        10.0,
                        0.0,
                        10.0,
                        0.0,
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).width,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                0.0,
                                0.0,
                                20.0,
                              ),
                              child: PageView(
                                controller: _model.pageViewController ??=
                                    PageController(initialPage: 0),
                                onPageChanged: (_) async {
                                  _model.updatePage(() {});
                                },
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/12.jpg',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/step_2.jpg',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/14.jpg',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/15.jpg',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  0.0,
                                  1.0,
                                ),
                                child: smooth_page_indicator.SmoothPageIndicator(
                                  controller: _model.pageViewController ??=
                                      PageController(initialPage: 0),
                                  count: 4,
                                  axisDirection: Axis.horizontal,
                                  onDotClicked: (i) async {
                                    await _model.pageViewController!
                                        .animateToPage(
                                          i,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                    safeSetState(() {});
                                  },
                                  effect:
                                      smooth_page_indicator.ExpandingDotsEffect(
                                        expansionFactor: 3.0,
                                        spacing: 8.0,
                                        radius: 16.0,
                                        dotWidth: 14.0,
                                        dotHeight: 8.0,
                                        dotColor: Color(0xFFFDFDFD),
                                        activeDotColor: Color(0xFFFF0000),
                                        paintStyle: PaintingStyle.fill,
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        20.0,
                        0.0,
                        0.0,
                        0.0,
                      ),
                      child: MundayButton(
                        onPressed: () async {
                          await _model.pageViewController?.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );

                          context.appState.update(() {});
                        },
                        text: AppLocalizations.of(context)!.k_rnbxlb0h,
                        options: MundayButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                            24.0,
                            0.0,
                            24.0,
                            2.0,
                          ),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                          ),
                          color: Colors.transparent,
                          textStyle: Theme.of(context).textTheme.titleSmall!
                              .override(
                                font: GoogleFonts.openSans(
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.fontWeight,
                                fontStyle: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.fontStyle,
                              ),
                          borderSide: BorderSide(
                            color: Color(0xFF818181),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        20.0,
                        0.0,
                      ),
                      child: MundayButton(
                        onPressed: () async {
                          if (_model.pageViewCurrentIndex == 3) {
                            Navigator.pop(context);
                          } else {
                            await _model.pageViewController?.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );

                            context.appState.update(() {});
                          }
                        },
                        text: _model.pageViewCurrentIndex == 3
                            ? 'Close'
                            : 'Next',
                        options: MundayButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                            24.0,
                            0.0,
                            24.0,
                            2.0,
                          ),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                          ),
                          color: _model.pageViewCurrentIndex == 3
                              ? Color(0xFFCC0303)
                              : Color(0x00000000),
                          textStyle: Theme.of(context).textTheme.titleSmall!
                              .override(
                                font: GoogleFonts.openSans(
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.fontWeight,
                                fontStyle: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.fontStyle,
                              ),
                          borderSide: BorderSide(
                            color: _model.pageViewCurrentIndex == 3
                                ? Colors.transparent
                                : Color(0xFF818181),
                            width: _model.pageViewCurrentIndex == 3 ? 0.0 : 2.0,
                          ),
                          borderRadius: BorderRadius.circular(45.0),
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
    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
  }
}
