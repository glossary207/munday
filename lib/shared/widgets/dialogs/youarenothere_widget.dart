import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/core/utils/app_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'youarenothere_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'youarenothere_model.dart';

class YouarenothereWidget extends ConsumerStatefulWidget {
  const YouarenothereWidget({super.key, required this.poperror});

  final bool? poperror;

  @override
  ConsumerState<YouarenothereWidget> createState() =>
      _YouarenothereWidgetState();
}

class _YouarenothereWidgetState extends ConsumerState<YouarenothereWidget> {
  late YouarenothereModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = YouarenothereModel()..internalInit(context);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    height: 207.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF131313),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          color: Color(0xFFFF0000),
                          size: 72.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            12.0,
                            0.0,
                            0.0,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.k_nyazsf47,
                            style: Theme.of(context).textTheme.headlineMedium!
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium!.fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium!.fontStyle,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            4.0,
                            0.0,
                            0.0,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.k_mp8ty4ge,
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
                                  color: Color(0xFFBABABA),
                                  letterSpacing: 0.0,
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.labelMedium!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.labelMedium!.fontStyle,
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
    );
  }
}
