part of '../main_page.dart';

class MainEventsWidget extends StatelessWidget {
  final MainModel _model;
  final Map<String, AnimationInfo> animationsMap;
  final dynamic currentUserLocationValue;

  const MainEventsWidget({
    super.key,
    required MainModel model,
    required this.animationsMap,
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
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 0.0, 10.0),
            child: Text(
              'Events สำหรับคุณ',
              style: Theme.of(context).textTheme.bodyMedium!.override(
                    font: GoogleFonts.openSans(
                      fontWeight:
                          Theme.of(context).textTheme.bodyMedium!.fontWeight,
                      fontStyle:
                          Theme.of(context).textTheme.bodyMedium!.fontStyle,
                    ),
                    color: Theme.of(context)
                        .extension<CustomColors>()!
                        .primaryText,
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
        StreamBuilder<List<EventsRecord>>(
          stream: queryEventsRecord(),
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
            List<EventsRecord> containerEventsRecordList = snapshot.data!;

            return Container(
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: AuthUserStreamWidget(
                builder: (context) => Builder(
                  builder: (context) {
                    final dataeventmainhome = functions
                            .dataEvent(
                                context.appState.Filterdistance,
                                containerEventsRecordList.toList(),
                                currentUserLocationValue,
                                context.appState.StyleMusic.toList(),
                                (currentUserDocument?.loveEvent.toList() ?? [])
                                    .toList(),
                                context.appState.StyleVenuse.toList(),
                                1,
                                false,
                                false,
                                getCurrentTimestamp,
                                false,
                                false)
                            ?.toList() ??
                        [];

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(dataeventmainhome.length,
                                (dataeventmainhomeIndex) {
                          final dataeventmainhomeItem =
                              dataeventmainhome[dataeventmainhomeIndex];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
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
                                      DataEventsStruct.maybeFromMap(
                                              dataeventmainhomeItem)
                                          ?.iDVenuse,
                                      ParamType.SupabaseDocRef,
                                    ),
                                    'distance': serializeParam(
                                      DataEventsStruct.maybeFromMap(
                                              dataeventmainhomeItem)
                                          ?.distance
                                          .toString(),
                                      ParamType.String,
                                    ),
                                    'dateclick': serializeParam(
                                      DataEventsStruct.maybeFromMap(
                                              dataeventmainhomeItem)
                                          ?.date,
                                      ParamType.DateTime,
                                    ),
                                    'index': serializeParam(
                                      0,
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.444,
                                height: valueOrDefault<double>(
                                  functions.posterscale(_model.wlid, false),
                                  250.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF161616),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      _safeMainImageUrl(
                                        DataEventsStruct.maybeFromMap(
                                                dataeventmainhomeItem)
                                            ?.poster,
                                        fallback: _kMainFallbackPosterUrl,
                                      ),
                                    ).image,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10.0, 10.0, 0.0, 0.0),
                                            child: Container(
                                              width: 42.0,
                                              height: 42.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF0000),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 3.0, 0.0, 0.0),
                                                    child: Text(
                                                      functions
                                                          .dateEventday(DataEventsStruct
                                                                  .maybeFromMap(
                                                                      dataeventmainhomeItem)
                                                              ?.date)
                                                          .toString(),
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
                                                            color: Theme.of(
                                                                    context)
                                                                .extension<
                                                                    CustomColors>()!
                                                                .primaryText,
                                                            fontSize: 17.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                            lineHeight: 1.0,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 2.0, 0.0, 2.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        functions.dateMonthTH(
                                                            DataEventsStruct
                                                                    .maybeFromMap(
                                                                        dataeventmainhomeItem)
                                                                ?.date),
                                                        'ไม่ระบุ',
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
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
                                                                .primaryText,
                                                            fontSize: 13.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                            lineHeight: 1.0,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if ((currentUserDocument
                                                          ?.loveEvent
                                                          .toList() ??
                                                      [])
                                                  .contains(DataEventsStruct
                                                          .maybeFromMap(
                                                              dataeventmainhomeItem)
                                                      ?.docRef)) {
                                                await currentUserReference!
                                                    .update({
                                                  ...mapToSupabase(
                                                    {
                                                      'loveEvent': FieldValue
                                                          .arrayRemove([
                                                        DataEventsStruct
                                                                .maybeFromMap(
                                                                    dataeventmainhomeItem)
                                                            ?.docRef
                                                      ]),
                                                    },
                                                  ),
                                                });
                                              } else {
                                                await currentUserReference!
                                                    .update({
                                                  ...mapToSupabase(
                                                    {
                                                      'loveEvent': FieldValue
                                                          .arrayUnion([
                                                        DataEventsStruct
                                                                .maybeFromMap(
                                                                    dataeventmainhomeItem)
                                                            ?.docRef
                                                      ]),
                                                    },
                                                  ),
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: 38.0,
                                              height: 38.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0x22000000),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Stack(
                                                children: [
                                                  if (!(currentUserDocument
                                                              ?.loveEvent
                                                              .toList() ??
                                                          [])
                                                      .contains(DataEventsStruct
                                                              .maybeFromMap(
                                                                  dataeventmainhomeItem)
                                                          ?.docRef))
                                                    const Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    1.5,
                                                                    0.0,
                                                                    0.0),
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .heart,
                                                          color:
                                                              Color(0xFFFDFDFD),
                                                          size: 23.0,
                                                        ),
                                                      ),
                                                    ),
                                                  if ((currentUserDocument
                                                              ?.loveEvent
                                                              .toList() ??
                                                          [])
                                                      .contains(DataEventsStruct
                                                              .maybeFromMap(
                                                                  dataeventmainhomeItem)
                                                          ?.docRef))
                                                    const Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    1.5,
                                                                    0.0,
                                                                    0.0),
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .solidHeart,
                                                          color:
                                                              Color(0xFFFF0000),
                                                          size: 23.0,
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
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: const BoxDecoration(),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.22,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Color(0xED000000)
                                          ],
                                          stops: [0.0, 1.0],
                                          begin:
                                              AlignmentDirectional(0.0, -1.0),
                                          end: AlignmentDirectional(0, 1.0),
                                        ),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -1.0, 0.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    DataEventsStruct.maybeFromMap(
                                                            dataeventmainhomeItem)
                                                        ?.nameArtise
                                                        .firstOrNull,
                                                    'ไม่ระบุ',
                                                  ),
                                                  maxLines: 18,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        color: Theme.of(context)
                                                            .extension<
                                                                CustomColors>()!
                                                            .primaryText,
                                                        fontSize: 18.0,
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
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 3.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            5.0, 0.0, 0.0, 2.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        DataEventsStruct
                                                                .maybeFromMap(
                                                                    dataeventmainhomeItem)
                                                            ?.nameStore,
                                                        'ไม่ระบุ',
                                                      ),
                                                      maxLines: 18,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            color: const Color(
                                                                0xFFA1A1A1),
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
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
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      1.0, 0.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        5.0, 0.0, 5.0, 5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                      width: 16.0,
                                                      height: 16.0,
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
                                                            DataEventsStruct
                                                                    .maybeFromMap(
                                                                        dataeventmainhomeItem)
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
                                                            .k_9ksqi8gl,
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
                                                              fontSize: 14.0,
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
                                                          DataEventsStruct
                                                                  .maybeFromMap(
                                                                      dataeventmainhomeItem)
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
                                                    Expanded(
                                                      child: Container(
                                                        width: 100.0,
                                                        height: 1.0,
                                                        decoration:
                                                            const BoxDecoration(),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(10.0,
                                                                0.0, 0.0, 0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            DataEventsStruct
                                                                    .maybeFromMap(
                                                                        dataeventmainhomeItem)
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
                                                              0.0, 0.0, 0.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .k_8wo43ybd,
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                            .addToStart(const SizedBox(width: 10.0))
                            .addToEnd(const SizedBox(width: 25.0)),
                      ),
                    );
                  },
                ),
              ),
            ).animateOnPageLoad(
                animationsMap['containerOnPageLoadAnimation1']!);
          },
        )
      ],
    );
  }
}
