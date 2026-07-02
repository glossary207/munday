import 'package:provider/provider.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart' as custom_widgets;
import '/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'booking_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'booking_model.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({
    super.key,
    required this.id,
    required this.location,
    required this.date,
    required this.currentuid,
    String? floorId,
  }) : this.floorId = floorId ?? 'F1';

  final SupabaseDocRef? id;
  final LatLng? location;

  /// วันที่จอง
  final DateTime? date;

  final String? currentuid;
  final String floorId;

  static String routeName = 'Booking';
  static String routePath = 'booking';

  @override
  ConsumerState<BookingPage> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends ConsumerState<BookingPage> {
  late BookingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = BookingModel()..internalInit(context);

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.appState.SeatSelect = [];
      context.appState.Totlepricebooking = 0;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return StreamBuilder<VenuesRecord>(
      stream: VenuesRecord.getDocument(widget.id!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.transparent,
                  ),
                ),
              ),
            ),
          );
        }

        final bookingVenuesRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 35.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // context.pushNamed(Booking2cPage.routeName);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.k_zl6cyp0w,
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
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.0, 0.0, 0.0, 3.0),
                              child: Text(
                                valueOrDefault<String>(
                                  functions.month(context.appState.dateclick),
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
                                      fontSize: 16.0,
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 7.0, 15.0, 5.0),
                        child: Container(
                          width: double.infinity,
                          height: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            width: 45.0,
                            height: 75.0,
                            child: custom_widgets.Calendarslide(
                              width: 45.0,
                              height: 75.0,
                              colorPicker: Color(0xFFFF0000),
                              icon: Icon(
                                Icons.star_rate,
                                color: Color(0xFFFF0000),
                                size: 15.0,
                              ),
                              dateNow: getCurrentTimestamp,
                              dateclickwidget: context.appState.dateclick,
                              dateEvent: bookingVenuesRecord.dateEvents,
                              onselect: () async {
                                safeSetState(() {});
                              },
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
                          context.appState.update(() {});
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.5,
                          child: custom_widgets.LayoutPreviewWidget(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.5,
                            currentuid: currentUserUid,
                            venueRef: widget.id!,
                            date: widget.date!,
                            floorId: 'F1',
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF131313),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            25.0, 20.0, 25.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 1.0, 0.0),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .k_dy9gu5p1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                      color: Theme.of(context)
                                                          .extension<
                                                              CustomColors>()!
                                                          .primaryBtnText,
                                                      fontSize: 18.0,
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/MEE2.png',
                                                      width: 20.0,
                                                      height: 20.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          2.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      functions.addname(
                                                          AppState()
                                                              .SeatSelect
                                                              .toList()),
                                                      'เลือกโต๊ะของคุณ',
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: Theme.of(
                                                                    context)
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
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 0.0, 15.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                  color: Color(0xFF2A2A2A),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 15.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (false)
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    15.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 102.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          bookingVenuesRecord
                                                                              .bg,
                                                                        ).image,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Opacity(
                                                                opacity: 0.5,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              Image.network(
                                                                            '',
                                                                          ).image,
                                                                        ),
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            Color(0xFFFF0000),
                                                                            Colors.transparent
                                                                          ],
                                                                          stops: [
                                                                            0.0,
                                                                            1.0
                                                                          ],
                                                                          begin: AlignmentDirectional(
                                                                              -1.0,
                                                                              -0.64),
                                                                          end: AlignmentDirectional(
                                                                              1.0,
                                                                              0.64),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          '',
                                                                        ).image,
                                                                      ),
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Colors
                                                                              .transparent,
                                                                          Color(
                                                                              0xCB000000)
                                                                        ],
                                                                        stops: [
                                                                          0.0,
                                                                          1.0
                                                                        ],
                                                                        begin: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                        end: AlignmentDirectional(
                                                                            0,
                                                                            1.0),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              80.0,
                                                                          height:
                                                                              100.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFFD8181B),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(15.0),
                                                                              bottomRight: Radius.circular(0.0),
                                                                              topLeft: Radius.circular(15.0),
                                                                              topRight: Radius.circular(0.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                3.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
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
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
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
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                65.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 30.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(90.0),
                                                                                  bottomRight: Radius.circular(90.0),
                                                                                  topLeft: Radius.circular(0.0),
                                                                                  topRight: Radius.circular(0.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              65.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                30.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(90.0),
                                                                                topRight: Radius.circular(90.0),
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
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        105.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      bookingVenuesRecord
                                                                          .nameVenuse,
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
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.5,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              2.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_4des514z,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.22,
                                                                              -0.49),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFFD8181B),
                                                                                borderRadius: BorderRadius.circular(90.0),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                    child: Icon(
                                                                                      Icons.star_rounded,
                                                                                      color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.k_b4pc5eeq,
                                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                            ),
                                                                                            color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 1.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
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
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              0.0),
                                                                          child:
                                                                              Image.network(
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                            width:
                                                                                12.0,
                                                                            height:
                                                                                12.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_xf0pjhr5,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_39iwpxhc,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_qsxwdzjs,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_75j6wza8,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.people_sharp,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFD8181B),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              45.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_incqu7ni,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: 54.0,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .asset(
                                                                        'assets/images/_(27).png',
                                                                      ).image,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.06,
                                                                        -1.25),
                                                                child:
                                                                    Container(
                                                                  width: 23.0,
                                                                  height: 23.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFF2D38),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            4.0,
                                                                        color: Color(
                                                                            0x33000000),
                                                                        offset:
                                                                            Offset(
                                                                          0.0,
                                                                          2.0,
                                                                        ),
                                                                        spreadRadius:
                                                                            1.0,
                                                                      )
                                                                    ],
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
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
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    15.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 102.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          bookingVenuesRecord
                                                                              .bg,
                                                                        ).image,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Opacity(
                                                                opacity: 0.5,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            50.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              Image.network(
                                                                            '',
                                                                          ).image,
                                                                        ),
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            Color(0xFFFA9207),
                                                                            Colors.transparent
                                                                          ],
                                                                          stops: [
                                                                            0.0,
                                                                            1.0
                                                                          ],
                                                                          begin: AlignmentDirectional(
                                                                              -1.0,
                                                                              -0.64),
                                                                          end: AlignmentDirectional(
                                                                              1.0,
                                                                              0.64),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          '',
                                                                        ).image,
                                                                      ),
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Colors
                                                                              .transparent,
                                                                          Color(
                                                                              0xB7000000)
                                                                        ],
                                                                        stops: [
                                                                          0.0,
                                                                          1.0
                                                                        ],
                                                                        begin: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                        end: AlignmentDirectional(
                                                                            0,
                                                                            1.0),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            80.0,
                                                                        height:
                                                                            100.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFFFA9207),
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(15.0),
                                                                            bottomRight:
                                                                                Radius.circular(0.0),
                                                                            topLeft:
                                                                                Radius.circular(15.0),
                                                                            topRight:
                                                                                Radius.circular(0.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                3.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
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
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
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
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                65.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 30.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(90.0),
                                                                                  bottomRight: Radius.circular(90.0),
                                                                                  topLeft: Radius.circular(0.0),
                                                                                  topRight: Radius.circular(0.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              65.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                30.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(90.0),
                                                                                topRight: Radius.circular(90.0),
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
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFFA9207),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              45.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_6z1g905j,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: 54.0,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .asset(
                                                                        'assets/images/_(27).png',
                                                                      ).image,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        105.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      bookingVenuesRecord
                                                                          .nameVenuse,
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
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.5,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              2.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_7pxafyej,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.22,
                                                                              -0.49),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFFFA9207),
                                                                                borderRadius: BorderRadius.circular(90.0),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                    child: Icon(
                                                                                      Icons.star_rounded,
                                                                                      color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.k_triic0tj,
                                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                            ),
                                                                                            color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 1.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
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
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              0.0),
                                                                          child:
                                                                              Image.network(
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                            width:
                                                                                12.0,
                                                                            height:
                                                                                12.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_f6rcpgao,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_6o9r564w,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_onlyzhuu,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_46ld0x0r,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.people_rounded,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.06,
                                                                        -1.25),
                                                                child:
                                                                    Container(
                                                                  width: 23.0,
                                                                  height: 23.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFF2D38),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            4.0,
                                                                        color: Color(
                                                                            0x33000000),
                                                                        offset:
                                                                            Offset(
                                                                          0.0,
                                                                          2.0,
                                                                        ),
                                                                        spreadRadius:
                                                                            1.0,
                                                                      )
                                                                    ],
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
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
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    15.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 102.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          bookingVenuesRecord
                                                                              .bg,
                                                                        ).image,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Opacity(
                                                                opacity: 0.5,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            50.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              Image.network(
                                                                            '',
                                                                          ).image,
                                                                        ),
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            Color(0xFFE42F7D),
                                                                            Colors.transparent
                                                                          ],
                                                                          stops: [
                                                                            0.0,
                                                                            1.0
                                                                          ],
                                                                          begin: AlignmentDirectional(
                                                                              -1.0,
                                                                              -0.64),
                                                                          end: AlignmentDirectional(
                                                                              1.0,
                                                                              0.64),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          1.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          '',
                                                                        ).image,
                                                                      ),
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Colors
                                                                              .transparent,
                                                                          Color(
                                                                              0xB7000000)
                                                                        ],
                                                                        stops: [
                                                                          0.0,
                                                                          1.0
                                                                        ],
                                                                        begin: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                        end: AlignmentDirectional(
                                                                            0,
                                                                            1.0),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              80.0,
                                                                          height:
                                                                              100.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFFE42F7D),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(15.0),
                                                                              bottomRight: Radius.circular(0.0),
                                                                              topLeft: Radius.circular(15.0),
                                                                              topRight: Radius.circular(0.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                3.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
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
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
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
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                65.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 30.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(90.0),
                                                                                  bottomRight: Radius.circular(90.0),
                                                                                  topLeft: Radius.circular(0.0),
                                                                                  topRight: Radius.circular(0.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              65.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                30.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(90.0),
                                                                                topRight: Radius.circular(90.0),
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
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFE42F7D),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              45.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_b5zdps8w,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: 54.0,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .asset(
                                                                        'assets/images/_(27).png',
                                                                      ).image,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        105.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      bookingVenuesRecord
                                                                          .nameVenuse,
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
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.5,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              2.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_ckldbpe2,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.22,
                                                                              -0.49),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFFE42F7D),
                                                                                borderRadius: BorderRadius.circular(90.0),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                    child: Icon(
                                                                                      Icons.star_rounded,
                                                                                      color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.k_vdk5ujss,
                                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                            ),
                                                                                            color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 1.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
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
                                                                    AlignmentDirectional(
                                                                        1.06,
                                                                        -1.25),
                                                                child:
                                                                    Container(
                                                                  width: 23.0,
                                                                  height: 23.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFF2D38),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            4.0,
                                                                        color: Color(
                                                                            0x33000000),
                                                                        offset:
                                                                            Offset(
                                                                          0.0,
                                                                          2.0,
                                                                        ),
                                                                        spreadRadius:
                                                                            1.0,
                                                                      )
                                                                    ],
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
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
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    15.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 102.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .network(
                                                                        bookingVenuesRecord
                                                                            .bg,
                                                                      ).image,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                ),
                                                              ),
                                                              Opacity(
                                                                opacity: 0.5,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          50.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          '',
                                                                        ).image,
                                                                      ),
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Color(
                                                                              0xFF0171BC),
                                                                          Colors
                                                                              .transparent
                                                                        ],
                                                                        stops: [
                                                                          0.0,
                                                                          1.0
                                                                        ],
                                                                        begin: AlignmentDirectional(
                                                                            -1.0,
                                                                            -0.64),
                                                                        end: AlignmentDirectional(
                                                                            1.0,
                                                                            0.64),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .network(
                                                                        '',
                                                                      ).image,
                                                                    ),
                                                                    gradient:
                                                                        LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .transparent,
                                                                        Color(
                                                                            0xB7000000)
                                                                      ],
                                                                      stops: [
                                                                        0.0,
                                                                        1.0
                                                                      ],
                                                                      begin: AlignmentDirectional(
                                                                          0.0,
                                                                          -1.0),
                                                                      end: AlignmentDirectional(
                                                                          0,
                                                                          1.0),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              80.0,
                                                                          height:
                                                                              100.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFF0171BC),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(15.0),
                                                                              bottomRight: Radius.circular(0.0),
                                                                              topLeft: Radius.circular(15.0),
                                                                              topRight: Radius.circular(0.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                3.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
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
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
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
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                65.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 30.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(90.0),
                                                                                  bottomRight: Radius.circular(90.0),
                                                                                  topLeft: Radius.circular(0.0),
                                                                                  topRight: Radius.circular(0.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              65.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                30.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(90.0),
                                                                                topRight: Radius.circular(90.0),
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
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF0171BC),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              45.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_stf94dvd,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: 54.0,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .asset(
                                                                        'assets/images/_(27).png',
                                                                      ).image,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        105.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      bookingVenuesRecord
                                                                          .nameVenuse,
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
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.5,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              2.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_dol4vivl,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.22,
                                                                              -0.49),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF0171BC),
                                                                                borderRadius: BorderRadius.circular(90.0),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                    child: Icon(
                                                                                      Icons.star_rounded,
                                                                                      color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.k_f5zj3cbu,
                                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                            ),
                                                                                            color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 1.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
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
                                                                    AlignmentDirectional(
                                                                        1.06,
                                                                        -1.25),
                                                                child:
                                                                    Container(
                                                                  width: 23.0,
                                                                  height: 23.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFF2D38),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            4.0,
                                                                        color: Color(
                                                                            0x33000000),
                                                                        offset:
                                                                            Offset(
                                                                          0.0,
                                                                          2.0,
                                                                        ),
                                                                        spreadRadius:
                                                                            1.0,
                                                                      )
                                                                    ],
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
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
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    15.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 102.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .network(
                                                                        bookingVenuesRecord
                                                                            .bg,
                                                                      ).image,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                ),
                                                              ),
                                                              Opacity(
                                                                opacity: 0.5,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          50.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          '',
                                                                        ).image,
                                                                      ),
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Color(
                                                                              0xFF333333),
                                                                          Colors
                                                                              .transparent
                                                                        ],
                                                                        stops: [
                                                                          0.0,
                                                                          1.0
                                                                        ],
                                                                        begin: AlignmentDirectional(
                                                                            -1.0,
                                                                            -0.64),
                                                                        end: AlignmentDirectional(
                                                                            1.0,
                                                                            0.64),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .network(
                                                                        '',
                                                                      ).image,
                                                                    ),
                                                                    gradient:
                                                                        LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .transparent,
                                                                        Color(
                                                                            0xB7000000)
                                                                      ],
                                                                      stops: [
                                                                        0.0,
                                                                        1.0
                                                                      ],
                                                                      begin: AlignmentDirectional(
                                                                          0.0,
                                                                          -1.0),
                                                                      end: AlignmentDirectional(
                                                                          0,
                                                                          1.0),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              80.0,
                                                                          height:
                                                                              100.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFF333333),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(15.0),
                                                                              bottomRight: Radius.circular(0.0),
                                                                              topLeft: Radius.circular(15.0),
                                                                              topRight: Radius.circular(0.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                3.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
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
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
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
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                65.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 30.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(90.0),
                                                                                  bottomRight: Radius.circular(90.0),
                                                                                  topLeft: Radius.circular(0.0),
                                                                                  topRight: Radius.circular(0.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              65.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                30.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(90.0),
                                                                                topRight: Radius.circular(90.0),
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
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF333333),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              45.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_uyk8szzk,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: 54.0,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .asset(
                                                                        'assets/images/_(27).png',
                                                                      ).image,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        105.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      bookingVenuesRecord
                                                                          .nameVenuse,
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
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.5,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              2.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_yavq9jpy,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.22,
                                                                              -0.49),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF333333),
                                                                                borderRadius: BorderRadius.circular(90.0),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                    child: Icon(
                                                                                      Icons.star_rounded,
                                                                                      color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.k_9t0uxohd,
                                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                            ),
                                                                                            color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 1.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
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
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              0.0),
                                                                          child:
                                                                              Image.network(
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                            width:
                                                                                12.0,
                                                                            height:
                                                                                12.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_th3wrju8,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_aw8qx9xu,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_oyyp5zzz,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_dyqvszfp,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.people_rounded,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.06,
                                                                        -1.25),
                                                                child:
                                                                    Container(
                                                                  width: 23.0,
                                                                  height: 23.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFF2D38),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            4.0,
                                                                        color: Color(
                                                                            0x33000000),
                                                                        offset:
                                                                            Offset(
                                                                          0.0,
                                                                          2.0,
                                                                        ),
                                                                        spreadRadius:
                                                                            1.0,
                                                                      )
                                                                    ],
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
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
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    15.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 102.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          bookingVenuesRecord
                                                                              .bg,
                                                                        ).image,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Opacity(
                                                                opacity: 0.5,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            50.0,
                                                                            1.0,
                                                                            0.0,
                                                                            1.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              Image.network(
                                                                            '',
                                                                          ).image,
                                                                        ),
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            Color(0xFF58BB2F),
                                                                            Colors.transparent
                                                                          ],
                                                                          stops: [
                                                                            0.0,
                                                                            1.0
                                                                          ],
                                                                          begin: AlignmentDirectional(
                                                                              -1.0,
                                                                              -0.64),
                                                                          end: AlignmentDirectional(
                                                                              1.0,
                                                                              0.64),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          1.0,
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        100.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          '',
                                                                        ).image,
                                                                      ),
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Colors
                                                                              .transparent,
                                                                          Color(
                                                                              0xB7000000)
                                                                        ],
                                                                        stops: [
                                                                          0.0,
                                                                          1.0
                                                                        ],
                                                                        begin: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                        end: AlignmentDirectional(
                                                                            0,
                                                                            1.0),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            80.0,
                                                                        height:
                                                                            100.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFF58BB2F),
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(15.0),
                                                                            bottomRight:
                                                                                Radius.circular(0.0),
                                                                            topLeft:
                                                                                Radius.circular(15.0),
                                                                            topRight:
                                                                                Radius.circular(0.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                3.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                3.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 3.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
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
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
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
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                65.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 30.0,
                                                                              height: 15.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF131313),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(90.0),
                                                                                  bottomRight: Radius.circular(90.0),
                                                                                  topLeft: Radius.circular(0.0),
                                                                                  topRight: Radius.circular(0.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              65.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                30.0,
                                                                            height:
                                                                                15.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF131313),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(90.0),
                                                                                topRight: Radius.circular(90.0),
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
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF58BB2F),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              45.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_zf2xwvnz,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: 54.0,
                                                                  height: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: Image
                                                                          .asset(
                                                                        'assets/images/_(27).png',
                                                                      ).image,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        105.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      bookingVenuesRecord
                                                                          .nameVenuse,
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
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.5,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              2.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_64igi5he,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.22,
                                                                              -0.49),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xFF58BB2F),
                                                                                borderRadius: BorderRadius.circular(90.0),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                                    child: Icon(
                                                                                      Icons.star_rounded,
                                                                                      color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.k_9msn8ey3,
                                                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                            ),
                                                                                            color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 1.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
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
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              0.0),
                                                                          child:
                                                                              Image.network(
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                            width:
                                                                                12.0,
                                                                            height:
                                                                                12.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_nd22qcfs,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_b2c81k0m,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              3.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_8ztwtbdl,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_ygi4rynl,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.people_rounded,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.06,
                                                                        -1.25),
                                                                child:
                                                                    Container(
                                                                  width: 23.0,
                                                                  height: 23.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFF2D38),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            4.0,
                                                                        color: Color(
                                                                            0x33000000),
                                                                        offset:
                                                                            Offset(
                                                                          0.0,
                                                                          2.0,
                                                                        ),
                                                                        spreadRadius:
                                                                            1.0,
                                                                      )
                                                                    ],
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 18.0,
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
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            25.0, 10.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 1.0, 0.0),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .k_3pliwr7o,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                      color: Theme.of(context)
                                                          .extension<
                                                              CustomColors>()!
                                                          .primaryBtnText,
                                                      fontSize: 18.0,
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 15.0, 150.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    border: Border.all(
                                                      color: Color(0xFF2A2A2A),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          2.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_quog03jp,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              fontSize: 17.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          0.22,
                                                                          -0.49),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFFD8181B),
                                                                          borderRadius:
                                                                              BorderRadius.circular(90.0),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 1.0),
                                                                              child: Icon(
                                                                                Icons.star_rounded,
                                                                                color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                size: 15.0,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(2.5, 1.0, 7.0, 1.5),
                                                                              child: Text(
                                                                                AppLocalizations.of(context)!.k_13x9uqs0,
                                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                      font: GoogleFonts.openSans(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                      ),
                                                                                      color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                      fontSize: 11.0,
                                                                                      letterSpacing: 1.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_zzal3cp1,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              fontSize: 17.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          3.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_r2j8yc5b,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          1.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .k_vs7xdzmi,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              fontSize: 17.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .people_rounded,
                                                                        color: Theme.of(context)
                                                                            .extension<CustomColors>()!
                                                                            .primaryText,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            40.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .k_b346r7d7,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontWeight,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFFF5F5F5),
                                                                        letterSpacing:
                                                                            0.0,
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
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            40.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .k_t2g5fbkh,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontWeight,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFFF5F5F5),
                                                                        letterSpacing:
                                                                            0.0,
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
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            40.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .k_pkz408a3,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontWeight,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFFF5F5F5),
                                                                        letterSpacing:
                                                                            0.0,
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
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          2.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_7nteuc8q,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.22,
                                                                          -0.49),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFFA9207),
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
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.star_rounded,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              2.5,
                                                                              1.0,
                                                                              7.0,
                                                                              1.5),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_0ndc7z7a,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                  fontSize: 11.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_zjqoai57,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          3.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_6elfinwi,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_zlj2bvxv,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .people_rounded,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .extension<
                                                                            CustomColors>()!
                                                                        .primaryText,
                                                                    size: 17.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          2.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_cc82j5o4,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.22,
                                                                          -0.49),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFE42F7D),
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
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.star_rounded,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              2.5,
                                                                              1.0,
                                                                              7.0,
                                                                              1.5),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_4g50bw3t,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                  fontSize: 11.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_rvzbnzim,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          3.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_sa7il9cu,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_t2nhsu2z,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .people_rounded,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .extension<
                                                                            CustomColors>()!
                                                                        .primaryText,
                                                                    size: 17.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          2.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_9z9bvdw7,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.22,
                                                                          -0.49),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF0171BC),
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
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.star_rounded,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              2.5,
                                                                              1.0,
                                                                              7.0,
                                                                              1.5),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_u5splgyl,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                  fontSize: 11.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_1btagzga,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          3.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_061te4or,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_i2yqt0vg,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .people_rounded,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .extension<
                                                                            CustomColors>()!
                                                                        .primaryText,
                                                                    size: 17.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          2.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_h6uupi1b,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.22,
                                                                          -0.49),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF666666),
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
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.star_rounded,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              2.5,
                                                                              1.0,
                                                                              7.0,
                                                                              1.5),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_8t91guy8,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                  fontSize: 11.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_27xmauca,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          3.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_tlm9qy3p,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_vc6bzueu,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .people_rounded,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .extension<
                                                                            CustomColors>()!
                                                                        .primaryText,
                                                                    size: 17.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          2.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_3j2l4cnb,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.22,
                                                                          -0.49),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF58BB2F),
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
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.star_rounded,
                                                                            color:
                                                                                Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              2.5,
                                                                              1.0,
                                                                              7.0,
                                                                              1.5),
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.k_v0p6ewim,
                                                                            style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  color: Theme.of(context).extension<CustomColors>()!.primaryText,
                                                                                  fontSize: 11.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          1.0,
                                                                          10.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_ebhvfrkk,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          3.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_c6l6yvfu,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          2.0,
                                                                          1.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .k_77ws4uwr,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                Theme.of(context).textTheme.bodyMedium!.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .people_rounded,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .extension<
                                                                            CustomColors>()!
                                                                        .primaryText,
                                                                    size: 17.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    15.0,
                                                                    10.0,
                                                                    10.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .k_8uod5ty9,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
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
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 7.0, 15.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            width: 45.0,
                            height: 75.0,
                            child: custom_widgets.Calendarslide(
                              width: 45.0,
                              height: 75.0,
                              colorPicker: Color(0xFFFF0000),
                              icon: Icon(
                                Icons.star_rate,
                                color: Color(0xFFFF0000),
                                size: 15.0,
                              ),
                              dateNow: getCurrentTimestamp,
                              dateclickwidget: context.appState.dateclick,
                              dateEvent: bookingVenuesRecord.dateEvents,
                              onselect: () async {
                                safeSetState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.1, 1.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.2,
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
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.11,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Color(0xE5000000)],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 15.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pop();
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF121212),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Color(0xFF343434),
                                    width: 2.0,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: Theme.of(context)
                                        .extension<CustomColors>()!
                                        .primaryText,
                                    size: 28.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (false)
                            Expanded(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.7,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFF0004),
                                      Color(0xFFA60000)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.k_nrbqwlw0,
                                      maxLines: 1,
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
                                            fontSize: 20.0,
                                            letterSpacing: 1.0,
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
                            ),
                          if (true)
                            Expanded(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                      PayreservenormdayPage.routeName);
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFF0004),
                                        Color(0xFFA60000)
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(0.0, -1.0),
                                      end: AlignmentDirectional(0, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .k_i56am3ch,
                                        maxLines: 1,
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
                                              fontSize: 20.0,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .fontStyle,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            7.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .k_a5zorp3n,
                                          maxLines: 1,
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
                                                fontSize: 20.0,
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            2.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          AppState()
                                              .Totlepricebooking
                                              .toString(),
                                          maxLines: 1,
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
                                                fontSize: 20.0,
                                                letterSpacing: 1.0,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
