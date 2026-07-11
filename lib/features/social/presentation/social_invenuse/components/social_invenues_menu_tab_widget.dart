part of '../social_invenuse_page.dart';

class SocialInvenuesMenuTabWidget extends ConsumerStatefulWidget {
  final SocialInVenuseModel model;
  final VenuesRecord stackVenuesRecord;
  final Map<String, AnimationInfo> animationsMap;

  const SocialInvenuesMenuTabWidget({
    super.key,
    required this.model,
    required this.stackVenuesRecord,
    required this.animationsMap,
  });

  @override
  ConsumerState<SocialInvenuesMenuTabWidget> createState() =>
      _SocialInvenuesMenuTabWidgetState();
}

class _SocialInvenuesMenuTabWidgetState
    extends ConsumerState<SocialInvenuesMenuTabWidget> {
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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (false)
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  1.0,
                  0.0,
                  0.0,
                  0.0,
                ),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 1.0,
                  ),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0,
                        10.0,
                        5.0,
                        0.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: const AlignmentDirectional(0.0, -1.0),
                            image: Image.network(stackVenuesRecord.bg).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 20.0,
                              sigmaY: 20.0,
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
                                        padding: MediaQuery.viewInsetsOf(
                                          context,
                                        ),
                                        child: ShowpromotionWidget(
                                          photo: stackVenuesRecord.promotion,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xDA000000),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: const Color(0xFF2C2C2C),
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.asset(
                                        'assets/images/Red_Yellow_Modern_New_Year_Sale_Facebook_Post_(1).png',
                                        width: 120.0,
                                        height: 110.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.k_7dqx0x2h,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.fontStyle,
                                            ),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
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
                        5.0,
                        10.0,
                        10.0,
                        0.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            image: Image.network(stackVenuesRecord.bg).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 20.0,
                              sigmaY: 20.0,
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
                                        padding: MediaQuery.viewInsetsOf(
                                          context,
                                        ),
                                        child: ShowpromotionWidget(
                                          photo: stackVenuesRecord.promotion,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xD9000000),
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: const Color(0xFF2C2C2C),
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            5.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          0.0,
                                        ),
                                        child: Image.asset(
                                          'assets/images/nswz3_9.png',
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.k_l8eqk9pq,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.fontStyle,
                                            ),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
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
                        10.0,
                        10.0,
                        5.0,
                        0.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: const AlignmentDirectional(-1.0, 1.0),
                            image: Image.network(stackVenuesRecord.bg).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 20.0,
                              sigmaY: 20.0,
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
                                        padding: MediaQuery.viewInsetsOf(
                                          context,
                                        ),
                                        child: ShowpromotionWidget(
                                          photo: stackVenuesRecord.promotion,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xD9000000),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: const Color(0xFF2C2C2C),
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.asset(
                                        'assets/images/k7eg7_8.png',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.k_gxdi3f2f,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.fontStyle,
                                            ),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
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
                  ],
                ),
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: const FilterWidget(),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0,
                              10.0,
                              0.0,
                              5.0,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          10.0,
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
                                          backgroundColor: Colors.transparent,
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
                                                child: const FilterWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));

                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        width: 45.0,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0x98FF0000),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 5.0,
                                              color: Color(0x33000000),
                                              offset: Offset(2.0, 2.0),
                                              spreadRadius: 4.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                          border: Border.all(
                                            color: const Color(0x98FF0000),
                                            width: 2.0,
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
                                              child: FaIcon(
                                                FontAwesomeIcons.search,
                                                color: Theme.of(context)
                                                    .extension<CustomColors>()!
                                                    .primaryText,
                                                size: 20.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              10.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child: Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0x98FF0000),
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                            border: Border.all(
                                              color: const Color(0x98FF0000),
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Align(
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
                                                    10.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_c3ihn4ll,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                            fontWeight:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
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
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              10.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child: Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF111111),
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          child: Align(
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
                                                    10.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_2ijyibzr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                            fontWeight:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                      color: const Color(
                                                        0xFFA2A2A2,
                                                      ),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
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
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              10.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child: Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF111111),
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          child: Align(
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
                                                    10.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_wkacxyok,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                            fontWeight:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                      color: const Color(
                                                        0xFFA2A2A2,
                                                      ),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
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
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              10.0,
                                              0.0,
                                              10.0,
                                              0.0,
                                            ),
                                        child: Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF111111),
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          child: Align(
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
                                                    10.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_jd24thiw,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                            fontWeight:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                      color: const Color(
                                                        0xFFA2A2A2,
                                                      ),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
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
                                    ],
                                  ),
                                ].addToEnd(const SizedBox(width: 40.0)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: Container(
                              width: 40.0,
                              height: 60.0,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.transparent, Colors.black],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(-1.0, 0.0),
                                  end: AlignmentDirectional(1.0, 0),
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
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: 240.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/Screenshot_2568-04-15_at_23.06.38.png',
                  ).image,
                ),
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0x58000000)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0,
                            10.0,
                            0.0,
                            0.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0x7F000000),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: const Color(0x7F111111),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 1.0,
                                  sigmaY: 1.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    2.0,
                                    10.0,
                                    2.0,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.k_hydaiewz,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            10.0,
                            10.0,
                            0.0,
                          ),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
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
                                          padding: MediaQuery.viewInsetsOf(
                                            context,
                                          ),
                                          child: const AppbarsilverWidget(
                                            image:
                                                'https://longdan.co.uk/cdn/shop/files/1701009_800x.png?v=1728881576',
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Container(
                                  width: 180.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/images/Screenshot_2568-04-15_at_18.37.55.png',
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFFF0000),
                                                  Color(0xFFC10000),
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
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  10.0,
                                                ),
                                                bottomRight: Radius.circular(
                                                  0.0,
                                                ),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                              shape: BoxShape.rectangle,
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
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Colors.white,
                                                      size: 19.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                                                Color(0xCC000000),
                                                Color(0xED000000),
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
                                              bottomRight: Radius.circular(
                                                10.0,
                                              ),
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  )!.k_h7aigha6,
                                                                  maxLines: 18,
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
                                                                        17.0,
                                                                    letterSpacing:
                                                                        0.0,
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
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                        context,
                                                                      )!.k_20jz9941,
                                                                      maxLines:
                                                                          18,
                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                        font: GoogleFonts.openSans(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: Theme.of(
                                                                            context,
                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                        ),
                                                                        color: const Color(
                                                                          0xFFD1D1D1,
                                                                        ),
                                                                        fontSize:
                                                                            12.5,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                              )!.k_hka3eg74,
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
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
                                                            )!.k_7mzxbnk8,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/Screenshot_2568-04-15_at_18.38.09.png',
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 30.0,
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF00E335),
                                                    Color(0xFF00BA2C),
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
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    10.0,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    0.0,
                                                  ),
                                                  topLeft: Radius.circular(0.0),
                                                  topRight: Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                                shape: BoxShape.rectangle,
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
                                                            1.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 19.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                                  Color(0xCC000000),
                                                  Color(0xED000000),
                                                ],
                                                stops: [0.0, 0.8, 1.0],
                                                begin: AlignmentDirectional(
                                                  0.0,
                                                  -1.0,
                                                ),
                                                end: AlignmentDirectional(
                                                  0,
                                                  1.0,
                                                ),
                                              ),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  10.0,
                                                ),
                                                bottomRight: Radius.circular(
                                                  10.0,
                                                ),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
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
                                                                    )!.k_0zspz9jz,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                      ),
                                                                      color: Theme.of(context)
                                                                          .extension<
                                                                            CustomColors
                                                                          >()!
                                                                          .primaryText,
                                                                      fontSize:
                                                                          17.0,
                                                                      letterSpacing:
                                                                          0.0,
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
                                                                      Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_8gfoe3yr,
                                                                        maxLines:
                                                                            18,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.bodyMedium!.override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              color: const Color(
                                                                                0xFFD1D1D1,
                                                                              ),
                                                                              fontSize: 12.5,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.fontStyle,
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
                                                                )!.k_8r09trlg,
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
                                                                  color: const Color(
                                                                    0xFFE8E8E8,
                                                                  ),
                                                                  fontSize:
                                                                      14.5,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                              )!.k_x9gjvmx0,
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        0.0,
                                      ),
                                      child: Container(
                                        width: 120.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xCD000000),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(0.0, 2.0),
                                              spreadRadius: 10.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                            90.0,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_kbmfk8fb,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          fontSize: 25.0,
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
                                              ],
                                            ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    -1.0,
                                                    0.0,
                                                  ),
                                              child: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.minus,
                                                      color: Colors.white,
                                                      size: 15.0,
                                                    ),
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
                                              child: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.plus,
                                                      color: Colors.white,
                                                      size: 15.0,
                                                    ),
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/Screenshot_2568-04-15_at_18.38.02.png',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF0000),
                                                Color(0xFFC10000),
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                0.0,
                                                -1.0,
                                              ),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: const Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        1.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 19.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                              Color(0xCC000000),
                                              Color(0xED000000),
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
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_h5zmj9ni,
                                                                maxLines: 18,
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
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_t6ieq3ei,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
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
                                                            )!.k_y32xdul9,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                          )!.k_cz6xp9fo,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ].addToStart(const SizedBox(width: 10.0)).addToEnd(const SizedBox(width: 25.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation2']!),
            ),
          ),
          const Divider(height: 20.0, thickness: 2.0, color: Color(0xB2252525)),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: 240.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/Image_15-4-2568_BE_at_23.03.jpg',
                  ).image,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0x58000000)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0,
                            10.0,
                            0.0,
                            0.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0x7F000000),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: const Color(0x7F111111),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 1.0,
                                  sigmaY: 1.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    2.0,
                                    10.0,
                                    2.0,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.k_3ahooyxh,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            10.0,
                            10.0,
                            0.0,
                          ),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  color: const Color(0x341C1C1C),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/Screenshot_2568-04-15_at_20.01.24.png',
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 30.0,
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF00E335),
                                                    Color(0xFF00BA2C),
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
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    10.0,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    0.0,
                                                  ),
                                                  topLeft: Radius.circular(0.0),
                                                  topRight: Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                                shape: BoxShape.rectangle,
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
                                                            1.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 19.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                                  Color(0xCC000000),
                                                  Color(0xED000000),
                                                ],
                                                stops: [0.0, 0.8, 1.0],
                                                begin: AlignmentDirectional(
                                                  0.0,
                                                  -1.0,
                                                ),
                                                end: AlignmentDirectional(
                                                  0,
                                                  1.0,
                                                ),
                                              ),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  10.0,
                                                ),
                                                bottomRight: Radius.circular(
                                                  10.0,
                                                ),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
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
                                                                    )!.k_lrh68n8q,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                      ),
                                                                      color: Theme.of(context)
                                                                          .extension<
                                                                            CustomColors
                                                                          >()!
                                                                          .primaryText,
                                                                      fontSize:
                                                                          17.0,
                                                                      letterSpacing:
                                                                          0.0,
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
                                                                      Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_br3pzi55,
                                                                        maxLines:
                                                                            18,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.bodyMedium!.override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              color: const Color(
                                                                                0xFFD1D1D1,
                                                                              ),
                                                                              fontSize: 12.5,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.fontStyle,
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
                                                                )!.k_8bb0vlf1,
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
                                                                  color: const Color(
                                                                    0xFFE8E8E8,
                                                                  ),
                                                                  fontSize:
                                                                      14.5,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                              )!.k_he7h9ja5,
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        0.0,
                                      ),
                                      child: Container(
                                        width: 120.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xCD000000),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(0.0, 2.0),
                                              spreadRadius: 10.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                            90.0,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    -1.0,
                                                    0.0,
                                                  ),
                                              child: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.minus,
                                                      color: Colors.white,
                                                      size: 15.0,
                                                    ),
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
                                              child: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.plus,
                                                      color: Colors.white,
                                                      size: 15.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0x4C000000),
                                                borderRadius:
                                                    BorderRadius.circular(90.0),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: MundayCountController(
                                                decrementIconBuilder:
                                                    (enabled) => Icon(
                                                      Icons.remove_rounded,
                                                      color: enabled
                                                          ? Colors.white
                                                          : const Color(
                                                              0xCD000000,
                                                            ),
                                                      size: 24.0,
                                                    ),
                                                incrementIconBuilder:
                                                    (enabled) => Icon(
                                                      Icons.add_rounded,
                                                      color: enabled
                                                          ? Colors.white
                                                          : const Color(
                                                              0xCD000000,
                                                            ),
                                                      size: 24.0,
                                                    ),
                                                countBuilder: (count) => Text(
                                                  count.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .override(
                                                        font: GoogleFonts.roboto(
                                                          fontWeight:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleLarge!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleLarge!
                                                                .fontStyle,
                                                      ),
                                                ),
                                                count:
                                                    _model.countControllerValue ??=
                                                        2,
                                                updateCount: (count) =>
                                                    safeSetState(
                                                      () =>
                                                          _model.countControllerValue =
                                                              count,
                                                    ),
                                                stepSize: 1,
                                                contentPadding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      12.0,
                                                      0.0,
                                                      12.0,
                                                      0.0,
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
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                0.0,
                                10.0,
                                0.0,
                              ),
                              child: Container(
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/Screenshot_2568-04-15_at_20.01.29.png',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF0000),
                                                Color(0xFFC10000),
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                0.0,
                                                -1.0,
                                              ),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: const Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        1.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 19.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                              Color(0xCC000000),
                                              Color(0xED000000),
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
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_axhfriq1,
                                                                maxLines: 18,
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
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_ina1urn0,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
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
                                                            )!.k_v0aqh8ec,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                          )!.k_a43vuqtp,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/Screenshot_2568-04-15_at_20.01.18.png',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF0000),
                                                Color(0xFFC10000),
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                0.0,
                                                -1.0,
                                              ),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: const Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        1.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 19.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                              Color(0xCC000000),
                                              Color(0xED000000),
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
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_2cd1vune,
                                                                maxLines: 18,
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
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_r71bjun7,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
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
                                                            )!.k_xp6v8pyx,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                          )!.k_u07ufrnd,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ].addToStart(const SizedBox(width: 10.0)).addToEnd(const SizedBox(width: 25.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation3']!),
            ),
          ),
          const Divider(height: 20.0, thickness: 2.0, color: Color(0xB2252525)),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: 240.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/480550932_923908646619366_4284518964252663928_n.jpg',
                  ).image,
                ),
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0x4D000000)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0,
                            10.0,
                            0.0,
                            0.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0x7F000000),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: const Color(0x7F111111),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 2.0,
                                  sigmaY: 2.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    2.0,
                                    10.0,
                                    2.0,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.k_0b8362q5,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            10.0,
                            10.0,
                            0.0,
                          ),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      'https://i0.wp.com/deedrink.com/wp-content/uploads/2019/10/hitejinro-soju.png?fit=600%2C600&ssl=1',
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
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0x261C1C1C),
                                      Colors.transparent,
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.5, -1.0),
                                    end: AlignmentDirectional(-0.5, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 30.0,
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF00E335),
                                                    Color(0xFF00BA2C),
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
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    10.0,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    0.0,
                                                  ),
                                                  topLeft: Radius.circular(0.0),
                                                  topRight: Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                                shape: BoxShape.rectangle,
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
                                                            1.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 19.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(
                                            0.0,
                                            1.0,
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: 70.0,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  Color(0xCC000000),
                                                  Color(0xED000000),
                                                ],
                                                stops: [0.0, 0.8, 1.0],
                                                begin: AlignmentDirectional(
                                                  0.0,
                                                  -1.0,
                                                ),
                                                end: AlignmentDirectional(
                                                  0,
                                                  1.0,
                                                ),
                                              ),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  10.0,
                                                ),
                                                bottomRight: Radius.circular(
                                                  10.0,
                                                ),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
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
                                                                    )!.k_mjmzivy5,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                      ),
                                                                      color: Theme.of(context)
                                                                          .extension<
                                                                            CustomColors
                                                                          >()!
                                                                          .primaryText,
                                                                      fontSize:
                                                                          17.0,
                                                                      letterSpacing:
                                                                          0.0,
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
                                                                      Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_8bfn0gcf,
                                                                        maxLines:
                                                                            18,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.bodyMedium!.override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              color: const Color(
                                                                                0xFFD1D1D1,
                                                                              ),
                                                                              fontSize: 12.5,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.fontStyle,
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
                                                                )!.k_1av5niej,
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
                                                                  color: const Color(
                                                                    0xFFE8E8E8,
                                                                  ),
                                                                  fontSize:
                                                                      14.5,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                              )!.k_6bxywujx,
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        0.0,
                                      ),
                                      child: Container(
                                        width: 120.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xCD000000),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(0.0, 2.0),
                                              spreadRadius: 10.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                            90.0,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.k_vv5dih4q,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts.openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          fontSize: 25.0,
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
                                              ],
                                            ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    -1.0,
                                                    0.0,
                                                  ),
                                              child: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.minus,
                                                      color: Colors.white,
                                                      size: 15.0,
                                                    ),
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
                                              child: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.plus,
                                                      color: Colors.white,
                                                      size: 15.0,
                                                    ),
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
                              ),
                            ),
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
                                          padding: MediaQuery.viewInsetsOf(
                                            context,
                                          ),
                                          child: const AppbarsilverWidget(
                                            image:
                                                'https://longdan.co.uk/cdn/shop/files/1701009_800x.png?v=1728881576',
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Container(
                                  width: 180.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.network(
                                        'https://longdan.co.uk/cdn/shop/files/1701009_800x.png?v=1728881576',
                                      ).image,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 10.0,
                                        color: Color(0x7F000000),
                                        offset: Offset(4.0, 4.0),
                                        spreadRadius: 4.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFFF0000),
                                                  Color(0xFFC10000),
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
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  10.0,
                                                ),
                                                bottomRight: Radius.circular(
                                                  0.0,
                                                ),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                              shape: BoxShape.rectangle,
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
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Colors.white,
                                                      size: 19.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                                                Color(0xCC000000),
                                                Color(0xED000000),
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
                                              bottomRight: Radius.circular(
                                                10.0,
                                              ),
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  )!.k_a69x38g0,
                                                                  maxLines: 18,
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
                                                                        17.0,
                                                                    letterSpacing:
                                                                        0.0,
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
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                        context,
                                                                      )!.k_lrltctfx,
                                                                      maxLines:
                                                                          18,
                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                        font: GoogleFonts.openSans(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: Theme.of(
                                                                            context,
                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                        ),
                                                                        color: const Color(
                                                                          0xFFD1D1D1,
                                                                        ),
                                                                        fontSize:
                                                                            12.5,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                              )!.k_1pj155l0,
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
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
                                                            )!.k_3o58br8y,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ].addToStart(const SizedBox(width: 10.0)).addToEnd(const SizedBox(width: 25.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation4']!),
            ),
          ),
          const Divider(height: 20.0, thickness: 2.0, color: Color(0xB2252525)),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: 240.0,
              decoration: const BoxDecoration(),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0x4D000000)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0,
                            10.0,
                            0.0,
                            0.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0x7F000000),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: const Color(0x4D1C1C1C),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 2.0,
                                  sigmaY: 2.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    2.0,
                                    10.0,
                                    2.0,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.k_6p4hnzd2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            10.0,
                            10.0,
                            0.0,
                          ),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/20.png',
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
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0x4D1C1C1C),
                                      Colors.transparent,
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.5, -1.0),
                                    end: AlignmentDirectional(-0.5, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF0000),
                                                Color(0xFFC10000),
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                0.0,
                                                -1.0,
                                              ),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: const Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        1.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 19.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        1.0,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 70.0,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Color(0xCC000000),
                                              Color(0xED000000),
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
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_wrs8y16r,
                                                                maxLines: 18,
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
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_lu0f1jur,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
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
                                                            )!.k_yy47n67q,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                          )!.k_f6b4yj4k,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                          padding: MediaQuery.viewInsetsOf(
                                            context,
                                          ),
                                          child: const AppbarmenuCopyWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Container(
                                  width: 180.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/images/16.png',
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
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0x1A1C1C1C),
                                        Colors.transparent,
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(0.5, -1.0),
                                      end: AlignmentDirectional(-0.5, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFFF0000),
                                                  Color(0xFFC10000),
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
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  10.0,
                                                ),
                                                bottomRight: Radius.circular(
                                                  0.0,
                                                ),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                              shape: BoxShape.rectangle,
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
                                                          1.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Colors.white,
                                                      size: 19.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                                                Color(0xCC000000),
                                                Color(0xED000000),
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
                                              bottomRight: Radius.circular(
                                                10.0,
                                              ),
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  )!.k_s5qrh9ui,
                                                                  maxLines: 18,
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
                                                                        17.0,
                                                                    letterSpacing:
                                                                        0.0,
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
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                        context,
                                                                      )!.k_esyddpqt,
                                                                      maxLines:
                                                                          18,
                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                        font: GoogleFonts.openSans(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: Theme.of(
                                                                            context,
                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                        ),
                                                                        color: const Color(
                                                                          0xFFD1D1D1,
                                                                        ),
                                                                        fontSize:
                                                                            12.5,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                              )!.k_z9tti8vi,
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
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
                                                            )!.k_flhphdak,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/17.png',
                                    ).image,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Color(0x7F000000),
                                      offset: Offset(4.0, 4.0),
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0x1A1C1C1C),
                                      Colors.transparent,
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.5, -1.0),
                                    end: AlignmentDirectional(-0.5, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF0000),
                                                Color(0xFFC10000),
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                0.0,
                                                -1.0,
                                              ),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: const Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        1.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 19.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                              Color(0xCC000000),
                                              Color(0xED000000),
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
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_lugtyj44,
                                                                maxLines: 18,
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
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_bmp2ct9r,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
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
                                                            )!.k_whutjxis,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                          )!.k_9lui9235,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/19.png',
                                    ).image,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Color(0x7F000000),
                                      offset: Offset(4.0, 4.0),
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0x1A1C1C1C),
                                      Colors.transparent,
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.5, -1.0),
                                    end: AlignmentDirectional(-0.5, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF0000),
                                                Color(0xFFC10000),
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                0.0,
                                                -1.0,
                                              ),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: const Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        1.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 19.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                              Color(0xCC000000),
                                              Color(0xED000000),
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
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_50kpigt7,
                                                                maxLines: 18,
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
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_9x2oese4,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
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
                                                            )!.k_7ym9zp16,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                          )!.k_vn7gl7fc,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                width: 180.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/18.png',
                                    ).image,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Color(0x7F000000),
                                      offset: Offset(4.0, 4.0),
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0x1A1C1C1C),
                                      Colors.transparent,
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.5, -1.0),
                                    end: AlignmentDirectional(-0.5, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF0000),
                                                Color(0xFFC10000),
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                0.0,
                                                -1.0,
                                              ),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: const Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        1.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 19.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                              Color(0xCC000000),
                                              Color(0xED000000),
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
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_akpgxm0s,
                                                                maxLines: 18,
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
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_9hodobhf,
                                                                    maxLines:
                                                                        18,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
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
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
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
                                                            )!.k_7k7z8fu7,
                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                          )!.k_scwzxz88,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
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
                                                                    Theme.of(
                                                                          context,
                                                                        )
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ].addToStart(const SizedBox(width: 10.0)).addToEnd(const SizedBox(width: 25.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation5']!),
            ),
          ),
          const Divider(height: 20.0, thickness: 2.0, color: Color(0xB2252525)),
        ],
      ),
    );
  }
}
