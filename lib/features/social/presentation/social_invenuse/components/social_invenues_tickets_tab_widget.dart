part of '../social_invenuse_page.dart';

class SocialInvenuesTicketsTabWidget extends ConsumerStatefulWidget {
  final SocialInVenuseModel model;
  final VenuesRecord stackVenuesRecord;
  final Map<String, AnimationInfo> animationsMap;

  const SocialInvenuesTicketsTabWidget({
    super.key,
    required this.model,
    required this.stackVenuesRecord,
    required this.animationsMap,
  });

  @override
  ConsumerState<SocialInvenuesTicketsTabWidget> createState() =>
      _SocialInvenuesTicketsTabWidgetState();
}

class _SocialInvenuesTicketsTabWidgetState
    extends ConsumerState<SocialInvenuesTicketsTabWidget> {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  SocialInVenuseModel get _model => widget.model;
  VenuesRecord get stackVenuesRecord => widget.stackVenuesRecord;
  Map<String, AnimationInfo> get animationsMap => widget.animationsMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialInvenuesMenuTabWidget(
          model: _model,
          stackVenuesRecord: stackVenuesRecord,
          animationsMap: animationsMap,
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      10.0,
                      0.0,
                      0.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0,
                          0.0,
                          15.0,
                          0.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: const Color(0xFF2A2A2A),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              0.0,
                              0.0,
                              15.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (false)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          15.0,
                                          15.0,
                                          15.0,
                                          0.0,
                                        ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 102.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    1.0,
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      stackVenuesRecord.bg,
                                                    ).image,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.5,
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      0.0,
                                                      1.0,
                                                      0.0,
                                                      1.0,
                                                    ),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.network(
                                                        '',
                                                      ).image,
                                                    ),
                                                    gradient: const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF0000),
                                                        Colors.transparent,
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                            -1.0,
                                                            -0.64,
                                                          ),
                                                      end: AlignmentDirectional(
                                                        1.0,
                                                        0.64,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
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
                                                    1.0,
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      '',
                                                    ).image,
                                                  ),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Color(0xCB000000),
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                      0.0,
                                                      -1.0,
                                                    ),
                                                    end: AlignmentDirectional(
                                                      0,
                                                      1.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          1.0,
                                                        ),
                                                    child: Container(
                                                      width: 80.0,
                                                      height: 100.0,
                                                      decoration: const BoxDecoration(
                                                        color: Color(
                                                          0xFFD8181B,
                                                        ),
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                15.0,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          topLeft:
                                                              Radius.circular(
                                                                15.0,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 3.0,
                                                        height: 15.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color: Color(
                                                                0xFF131313,
                                                              ),
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 102.0,
                                            decoration: const BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                              65.0,
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 15.0,
                                                          decoration: const BoxDecoration(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            65.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 15.0,
                                                        decoration: const BoxDecoration(
                                                          color: Color(
                                                            0xFF131313,
                                                          ),
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  90.0,
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
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  105.0,
                                                  10.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stackVenuesRecord.nameVenuse,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .override(
                                                        font: GoogleFonts.openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            2.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_qmh6yd5j,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
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
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFD8181B,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  90.0,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  Icons
                                                                      .star_rounded,
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
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
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_0a32enq7,
                                                                  style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .extension<
                                                                          CustomColors
                                                                        >()!
                                                                        .primaryText,
                                                                    fontSize:
                                                                        11.0,
                                                                    letterSpacing:
                                                                        1.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            4.0,
                                                            0.0,
                                                          ),
                                                      child: Image.network(
                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                        width: 12.0,
                                                        height: 12.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            3.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_jan7y48v,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            4.0,
                                                            1.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_67vpqajh,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            3.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_nsq5ypne,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            1.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_2xdxwvhh,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
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
                                                      child: Icon(
                                                        Icons.people_sharp,
                                                        color: Theme.of(context)
                                                            .extension<
                                                              CustomColors
                                                            >()!
                                                            .primaryText,
                                                        size: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.0,
                                                  1.0,
                                                ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    15.0,
                                                    10.0,
                                                  ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFD8181B,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        45.0,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        1.0,
                                                        10.0,
                                                        1.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_oa4jb8x0,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  7.0,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 54.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/_(27).png',
                                                  ).image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.06,
                                                  -1.25,
                                                ),
                                            child: Container(
                                              width: 23.0,
                                              height: 23.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFFF2D38),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0.0, 2.0),
                                                    spreadRadius: 1.0,
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (false)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          15.0,
                                          15.0,
                                          15.0,
                                          0.0,
                                        ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 102.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    1.0,
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      stackVenuesRecord.bg,
                                                    ).image,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.5,
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      50.0,
                                                      1.0,
                                                      0.0,
                                                      1.0,
                                                    ),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.network(
                                                        '',
                                                      ).image,
                                                    ),
                                                    gradient: const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFA9207),
                                                        Colors.transparent,
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                            -1.0,
                                                            -0.64,
                                                          ),
                                                      end: AlignmentDirectional(
                                                        1.0,
                                                        0.64,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
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
                                                    1.0,
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      '',
                                                    ).image,
                                                  ),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Color(0xB7000000),
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                      0.0,
                                                      -1.0,
                                                    ),
                                                    end: AlignmentDirectional(
                                                      0,
                                                      1.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 80.0,
                                                    height: 100.0,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFFA9207),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                          ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 3.0,
                                                        height: 15.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color: Color(
                                                                0xFF131313,
                                                              ),
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                              65.0,
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 15.0,
                                                          decoration: const BoxDecoration(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            65.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 15.0,
                                                        decoration: const BoxDecoration(
                                                          color: Color(
                                                            0xFF131313,
                                                          ),
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  90.0,
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
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.0,
                                                  1.0,
                                                ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    15.0,
                                                    10.0,
                                                  ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFFA9207,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        45.0,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        1.0,
                                                        10.0,
                                                        1.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_0fzvnm0i,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  7.0,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 54.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/_(27).png',
                                                  ).image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  105.0,
                                                  10.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stackVenuesRecord.nameVenuse,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .override(
                                                        font: GoogleFonts.openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            2.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_d8rx3oht,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
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
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFFA9207,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  90.0,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  Icons
                                                                      .star_rounded,
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
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
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_c5e19q8a,
                                                                  style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .extension<
                                                                          CustomColors
                                                                        >()!
                                                                        .primaryText,
                                                                    fontSize:
                                                                        11.0,
                                                                    letterSpacing:
                                                                        1.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            4.0,
                                                            0.0,
                                                          ),
                                                      child: Image.network(
                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                        width: 12.0,
                                                        height: 12.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            3.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_pzu2mk3c,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            4.0,
                                                            1.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_xgb5c10h,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            3.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_y7bqz7se,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            1.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_bhswa6w6,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
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
                                                      child: Icon(
                                                        Icons.people_rounded,
                                                        color: Theme.of(context)
                                                            .extension<
                                                              CustomColors
                                                            >()!
                                                            .primaryText,
                                                        size: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.06,
                                                  -1.25,
                                                ),
                                            child: Container(
                                              width: 23.0,
                                              height: 23.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFFF2D38),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0.0, 2.0),
                                                    spreadRadius: 1.0,
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (false)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          15.0,
                                          15.0,
                                          15.0,
                                          0.0,
                                        ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 102.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    1.0,
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      stackVenuesRecord.bg,
                                                    ).image,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.5,
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      50.0,
                                                      1.0,
                                                      0.0,
                                                      1.0,
                                                    ),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.network(
                                                        '',
                                                      ).image,
                                                    ),
                                                    gradient: const LinearGradient(
                                                      colors: [
                                                        Color(0xFFE42F7D),
                                                        Colors.transparent,
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                            -1.0,
                                                            -0.64,
                                                          ),
                                                      end: AlignmentDirectional(
                                                        1.0,
                                                        0.64,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
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
                                                    1.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      '',
                                                    ).image,
                                                  ),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Color(0xB7000000),
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                      0.0,
                                                      -1.0,
                                                    ),
                                                    end: AlignmentDirectional(
                                                      0,
                                                      1.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          1.0,
                                                        ),
                                                    child: Container(
                                                      width: 80.0,
                                                      height: 100.0,
                                                      decoration: const BoxDecoration(
                                                        color: Color(
                                                          0xFFE42F7D,
                                                        ),
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                15.0,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          topLeft:
                                                              Radius.circular(
                                                                15.0,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 3.0,
                                                        height: 15.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color: Color(
                                                                0xFF131313,
                                                              ),
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                              65.0,
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 15.0,
                                                          decoration: const BoxDecoration(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            65.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 15.0,
                                                        decoration: const BoxDecoration(
                                                          color: Color(
                                                            0xFF131313,
                                                          ),
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  90.0,
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
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.0,
                                                  1.0,
                                                ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    15.0,
                                                    10.0,
                                                  ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFE42F7D,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        45.0,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        1.0,
                                                        10.0,
                                                        1.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_o868lv4g,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  7.0,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 54.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/_(27).png',
                                                  ).image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  105.0,
                                                  10.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stackVenuesRecord.nameVenuse,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .override(
                                                        font: GoogleFonts.openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            2.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_omo6k280,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
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
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFE42F7D,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  90.0,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  Icons
                                                                      .star_rounded,
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
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
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_zgu7klph,
                                                                  style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .extension<
                                                                          CustomColors
                                                                        >()!
                                                                        .primaryText,
                                                                    fontSize:
                                                                        11.0,
                                                                    letterSpacing:
                                                                        1.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.06,
                                                  -1.25,
                                                ),
                                            child: Container(
                                              width: 23.0,
                                              height: 23.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFFF2D38),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0.0, 2.0),
                                                    spreadRadius: 1.0,
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (false)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          15.0,
                                          15.0,
                                          15.0,
                                          0.0,
                                        ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 102.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  1.0,
                                                  0.0,
                                                  1.0,
                                                ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    stackVenuesRecord.bg,
                                                  ).image,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    50.0,
                                                    1.0,
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      '',
                                                    ).image,
                                                  ),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xFF0171BC),
                                                      Colors.transparent,
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                      -1.0,
                                                      -0.64,
                                                    ),
                                                    end: AlignmentDirectional(
                                                      1.0,
                                                      0.64,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  1.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    '',
                                                  ).image,
                                                ),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Color(0xB7000000),
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                    0.0,
                                                    -1.0,
                                                  ),
                                                  end: AlignmentDirectional(
                                                    0,
                                                    1.0,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          1.0,
                                                        ),
                                                    child: Container(
                                                      width: 80.0,
                                                      height: 100.0,
                                                      decoration: const BoxDecoration(
                                                        color: Color(
                                                          0xFF0171BC,
                                                        ),
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                15.0,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          topLeft:
                                                              Radius.circular(
                                                                15.0,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 3.0,
                                                        height: 15.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color: Color(
                                                                0xFF131313,
                                                              ),
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                              65.0,
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 15.0,
                                                          decoration: const BoxDecoration(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            65.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 15.0,
                                                        decoration: const BoxDecoration(
                                                          color: Color(
                                                            0xFF131313,
                                                          ),
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  90.0,
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
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.0,
                                                  1.0,
                                                ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    15.0,
                                                    10.0,
                                                  ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF0171BC,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        45.0,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        1.0,
                                                        10.0,
                                                        1.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_coke8r44,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  7.0,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 54.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/_(27).png',
                                                  ).image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  105.0,
                                                  10.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stackVenuesRecord.nameVenuse,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .override(
                                                        font: GoogleFonts.openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            2.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_a7wsrjh8,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
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
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFF0171BC,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  90.0,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  Icons
                                                                      .star_rounded,
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
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
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_z1c4xn1e,
                                                                  style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .extension<
                                                                          CustomColors
                                                                        >()!
                                                                        .primaryText,
                                                                    fontSize:
                                                                        11.0,
                                                                    letterSpacing:
                                                                        1.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.06,
                                                  -1.25,
                                                ),
                                            child: Container(
                                              width: 23.0,
                                              height: 23.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFFF2D38),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0.0, 2.0),
                                                    spreadRadius: 1.0,
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (false)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          15.0,
                                          15.0,
                                          15.0,
                                          0.0,
                                        ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 102.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  1.0,
                                                  0.0,
                                                  1.0,
                                                ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    stackVenuesRecord.bg,
                                                  ).image,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    50.0,
                                                    1.0,
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      '',
                                                    ).image,
                                                  ),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xFF333333),
                                                      Colors.transparent,
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                      -1.0,
                                                      -0.64,
                                                    ),
                                                    end: AlignmentDirectional(
                                                      1.0,
                                                      0.64,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  1.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    '',
                                                  ).image,
                                                ),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Color(0xB7000000),
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                    0.0,
                                                    -1.0,
                                                  ),
                                                  end: AlignmentDirectional(
                                                    0,
                                                    1.0,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          1.0,
                                                        ),
                                                    child: Container(
                                                      width: 80.0,
                                                      height: 100.0,
                                                      decoration: const BoxDecoration(
                                                        color: Color(
                                                          0xFF333333,
                                                        ),
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                15.0,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          topLeft:
                                                              Radius.circular(
                                                                15.0,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 3.0,
                                                        height: 15.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color: Color(
                                                                0xFF131313,
                                                              ),
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                              65.0,
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 15.0,
                                                          decoration: const BoxDecoration(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            65.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 15.0,
                                                        decoration: const BoxDecoration(
                                                          color: Color(
                                                            0xFF131313,
                                                          ),
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  90.0,
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
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.0,
                                                  1.0,
                                                ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    15.0,
                                                    10.0,
                                                  ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF333333,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        45.0,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        1.0,
                                                        10.0,
                                                        1.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_shq99fqr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  7.0,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 54.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/_(27).png',
                                                  ).image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  105.0,
                                                  10.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stackVenuesRecord.nameVenuse,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .override(
                                                        font: GoogleFonts.openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            2.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_0pngncto,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
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
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFF333333,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  90.0,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  Icons
                                                                      .star_rounded,
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
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
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_7wbou916,
                                                                  style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .extension<
                                                                          CustomColors
                                                                        >()!
                                                                        .primaryText,
                                                                    fontSize:
                                                                        11.0,
                                                                    letterSpacing:
                                                                        1.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            4.0,
                                                            0.0,
                                                          ),
                                                      child: Image.network(
                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                        width: 12.0,
                                                        height: 12.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            3.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_6wdsan0b,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            4.0,
                                                            1.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_c419ikq1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            3.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_y2pex1lp,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            1.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_zl6jbews,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
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
                                                      child: Icon(
                                                        Icons.people_rounded,
                                                        color: Theme.of(context)
                                                            .extension<
                                                              CustomColors
                                                            >()!
                                                            .primaryText,
                                                        size: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.06,
                                                  -1.25,
                                                ),
                                            child: Container(
                                              width: 23.0,
                                              height: 23.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFFF2D38),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0.0, 2.0),
                                                    spreadRadius: 1.0,
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (true)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          15.0,
                                          15.0,
                                          15.0,
                                          0.0,
                                        ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 102.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  1.0,
                                                  0.0,
                                                  1.0,
                                                ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    stackVenuesRecord.bg,
                                                  ).image,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 15.0,
                                                  sigmaY: 15.0,
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.3,
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      50.0,
                                                      1.0,
                                                      0.0,
                                                      1.0,
                                                    ),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.network(
                                                        '',
                                                      ).image,
                                                    ),
                                                    gradient: const LinearGradient(
                                                      colors: [
                                                        Color(0xFF58BB2F),
                                                        Colors.transparent,
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                            -1.0,
                                                            -0.64,
                                                          ),
                                                      end: AlignmentDirectional(
                                                        1.0,
                                                        0.64,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
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
                                                    1.0,
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      '',
                                                    ).image,
                                                  ),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Color(0xB7000000),
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                      0.0,
                                                      -1.0,
                                                    ),
                                                    end: AlignmentDirectional(
                                                      0,
                                                      1.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 80.0,
                                                    height: 100.0,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFF58BB2F),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                          ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 3.0,
                                                        height: 15.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color: Color(
                                                                0xFF131313,
                                                              ),
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              3.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 3.0,
                                                          height: 15.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Color(
                                                                  0xFF131313,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                              65.0,
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 15.0,
                                                          decoration: const BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            65.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 15.0,
                                                        decoration: const BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  90.0,
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
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.0,
                                                  1.0,
                                                ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    15.0,
                                                    10.0,
                                                  ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF58BB2F,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        45.0,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        1.0,
                                                        10.0,
                                                        1.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_5os2reb5,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  7.0,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 54.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/_(27).png',
                                                  ).image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  105.0,
                                                  10.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stackVenuesRecord.nameVenuse,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .override(
                                                        font: GoogleFonts.openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            2.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_gabivqc0,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
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
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFF58BB2F,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  90.0,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  Icons
                                                                      .star_rounded,
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
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
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_kbv179q0,
                                                                  style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .extension<
                                                                          CustomColors
                                                                        >()!
                                                                        .primaryText,
                                                                    fontSize:
                                                                        11.0,
                                                                    letterSpacing:
                                                                        1.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            4.0,
                                                            0.0,
                                                          ),
                                                      child: Image.network(
                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                        width: 12.0,
                                                        height: 12.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            3.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_fhll1d2g,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            4.0,
                                                            1.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_y6dte3q4,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            3.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_syvfu0z9,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            1.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_z1owagsh,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
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
                                                      child: Icon(
                                                        Icons.people_rounded,
                                                        color: Theme.of(context)
                                                            .extension<
                                                              CustomColors
                                                            >()!
                                                            .primaryText,
                                                        size: 15.0,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    10.0,
                    0.0,
                    10.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0,
                              0.0,
                              0.0,
                              3.0,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.k_ry2h7926,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium!.fontStyle,
                                    ),
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          0.0,
                          15.0,
                          0.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.0),
                            border: Border.all(
                              color: const Color(0xFF2A2A2A),
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0,
                                  0.0,
                                  10.0,
                                  0.0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/22.png',
                                    width: 23.0,
                                    height: 23.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  2.0,
                                  0.0,
                                  2.0,
                                  0.0,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.k_sxhp3nkh,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w500,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontStyle,
                                        ),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.fontStyle,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  2.0,
                                  0.0,
                                  2.0,
                                  0.0,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.k_zozupo7c,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w500,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontStyle,
                                        ),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.fontStyle,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  2.0,
                                  0.0,
                                  10.0,
                                  0.0,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.k_kcxm5sm8,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w500,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontStyle,
                                        ),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.fontStyle,
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    15.0,
                    7.0,
                    15.0,
                    10.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 95.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              0.0,
                              10.0,
                              0.0,
                            ),
                            child: Container(
                              width: 75.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 75.0,
                                              height: 75.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF1D1D1D),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    currentUserPhoto,
                                                  ).image,
                                                ),
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 1.0),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_clujchkv,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              0.0,
                              10.0,
                              0.0,
                            ),
                            child: Container(
                              width: 75.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 75.0,
                                              height: 75.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF1D1D1D),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/20240515182857-Create_an_image_of_a.png',
                                                  ).image,
                                                ),
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 1.0),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_0dgp04cp,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              0.0,
                              10.0,
                              0.0,
                            ),
                            child: Container(
                              width: 75.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Container(
                                              width: 75.0,
                                              height: 75.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF1D1D1D),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/20240515154627-Create_an_image_of_a.png',
                                                  ).image,
                                                ),
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 1.0),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_a314cm4r,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
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
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      10.0,
                      0.0,
                      0.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0,
                              0.0,
                              15.0,
                              150.0,
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: const Color(0xFF2A2A2A),
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          10.0,
                                          15.0,
                                          10.0,
                                          10.0,
                                        ),
                                    child: Text(
                                      AppLocalizations.of(context)!.k_53lbeu8e,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .fontWeight,
                                              fontStyle: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontWeight,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
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
              ].addToEnd(const SizedBox(height: 120.0)),
            ),
          ],
        ),
      ],
    );
  }
}
