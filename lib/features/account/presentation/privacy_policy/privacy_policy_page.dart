import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/core/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'privacy_policy_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'privacy_policy_model.dart';

class PrivacyPolicyPage extends ConsumerStatefulWidget {
  const PrivacyPolicyPage({super.key});

  static String routeName = 'privacyPolicy';
  static String routePath = 'privacyPolicy';

  @override
  ConsumerState<PrivacyPolicyPage> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends ConsumerState<PrivacyPolicyPage> {
  late PrivacyPolicyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrivacyPolicyModel()..internalInit(context);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: responsiveVisibility(
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
                  fillColor: Colors.black,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context)
                        .extension<CustomColors>()!
                        .primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                title: Text(
                  AppLocalizations.of(context)!.k_ol9f5363,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.override(
                        font: GoogleFonts.roboto(
                          fontWeight: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontWeight,
                          fontStyle: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .fontWeight,
                        fontStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .fontStyle,
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
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: 570.0,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 15.0, 20.0, 0.0),
                        child: Text(
                          AppLocalizations.of(context)!.k_5tsyrm42,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.override(
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
                                    fontSize: 11.0,
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
                    ].addToEnd(SizedBox(height: 44.0)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
