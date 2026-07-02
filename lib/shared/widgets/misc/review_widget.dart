import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/backend/backend.dart';
import '/shared/widgets/misc/reviewcoponent_widget.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart' as custom_widgets;
import '/core/utils/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'review_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'review_model.dart';

class ReviewWidget extends ConsumerStatefulWidget {
  const ReviewWidget({
    super.key,
    this.idVenues,
  });

  final SupabaseDocRef? idVenues;

  @override
  ConsumerState<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends ConsumerState<ReviewWidget> {
  late ReviewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = ReviewModel()..internalInit(context);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<VenuesRecord>(
      stream: VenuesRecord.getDocument(widget.idVenues!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.transparent,
                ),
              ),
            ),
          );
        }

        final containerVenuesRecord = snapshot.data!;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xE6000000),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 0.0, 0.0),
                        child: MundayIconButton(
                          borderRadius: 90.0,
                          buttonSize: 50.0,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context)
                                .extension<CustomColors>()!
                                .info,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)!.k_25bukxun,
                    style: Theme.of(context).textTheme.bodyMedium!.override(
                          font: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontStyle,
                          ),
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              Theme.of(context).textTheme.bodyMedium!.fontStyle,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        functions
                            .listaverage(
                                containerVenuesRecord.userReview.toList())
                            .toString(),
                        'ไม่มี review',
                      ).maybeHandleOverflow(
                        maxChars: 3,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium!.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .fontStyle,
                            ),
                            fontSize: 50.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontStyle,
                          ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 5.0, 0.0),
                            child: Container(
                              width: 203.0,
                              height: 60.0,
                              child: custom_widgets.RatingBar(
                                width: 203.0,
                                height: 60.0,
                                showOrInput: true,
                                rate: functions.doubleinteger(
                                    functions.listaverage(containerVenuesRecord
                                        .userReview
                                        .toList())),
                                sizeicon: 35.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 2.0, 0.0),
                          child: Text(
                            containerVenuesRecord.userReview.length.toString(),
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            AppLocalizations.of(context)!.k_wnzwymdq,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: Text(
                            AppLocalizations.of(context)!.k_fg7k7qoa,
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
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Builder(
                        builder: (context) {
                          final dateReview =
                              containerVenuesRecord.userReview.toList();

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(dateReview.length,
                                  (dateReviewIndex) {
                                final dateReviewItem =
                                    dateReview[dateReviewIndex];
                                return ReviewcoponentWidget(
                                  key: Key(
                                      'Keypf8_${dateReviewIndex}_of_${dateReview.length}'),
                                  rate: dateReviewItem.rate.toDouble(),
                                  name: dateReviewItem.nameuser,
                                  comment: dateReviewItem.comment,
                                  profile: dateReviewItem.profilePhoto,
                                  date: dateReviewItem.dateupdate!,
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
