import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/core/utils/app_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'support_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'support_model.dart';

class SupportPage extends ConsumerStatefulWidget {
  const SupportPage({super.key});

  static String routeName = 'Support';
  static String routePath = 'support';

  @override
  ConsumerState<SupportPage> createState() => _SupportWidgetState();
}

class _SupportWidgetState extends ConsumerState<SupportPage>
    with TickerProviderStateMixin {
  late SupportModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = SupportModel()..internalInit(context);

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
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(AccountSettingsPage.routeName);
                  },
                ),
                title: Text(
                  AppLocalizations.of(context)!.k_w7c5dn9i,
                  style: Theme.of(context).textTheme.headlineMedium!.override(
                    font: GoogleFonts.roboto(
                      fontWeight: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.fontWeight,
                      fontStyle: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.fontStyle,
                    ),
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.fontWeight,
                    fontStyle: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.fontStyle,
                  ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF131313),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      15.0,
                      12.0,
                      0.0,
                      12.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            5.0,
                            0.0,
                            0.0,
                            15.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0,
                                      0.0,
                                      0.0,
                                      10.0,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.k_6q9pqn76,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.fontStyle,
                                            ),
                                            fontSize: 25.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0,
                                      5.0,
                                      0.0,
                                      0.0,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.k_eti5mtll,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w300,
                                              fontStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .fontStyle,
                                            ),
                                            color: Theme.of(context)
                                                .extension<CustomColors>()!
                                                .primaryText,
                                            fontSize: 17.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0,
                                      10.0,
                                      0.0,
                                      0.0,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.k_f42ba7ou,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w300,
                                              fontStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .fontStyle,
                                            ),
                                            color: Theme.of(context)
                                                .extension<CustomColors>()!
                                                .primaryText,
                                            fontSize: 17.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .fontStyle,
                                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
