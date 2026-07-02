import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import 'package:map_launcher/map_launcher.dart' as $ml;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'select_app_map_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'select_app_map_model.dart';

class SelectAppMapWidget extends ConsumerStatefulWidget {
  const SelectAppMapWidget({
    super.key,
    required this.location,
    required this.title,
  });

  final LatLng? location;
  final String? title;

  @override
  ConsumerState<SelectAppMapWidget> createState() => _SelectAppMapWidgetState();
}

class _SelectAppMapWidgetState extends ConsumerState<SelectAppMapWidget> {
  late SelectAppMapModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = SelectAppMapModel()..internalInit(context);

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
      width: double.infinity,
      height: 270.0,
      decoration: BoxDecoration(
        color: Color(0xFF0D0D0D),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(
              0.0,
              -3.0,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MundayButton(
              onPressed: () async {
                await launchMap(
                  mapType: $ml.MapType.apple,
                  location: widget.location,
                  title: widget.title!,
                );
              },
              text: AppLocalizations.of(context)!.k_vs27b27y,
              options: MundayButtonOptions(
                width: double.infinity,
                height: 60.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFF131313),
                textStyle: Theme.of(context).textTheme.bodyLarge!.override(
                      font: GoogleFonts.openSans(
                        fontWeight:
                            Theme.of(context).textTheme.bodyLarge!.fontWeight,
                        fontStyle:
                            Theme.of(context).textTheme.bodyLarge!.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          Theme.of(context).textTheme.bodyLarge!.fontWeight,
                      fontStyle:
                          Theme.of(context).textTheme.bodyLarge!.fontStyle,
                    ),
                elevation: 2.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: MundayButton(
                onPressed: () async {
                  await launchMap(
                    mapType: $ml.MapType.google,
                    location: widget.location,
                    title: widget.title!,
                  );
                },
                text: AppLocalizations.of(context)!.k_pbykxkt1,
                options: MundayButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFF131313),
                  textStyle: Theme.of(context).textTheme.bodyLarge!.override(
                        font: GoogleFonts.openSans(
                          fontWeight:
                              Theme.of(context).textTheme.bodyLarge!.fontWeight,
                          fontStyle:
                              Theme.of(context).textTheme.bodyLarge!.fontStyle,
                        ),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            Theme.of(context).textTheme.bodyLarge!.fontWeight,
                        fontStyle:
                            Theme.of(context).textTheme.bodyLarge!.fontStyle,
                      ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: MundayButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: AppLocalizations.of(context)!.k_6sh1ybvc,
                options: MundayButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Colors.transparent,
                  textStyle: Theme.of(context).textTheme.titleSmall!.override(
                        font: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              Theme.of(context).textTheme.titleSmall!.fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            Theme.of(context).textTheme.titleSmall!.fontStyle,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Color(0xFF131313),
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
