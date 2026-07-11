import 'package:provider/provider.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import 'package:munday/core/state/app_state.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/shared/widgets/dialogs/confirmdel_widget.dart';
import '/shared/widgets/inputs/language_widget.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/core/utils/app_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:munday/core/routing/serialization_util.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'account_settings_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'account_settings_model.dart';

class AccountSettingsPage extends ConsumerStatefulWidget {
  const AccountSettingsPage({super.key});

  static String routeName = 'AccountSettings';
  static String routePath = 'accountSettings';

  @override
  ConsumerState<AccountSettingsPage> createState() =>
      _AccountSettingsWidgetState();
}

class _AccountSettingsWidgetState extends ConsumerState<AccountSettingsPage>
    with TickerProviderStateMixin {
  late AccountSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = AccountSettingsModel()..internalInit(context);

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
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
            delay: 100.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation7': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation8': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 300.0.ms,
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar:
            responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
              desktop: false,
            )
            ? AppBar(
                backgroundColor: Colors.black,
                automaticallyImplyLeading: false,
                leading: MundayIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(
                      context,
                    ).extension<CustomColors>()!.primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(
                      ProfilePage.routeName,
                      queryParameters: {
                        'fromSeting': serializeParam(true, ParamType.bool),
                      }.withoutNulls,
                    );
                  },
                ),
                title: Text(
                  AppLocalizations.of(context)!.k_7pvmel5f,
                  style: Theme.of(context).textTheme.bodyLarge!.override(
                    font: GoogleFonts.openSans(
                      fontWeight: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.fontWeight,
                      fontStyle: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.fontWeight,
                    fontStyle: Theme.of(context).textTheme.bodyLarge!.fontStyle,
                  ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 0.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        16.0,
                        0.0,
                      ),
                      child:
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(PrivacyPolicyPage.routeName);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF171717),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.privacy_tip,
                                      color: Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.primaryText,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.k_ds3pryja,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context)
                                          .extension<CustomColors>()!
                                          .secondaryText,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation1']!,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        16.0,
                        0.0,
                      ),
                      child:
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(SupportPage.routeName);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF171717),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.help_outline_rounded,
                                      color: Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.primaryText,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.k_mpdkrpd2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.9, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context)
                                            .extension<CustomColors>()!
                                            .secondaryText,
                                        size: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation2']!,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        16.0,
                        0.0,
                      ),
                      child:
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: LanguageWidget(),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF171717),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Icon(
                                        Icons.language,
                                        color: Theme.of(context)
                                            .extension<CustomColors>()!
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.k_ppvcpis6,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.9, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context)
                                            .extension<CustomColors>()!
                                            .secondaryText,
                                        size: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation3']!,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        16.0,
                        0.0,
                      ),
                      child:
                          Container(
                            width: double.infinity,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF171717),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5.0,
                                  color: Color(0x3416202A),
                                  offset: Offset(0.0, 2.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                    ),
                                    child: Icon(
                                      Icons.airplay,
                                      color: Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.k_rva4ipva,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge!.fontWeight,
                                              fontStyle: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge!.fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.9, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context)
                                          .extension<CustomColors>()!
                                          .secondaryText,
                                      size: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation4']!,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        16.0,
                        0.0,
                      ),
                      child:
                          Container(
                            width: double.infinity,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF171717),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5.0,
                                  color: Color(0x3416202A),
                                  offset: Offset(0.0, 2.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                    ),
                                    child: Icon(
                                      Icons.airplay,
                                      color: Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.k_hageibjl,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge!.fontWeight,
                                              fontStyle: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge!.fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.9, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context)
                                          .extension<CustomColors>()!
                                          .secondaryText,
                                      size: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation5']!,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        16.0,
                        0.0,
                      ),
                      child:
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(BlocklistPage.routeName);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Color(0xFF202020),
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.block,
                                      color: Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.primaryText,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.k_hj4c6tri,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context)
                                          .extension<CustomColors>()!
                                          .secondaryText,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation6']!,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        16.0,
                        0.0,
                      ),
                      child:
                          InkWell(
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
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: ConfirmdelWidget(),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Color(0xFF202020),
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.delete_sweep,
                                      color: Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.primaryText,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.k_6adcjh05,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context)
                                          .extension<CustomColors>()!
                                          .secondaryText,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation7']!,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        16.0,
                        0.0,
                      ),
                      child:
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await currentUserReference!.update(
                                createUsersRecordData(online: false),
                              );
                              await DeleteuserfromstoretwoCall.call(
                                uid: currentUserReference?.id,
                                storeid: currentUserDocument?.checkinID?.id,
                              );

                              context.pushNamed(PhoneLoginPage.routeName);

                              context.appState.ActivePromotion = true;
                              context.appState.readyshowcheers = true;
                              context.appState.lockfuctionadd = false;
                              safeSetState(() {});
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFB50000),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.primaryText,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.k_ip7gorf2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context)
                                          .extension<CustomColors>()!
                                          .secondaryText,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation8']!,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
