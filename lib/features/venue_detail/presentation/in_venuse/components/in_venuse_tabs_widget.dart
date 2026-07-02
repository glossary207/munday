part of '../in_venuse_page.dart';



@NowaGenerated()
class InVenuseTabsWidget extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const InVenuseTabsWidget({
    super.key,
    required this.model,
    required this.inVenuseVenuesRecord,
    required this.animationsMap,
    this.currentUserLocationValue,
    required this.venueAudienceSection,
    required this.onStateChanged,
  });

  final InVenuseModel model;

  final VenuesRecord inVenuseVenuesRecord;

  final Map<String, AnimationInfo> animationsMap;

  final LatLng? currentUserLocationValue;

  final void Function() onStateChanged;

  final Widget venueAudienceSection;

  InVenuseModel get _model {
    return model;
  }

  bool _hasValidNetworkImageUrl(String? url) {
    if (url == null || url!.trim().isEmpty) {
      return false;
    }
    final lowerUrl = url.toLowerCase();
    return lowerUrl.startsWith('http://') || lowerUrl.startsWith('https://');
  }

  String _safeNetworkImageUrl(String? url, {required String fallback}) {
    if (_hasValidNetworkImageUrl(url)) {
      return url!.trim();
    }
    return fallback;
  }

  List<PromotionDataSubStruct> _resolvedVenuePromotions(VenuesRecord venue) {
    if (venue.listpromotion.isNotEmpty) {
      final validLegacyPromotions = venue.listpromotion
          .where((promotion) => _hasValidNetworkImageUrl(promotion.photo))
          .toList(growable: false);
      if (validLegacyPromotions.isNotEmpty) {
        return validLegacyPromotions;
      }
    }
    return venue.promotion
        .where(_hasValidNetworkImageUrl)
        .map(
          (photoUrl) => PromotionDataSubStruct(
            photo: photoUrl.trim(),
            mon: true,
            tue: true,
            wed: true,
            thu: true,
            fri: true,
            sat: true,
            sun: true,
          ),
        )
        .toList(growable: false);
  }

  List<String> _resolvedVenuePhotoUrls(VenuesRecord venue) {
    return venue.photos
        .where(_hasValidNetworkImageUrl)
        .map((photoUrl) => photoUrl.trim())
        .toList(growable: false);
  }

  Future<void> _showVenuePhotoSheet(
    BuildContext context,
    VenuesRecord venue,
    int index,
  ) async {
    final photoUrls = _resolvedVenuePhotoUrls(venue);
    if (index < 0 || index >= photoUrls.length) {
      return;
    }
    final orderedPhotos = List<String>.from(photoUrls);
    final selectedPhoto = orderedPhotos.removeAt(index);
    orderedPhotos.insert(0, selectedPhoto);
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: ShowphotoWidget(photo: orderedPhotos),
        ),
      ),
    ).then((value) => onStateChanged());
  }

  Widget _buildVenuePhotoTile(
    BuildContext context,
    VenuesRecord venue,
    int index,
  ) {
    final photoUrls = _resolvedVenuePhotoUrls(venue);
    final photoUrl = index < photoUrls.length ? photoUrls[index] : null;
    final tileWidth = MediaQuery.sizeOf(context).width * 0.33;
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: photoUrl == null
          ? null
          : () => _showVenuePhotoSheet(context, venue, index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: photoUrl != null
            ? Image.network(
                photoUrl!,
                width: tileWidth,
                height: MediaQuery.sizeOf(context).height * 1.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: const Color(0xFF1A1A1A)),
              )
            : Container(width: tileWidth, color: const Color(0xFF1A1A1A)),
      ),
    );
  }

  Widget _buildVenuePhotoGrid(BuildContext context, VenuesRecord venue) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gridHeight =
            constraints.maxHeight.isFinite && constraints.maxHeight > 0.0
            ? constraints.maxHeight
            : 260.0;
        final rowHeight = (gridHeight - 1.0) / 2;
        return SizedBox(
          height: gridHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: rowHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => _buildVenuePhotoTile(context, venue, index),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  1.0,
                  0.0,
                  0.0,
                ),
                child: SizedBox(
                  height: rowHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) =>
                          _buildVenuePhotoTile(context, venue, index + 3),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
          child: Container(
            height: 334.0,
            decoration: const BoxDecoration(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tabViewHeight = math.max(
                  0.0,
                  constraints.maxHeight - kTextTabBarHeight,
                );
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: const Alignment(-1.0, 0),
                      child: TabBar(
                        labelColor: MundayTheme.of(context).primaryText,
                        unselectedLabelColor: const Color(0xFFB1B1B1),
                        labelPadding: const EdgeInsetsDirectional.fromSTEB(
                          10.0,
                          0.0,
                          10.0,
                          0.0,
                        ),
                        labelStyle: MundayTheme.of(context).titleMedium
                            .override(
                              font: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                                fontStyle: MundayTheme.of(
                                  context,
                                ).titleMedium.fontStyle,
                              ),
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: MundayTheme.of(
                                context,
                              ).titleMedium.fontStyle,
                              lineHeight: 0.0,
                            ),
                        unselectedLabelStyle: const TextStyle(),
                        indicatorColor: const Color(0xFFFF0000),
                        indicatorWeight: 2.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          13.0,
                          0.0,
                          0.0,
                          0.0,
                        ),
                        tabs: [
                          Tab(text: AppLocalizations.of(context)!.k_z0ulu30f),
                          Tab(text: AppLocalizations.of(context)!.k_l41wx1tf),
                          Tab(text: AppLocalizations.of(context)!.k_jo5htnm4),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}, () async {}][i]();
                        },
                      ),
                    ),
                    SizedBox(
                      height: tabViewHeight,
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          Container(
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    10.0,
                                    0.0,
                                    0.0,
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      final events = inVenuseVenuesRecord.events
                                          .toList();
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: List.generate(events.length, (
                                            eventsIndex,
                                          ) {
                                            final eventsItem =
                                                events[eventsIndex];
                                            return Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    7.0,
                                                    0.0,
                                                  ),
                                              child: StreamBuilder<EventsRecord>(
                                                stream:
                                                    EventsRecord.getDocument(
                                                      eventsItem,
                                                    ),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return const Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child: CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                Color
                                                              >(
                                                                Colors
                                                                    .transparent,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  final containerEventsRecord =
                                                      snapshot.data!;
                                                  return InkWell(
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
                                                              child: PosterPresentWidget(
                                                                detail:
                                                                    containerEventsRecord
                                                                        .detail,
                                                                poster:
                                                                    containerEventsRecord
                                                                        .poster,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then(
                                                        (value) =>
                                                            onStateChanged(),
                                                      );
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.sizeOf(
                                                            context,
                                                          ).width *
                                                          0.44,
                                                      height: 250.0,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFF161616,
                                                        ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(
                                                            _safeNetworkImageUrl(
                                                              containerEventsRecord
                                                                  .poster,
                                                              fallback:
                                                                  _kInVenuseFallbackPosterUrl,
                                                            ),
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10.0,
                                                            ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                        10.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Container(
                                                                    width: 42.0,
                                                                    height:
                                                                        42.0,
                                                                    decoration: BoxDecoration(
                                                                      color: const Color(
                                                                        0xFFFF0000,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.0,
                                                                          ),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                          child: Text(
                                                                            functions
                                                                                .dateEventday(
                                                                                  containerEventsRecord.date,
                                                                                )
                                                                                .toString(),
                                                                            style:
                                                                                MundayTheme.of(
                                                                                  context,
                                                                                ).bodyMedium.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: MundayTheme.of(
                                                                                      context,
                                                                                    ).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: MundayTheme.of(
                                                                                    context,
                                                                                  ).primaryText,
                                                                                  fontSize: 17.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: MundayTheme.of(
                                                                                    context,
                                                                                  ).bodyMedium.fontStyle,
                                                                                  lineHeight: 1.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            2.0,
                                                                            0.0,
                                                                            2.0,
                                                                          ),
                                                                          child: Text(
                                                                            valueOrDefault<
                                                                              String
                                                                            >(
                                                                              functions.dateMonthTH(
                                                                                containerEventsRecord.date,
                                                                              ),
                                                                              'ไม่ระบุ',
                                                                            ),
                                                                            style:
                                                                                MundayTheme.of(
                                                                                  context,
                                                                                ).bodyMedium.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: MundayTheme.of(
                                                                                      context,
                                                                                    ).bodyMedium.fontWeight,
                                                                                    fontStyle: MundayTheme.of(
                                                                                      context,
                                                                                    ).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: MundayTheme.of(
                                                                                    context,
                                                                                  ).primaryText,
                                                                                  fontSize: 13.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: MundayTheme.of(
                                                                                    context,
                                                                                  ).bodyMedium.fontWeight,
                                                                                  fontStyle: MundayTheme.of(
                                                                                    context,
                                                                                  ).bodyMedium.fontStyle,
                                                                                  lineHeight: 1.0,
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
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                MediaQuery.sizeOf(
                                                                  context,
                                                                ).height *
                                                                0.22,
                                                            decoration: const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  Colors
                                                                      .transparent,
                                                                  Color(
                                                                    0xED000000,
                                                                  ),
                                                                ],
                                                                stops: [
                                                                  0.0,
                                                                  1.0,
                                                                ],
                                                                begin:
                                                                    AlignmentDirectional(
                                                                      0.0,
                                                                      -1.0,
                                                                    ),
                                                                end:
                                                                    AlignmentDirectional(
                                                                      0,
                                                                      1.0,
                                                                    ),
                                                              ),
                                                              borderRadius: BorderRadius.only(
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                      10.0,
                                                                    ),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                      10.0,
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
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional.fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                  ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0,
                                                                        ),
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                          ),
                                                                      child: Text(
                                                                        containerEventsRecord.nameArtise.firstOrNull ??
                                                                            'ไม่ระบุ',
                                                                        maxLines:
                                                                            18,
                                                                        style:
                                                                            MundayTheme.of(
                                                                              context,
                                                                            ).bodyMedium.override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: MundayTheme.of(
                                                                                  context,
                                                                                ).bodyMedium.fontWeight,
                                                                                fontStyle: MundayTheme.of(
                                                                                  context,
                                                                                ).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: MundayTheme.of(
                                                                                context,
                                                                              ).primaryText,
                                                                              fontSize: 16.0,
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
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                          1.0,
                                                                          0.0,
                                                                        ),
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            5.0,
                                                                            10.0,
                                                                          ),
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
                                                                            width:
                                                                                16.0,
                                                                            height:
                                                                                16.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                          Align(
                                                                            alignment: const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              child: Text(
                                                                                containerEventsRecord.capacity.toString(),
                                                                                style:
                                                                                    MundayTheme.of(
                                                                                      context,
                                                                                    ).bodyMedium.override(
                                                                                      font: GoogleFonts.openSans(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: MundayTheme.of(
                                                                                          context,
                                                                                        ).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: const Color(
                                                                                        0xFFE8E8E8,
                                                                                      ),
                                                                                      fontSize: 13.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: MundayTheme.of(
                                                                                        context,
                                                                                      ).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              2.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Text(
                                                                              AppLocalizations.of(
                                                                                context,
                                                                              )!.k_nfc8d6s8,
                                                                              style:
                                                                                  MundayTheme.of(
                                                                                    context,
                                                                                  ).bodyMedium.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: MundayTheme.of(
                                                                                        context,
                                                                                      ).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: const Color(
                                                                                      0xFFE8E8E8,
                                                                                    ),
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: MundayTheme.of(
                                                                                      context,
                                                                                    ).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              2.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Text(
                                                                              containerEventsRecord.maxCapacity.toString(),
                                                                              style:
                                                                                  MundayTheme.of(
                                                                                    context,
                                                                                  ).bodyMedium.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: MundayTheme.of(
                                                                                        context,
                                                                                      ).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: const Color(
                                                                                      0xFFE8E8E8,
                                                                                    ),
                                                                                    fontSize: 13.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: MundayTheme.of(
                                                                                      context,
                                                                                    ).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Container(
                                                                              width: 100.0,
                                                                              height: 1.0,
                                                                              decoration: const BoxDecoration(),
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
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (!(inVenuseVenuesRecord.events.isNotEmpty))
                                  Align(
                                    alignment: const AlignmentDirectional(
                                      0.0,
                                      -1.0,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            40.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.notifications_none,
                                            color: Colors.white,
                                            size: 72.0,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  5.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.k_ru3pw87v,
                                              style:
                                                  MundayTheme.of(
                                                    context,
                                                  ).headlineMedium.override(
                                                    font: GoogleFonts.outfit(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          MundayTheme.of(
                                                                context,
                                                              )
                                                              .headlineMedium
                                                              .fontStyle,
                                                    ),
                                                    color: Colors.white,
                                                    fontSize: 30.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        MundayTheme.of(
                                                              context,
                                                            )
                                                            .headlineMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  25.0,
                                                  4.0,
                                                  25.0,
                                                  0.0,
                                                ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.k_ff7cf9o6,
                                              textAlign: TextAlign.center,
                                              style:
                                                  MundayTheme.of(
                                                    context,
                                                  ).labelMedium.override(
                                                    font: GoogleFonts.plusJakartaSans(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          MundayTheme.of(
                                                                context,
                                                              )
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: const Color(
                                                      0xFFBCBCBC,
                                                    ),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        MundayTheme.of(
                                                          context,
                                                        ).labelMedium.fontStyle,
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
                          Container(
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(
                                    -1.0,
                                    -1.0,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          13.0,
                                          0.0,
                                          0.0,
                                        ),
                                    child: ChangeNotifierProvider.value(
                                      value: _model.rowpromotionModel
                                          .setOnUpdate(
                                            onUpdate: () => onStateChanged(),
                                          ),
                                      child: RowpromotionWidget(
                                        dataPro: _resolvedVenuePromotions(
                                          inVenuseVenuesRecord,
                                        ),
                                        todaycheck: true,
                                      ),
                                    ),
                                  ),
                                ),
                                if (_resolvedVenuePromotions(
                                  inVenuseVenuesRecord,
                                ).isEmpty)
                                  Align(
                                    alignment: const AlignmentDirectional(
                                      0.0,
                                      -1.0,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            40.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.notifications_none,
                                            color: Colors.white,
                                            size: 72.0,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  5.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.k_ufk1gvu8,
                                              style:
                                                  MundayTheme.of(
                                                    context,
                                                  ).headlineMedium.override(
                                                    font: GoogleFonts.outfit(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          MundayTheme.of(
                                                                context,
                                                              )
                                                              .headlineMedium
                                                              .fontStyle,
                                                    ),
                                                    color: Colors.white,
                                                    fontSize: 30.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        MundayTheme.of(
                                                              context,
                                                            )
                                                            .headlineMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  25.0,
                                                  4.0,
                                                  25.0,
                                                  0.0,
                                                ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.k_9v0vv7rb,
                                              textAlign: TextAlign.center,
                                              style:
                                                  MundayTheme.of(
                                                    context,
                                                  ).labelMedium.override(
                                                    font: GoogleFonts.plusJakartaSans(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          MundayTheme.of(
                                                                context,
                                                              )
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: const Color(
                                                      0xFFBCBCBC,
                                                    ),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        MundayTheme.of(
                                                          context,
                                                        ).labelMedium.fontStyle,
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
                              0.0,
                              10.0,
                              0.0,
                              0.0,
                            ),
                            child: Stack(
                              children: [
                                _buildVenuePhotoGrid(
                                  context,
                                  inVenuseVenuesRecord,
                                ),
                                if (false)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
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
                                                        child: ShowphotoWidget(
                                                          photo: functions
                                                              .selectpicture(
                                                                0,
                                                                inVenuseVenuesRecord
                                                                    .photos
                                                                    .toList(),
                                                              )!,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                  (value) => onStateChanged(),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child:
                                                    inVenuseVenuesRecord
                                                        .photos
                                                        .isNotEmpty
                                                    ? Image.network(
                                                        inVenuseVenuesRecord
                                                            .photos[0],
                                                        width:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).width *
                                                            0.33,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).height *
                                                            1.0,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => Container(
                                                              color:
                                                                  const Color(
                                                                    0xFF1A1A1A,
                                                                  ),
                                                            ),
                                                      )
                                                    : Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).width *
                                                            0.33,
                                                        color: const Color(
                                                          0xFF1A1A1A,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
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
                                                        child: ShowphotoWidget(
                                                          photo: functions
                                                              .selectpicture(
                                                                1,
                                                                inVenuseVenuesRecord
                                                                    .photos
                                                                    .toList(),
                                                              )!,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                  (value) => onStateChanged(),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child:
                                                    inVenuseVenuesRecord
                                                            .photos
                                                            .length >
                                                        1
                                                    ? Image.network(
                                                        inVenuseVenuesRecord
                                                            .photos[1],
                                                        width:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).width *
                                                            0.33,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).height *
                                                            1.0,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => Container(
                                                              color:
                                                                  const Color(
                                                                    0xFF1A1A1A,
                                                                  ),
                                                            ),
                                                      )
                                                    : Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).width *
                                                            0.33,
                                                        color: const Color(
                                                          0xFF1A1A1A,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
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
                                                        child: ShowphotoWidget(
                                                          photo: functions
                                                              .selectpicture(
                                                                2,
                                                                inVenuseVenuesRecord
                                                                    .photos
                                                                    .toList(),
                                                              )!,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                  (value) => onStateChanged(),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child:
                                                    inVenuseVenuesRecord
                                                            .photos
                                                            .length >
                                                        2
                                                    ? Image.network(
                                                        inVenuseVenuesRecord
                                                            .photos[2],
                                                        width:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).width *
                                                            0.33,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).height *
                                                            1.0,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => Container(
                                                              color:
                                                                  const Color(
                                                                    0xFF1A1A1A,
                                                                  ),
                                                            ),
                                                      )
                                                    : Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).width *
                                                            0.33,
                                                        color: const Color(
                                                          0xFF1A1A1A,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                1.0,
                                                0.0,
                                                0.0,
                                              ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
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
                                                          child: ShowphotoWidget(
                                                            photo: functions
                                                                .selectpicture(
                                                                  3,
                                                                  inVenuseVenuesRecord
                                                                      .photos
                                                                      .toList(),
                                                                )!,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then(
                                                    (value) => onStateChanged(),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        0.0,
                                                      ),
                                                  child:
                                                      inVenuseVenuesRecord
                                                              .photos
                                                              .length >
                                                          3
                                                      ? Image.network(
                                                          inVenuseVenuesRecord
                                                              .photos[3],
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.33,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).height *
                                                              1.0,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) => Container(
                                                                color:
                                                                    const Color(
                                                                      0xFF1A1A1A,
                                                                    ),
                                                              ),
                                                        )
                                                      : Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.33,
                                                          color: const Color(
                                                            0xFF1A1A1A,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
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
                                                          child: ShowphotoWidget(
                                                            photo: functions
                                                                .selectpicture(
                                                                  4,
                                                                  inVenuseVenuesRecord
                                                                      .photos
                                                                      .toList(),
                                                                )!,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then(
                                                    (value) => onStateChanged(),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        0.0,
                                                      ),
                                                  child:
                                                      inVenuseVenuesRecord
                                                              .photos
                                                              .length >
                                                          4
                                                      ? Image.network(
                                                          inVenuseVenuesRecord
                                                              .photos[4],
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.33,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).height *
                                                              1.0,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) => Container(
                                                                color:
                                                                    const Color(
                                                                      0xFF1A1A1A,
                                                                    ),
                                                              ),
                                                        )
                                                      : Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.33,
                                                          color: const Color(
                                                            0xFF1A1A1A,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
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
                                                          child: ShowphotoWidget(
                                                            photo: functions
                                                                .selectpicture(
                                                                  5,
                                                                  inVenuseVenuesRecord
                                                                      .photos
                                                                      .toList(),
                                                                )!,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then(
                                                    (value) => onStateChanged(),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        0.0,
                                                      ),
                                                  child:
                                                      inVenuseVenuesRecord
                                                              .photos
                                                              .length >
                                                          5
                                                      ? Image.network(
                                                          inVenuseVenuesRecord
                                                              .photos[5],
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.33,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).height *
                                                              1.0,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) => Container(
                                                                color:
                                                                    const Color(
                                                                      0xFF1A1A1A,
                                                                    ),
                                                              ),
                                                        )
                                                      : Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.33,
                                                          color: const Color(
                                                            0xFF1A1A1A,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (_resolvedVenuePhotoUrls(
                                      inVenuseVenuesRecord,
                                    ).length >
                                    6)
                                  Align(
                                    alignment: const AlignmentDirectional(
                                      0.0,
                                      1.0,
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
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
                                                child: AllphotoWidget(
                                                  dataphoto:
                                                      _resolvedVenuePhotoUrls(
                                                        inVenuseVenuesRecord,
                                                      ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => onStateChanged());
                                      },
                                      child: Container(
                                        width: 100.0,
                                        height: 25.0,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF0000),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Align(
                                          alignment: const AlignmentDirectional(
                                            0.0,
                                            0.0,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_5fy6v03b,
                                            style: MundayTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        MundayTheme.of(
                                                          context,
                                                        ).bodyMedium.fontWeight,
                                                    fontStyle:
                                                        MundayTheme.of(
                                                          context,
                                                        ).bodyMedium.fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      MundayTheme.of(
                                                        context,
                                                      ).bodyMedium.fontWeight,
                                                  fontStyle:
                                                      MundayTheme.of(
                                                        context,
                                                      ).bodyMedium.fontStyle,
                                                ),
                                          ),
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
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
          child: Container(
            height: 190.0,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    20.0,
                    0.0,
                    0.0,
                    10.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.k_msgdr2kn,
                    style: MundayTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontStyle: MundayTheme.of(
                          context,
                        ).bodyMedium.fontStyle,
                      ),
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: MundayTheme.of(
                        context,
                      ).bodyMedium.fontStyle,
                    ),
                  ),
                ),
                SingleChildScrollView(
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
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
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
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: const AppbarsilverWidget(
                                      image:
                                          'https://longdan.co.uk/cdn/shop/files/1701009_800x.png?v=1728881576',
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => onStateChanged());
                          },
                          child: Container(
                            width: 140.0,
                            height: 140.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/565179821_17903345310270037_2336821677705862664_n.jpg',
                                ).image,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Color(0x65000000),
                                  offset: Offset(4.0, 4.0),
                                  spreadRadius: 4.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [],
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(
                                    0.0,
                                    1.0,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 80.0,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Color(0x99000000),
                                          Color(0xCD000000),
                                        ],
                                        stops: [0.0, 0.8, 1.0],
                                        begin: AlignmentDirectional(0.0, -1.0),
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            5.0,
                                            0.0,
                                            5.0,
                                            0.0,
                                          ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  1.0,
                                                  0.0,
                                                ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    5.0,
                                                    0.0,
                                                    5.0,
                                                    5.0,
                                                  ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                      -1.0,
                                                                      0.0,
                                                                    ),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_rxpcsy4y,
                                                                  maxLines: 30,
                                                                  style: MundayTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                    ),
                                                                    color: MundayTheme.of(
                                                                      context,
                                                                    ).primaryText,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle:
                                                                        MundayTheme.of(
                                                                          context,
                                                                        ).bodyMedium.fontStyle,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                3.0,
                                                              ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_3mbf3ujq,
                                                                  maxLines: 18,
                                                                  style: MundayTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                    ),
                                                                    color: const Color(
                                                                      0xFFD1D1D1,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle:
                                                                        MundayTheme.of(
                                                                          context,
                                                                        ).bodyMedium.fontStyle,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 1.0,
                                                          height: 1.0,
                                                          decoration:
                                                              const BoxDecoration(),
                                                        ),
                                                      ],
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
                                                            10.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_6z9zg4yc,
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
                                                                  const Color(
                                                                    0xFFE8E8E8,
                                                                  ),
                                                              fontSize: 14.5,
                                                              letterSpacing:
                                                                  0.0,
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
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          3.0,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.k_nawxs7oi,
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
                                                            color: const Color(
                                                              0xFFE8E8E8,
                                                            ),
                                                            fontSize: 13.0,
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
                                                ],
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
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          0.0,
                          10.0,
                          0.0,
                        ),
                        child: Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/573536959_17905547412270037_1716312783667038911_n.jpg',
                              ).image,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Color(0x65000000),
                                offset: Offset(4.0, 4.0),
                                spreadRadius: 4.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [],
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(
                                      0.0,
                                      1.0,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 80.0,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Color(0x99000000),
                                            Color(0xCD000000),
                                          ],
                                          stops: [0.0, 0.8, 1.0],
                                          begin: AlignmentDirectional(
                                            0.0,
                                            -1.0,
                                          ),
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
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              5.0,
                                              0.0,
                                              5.0,
                                              0.0,
                                            ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    1.0,
                                                    0.0,
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      5.0,
                                                      0.0,
                                                      5.0,
                                                      5.0,
                                                    ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_vqonn8mz,
                                                                    maxLines:
                                                                        18,
                                                                    style: MundayTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: MundayTheme.of(
                                                                          context,
                                                                        ).bodyMedium.fontStyle,
                                                                      ),
                                                                      color: MundayTheme.of(
                                                                        context,
                                                                      ).primaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  3.0,
                                                                ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_mh90obeb,
                                                                    maxLines:
                                                                        18,
                                                                    style: MundayTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: MundayTheme.of(
                                                                          context,
                                                                        ).bodyMedium.fontStyle,
                                                                      ),
                                                                      color: const Color(
                                                                        0xFFD1D1D1,
                                                                      ),
                                                                      fontSize:
                                                                          12.5,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 100.0,
                                                            height: 1.0,
                                                            decoration:
                                                                const BoxDecoration(),
                                                          ),
                                                        ],
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
                                                              10.0,
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.k_8eiogcop,
                                                          style: MundayTheme.of(context).bodyMedium.override(
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
                                                            color: const Color(
                                                              0xFFE8E8E8,
                                                            ),
                                                            fontSize: 14.5,
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            3.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.k_eosk366z,
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
                                                                  const Color(
                                                                    0xFFE8E8E8,
                                                                  ),
                                                              fontSize: 13.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                ],
                              ),
                            ],
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
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/573550812_17905547766270037_5228271313856733664_n.jpg',
                              ).image,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Color(0x65000000),
                                offset: Offset(4.0, 4.0),
                                spreadRadius: 4.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [],
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 80.0,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Color(0x99000000),
                                        Color(0xCD000000),
                                      ],
                                      stops: [0.0, 0.8, 1.0],
                                      begin: AlignmentDirectional(0.0, -1.0),
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
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          5.0,
                                          0.0,
                                          5.0,
                                          0.0,
                                        ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                            1.0,
                                            0.0,
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  5.0,
                                                  0.0,
                                                  5.0,
                                                  5.0,
                                                ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                              -1.0,
                                                              0.0,
                                                            ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.k_tt381dwt,
                                                          maxLines: 18,
                                                          style: MundayTheme.of(context).bodyMedium.override(
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
                                                            fontSize: 16.0,
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              3.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_8ww8v0t5,
                                                                maxLines: 18,
                                                                style: MundayTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle:
                                                                        MundayTheme.of(
                                                                          context,
                                                                        ).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: const Color(
                                                                    0xFFD1D1D1,
                                                                  ),
                                                                  fontSize:
                                                                      12.5,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle:
                                                                      MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 100.0,
                                                        height: 1.0,
                                                        decoration:
                                                            const BoxDecoration(),
                                                      ),
                                                    ],
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
                                                          10.0,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.k_cs9oms2v,
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
                                                            color: const Color(
                                                              0xFFE8E8E8,
                                                            ),
                                                            fontSize: 14.5,
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                        3.0,
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_j3pfoanq,
                                                    style:
                                                        MundayTheme.of(
                                                          context,
                                                        ).bodyMedium.override(
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
                                                          color: const Color(
                                                            0xFFE8E8E8,
                                                          ),
                                                          fontSize: 13.0,
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
                                              ],
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
                    ].addToStart(const SizedBox(width: 10.0)).addToEnd(const SizedBox(width: 25.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
        venueAudienceSection,
      ],
    );
  }
}
