part of '../social_invenuse_page.dart';

class SocialInvenuesHeaderWidget extends ConsumerStatefulWidget {
  final SocialInVenuseModel model;
  final VenuesRecord stackVenuesRecord;

  const SocialInvenuesHeaderWidget({
    super.key,
    required this.model,
    required this.stackVenuesRecord,
  });

  @override
  ConsumerState<SocialInvenuesHeaderWidget> createState() =>
      _SocialInvenuesHeaderWidgetState();
}

class _SocialInvenuesHeaderWidgetState
    extends ConsumerState<SocialInvenuesHeaderWidget> {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  SocialInVenuseModel get _model => widget.model;
  VenuesRecord get stackVenuesRecord => widget.stackVenuesRecord;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: const AlignmentDirectional(-1.0, 0.0),
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 12.5),
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
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                              color: const Color(0x98FF0000),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x7A000000),
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                )
                              ],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0x98FF0000),
                                width: 2.0,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 2.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_back_ios_new_sharp,
                                      color: Theme.of(context)
                                          .extension<CustomColors>()!
                                          .primaryText,
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
            Expanded(
              child: Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 41.0, 10.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(45.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 4.5,
                        sigmaY: 4.5,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0x4D000000), Color(0x4D000000)],
                            stops: [0.0, 1.0],
                            begin: AlignmentDirectional(0.0, -1.0),
                            end: AlignmentDirectional(0, 1.0),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(45.0),
                            bottomRight: Radius.circular(45.0),
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 7.5, 0.0, 7.5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: const BoxDecoration(),
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            ProfilePage.routeName,
                                            queryParameters: {
                                              'fromSeting': serializeParam(
                                                false,
                                                ParamType.bool,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            fadeInDuration: const Duration(
                                                milliseconds: 500),
                                            fadeOutDuration: const Duration(
                                                milliseconds: 500),
                                            imageUrl: valueOrDefault<String>(
                                              currentUserPhoto,
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 2.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 2.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(4.0,
                                                              0.0, 0.0, 0.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .k_jza53d0o,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .override(
                                                              font: GoogleFonts
                                                                  .openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .fontStyle,
                                                              ),
                                                              color: const Color(
                                                                  0xFFCACACA),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelMedium!
                                                                  .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              2.0, 0.0, 0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      2.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                              child: StreamBuilder<
                                                                  List<
                                                                      VenuesRecord>>(
                                                                stream:
                                                                    queryVenuesRecord(),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return const Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            Colors.transparent,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<VenuesRecord>
                                                                      textVenuesRecordList =
                                                                      snapshot
                                                                          .data!;

                                                                  return InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(context).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                              child: JoinroomWidget(
                                                                                datavenuse: textVenuesRecordList.take(3).toList().map((e) => e.reference).toList(),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          safeSetState(
                                                                              () {}));
                                                                    },
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .k_ifexozan,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.2,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.22,
                                                                    -0.49),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      7.0,
                                                                      3.0,
                                                                      0.0,
                                                                      0.0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  await showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    useSafeArea:
                                                                        true,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              MediaQuery.viewInsetsOf(context),
                                                                          child:
                                                                              ReviewWidget(
                                                                            idVenues:
                                                                                currentUserDocument?.loginVenuesRoom,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ).then((value) =>
                                                                      safeSetState(
                                                                          () {}));
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xFF666666),
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .asset(
                                                                        'assets/images/colorful-vibrant-holographic-pastel-foil-background-texture-toxic-rave-party-backdrop_232693-243_3.jpeg',
                                                                      ).image,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        padding: const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            10.0,
                                                                            1.0,
                                                                            10.0,
                                                                            2.0),
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .k_1lam8xke,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                11.0,
                                                                            letterSpacing:
                                                                                1.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            shadows: [
                                                                              const Shadow(
                                                                                color: Color(0xFF262626),
                                                                                offset: Offset(2.0, 2.0),
                                                                                blurRadius: 4.0,
                                                                              )
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
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 2.0, 10.0, 0.0),
                                child: Container(
                                  width: 45.0,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            0.0, 0.0),
                                        child: Container(
                                          width: 33.0,
                                          height: 33.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.network(
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/tpcoeg4f3ab4/iconmain.png',
                                              ).image,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (functions
                                              .aminusB(
                                                  (currentUserDocument
                                                              ?.usercheerme
                                                              .toList() ??
                                                          [])
                                                      .length,
                                                  valueOrDefault(
                                                      currentUserDocument
                                                          ?.readcheers,
                                                      0))
                                              .toString() !=
                                          '0')
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              1.2, -1.2),
                                          child: Container(
                                            width: 18.0,
                                            height: 18.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFF0000),
                                              borderRadius:
                                                  BorderRadius.circular(180.0),
                                            ),
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0.0, 0.0),
                                              child: Text(
                                                functions
                                                    .aminusB(
                                                        (currentUserDocument
                                                                    ?.usercheerme
                                                                    .toList() ??
                                                                [])
                                                            .length,
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.readcheers,
                                                            0))
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
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
                                                      fontSize: 10.0,
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
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 2.0, 8.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(MainChatPage.routeName);
                                  },
                                  child: Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Image.network(
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/ucvx51dhc4gx/message2.png',
                                            width: 36.0,
                                            height: 36.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if ((currentUserDocument?.usermassage
                                                    .toList() ??
                                                [])
                                            .isNotEmpty)
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    1.2, -1.2),
                                            child: Container(
                                              width: 18.0,
                                              height: 18.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF0000),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        180.0),
                                              ),
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.1, 0.0),
                                                child: Text(
                                                  (currentUserDocument
                                                              ?.usermassage
                                                              .toList() ??
                                                          [])
                                                      .length
                                                      .toString(),
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
                                                        fontSize: 10.0,
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
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
            child: Container(
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 80.0, 0.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.network(
                                  stackVenuesRecord.logo,
                                ).image,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              17.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        // context.pushNamed(HomeCopy2Page.routeName);
                                      },
                                      child: Text(
                                        valueOrDefault<String>(
                                          functions.newCustomFunction(
                                              stackVenuesRecord.nameVenuse, 14),
                                          'ไม่ระบุ',
                                        ),
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
                                              fontSize: 27.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 2.0, 0.0, 7.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      stackVenuesRecord.openCloseTime,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .fontStyle,
                                            ),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .fontStyle,
                                          ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                          0.22, -0.49),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10.0, 0.0, 0.0, 0.0),
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
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: ReviewWidget(
                                                      idVenues:
                                                          currentUserDocument
                                                              ?.loginVenuesRoom,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
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
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          5.0, 0.0, 0.0, 1.0),
                                                  child: Icon(
                                                    Icons.star_rounded,
                                                    color: Theme.of(context)
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
                                                          2.5, 1.0, 7.0, 1.5),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .k_sx8oo1l5,
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
                                                              .primaryText,
                                                          fontSize: 13.0,
                                                          letterSpacing: 1.0,
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
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/MEE2.png',
                                        width: 18.0,
                                        height: 18.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 25.0, 0.0),
                                    child: StreamBuilder<UserInVenuesRecord>(
                                      stream: UserInVenuesRecord.getDocument(
                                          (currentUserDocument?.iDROOMVenues
                                                      .toList() ??
                                                  [])
                                              .firstOrNull!),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return const Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        final textUserInVenuesRecord =
                                            snapshot.data!;

                                        return Text(
                                          AppLocalizations.of(context)!
                                              .k_n9q37elg,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontStyle,
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                    child: Icon(
                                      Icons.people_rounded,
                                      color: Theme.of(context)
                                          .extension<CustomColors>()!
                                          .primaryText,
                                      size: 22.0,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 2.0, 0.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.k_89nb8pgs,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .fontStyle,
                                            ),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.k_zzwut81b,
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
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            2.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.k_bvjy4cxr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .fontStyle,
                                            ),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .fontStyle,
                                          ),
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
