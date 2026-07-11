import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/core/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payreservenormday_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'payreservenormday_model.dart';

class PayreservenormdayPage extends ConsumerStatefulWidget {
  const PayreservenormdayPage({super.key});

  static String routeName = 'payreservenormday';
  static String routePath = 'payreservenormday';

  @override
  ConsumerState<PayreservenormdayPage> createState() =>
      _PayreservenormdayWidgetState();
}

class _PayreservenormdayWidgetState
    extends ConsumerState<PayreservenormdayPage> {
  late PayreservenormdayModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PayreservenormdayModel()..internalInit(context);

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
        backgroundColor: Theme.of(
          context,
        ).extension<CustomColors>()!.primaryBackground,
        appBar:
            responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
              desktop: false,
            )
            ? AppBar(
                backgroundColor: Color(0xFFFF0003),
                automaticallyImplyLeading: false,
                title: Text(
                  AppLocalizations.of(context)!.k_glw1miga,
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
          child: Column(mainAxisSize: MainAxisSize.max, children: []),
        ),
      ),
    );
  }
}
