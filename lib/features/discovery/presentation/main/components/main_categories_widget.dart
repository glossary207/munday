part of '../main_page.dart';

class MainCategoriesWidget extends StatelessWidget {
  final MainModel _model;

  const MainCategoriesWidget({super.key, required MainModel model})
    : _model = model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          child: Row(
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
                child: Text(
                  'รูปแบบร้าน',
                  style: Theme.of(context).textTheme.bodyMedium!.override(
                    font: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontStyle: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.fontStyle,
                    ),
                    color: Theme.of(
                      context,
                    ).extension<CustomColors>()!.primaryText,
                    fontSize: 18.0,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w600,
                    fontStyle: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.fontStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  0.0,
                  30.0,
                  0.0,
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(VenuesPage.routeName);
                  },
                  child: Text(
                    'อื่นๆ',
                    style: Theme.of(context).textTheme.bodyMedium!.override(
                      font: GoogleFonts.openSans(
                        fontWeight: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.fontWeight,
                        fontStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.fontStyle,
                      ),
                      color: const Color(0xFF7D7D7D),
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
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 20.0, 8.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D0D),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    5.0,
                    0.0,
                    5.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.appState.menuActiveitem = 'Venues';
                          context.appState.StyleVenuse = [];
                          context.appState.update(() {});
                          context.appState.addToStyleVenuse('Pub');
                          context.appState.update(() {});

                          context.pushNamed(VenuesPage.routeName);
                        },
                        child: Container(
                          width: 60.0,
                          height: 80.0,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/dancing.png',
                                      width: 35.0,
                                      height: 22.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  7.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Text(
                                  'ผับ',
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
                                        fontSize: 11.0,
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
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.appState.menuActiveitem = 'Venues';
                          context.appState.StyleVenuse = [];
                          context.appState.update(() {});
                          context.appState.addToStyleVenuse('Bar');
                          context.appState.update(() {});

                          context.pushNamed(VenuesPage.routeName);
                        },
                        child: Container(
                          width: 60.0,
                          height: 80.0,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    3.0,
                                    5.0,
                                    7.0,
                                    5.0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.asset(
                                      'assets/images/mojito.png',
                                      width: 35.0,
                                      height: 22.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  7.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Text(
                                  'บาร์',
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
                                        fontSize: 11.0,
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
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.appState.menuActiveitem = 'Venues';
                          context.appState.StyleVenuse = [];
                          context.appState.update(() {});
                          context.appState.addToStyleVenuse('Chill');
                          context.appState.update(() {});

                          context.pushNamed(VenuesPage.routeName);
                        },
                        child: Container(
                          width: 60.0,
                          height: 80.0,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    5.0,
                                    8.0,
                                    5.0,
                                    2.0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.asset(
                                      'assets/images/beer_(7).png',
                                      width: 35.0,
                                      height: 22.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  7.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Text(
                                  'นั่งชิล',
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
                                        fontSize: 11.0,
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
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.appState.menuActiveitem = 'Venues';
                          context.appState.StyleVenuse = [];
                          context.appState.update(() {});
                          context.appState.addToStyleVenuse('Out Door');
                          context.appState.update(() {});

                          context.pushNamed(VenuesPage.routeName);
                        },
                        child: Container(
                          width: 60.0,
                          height: 80.0,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    2.0,
                                    6.0,
                                    2.0,
                                    0.0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/picnic-table_(1).png',
                                      width: 35.0,
                                      height: 22.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  7.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Text(
                                  'ลานเบียร์',
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
                                        fontSize: 11.0,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
