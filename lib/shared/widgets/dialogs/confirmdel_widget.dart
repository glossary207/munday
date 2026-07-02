import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'confirmdel_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'confirmdel_model.dart';

class ConfirmdelWidget extends ConsumerStatefulWidget {
  const ConfirmdelWidget({super.key});

  @override
  ConsumerState<ConfirmdelWidget> createState() => _ConfirmdelWidgetState();
}

class _ConfirmdelWidgetState extends ConsumerState<ConfirmdelWidget> {
  late ConfirmdelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = ConfirmdelModel()..internalInit(context);

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
      height: 228.0,
      decoration: BoxDecoration(
        color: Color(0xFF131313),
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: MundayButton(
                onPressed: () async {
                  context.pushNamed(
                    PhoneLoginPage.routeName,
                  );

                  context.appState.ActivePromotion = true;
                  context.appState.readyshowcheers = true;
                  context.appState.lockfuctionadd = false;
                  safeSetState(() {});
                  await DeletechatCall.call(
                    uid: currentUserReference?.id,
                  );

                  await DeleteroomCall.call(
                    uid: currentUserReference?.id,
                  );

                  await DeleteuserfromstoretwoCall.call(
                    uid: currentUserReference?.id,
                    storeid: currentUserDocument?.checkinID?.id,
                  );

                  await DeleteuserfromotheruserCall.call(
                    uid: currentUserReference?.id,
                  );

                  await currentUserReference!.delete();
                },
                text: AppLocalizations.of(context)!.k_1lw0tlcq,
                options: MundayButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFB50000),
                  textStyle: Theme.of(context).textTheme.bodyLarge!.override(
                        font: GoogleFonts.openSans(
                          fontWeight:
                              Theme.of(context).textTheme.bodyLarge!.fontWeight,
                          fontStyle:
                              Theme.of(context).textTheme.bodyLarge!.fontStyle,
                        ),
                        color: Theme.of(context)
                            .extension<CustomColors>()!
                            .primaryText,
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
                text: AppLocalizations.of(context)!.k_ka4eqgjx,
                options: MundayButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFF232323),
                  textStyle: Theme.of(context).textTheme.titleSmall!.override(
                        font: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              Theme.of(context).textTheme.titleSmall!.fontStyle,
                        ),
                        color: Theme.of(context)
                            .extension<CustomColors>()!
                            .primaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            Theme.of(context).textTheme.titleSmall!.fontStyle,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
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
