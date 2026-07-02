part of '../main_page.dart';

class MainHeaderWidget extends StatelessWidget {
  final MainModel _model;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final dynamic currentUserLocationValue;

  const MainHeaderWidget({
    super.key,
    required MainModel model,
    required this.scaffoldKey,
    required this.currentUserLocationValue,
  }) : _model = model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.34,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      final isLoggedIn =
                          currentUser != null; // Handle null user
                      if (!isLoggedIn) {
                        context.pushNamed(PhoneLoginPage.routeName);
                        return;
                      }
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
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          AuthUserStreamWidget(
                            builder: (context) => Container(
                              width: 50.0,
                              height: 50.0,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                _safeMainImageUrl(
                                  currentUserPhoto,
                                  fallback: _kMainFallbackProfileUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, 1.0),
                            child: Container(
                              width: 18.0,
                              height: 18.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF0000),
                                borderRadius: BorderRadius.circular(45.0),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.settings,
                                        color: Theme.of(context)
                                            .extension<CustomColors>()!
                                            .primaryText,
                                        size: 13.0,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        18.0, 0.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        // context.pushNamed(
                        //     MapExPage.routeName);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 13.0,
                                  height: 20.0,
                                  decoration: const BoxDecoration(),
                                  child: Align(
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 3.0),
                                            child: Container(
                                              width: 6.0,
                                              height: 6.0,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .extension<CustomColors>()!
                                                    .primaryText,
                                                borderRadius:
                                                    BorderRadius.circular(45.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Icon(
                                            Icons.location_pin,
                                            color: Color(0xFFFF0000),
                                            size: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: SizedBox(
                                    width: 100.0,
                                    height: 15.0,
                                    child: custom_widgets.LocationName(
                                      width: 100.0,
                                      height: 15.0,
                                      locationNow: context.appState.locationsearch,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Home',
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
                                    fontSize: 17.0,
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
                  ),
                ),
                // ── Ticket ──
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 10.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      if (currentUser == null) {
                        context.pushNamed(PhoneLoginPage.routeName);
                        return;
                      }
                      context.pushNamed(TicketPage.routeName);
                    },
                    child: AuthUserStreamWidget(
                      builder: (context) => _AppBarIconButton(
                        assetPath: 'assets/images/icon_ticket.png',
                        iconSize: 27.0,
                        showBadge:
                            (currentUserDocument?.tickets ?? []).isNotEmpty,
                      ),
                    ),
                  ),
                ),
                // ── Chat ──
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 10.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      if (currentUser == null) {
                        context.pushNamed(PhoneLoginPage.routeName);
                        return;
                      }
                      context.pushNamed(MainChatPage.routeName);
                    },
                    child: AuthUserStreamWidget(
                      builder: (context) => _AppBarIconButton(
                        assetPath: 'assets/images/icon_message.png',
                        showBadge:
                            (currentUserDocument?.usermassage ?? []).isNotEmpty,
                      ),
                    ),
                  ),
                ),
                // ── Notifications ──
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 16.0, 0.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => NotificationBadgeButton(
                      onTap: () =>
                          context.pushNamed('NotificationPage'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 220.0,
              child: Stack(
                children: [
                  PageView(
                    controller: _model.pageViewController ??=
                        PageController(initialPage: 0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 0.0, 0.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200.0,
                          child: Stack(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 14.0, 20.0, 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/455040334_886884533466916_1650523449501590794_n.jpg',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: const Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Stack(
                                        children: [],
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
                            20.0, 0.0, 0.0, 0.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200.0,
                          child: Stack(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 14.0, 20.0, 20.0),
                                  child: Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(
                                          'https://indiaoutbound.info/wp-content/uploads/2023/04/Pattaya-to-host-%E2%80%98Rolling-Loud-hip-hop-music-festival-for-Songkran-Cover.jpg',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: const Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Stack(
                                        children: [],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://picsum.photos/seed/133/600',
                          width: 300.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: smooth_page_indicator.SmoothPageIndicator(
                      controller: _model.pageViewController ??=
                          PageController(initialPage: 0),
                      count: 3,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) async {
                        await _model.pageViewController!.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        context.appState.update(() {});
                      },
                      effect: const smooth_page_indicator.SlideEffect(
                        spacing: 8.0,
                        radius: 16.0,
                        dotWidth: 8.0,
                        dotHeight: 8.0,
                        dotColor: Color(0xFF9F9F9F),
                        activeDotColor: Color(0xFFFF0000),
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
