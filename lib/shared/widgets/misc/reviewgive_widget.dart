import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import '/shared/widgets/index.dart' as custom_widgets;
import '/core/utils/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reviewgive_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'reviewgive_model.dart';

class ReviewgiveWidget extends ConsumerStatefulWidget {
  const ReviewgiveWidget({super.key, required this.reviewto});

  final SupabaseDocRef? reviewto;

  @override
  ConsumerState<ReviewgiveWidget> createState() => _ReviewgiveWidgetState();
}

class _ReviewgiveWidgetState extends ConsumerState<ReviewgiveWidget> {
  late ReviewgiveModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = ReviewgiveModel()..internalInit(context);

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 1.0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.6,
            decoration: BoxDecoration(
              color: Color(0xE5000000),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      24.0,
                      20.0,
                      24.0,
                      0.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.k_xfvpitv9,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall!
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall!.fontStyle,
                                  ),
                                  fontSize: 30.0,
                                  letterSpacing: 0.0,
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.fontStyle,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            12.0,
                            0.0,
                            0.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.k_z0f12e5c,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.labelLarge!.fontStyle,
                                        ),
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.labelLarge!.fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            24.0,
                            0.0,
                            0.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 228.0,
                                height: 40.0,
                                child: custom_widgets.RatingBar(
                                  width: 228.0,
                                  height: 40.0,
                                  showOrInput: false,
                                  sizeicon: 40.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            24.0,
                            0.0,
                            24.0,
                          ),
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: Theme.of(
                                        context,
                                      ).textTheme.labelMedium!.fontWeight,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.labelMedium!.fontStyle,
                                    ),
                                    color: Color(0xFFC8C8C8),
                                    letterSpacing: 0.0,
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.labelMedium!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.labelMedium!.fontStyle,
                                  ),
                              hintText: AppLocalizations.of(
                                context,
                              )!.k_yb1d4pp3,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: Theme.of(
                                        context,
                                      ).textTheme.labelMedium!.fontWeight,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.labelMedium!.fontStyle,
                                    ),
                                    color: Color(0xFFC6C6C6),
                                    letterSpacing: 0.0,
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.labelMedium!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.labelMedium!.fontStyle,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF3B3B3B),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(
                                    context,
                                  ).extension<CustomColors>()!.primaryText,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyMedium!
                                .override(
                                  font: GoogleFonts.openSans(
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.fontStyle,
                                  ),
                                  color: Theme.of(
                                    context,
                                  ).extension<CustomColors>()!.primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontStyle,
                                ),
                            maxLines: 5,
                            minLines: 3,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      24.0,
                      0.0,
                      24.0,
                      24.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: MundayButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            text: AppLocalizations.of(context)!.k_059j9bih,
                            options: MundayButtonOptions(
                              width: 150.0,
                              height: 54.0,
                              padding: EdgeInsets.all(0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                              ),
                              color: Color(0x00292929),
                              textStyle: Theme.of(context).textTheme.bodyLarge!
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.fontWeight,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.fontStyle,
                                    ),
                                    color: Theme.of(
                                      context,
                                    ).extension<CustomColors>()!.primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Color(0xFF3B3B3B),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: MundayButton(
                            onPressed: () async {
                              await widget.reviewto!.update({
                                ...mapToSupabase({
                                  'user_review': FieldValue.arrayUnion([
                                    getReviewFirestoreData(
                                      updateReviewStruct(
                                        ReviewStruct(
                                          profilePhoto: currentUserPhoto,
                                          comment: _model.textController.text,
                                          rate: context.appState.ratingreview,
                                          dateupdate: getCurrentTimestamp,
                                          nameuser: currentUserDisplayName,
                                        ),
                                        clearUnsetFields: false,
                                      ),
                                      true,
                                    ),
                                  ]),
                                }),
                              });
                              _model.dataread =
                                  await VenuesRecord.getDocumentOnce(
                                    widget.reviewto!,
                                  );

                              await widget.reviewto!.update(
                                createVenuesRecordData(
                                  rating: functions.listaverage(
                                    _model.dataread?.userReview.toList(),
                                  ),
                                ),
                              );
                              context.appState.ratingreview = 0;
                              safeSetState(() {});
                              Navigator.pop(context);

                              safeSetState(() {});
                            },
                            text: AppLocalizations.of(context)!.k_66yuaryw,
                            options: MundayButtonOptions(
                              height: 54.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                24.0,
                                0.0,
                                24.0,
                                0.0,
                              ),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                              ),
                              color: Color(0xFFFF0000),
                              textStyle: Theme.of(context).textTheme.bodyLarge!
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.fontWeight,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.fontStyle,
                                  ),
                              elevation: 10.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
