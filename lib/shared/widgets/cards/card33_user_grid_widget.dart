import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/core/utils/app_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'card33_user_grid_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'card33_user_grid_model.dart';

class Card33UserGridWidget extends ConsumerStatefulWidget {
  const Card33UserGridWidget({
    super.key,
    required this.name,
    required this.image,
    required this.uid,
  });

  final String? name;
  final String? image;
  final SupabaseDocRef? uid;

  @override
  ConsumerState<Card33UserGridWidget> createState() => _Card33UserGridWidgetState();
}

class _Card33UserGridWidgetState extends ConsumerState<Card33UserGridWidget>
    with TickerProviderStateMixin {
  late Card33UserGridModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = Card33UserGridModel()..internalInit(context);

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.updatePage(() {});
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
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
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.05, 1.05),
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
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.0,
            sigmaY: 3.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    height: 241.0,
                    constraints: BoxConstraints(
                      maxWidth: 570.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF0E0E0E),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 1.0, 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Text(
                              AppLocalizations.of(context)!.k_nifsved0,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .fontWeight,
                                      fontStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .fontStyle,
                                    ),
                                    color: Theme.of(context)
                                        .extension<CustomColors>()!
                                        .primaryText,
                                    fontSize: 25.0,
                                    letterSpacing: 0.0,
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .fontWeight,
                                    fontStyle: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 15.0, 12.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 75.0,
                                  height: 75.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => ClipRRect(
                                      borderRadius: BorderRadius.circular(40.0),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          currentUserPhoto,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png',
                                        ),
                                        width: 90.0,
                                        height: 90.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Stack(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Container(
                                        width: 120.0,
                                        height: 4.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF4E4E4E),
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 75.0,
                                      height: 75.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF0E0E0E),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF0E0E0E),
                                          width: 2.0,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.network(
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/5s0qvzhuscfm/6.png',
                                              ).image,
                                            ),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation2']!),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 75.0,
                                  height: 75.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        widget.image,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png',
                                      ),
                                      width: 90.0,
                                      height: 90.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              widget.name,
                              'ไม่ระบุ',
                            ),
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .fontWeight,
                                    fontStyle: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .fontStyle,
                                  ),
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .fontWeight,
                                  fontStyle: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .fontStyle,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 5.0),
                            child: Text(
                              AppLocalizations.of(context)!.k_7hzb9e7k,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .override(
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
                                    color: Theme.of(context)
                                        .extension<CustomColors>()!
                                        .primaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
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
                        ]
                            .divide(SizedBox(height: 4.0))
                            .addToEnd(SizedBox(height: 12.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!)
        .animateOnActionTrigger(
          animationsMap['containerOnActionTriggerAnimation']!,
        );
  }
}
