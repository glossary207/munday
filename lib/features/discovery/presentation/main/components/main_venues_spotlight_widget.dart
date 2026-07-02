part of '../main_page.dart';

class MainVenuesSpotlightWidget extends StatelessWidget {
  final MainModel _model;
  final Map<String, AnimationInfo> animationsMap;
  final VoidCallback onStateChanged;
  final dynamic currentUserLocationValue;

  const MainVenuesSpotlightWidget({
    super.key,
    required MainModel model,
    required this.animationsMap,
    required this.onStateChanged,
    required this.currentUserLocationValue,
  }) : _model = model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.0, 0.0),
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 0.0, 15.0),
            child: Text(
              'ร้านสำหรับคุณ',
              style: Theme.of(context).textTheme.bodyMedium!.override(
                    font: GoogleFonts.openSans(
                      fontWeight:
                          Theme.of(context).textTheme.bodyMedium!.fontWeight,
                      fontStyle:
                          Theme.of(context).textTheme.bodyMedium!.fontStyle,
                    ),
                    fontSize: 18.0,
                    letterSpacing: 0.4,
                    fontWeight:
                        Theme.of(context).textTheme.bodyMedium!.fontWeight,
                    fontStyle:
                        Theme.of(context).textTheme.bodyMedium!.fontStyle,
                  ),
            ),
          ),
        ),
        StreamBuilder<List<VenuesRecord>>(
          stream: queryVenuesRecord(),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return const Center(
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
            List<VenuesRecord> containerVenuesRecordList = snapshot.data!;

            return Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              decoration: const BoxDecoration(),
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
                child: AuthUserStreamWidget(
                  builder: (context) => Builder(
                    builder: (context) {
                      final dataV = (functions
                                  .dataVenuse(
                                      containerVenuesRecordList.toList(),
                                      context.appState.Filterdistance,
                                      (currentUserDocument?.loveVenuse
                                                  .toList() ??
                                              [])
                                          .toList(),
                                      currentUserLocationValue,
                                      context.appState.StyleMusic.toList(),
                                      context.appState.StyleVenuse.toList(),
                                      1,
                                      true,
                                      false)
                                  ?.toList() ??
                              [])
                          .take(6)
                          .toList();

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(dataV.length, (dataVIndex) {
                          final dataVItem = dataV[dataVIndex];
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 10.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  InVenusePage.routeName,
                                  queryParameters: {
                                    'idVenues': serializeParam(
                                      DataVenuesStruct.maybeFromMap(dataVItem)
                                          ?.iDVenuse,
                                      ParamType.SupabaseDocRef,
                                    ),
                                    'distance': serializeParam(
                                      DataVenuesStruct.maybeFromMap(dataVItem)
                                          ?.distance
                                          .toString(),
                                      ParamType.String,
                                    ),
                                    'index': serializeParam(
                                      2,
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 197.4,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.transparent, Colors.black],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(1.0, -1.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.99,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFE000000),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.network(
                                              _safeMainImageUrl(
                                                DataVenuesStruct.maybeFromMap(
                                                        dataVItem)
                                                    ?.bg,
                                                fallback:
                                                    _kMainFallbackPosterUrl,
                                              ),
                                            ).image,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1.0,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Color(0xDD000000)
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(0.0, -1.0),
                                            end: AlignmentDirectional(0, 1.0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -1.0, 0.11),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        15.0, 10.0, 0.0, 0.0),
                                                child: Container(
                                                  width: 200.0,
                                                  height: 18.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0x00FFFFFF),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    7.0,
                                                                    0.0),
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0xFFFF0000),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              10.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'Pub',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            maxLines:
                                                                                1,
                                                                            style: Theme.of(context).textTheme.displaySmall!.override(
                                                                                  font: GoogleFonts.roboto(
                                                                                    fontWeight: Theme.of(context).textTheme.displaySmall!.fontWeight,
                                                                                    fontStyle: Theme.of(context).textTheme.displaySmall!.fontStyle,
                                                                                  ),
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: Theme.of(context).textTheme.displaySmall!.fontWeight,
                                                                                  fontStyle: Theme.of(context).textTheme.displaySmall!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    7.0,
                                                                    0.0),
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .extension<
                                                                        CustomColors>()!
                                                                    .primaryText,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              10.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'LiveMusic',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            maxLines:
                                                                                1,
                                                                            style: Theme.of(context).textTheme.displaySmall!.override(
                                                                                  font: GoogleFonts.roboto(
                                                                                    fontWeight: Theme.of(context).textTheme.displaySmall!.fontWeight,
                                                                                    fontStyle: Theme.of(context).textTheme.displaySmall!.fontStyle,
                                                                                  ),
                                                                                  color: const Color(0xFF15161E),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: Theme.of(context).textTheme.displaySmall!.fontWeight,
                                                                                  fontStyle: Theme.of(context).textTheme.displaySmall!.fontStyle,
                                                                                ),
                                                                          ),
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          15.0, 14.0, 0.0, 2.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      DataVenuesStruct
                                                              .maybeFromMap(
                                                                  dataVItem)
                                                          ?.nameVenuse,
                                                      'ไม่ระบุ',
                                                    ).maybeHandleOverflow(
                                                      maxChars: 20,
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                          color: Theme.of(
                                                                  context)
                                                              .extension<
                                                                  CustomColors>()!
                                                              .primaryBtnText,
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                if (DataVenuesStruct
                                                            .maybeFromMap(
                                                                dataVItem)!
                                                        .rating >
                                                    3.0)
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.22, -0.49),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(8.0,
                                                              9.5, 0.0, 0.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      ReviewWidget(
                                                                    idVenues: DataVenuesStruct.maybeFromMap(
                                                                            dataVItem)
                                                                        ?.iDVenuse,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              onStateChanged());
                                                        },
                                                        child: Container(
                                                          height: 22.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xFFFF0000),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        90.0),
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
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .star_rounded,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .extension<
                                                                          CustomColors>()!
                                                                      .primaryText,
                                                                  size: 15.0,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        1.5,
                                                                        7.0,
                                                                        0.0),
                                                                child: Text(
                                                                  formatNumber(
                                                                    DataVenuesStruct.maybeFromMap(
                                                                            dataVItem)!
                                                                        .rating,
                                                                    formatType:
                                                                        FormatType
                                                                            .custom,
                                                                    format:
                                                                        '.0',
                                                                    locale: '',
                                                                  ),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Theme.of(context)
                                                                            .extension<CustomColors>()!
                                                                            .primaryText,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            1.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
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
                                                  ),
                                              ],
                                            ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      1.0, 0.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 10.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              -0.9, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(15.0,
                                                                0.0, 15.0, 0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            DataVenuesStruct
                                                                    .maybeFromMap(
                                                                        dataVItem)
                                                                ?.openCloseTime,
                                                            'ไม่ระบุ',
                                                          ),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: const Color(
                                                                        0xFFE8E8E8),
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    Image.network(
                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                      width: 20.0,
                                                      height: 20.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(8.0,
                                                                0.0, 0.0, 0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            DataVenuesStruct
                                                                    .maybeFromMap(
                                                                        dataVItem)
                                                                ?.capacity
                                                                .toString(),
                                                            'ไม่ระบุ',
                                                          ),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: const Color(
                                                                        0xFFE8E8E8),
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(2.0,
                                                              0.0, 0.0, 0.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .k_ef5snpoq,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts
                                                                  .openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                              color: const Color(
                                                                  0xFFE8E8E8),
                                                              fontSize: 13.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(2.0,
                                                              0.0, 0.0, 0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          DataVenuesStruct
                                                                  .maybeFromMap(
                                                                      dataVItem)
                                                              ?.maxCapacity
                                                              .toString(),
                                                          'ไม่ระบุ',
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts
                                                                  .openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                              color: const Color(
                                                                  0xFFE8E8E8),
                                                              fontSize: 13.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(15.0,
                                                                0.0, 0.0, 0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            DataVenuesStruct
                                                                    .maybeFromMap(
                                                                        dataVItem)
                                                                ?.distance
                                                                .toString(),
                                                            'ไม่ระบุ',
                                                          ),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: const Color(
                                                                        0xFFE8E8E8),
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(5.0,
                                                              0.0, 8.0, 0.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .k_f7mjf40s,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts
                                                                  .openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                              color: const Color(
                                                                  0xFFE8E8E8),
                                                              fontSize: 13.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle: Theme.of(
                                                                      context)
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
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 9.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(15.0,
                                                              0.0, 0.0, 0.0),
                                                      child: Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          _safeMainImageUrl(
                                                            DataVenuesStruct
                                                                    .maybeFromMap(
                                                                        dataVItem)
                                                                ?.logo,
                                                            fallback:
                                                                _kMainFallbackPosterUrl,
                                                          ),
                                                          fit: BoxFit.cover,
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
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            1.0, 1.0),
                                        child: Container(
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 10.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              height: 50.0,
                                              child: Stack(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        -1.0, 0.0),
                                                children: [
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -0.2, 0.0),
                                                    child: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/20240515154627-Create_an_image_of_a.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.2, 0.0),
                                                    child: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/1-1-3.jpg',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.6, 0.0),
                                                    child: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/20240515161820-Create_an_image_of_a.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/20240515182857-Create_an_image_of_a.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            1.0, -1.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if ((currentUserDocument?.loveVenuse
                                                        .toList() ??
                                                    [])
                                                .contains(DataVenuesStruct
                                                        .maybeFromMap(dataVItem)
                                                    ?.iDVenuse)) {
                                              await currentUserReference!
                                                  .update({
                                                ...mapToSupabase(
                                                  {
                                                    'loveVenuse':
                                                        FieldValue.arrayRemove([
                                                      DataVenuesStruct
                                                              .maybeFromMap(
                                                                  dataVItem)
                                                          ?.iDVenuse
                                                    ]),
                                                  },
                                                ),
                                              });
                                            } else {
                                              await currentUserReference!
                                                  .update({
                                                ...mapToSupabase(
                                                  {
                                                    'loveVenuse':
                                                        FieldValue.arrayUnion([
                                                      DataVenuesStruct
                                                              .maybeFromMap(
                                                                  dataVItem)
                                                          ?.iDVenuse
                                                    ]),
                                                  },
                                                ),
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: 42.0,
                                            height: 42.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Stack(
                                              children: [
                                                if (!(currentUserDocument
                                                            ?.loveVenuse
                                                            .toList() ??
                                                        [])
                                                    .contains(DataVenuesStruct
                                                            .maybeFromMap(
                                                                dataVItem)
                                                        ?.iDVenuse))
                                                  const Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.heart,
                                                      color: Color(0xFFFDFDFD),
                                                      size: 23.0,
                                                    ),
                                                  ),
                                                if ((currentUserDocument
                                                            ?.loveVenuse
                                                            .toList() ??
                                                        [])
                                                    .contains(DataVenuesStruct
                                                            .maybeFromMap(
                                                                dataVItem)
                                                        ?.iDVenuse))
                                                  const Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color: Color(0xFFFF0000),
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
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
            ).animateOnPageLoad(
                animationsMap['containerOnPageLoadAnimation2']!);
          },
        )
      ],
    );
  }
}
