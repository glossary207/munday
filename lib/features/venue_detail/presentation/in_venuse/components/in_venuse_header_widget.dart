part of '../in_venuse_page.dart';

class InVenuseHeaderWidget extends StatelessWidget {
  final InVenuseModel model;
  final VenuesRecord inVenuseVenuesRecord;
  final ImageProvider? venueBgImage;
  final ImageProvider? venueLogoImage;
  final double fadeFactor;
  final bool videoCompleted;
  final VoidCallback onVideoCompleted;
  final Map<String, AnimationInfo> animationsMap;
  final String? distance;
  final VenuesRecord? idVenues;
  final VoidCallback onStateChanged;

  const InVenuseHeaderWidget({
    super.key,
    required this.model,
    required this.inVenuseVenuesRecord,
    this.venueBgImage,
    this.venueLogoImage,
    required this.fadeFactor,
    required this.videoCompleted,
    required this.onVideoCompleted,
    required this.animationsMap,
    this.distance,
    this.idVenues,
    required this.onStateChanged,
  });

  InVenuseModel get _model => model;

  void _showSchemaUnavailableMessage(
    BuildContext context, {
    required String feature,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('$feature ยังไม่รองรับใน schema ปัจจุบัน')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: Stack(
        children: [
          if (venueBgImage != null) //
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: venueBgImage!,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          if (_model.demoVenueCoverVideoPath.isNotEmpty || !videoCompleted)
            Opacity(
              opacity: fadeFactor,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.6,
                child: MundayVideoPlayer(
                  key: ValueKey(_model.demoVenueCoverVideoPath),
                  path: _model.demoVenueCoverVideoPath,
                  videoType: VideoType.asset,
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  autoPlay: true,
                  looping: true,
                  showControls: false,
                  allowFullScreen: false,
                  allowPlaybackSpeedMenu: false,
                  volume: 0.0,
                ),
              ),
            ),
          Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 0.6,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black,
                  ],
                  stops: [0.0, 0.6, 1.0],
                  begin: AlignmentDirectional(0.0, -1.0),
                  end: AlignmentDirectional(0, 1.0),
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                20.0,
                0.0,
                0.0,
                0.0,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (inVenuseVenuesRecord.video.isNotEmpty) {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                useSafeArea: true,
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
                                      child: const StoryViewWidget(),
                                    ),
                                  );
                                },
                              ).then((value) => onStateChanged());

                              _model.play = true;
                              onStateChanged();
                            }
                          },
                          child: SizedBox(
                            width: inVenuseVenuesRecord.video.isNotEmpty
                                ? 115.0
                                : 100.0,
                            height: inVenuseVenuesRecord.video.isNotEmpty
                                ? 115.0
                                : 100.0,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(
                                    0.0,
                                    0.0,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      image: venueLogoImage != null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: venueLogoImage!,
                                            )
                                          : null,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                if (inVenuseVenuesRecord.video.isNotEmpty)
                                  Align(
                                    alignment: const AlignmentDirectional(
                                      0.0,
                                      0.0,
                                    ),
                                    child: Container(
                                      width: 115.0,
                                      height: 115.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: _model.play!
                                              ? const Color(0xFF434343)
                                              : const Color(0xFFDE0000),
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (inVenuseVenuesRecord.video.isNotEmpty)
                                  Align(
                                    alignment: const AlignmentDirectional(
                                      1.0,
                                      1.0,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            0.0,
                                            5.0,
                                            5.0,
                                          ),
                                      child: Container(
                                        width: 25.0,
                                        height: 25.0,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF0000),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x7A000000),
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      2.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                    ),
                                                child: FaIcon(
                                                  FontAwesomeIcons.play,
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  size: 14.0,
                                                ),
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            17.0,
                            0.0,
                            0.0,
                            0.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  0.0,
                                  5.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                6.0,
                                                0.0,
                                              ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              onStateChanged();
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                        context,
                                                      ).unfocus();
                                                      FocusManager
                                                          .instance
                                                          .primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          MediaQuery.viewInsetsOf(
                                                            context,
                                                          ),
                                                      child:
                                                          const StoryViewWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then(
                                                (value) => onStateChanged(),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF0000),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      13.0,
                                                      1.0,
                                                      13.0,
                                                      1.5,
                                                    ),
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.k_znwljmuz,
                                                  style: MundayTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              MundayTheme.of(
                                                                    context,
                                                                  )
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 11.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            MundayTheme.of(
                                                                  context,
                                                                )
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                6.0,
                                                0.0,
                                              ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    13.0,
                                                    1.0,
                                                    13.0,
                                                    1.5,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_5yp7ypsm,
                                                style: MundayTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                MundayTheme.of(
                                                                      context,
                                                                    )
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                      color: Colors.black,
                                                      fontSize: 11.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle: MundayTheme.of(
                                                        context,
                                                      ).bodyMedium.fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  0.0,
                                  4.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        // EnableScreenShield
                                        await actions.enableScreenShield(
                                          context,
                                        );
                                      },
                                      child: Text(
                                        inVenuseVenuesRecord.nameVenuse,
                                        style: MundayTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w600,
                                                fontStyle: MundayTheme.of(
                                                  context,
                                                ).bodyMedium.fontStyle,
                                              ),
                                              fontSize: 23.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: MundayTheme.of(
                                                context,
                                              ).bodyMedium.fontStyle,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  0.0,
                                  5.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      inVenuseVenuesRecord.openCloseTime,
                                      style: MundayTheme.of(context).bodyMedium
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: MundayTheme.of(
                                                context,
                                              ).bodyMedium.fontStyle,
                                            ),
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: MundayTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                    ),
                                    if (inVenuseVenuesRecord.rating > 3.0)
                                      Align(
                                        alignment: const AlignmentDirectional(
                                          0.22,
                                          -0.49,
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                8.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                useSafeArea: true,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                        context,
                                                      ).unfocus();
                                                      FocusManager
                                                          .instance
                                                          .primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          MediaQuery.viewInsetsOf(
                                                            context,
                                                          ),
                                                      child: ReviewWidget(
                                                        idVenues:
                                                            inVenuseVenuesRecord
                                                                .reference,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then(
                                                (value) => onStateChanged(),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF0000),
                                                borderRadius:
                                                    BorderRadius.circular(90.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          5.0,
                                                          0.0,
                                                          0.0,
                                                          1.0,
                                                        ),
                                                    child: Icon(
                                                      Icons.star_rounded,
                                                      color: MundayTheme.of(
                                                        context,
                                                      ).primaryText,
                                                      size: 15.0,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          2.5,
                                                          1.0,
                                                          7.0,
                                                          1.5,
                                                        ),
                                                    child: Text(
                                                      formatNumber(
                                                        inVenuseVenuesRecord
                                                            .rating,
                                                        formatType:
                                                            FormatType.custom,
                                                        format: '.0',
                                                        locale: '',
                                                      ).maybeHandleOverflow(
                                                        maxChars: 3,
                                                      ),
                                                      style:
                                                          MundayTheme.of(
                                                            context,
                                                          ).bodyMedium.override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  MundayTheme.of(
                                                                        context,
                                                                      )
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color:
                                                                MundayTheme.of(
                                                                  context,
                                                                ).primaryText,
                                                            fontSize: 11.0,
                                                            letterSpacing: 1.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                MundayTheme.of(
                                                                      context,
                                                                    )
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await actions.disableScreenShield(
                                        context,
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                6.0,
                                                4.0,
                                              ),
                                          child: Container(
                                            width: 23.0,
                                            height: 23.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/lqf7m_.png',
                                                ).image,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                7.0,
                                                0.0,
                                              ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_8ueny3ds,
                                            style: MundayTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: MundayTheme.of(
                                                      context,
                                                    ).bodyMedium.fontStyle,
                                                  ),
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryBtnText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: MundayTheme.of(
                                                    context,
                                                  ).bodyMedium.fontStyle,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                5.0,
                                                0.0,
                                              ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_203t8lnr,
                                            style: MundayTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: MundayTheme.of(
                                                      context,
                                                    ).bodyMedium.fontStyle,
                                                  ),
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryBtnText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: MundayTheme.of(
                                                    context,
                                                  ).bodyMedium.fontStyle,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              5.0,
                                              0.0,
                                              6.0,
                                              0.0,
                                            ),
                                        child: Container(
                                          width: 23.0,
                                          height: 23.0,
                                          decoration: const BoxDecoration(),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                      0.0,
                                                      1.0,
                                                    ),
                                                child: Icon(
                                                  Icons.people_rounded,
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  size: 17.0,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                      1.0,
                                                      -1.0,
                                                    ),
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.k_we9kgu84,
                                                  style: MundayTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.openSans(
                                                          fontWeight:
                                                              MundayTheme.of(
                                                                    context,
                                                                  )
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              MundayTheme.of(
                                                                    context,
                                                                  )
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 6.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            MundayTheme.of(
                                                                  context,
                                                                )
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            MundayTheme.of(
                                                                  context,
                                                                )
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              0.0,
                                              1.0,
                                              2.5,
                                              1.0,
                                            ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.k_kd32zbfm,
                                          style: MundayTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: MundayTheme.of(
                                                    context,
                                                  ).bodyMedium.fontStyle,
                                                ),
                                                color: MundayTheme.of(
                                                  context,
                                                ).primaryBtnText,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: MundayTheme.of(
                                                  context,
                                                ).bodyMedium.fontStyle,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              0.0,
                                              1.0,
                                              0.0,
                                              1.0,
                                            ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.k_bpvwlxqt,
                                          style: MundayTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: MundayTheme.of(
                                                    context,
                                                  ).bodyMedium.fontStyle,
                                                ),
                                                color: MundayTheme.of(
                                                  context,
                                                ).primaryBtnText,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: MundayTheme.of(
                                                  context,
                                                ).bodyMedium.fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          1.0,
                          0.0,
                          0.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(
                                  1.0,
                                  -1.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    23.0,
                                    4.0,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.k_17ibcz68,
                                    style: MundayTheme.of(context).bodyMedium
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: MundayTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: MundayTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 7.0,
                                          letterSpacing: 0.0,
                                          fontWeight: MundayTheme.of(
                                            context,
                                          ).bodyMedium.fontWeight,
                                          fontStyle: MundayTheme.of(
                                            context,
                                          ).bodyMedium.fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  20.0,
                                  10.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (inVenuseVenuesRecord.position ==
                                                null) {
                                              return;
                                            }
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(
                                                      context,
                                                    ).unfocus();
                                                    FocusManager
                                                        .instance
                                                        .primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                          context,
                                                        ),
                                                    child: PopupmapWidget(
                                                      location:
                                                          inVenuseVenuesRecord
                                                              .position!,
                                                      distance: distance ?? '-',
                                                      logo: inVenuseVenuesRecord
                                                          .logo,
                                                      name: inVenuseVenuesRecord
                                                          .nameVenuse,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => onStateChanged());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0x981D1D1D),
                                              borderRadius:
                                                  BorderRadius.circular(90.0),
                                              border: Border.all(
                                                color: const Color(0x981D1D1D),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.5,
                                                    0.0,
                                                    0.5,
                                                  ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          6.0,
                                                          3.0,
                                                          5.0,
                                                          3.0,
                                                        ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            0.0,
                                                          ),
                                                      child: Image.asset(
                                                        'assets/images/7089161_google_maps_icon.png',
                                                        width: 17.0,
                                                        height: 17.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          6.0,
                                                          0.0,
                                                        ),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        distance,
                                                        '10',
                                                      ).maybeHandleOverflow(
                                                        maxChars: 4,
                                                      ),
                                                      style:
                                                          MundayTheme.of(
                                                            context,
                                                          ).bodyMedium.override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  MundayTheme.of(
                                                                        context,
                                                                      )
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 14.5,
                                                            letterSpacing: 0.5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                MundayTheme.of(
                                                                      context,
                                                                    )
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          10.0,
                                                          0.0,
                                                        ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.k_d98iv601,
                                                      style:
                                                          MundayTheme.of(
                                                            context,
                                                          ).bodyMedium.override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  MundayTheme.of(
                                                                        context,
                                                                      )
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                MundayTheme.of(
                                                                      context,
                                                                    )
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                5.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await launchURL(
                                                functions.linkgrab(
                                                  inVenuseVenuesRecord
                                                      .nameVenuse,
                                                  inVenuseVenuesRecord.position,
                                                )!,
                                              );
                                            },
                                            child: Container(
                                              width: 23.0,
                                              height: 23.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 1.0),
                                              ),
                                              child: const Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            2.6,
                                                          ),
                                                      child: Icon(
                                                        Icons
                                                            .directions_car_rounded,
                                                        color: Colors.black,
                                                        size: 18.5,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          90.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (inVenuseVenuesRecord
                                                  .linkContact
                                                  .tiktok !=
                                              '')
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    17.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await launchURL(
                                                    functions.addsocial(
                                                      'snssdk1233://user/',
                                                      inVenuseVenuesRecord
                                                          .linkContact
                                                          .tiktok,
                                                    )!,
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.tiktok_rounded,
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                          if (inVenuseVenuesRecord
                                                  .linkContact
                                                  .facebook !=
                                              '')
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    14.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await launchURL(
                                                    functions.addsocial(
                                                      'fb://profile/',
                                                      inVenuseVenuesRecord
                                                          .linkContact
                                                          .facebook,
                                                    )!,
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.facebook,
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  size: 23.0,
                                                ),
                                              ),
                                            ),
                                          if (inVenuseVenuesRecord
                                                  .linkContact
                                                  .ig !=
                                              '')
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    17.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await launchURL(
                                                    functions.addsocial(
                                                      'instagram://user?username=',
                                                      inVenuseVenuesRecord
                                                          .linkContact
                                                          .ig,
                                                    )!,
                                                  );
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.instagram,
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                          if (inVenuseVenuesRecord
                                                  .linkContact
                                                  .line !=
                                              '')
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    17.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await launchURL(
                                                    functions.linkLine(
                                                      inVenuseVenuesRecord
                                                          .linkContact
                                                          .line,
                                                    )!,
                                                  );
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.line,
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                          if (inVenuseVenuesRecord
                                                  .linkContact
                                                  .phone !=
                                              '')
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    17.0,
                                                    0.0,
                                                    0.0,
                                                    0.5,
                                                  ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await launchUrl(
                                                    Uri(
                                                      scheme: 'tel',
                                                      path: inVenuseVenuesRecord
                                                          .linkContact
                                                          .phone,
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 23.5,
                                                  height: 23.5,
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                2.0,
                                                                0.0,
                                                                0.0,
                                                              ),
                                                          child: Container(
                                                            width: 18.0,
                                                            height: 18.0,
                                                            decoration:
                                                                const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .phoneSquare,
                                                          color: Color(
                                                            0xFFFF0000,
                                                          ),
                                                          size: 23.0,
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
          ),
          Align(
            alignment: const AlignmentDirectional(1.0, -1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                0.0,
                65.0,
                20.0,
                0.0,
              ),
              child: Container(
                height: 60.0,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0,
                            0.0,
                            0.0,
                            0.0,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pop();
                            },
                            child: Container(
                              width: 45.0,
                              height: 45.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.transparent),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pop();
                                  },
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Stack(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        0.0,
                                      ),
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                            0.0,
                                            0.0,
                                          ),
                                          child: Container(
                                            width: 25.0,
                                            height: 25.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFFF0000),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x7A000000),
                                                  offset: Offset(2.0, 2.0),
                                                ),
                                              ],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          2.0,
                                                          0.0,
                                                        ),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_back_ios_new_sharp,
                                                      color: MundayTheme.of(
                                                        context,
                                                      ).primaryText,
                                                      size: 14.0,
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
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  10.0,
                                  0.0,
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (!_supportsVenueFavorites) {
                                      _showSchemaUnavailableMessage(
                                        context,
                                        feature: 'บันทึกร้านโปรด',
                                      );
                                      return;
                                    }
                                    if ((currentUserDocument?.loveVenuse
                                                .toList() ??
                                            [])
                                        .contains(
                                          inVenuseVenuesRecord.reference,
                                        )) {
                                      await currentUserReference!.update({
                                        ...mapToSupabase({
                                          'loveVenuse': FieldValue.arrayRemove([
                                            idVenues,
                                          ]),
                                        }),
                                      });
                                    } else {
                                      await currentUserReference!.update({
                                        ...mapToSupabase({
                                          'loveVenuse': FieldValue.arrayUnion([
                                            idVenues,
                                          ]),
                                        }),
                                      });
                                      context.appState.ratingreview = 0;
                                      onStateChanged();
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
                                              padding: MediaQuery.viewInsetsOf(
                                                context,
                                              ),
                                              child: ReviewgiveWidget(
                                                reviewto: inVenuseVenuesRecord
                                                    .reference,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => onStateChanged());
                                    }

                                    onStateChanged();
                                  },
                                  child: Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0x99000000),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        if (!(currentUserDocument?.loveVenuse
                                                    .toList() ??
                                                [])
                                            .contains(
                                              inVenuseVenuesRecord.reference,
                                            ))
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: AuthUserStreamWidget(
                                              builder: (context) =>
                                                  const FaIcon(
                                                    FontAwesomeIcons.heart,
                                                    color: Color(0xFFFDFDFD),
                                                    size: 25.0,
                                                  ),
                                            ),
                                          ),
                                        if ((currentUserDocument?.loveVenuse
                                                    .toList() ??
                                                [])
                                            .contains(
                                              inVenuseVenuesRecord.reference,
                                            ))
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: AuthUserStreamWidget(
                                              builder: (context) =>
                                                  const FaIcon(
                                                    FontAwesomeIcons.solidHeart,
                                                    color: Color(0xFFFF0000),
                                                    size: 25.0,
                                                  ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Builder(
                                builder: (context) => Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    10.0,
                                    0.0,
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await Share.share(
                                        functions.addsocial(
                                          'https://black-rooms.com/sharepage?distance=4&index=2&idVenues=',
                                          idVenues?.reference.id,
                                        )!,
                                        sharePositionOrigin:
                                            getWidgetBoundingBox(context),
                                      );
                                    },
                                    child: Container(
                                      width: 45.0,
                                      height: 45.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0x99000000),
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child:
                                                const Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                  size: 31.0,
                                                ).animateOnActionTrigger(
                                                  animationsMap['iconOnActionTriggerAnimation']!,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'SharepagePage',
                                    queryParameters: {
                                      'idVenues': serializeParam(
                                        idVenues,
                                        ParamType.SupabaseDocRef,
                                      ),
                                      'distance': serializeParam(
                                        '',
                                        ParamType.String,
                                      ),
                                      'dateclick': serializeParam(
                                        getCurrentTimestamp,
                                        ParamType.DateTime,
                                      ),
                                      'index': serializeParam(2, ParamType.int),
                                    }.withoutNulls,
                                  );
                                },
                                child: Container(
                                  width: 45.0,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0x99000000),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              6.0,
                                              5.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child: Image.network(
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/ucvx51dhc4gx/message2.png',
                                          width: 31.0,
                                          height: 31.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
