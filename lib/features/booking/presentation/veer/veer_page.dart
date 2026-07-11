import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'veer_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'veer_model.dart';

class VeerPage extends ConsumerStatefulWidget {
  const VeerPage({super.key});

  static String routeName = 'veer';
  static String routePath = 'veer';

  @override
  ConsumerState<VeerPage> createState() => _VeerWidgetState();
}

class _VeerWidgetState extends ConsumerState<VeerPage> {
  late VeerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = VeerModel()..internalInit(context);

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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/Munday-logo.png',
                    width: 300.0,
                    height: 91.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_xlkxtmul.json',
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                      frameRate: FrameRate(60.0),
                      repeat: false,
                      animate: true,
                    ),
                  ],
                ),
              ),
              Text(
                AppLocalizations.of(context)!.k_akurgq59,
                style: Theme.of(context).textTheme.headlineMedium!.override(
                  font: GoogleFonts.outfit(
                    fontWeight: FontWeight.w500,
                    fontStyle: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 32.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.fontStyle,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: Text(
                  AppLocalizations.of(context)!.k_19sjwccm,
                  style: Theme.of(context).textTheme.titleSmall!.override(
                    font: GoogleFonts.outfit(
                      fontWeight: FontWeight.w300,
                      fontStyle: Theme.of(
                        context,
                      ).textTheme.titleSmall!.fontStyle,
                    ),
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w300,
                    fontStyle: Theme.of(
                      context,
                    ).textTheme.titleSmall!.fontStyle,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 44.0, 0.0, 0.0),
                child: MundayButton(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: AppLocalizations.of(context)!.k_vjy12zui,
                  options: MundayButtonOptions(
                    width: 130.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                    ),
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.titleSmall!.override(
                      font: GoogleFonts.outfit(
                        fontWeight: FontWeight.normal,
                        fontStyle: Theme.of(
                          context,
                        ).textTheme.titleSmall!.fontStyle,
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      fontStyle: Theme.of(
                        context,
                      ).textTheme.titleSmall!.fontStyle,
                    ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
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
