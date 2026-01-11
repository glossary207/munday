import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/supabase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/card33_user_grid_widget.dart';
import '/components/delallchat_widget.dart';
import '/components/delchat_widget.dart';
import '/components/item_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chats_model.dart';
export 'chats_model.dart';

class ChatsWidget extends StatefulWidget {
  const ChatsWidget({
    super.key,
    this.userProfile,
    required this.roomref,
    String? name,
    required this.online,
    required this.openchat,
  }) : this.name = name ?? 'ไม่ระบุ';

  final String? userProfile;
  final SupabaseDocRef? roomref;
  final String name;
  final bool? online;
  final bool? openchat;

  static String routeName = 'Chats';
  static String routePath = 'chats';

  @override
  State<ChatsWidget> createState() => _ChatsWidgetState();
}

class _ChatsWidgetState extends State<ChatsWidget> {
  late ChatsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.columnController?.animateTo(
        _model.columnController!.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
      _model.timecheckread = true;
      _model.lockchatt = false;
      safeSetState(() {});
      if (!FFAppState().relock) {
        FFAppState().namestorelink =
            valueOrDefault(currentUserDocument?.checkin, '');
        FFAppState().ActivePromotion = false;
        FFAppState().apiready = true;
        FFAppState().relock = true;
        safeSetState(() {});
      }

      safeSetState(() {});
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: ItemWidget(),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<f_f_story_view_live_zhm3f3_app_state.FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          body: SafeArea(
            top: true,
            child: StreamBuilder<RoomRecord>(
              stream: FFAppState().datachat(
                uniqueQueryKey: valueOrDefault<String>(
                  widget.roomref?.id,
                  'aaa',
                ),
                requestFn: () => RoomRecord.getDocument(widget.roomref!),
              )..listen((stackRoomRecord) async {
                  if (_model.stackPreviousSnapshot != null &&
                      !RoomRecordDocumentEquality().equals(
                          stackRoomRecord, _model.stackPreviousSnapshot)) {
                    await _model.columnController?.animateTo(
                      _model.columnController!.position.maxScrollExtent,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.ease,
                    );

                    safeSetState(() {});
                  }
                  _model.stackPreviousSnapshot = stackRoomRecord;
                }),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
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

                final stackRoomRecord = snapshot.data!;

                return Stack(
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 38.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Divider(
                                  height: 48.0,
                                  thickness: 2.5,
                                  color: Color(0xFF2C2C2C),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 16.0),
                                    child: SingleChildScrollView(
                                      controller: _model.columnController,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.0, -1.0),
                                            child: Builder(
                                              builder: (context) {
                                                final datachat = stackRoomRecord
                                                    .message
                                                    .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: datachat.length,
                                                  itemBuilder:
                                                      (context, datachatIndex) {
                                                    final datachatItem =
                                                        datachat[datachatIndex];
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if ((datachatItem
                                                                    .messagephoto !=
                                                                '') &&
                                                            (datachatItem
                                                                    .who?.id !=
                                                                currentUserReference
                                                                    ?.id) &&
                                                            !functions.checklist(
                                                                (currentUserDocument
                                                                            ?.blockuser
                                                                            .toList() ??
                                                                        [])
                                                                    .map((e) =>
                                                                        e.id)
                                                                    .toList(),
                                                                datachatItem
                                                                    .who?.id)!)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        24.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                AuthUserStreamWidget(
                                                              builder:
                                                                  (context) =>
                                                                      Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  InkWell(
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
                                                                        () async {},
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          36.0,
                                                                      height:
                                                                          36.0,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          datachatItem
                                                                              .userphoto,
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          300.0,
                                                                      height:
                                                                          180.0,
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        maxWidth:
                                                                            260.0,
                                                                        maxHeight:
                                                                            180.0,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xFF232323),
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(24.0),
                                                                          bottomRight:
                                                                              Radius.circular(24.0),
                                                                          topLeft:
                                                                              Radius.circular(3.0),
                                                                          topRight:
                                                                              Radius.circular(24.0),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              await Navigator.push(
                                                                                context,
                                                                                PageTransition(
                                                                                  type: PageTransitionType.fade,
                                                                                  child: FlutterFlowExpandedImageView(
                                                                                    image: Image.network(
                                                                                      datachatItem.messagephoto,
                                                                                      fit: BoxFit.contain,
                                                                                    ),
                                                                                    allowRotation: false,
                                                                                    tag: datachatItem.messagephoto,
                                                                                    useHeroAnimation: true,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Hero(
                                                                              tag: datachatItem.messagephoto,
                                                                              transitionOnUserGestures: true,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                child: Image.network(
                                                                                  datachatItem.messagephoto,
                                                                                  width: 300.0,
                                                                                  height: 200.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(1.0, 1.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: 80.0,
                                                                                height: 26.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xBF15161E),
                                                                                  borderRadius: BorderRadius.only(
                                                                                    bottomLeft: Radius.circular(15.0),
                                                                                    bottomRight: Radius.circular(15.0),
                                                                                    topLeft: Radius.circular(15.0),
                                                                                    topRight: Radius.circular(15.0),
                                                                                  ),
                                                                                ),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Text(
                                                                                    dateTimeFormat(
                                                                                      "Hm",
                                                                                      datachatItem.timeup!,
                                                                                      locale: FFLocalizations.of(context).languageCode,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          fontSize: 12.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        if ((datachatItem
                                                                    .messagephoto !=
                                                                '') &&
                                                            (datachatItem
                                                                    .who?.id ==
                                                                currentUserReference
                                                                    ?.id))
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        24.0,
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
                                                              onLongPress:
                                                                  () async {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
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
                                                                            DelchatWidget(
                                                                          chatID:
                                                                              datachatItem.idchat,
                                                                          room:
                                                                              widget.roomref!,
                                                                          who: datachatItem
                                                                              .who!,
                                                                          testmessage:
                                                                              datachatItem.messagetext,
                                                                          photomessage:
                                                                              datachatItem.messagephoto,
                                                                          time:
                                                                              datachatItem.timeup!,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              },
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        300.0,
                                                                    height:
                                                                        180.0,
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      maxWidth:
                                                                          260.0,
                                                                      maxHeight:
                                                                          180.0,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF232323),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(24.0),
                                                                        bottomRight:
                                                                            Radius.circular(24.0),
                                                                        topLeft:
                                                                            Radius.circular(24.0),
                                                                        topRight:
                                                                            Radius.circular(3.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            await Navigator.push(
                                                                              context,
                                                                              PageTransition(
                                                                                type: PageTransitionType.fade,
                                                                                child: FlutterFlowExpandedImageView(
                                                                                  image: Image.network(
                                                                                    datachatItem.messagephoto,
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                  allowRotation: false,
                                                                                  tag: datachatItem.messagephoto,
                                                                                  useHeroAnimation: true,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Hero(
                                                                            tag:
                                                                                datachatItem.messagephoto,
                                                                            transitionOnUserGestures:
                                                                                true,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.network(
                                                                                datachatItem.messagephoto,
                                                                                width: 300.0,
                                                                                height: 200.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: 80.0,
                                                                              height: 26.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xBF15161E),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(15.0),
                                                                                  bottomRight: Radius.circular(15.0),
                                                                                  topLeft: Radius.circular(15.0),
                                                                                  topRight: Radius.circular(15.0),
                                                                                ),
                                                                              ),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Text(
                                                                                  dateTimeFormat(
                                                                                    "Hm",
                                                                                    datachatItem.timeup!,
                                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                          ),
                                                        if ((datachatItem
                                                                    .messagetext !=
                                                                '') &&
                                                            (datachatItem
                                                                    .who?.id !=
                                                                currentUserReference
                                                                    ?.id) &&
                                                            !functions.checklist(
                                                                (currentUserDocument
                                                                            ?.blockuser
                                                                            .toList() ??
                                                                        [])
                                                                    .map((e) =>
                                                                        e.id)
                                                                    .toList(),
                                                                datachatItem
                                                                    .who?.id)!)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        24.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                AuthUserStreamWidget(
                                                              builder:
                                                                  (context) =>
                                                                      Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  InkWell(
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
                                                                      if (widget
                                                                          .openchat!) {}
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          36.0,
                                                                      height:
                                                                          36.0,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          datachatItem
                                                                              .userphoto,
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          300.0,
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        maxWidth:
                                                                            260.0,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xFF131313),
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(24.0),
                                                                          bottomRight:
                                                                              Radius.circular(24.0),
                                                                          topLeft:
                                                                              Radius.circular(3.0),
                                                                          topRight:
                                                                              Radius.circular(24.0),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            12.0,
                                                                            16.0,
                                                                            12.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: 160.0,
                                                                                  constraints: BoxConstraints(
                                                                                    maxWidth: 260.0,
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF131313),
                                                                                  ),
                                                                                  child: Text(
                                                                                    datachatItem.messagetext,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  dateTimeFormat(
                                                                                    "Hm",
                                                                                    datachatItem.timeup!,
                                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFFE0E0E0),
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                            ),
                                                          ),
                                                        if ((datachatItem
                                                                    .messagetext !=
                                                                '') &&
                                                            (datachatItem
                                                                    .who?.id ==
                                                                currentUserReference
                                                                    ?.id))
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        24.0,
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
                                                              onLongPress:
                                                                  () async {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
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
                                                                            DelchatWidget(
                                                                          chatID:
                                                                              datachatItem.idchat,
                                                                          room:
                                                                              widget.roomref!,
                                                                          who: datachatItem
                                                                              .who!,
                                                                          testmessage:
                                                                              datachatItem.messagetext,
                                                                          photomessage:
                                                                              datachatItem.messagephoto,
                                                                          time:
                                                                              datachatItem.timeup!,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              },
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        300.0,
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      maxWidth:
                                                                          260.0,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFB50000),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(24.0),
                                                                        bottomRight:
                                                                            Radius.circular(24.0),
                                                                        topLeft:
                                                                            Radius.circular(24.0),
                                                                        topRight:
                                                                            Radius.circular(3.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          12.0,
                                                                          16.0,
                                                                          12.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 160.0,
                                                                                decoration: BoxDecoration(),
                                                                                child: Text(
                                                                                  datachatItem.messagetext,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    dateTimeFormat(
                                                                                      "Hm",
                                                                                      datachatItem.timeup!,
                                                                                      locale: FFLocalizations.of(context).languageCode,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          fontSize: 12.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
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
                                                    );
                                                  },
                                                  controller:
                                                      _model.listViewController,
                                                );
                                              },
                                            ),
                                          ),
                                        ].addToEnd(SizedBox(height: 60.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 28.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 10.0, 0.0),
                                          child: Container(
                                            height: 38.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1D1D1D),
                                              borderRadius:
                                                  BorderRadius.circular(45.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 6.0, 12.0, 6.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: TextFormField(
                                                        controller: _model
                                                            .textController,
                                                        focusNode: _model
                                                            .textFieldFocusNode,
                                                        onChanged: (_) =>
                                                            EasyDebounce
                                                                .debounce(
                                                          '_model.textController',
                                                          Duration(
                                                              milliseconds:
                                                                  2000),
                                                          () => safeSetState(
                                                              () {}),
                                                        ),
                                                        onFieldSubmitted:
                                                            (_) async {
                                                          if (_model
                                                                  .lockchatt ==
                                                              false) {
                                                            _model.lockchatt =
                                                                true;
                                                            safeSetState(() {});
                                                            if (_model
                                                                    .textController
                                                                    .text !=
                                                                '') {
                                                              await widget
                                                                  .roomref!
                                                                  .update({
                                                                ...createRoomRecordData(
                                                                  lastmassage:
                                                                      _model
                                                                          .textController
                                                                          .text,
                                                                  timeupdate:
                                                                      getCurrentTimestamp,
                                                                  lastpersonUpdate:
                                                                      currentUserReference,
                                                                  startchat:
                                                                      true,
                                                                ),
                                                                ...mapToSupabase(
                                                                  {
                                                                    'message':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      getDatamassageFirestoreData(
                                                                        updateDatamassageStruct(
                                                                          DatamassageStruct(
                                                                            who:
                                                                                currentUserReference,
                                                                            messagetext:
                                                                                _model.textController.text,
                                                                            timeup:
                                                                                getCurrentTimestamp,
                                                                            idchat:
                                                                                random_data.randomInteger(0, 100000),
                                                                            userphoto:
                                                                                currentUserPhoto,
                                                                            name:
                                                                                currentUserDisplayName,
                                                                          ),
                                                                          clearUnsetFields:
                                                                              false,
                                                                        ),
                                                                        true,
                                                                      )
                                                                    ]),
                                                                  },
                                                                ),
                                                              });
                                                              if (!widget
                                                                  .openchat!) {
                                                                if (stackRoomRecord
                                                                        .usersend ==
                                                                    currentUserReference) {
                                                                  await stackRoomRecord
                                                                      .userrecive!
                                                                      .update({
                                                                    ...mapToSupabase(
                                                                      {
                                                                        'usermassage':
                                                                            FieldValue.arrayUnion([
                                                                          currentUserReference
                                                                        ]),
                                                                      },
                                                                    ),
                                                                  });
                                                                  triggerPushNotification(
                                                                    notificationTitle:
                                                                        currentUserDisplayName,
                                                                    notificationText:
                                                                        _model
                                                                            .textController
                                                                            .text,
                                                                    userRefs: [
                                                                      stackRoomRecord
                                                                          .userrecive!
                                                                    ],
                                                                    initialPageName:
                                                                        'HomePage',
                                                                    parameterData: {},
                                                                  );

                                                                  await currentUserReference!
                                                                      .update({
                                                                    ...mapToSupabase(
                                                                      {
                                                                        'usermassageRead':
                                                                            FieldValue.arrayUnion([
                                                                          stackRoomRecord
                                                                              .userrecive
                                                                        ]),
                                                                      },
                                                                    ),
                                                                  });
                                                                } else {
                                                                  await stackRoomRecord
                                                                      .usersend!
                                                                      .update({
                                                                    ...mapToSupabase(
                                                                      {
                                                                        'usermassage':
                                                                            FieldValue.arrayUnion([
                                                                          currentUserReference
                                                                        ]),
                                                                      },
                                                                    ),
                                                                  });
                                                                  triggerPushNotification(
                                                                    notificationTitle:
                                                                        currentUserDisplayName,
                                                                    notificationText:
                                                                        _model
                                                                            .textController
                                                                            .text,
                                                                    userRefs: [
                                                                      stackRoomRecord
                                                                          .usersend!
                                                                    ],
                                                                    initialPageName:
                                                                        'HomePage',
                                                                    parameterData: {},
                                                                  );

                                                                  await currentUserReference!
                                                                      .update({
                                                                    ...mapToSupabase(
                                                                      {
                                                                        'usermassageRead':
                                                                            FieldValue.arrayUnion([
                                                                          stackRoomRecord
                                                                              .usersend
                                                                        ]),
                                                                      },
                                                                    ),
                                                                  });
                                                                }
                                                              }
                                                              safeSetState(() {
                                                                _model
                                                                    .textController
                                                                    ?.clear();
                                                              });
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Please type something...',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0x00000000),
                                                                ),
                                                              );
                                                            }

                                                            _model.lockchatt =
                                                                false;
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        autofocus: false,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                            'mtwb7kux' /* Message */,
                                                          ),
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFBDBDBD),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                          errorBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                          focusedErrorBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                          suffixIcon: _model
                                                                  .textController!
                                                                  .text
                                                                  .isNotEmpty
                                                              ? InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    _model
                                                                        .textController
                                                                        ?.clear();
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                    Icons.clear,
                                                                    color: Color(
                                                                        0xFF757575),
                                                                    size: 22.0,
                                                                  ),
                                                                )
                                                              : null,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        validator: _model
                                                            .textControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(6.0, 0.0,
                                                                6.0, 0.0),
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
                                                        if (_model.lockchatt ==
                                                            false) {
                                                          _model.lockchatt =
                                                              true;
                                                          safeSetState(() {});
                                                          final selectedMedia =
                                                              await selectMedia(
                                                            maxWidth: 700.00,
                                                            maxHeight: 700.00,
                                                            imageQuality: 70,
                                                            mediaSource:
                                                                MediaSource
                                                                    .photoGallery,
                                                            multiImage: false,
                                                          );
                                                          if (selectedMedia !=
                                                                  null &&
                                                              selectedMedia.every((m) =>
                                                                  validateFileFormat(
                                                                      m.storagePath,
                                                                      context))) {
                                                            safeSetState(() =>
                                                                _model.isDataUploading_uploadData1ir =
                                                                    true);
                                                            var selectedUploadedFiles =
                                                                <FFUploadedFile>[];

                                                            var downloadUrls =
                                                                <String>[];
                                                            try {
                                                              showUploadMessage(
                                                                context,
                                                                'Uploading file...',
                                                                showLoading:
                                                                    true,
                                                              );
                                                              selectedUploadedFiles =
                                                                  selectedMedia
                                                                      .map((m) =>
                                                                          FFUploadedFile(
                                                                            name:
                                                                                m.storagePath.split('/').last,
                                                                            bytes:
                                                                                m.bytes,
                                                                            height:
                                                                                m.dimensions?.height,
                                                                            width:
                                                                                m.dimensions?.width,
                                                                            blurHash:
                                                                                m.blurHash,
                                                                            originalFilename:
                                                                                m.originalFilename,
                                                                          ))
                                                                      .toList();

                                                              downloadUrls =
                                                                  (await Future
                                                                          .wait(
                                                                selectedMedia
                                                                    .map(
                                                                  (m) async =>
                                                                      await uploadData(
                                                                          m.storagePath,
                                                                          m.bytes),
                                                                ),
                                                              ))
                                                                      .where((u) =>
                                                                          u !=
                                                                          null)
                                                                      .map((u) =>
                                                                          u!)
                                                                      .toList();
                                                            } finally {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                              _model.isDataUploading_uploadData1ir =
                                                                  false;
                                                            }
                                                            if (selectedUploadedFiles
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length &&
                                                                downloadUrls
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                              safeSetState(() {
                                                                _model.uploadedLocalFile_uploadData1ir =
                                                                    selectedUploadedFiles
                                                                        .first;
                                                                _model.uploadedFileUrl_uploadData1ir =
                                                                    downloadUrls
                                                                        .first;
                                                              });
                                                              showUploadMessage(
                                                                  context,
                                                                  'Success!');
                                                            } else {
                                                              safeSetState(
                                                                  () {});
                                                              showUploadMessage(
                                                                  context,
                                                                  'Failed to upload data');
                                                              return;
                                                            }
                                                          }

                                                          if (_model
                                                                  .uploadedFileUrl_uploadData1ir !=
                                                              '') {
                                                            await widget
                                                                .roomref!
                                                                .update({
                                                              ...createRoomRecordData(
                                                                timeupdate:
                                                                    getCurrentTimestamp,
                                                                lastmassage:
                                                                    'รูปภาพ',
                                                                lastpersonUpdate:
                                                                    currentUserReference,
                                                                startchat: true,
                                                              ),
                                                              ...mapToSupabase(
                                                                {
                                                                  'message':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    getDatamassageFirestoreData(
                                                                      updateDatamassageStruct(
                                                                        DatamassageStruct(
                                                                          who:
                                                                              currentUserReference,
                                                                          messagephoto:
                                                                              _model.uploadedFileUrl_uploadData1ir,
                                                                          timeup:
                                                                              getCurrentTimestamp,
                                                                          idchat: random_data.randomInteger(
                                                                              0,
                                                                              100000),
                                                                          userphoto:
                                                                              currentUserPhoto,
                                                                          name:
                                                                              currentUserDisplayName,
                                                                        ),
                                                                        clearUnsetFields:
                                                                            false,
                                                                      ),
                                                                      true,
                                                                    )
                                                                  ]),
                                                                },
                                                              ),
                                                            });
                                                            if (!widget
                                                                .openchat!) {
                                                              if (stackRoomRecord
                                                                      .usersend ==
                                                                  currentUserReference) {
                                                                await stackRoomRecord
                                                                    .userrecive!
                                                                    .update({
                                                                  ...mapToSupabase(
                                                                    {
                                                                      'usermassage':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        currentUserReference
                                                                      ]),
                                                                    },
                                                                  ),
                                                                });
                                                                triggerPushNotification(
                                                                  notificationTitle:
                                                                      currentUserDisplayName,
                                                                  notificationText:
                                                                      'มีข้อความรูปภาพ',
                                                                  userRefs: [
                                                                    stackRoomRecord
                                                                        .userrecive!
                                                                  ],
                                                                  initialPageName:
                                                                      'HomePage',
                                                                  parameterData: {},
                                                                );

                                                                await currentUserReference!
                                                                    .update({
                                                                  ...mapToSupabase(
                                                                    {
                                                                      'usermassageRead':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        stackRoomRecord
                                                                            .userrecive
                                                                      ]),
                                                                    },
                                                                  ),
                                                                });
                                                              } else {
                                                                await stackRoomRecord
                                                                    .usersend!
                                                                    .update({
                                                                  ...mapToSupabase(
                                                                    {
                                                                      'usermassage':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        currentUserReference
                                                                      ]),
                                                                    },
                                                                  ),
                                                                });
                                                                triggerPushNotification(
                                                                  notificationTitle:
                                                                      currentUserDisplayName,
                                                                  notificationText:
                                                                      'มีข้อความรูปภาพ',
                                                                  userRefs: [
                                                                    stackRoomRecord
                                                                        .usersend!
                                                                  ],
                                                                  initialPageName:
                                                                      'HomePage',
                                                                  parameterData: {},
                                                                );

                                                                await currentUserReference!
                                                                    .update({
                                                                  ...mapToSupabase(
                                                                    {
                                                                      'usermassageRead':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        stackRoomRecord
                                                                            .usersend
                                                                      ]),
                                                                    },
                                                                  ),
                                                                });
                                                              }
                                                            }
                                                            safeSetState(() {
                                                              _model.isDataUploading_uploadData1ir =
                                                                  false;
                                                              _model.uploadedLocalFile_uploadData1ir =
                                                                  FFUploadedFile(
                                                                      bytes: Uint8List
                                                                          .fromList(
                                                                              []),
                                                                      originalFilename:
                                                                          '');
                                                              _model.uploadedFileUrl_uploadData1ir =
                                                                  '';
                                                            });
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Please type something...',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    Color(
                                                                        0x00000000),
                                                              ),
                                                            );
                                                          }

                                                          _model.lockchatt =
                                                              false;
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      child: Image.asset(
                                                        'assets/images/camera.png',
                                                        height: 16.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 24.0,
                                                    child: VerticalDivider(
                                                      thickness: 1.0,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(6.0, 0.0,
                                                                6.0, 0.0),
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
                                                                    ItemWidget(),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Image.network(
                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/w5g3s4lkc5m8/%E0%B9%80%E0%B8%9E%E0%B8%B4%E0%B9%88%E0%B8%A1%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%E0%B9%83%E0%B8%99%E0%B8%AA%E0%B9%88%E0%B8%A7%E0%B8%99%E0%B9%80%E0%B8%99%E0%B8%B7%E0%B9%89%E0%B8%AD%E0%B8%AB%E0%B8%B2%E0%B9%80%E0%B8%A5%E0%B9%87%E0%B8%81%E0%B8%99%E0%B9%89%E0%B8%AD%E0%B8%A2_(3).png',
                                                        width: 20.0,
                                                        height: 20.0,
                                                        fit: BoxFit.contain,
                                                      ),
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
                                          if (_model.lockchatt == false) {
                                            _model.lockchatt = true;
                                            safeSetState(() {});
                                            if (_model.textController.text !=
                                                '') {
                                              await widget.roomref!.update({
                                                ...createRoomRecordData(
                                                  lastmassage: _model
                                                      .textController.text,
                                                  timeupdate:
                                                      getCurrentTimestamp,
                                                  lastpersonUpdate:
                                                      currentUserReference,
                                                  startchat: true,
                                                ),
                                                ...mapToSupabase(
                                                  {
                                                    'message':
                                                        FieldValue.arrayUnion([
                                                      getDatamassageFirestoreData(
                                                        updateDatamassageStruct(
                                                          DatamassageStruct(
                                                            who:
                                                                currentUserReference,
                                                            messagetext: _model
                                                                .textController
                                                                .text,
                                                            timeup:
                                                                getCurrentTimestamp,
                                                            idchat: random_data
                                                                .randomInteger(
                                                                    0, 100000),
                                                            userphoto:
                                                                currentUserPhoto,
                                                            name:
                                                                currentUserDisplayName,
                                                          ),
                                                          clearUnsetFields:
                                                              false,
                                                        ),
                                                        true,
                                                      )
                                                    ]),
                                                  },
                                                ),
                                              });
                                              if (!widget.openchat!) {
                                                if (stackRoomRecord.usersend ==
                                                    currentUserReference) {
                                                  await stackRoomRecord
                                                      .userrecive!
                                                      .update({
                                                    ...mapToSupabase(
                                                      {
                                                        'usermassage':
                                                            FieldValue
                                                                .arrayUnion([
                                                          currentUserReference
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        currentUserDisplayName,
                                                    notificationText: _model
                                                        .textController.text,
                                                    scheduledTime:
                                                        getCurrentTimestamp,
                                                    notificationSound:
                                                        'default',
                                                    userRefs: [
                                                      stackRoomRecord
                                                          .userrecive!
                                                    ],
                                                    initialPageName: 'HomePage',
                                                    parameterData: {},
                                                  );

                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToSupabase(
                                                      {
                                                        'usermassageRead':
                                                            FieldValue
                                                                .arrayUnion([
                                                          stackRoomRecord
                                                              .userrecive
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                } else {
                                                  await stackRoomRecord
                                                      .usersend!
                                                      .update({
                                                    ...mapToSupabase(
                                                      {
                                                        'usermassage':
                                                            FieldValue
                                                                .arrayUnion([
                                                          currentUserReference
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        currentUserDisplayName,
                                                    notificationText: _model
                                                        .textController.text,
                                                    scheduledTime:
                                                        getCurrentTimestamp,
                                                    notificationSound:
                                                        'default',
                                                    userRefs: [
                                                      stackRoomRecord.usersend!
                                                    ],
                                                    initialPageName: 'HomePage',
                                                    parameterData: {},
                                                  );

                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToSupabase(
                                                      {
                                                        'usermassageRead':
                                                            FieldValue
                                                                .arrayUnion([
                                                          stackRoomRecord
                                                              .usersend
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                }
                                              }
                                              safeSetState(() {
                                                _model.textController?.clear();
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Please type something...',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      Color(0x00000000),
                                                ),
                                              );
                                            }

                                            _model.lockchatt = false;
                                            safeSetState(() {});
                                          }
                                        },
                                        child: Container(
                                          width: 38.0,
                                          height: 38.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFF0000),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          3.0, 0.0, 0.0, 0.0),
                                                  child: Icon(
                                                    Icons.send_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 20.0,
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
                        ],
                      ),
                    ),
                    Container(
                      height: 58.0,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                            context.pushNamed(
                                                HomePageWidget.routeName);

                                            if (!widget.openchat!) {
                                              if (stackRoomRecord.usersend ==
                                                  currentUserReference) {
                                                await currentUserReference!
                                                    .update({
                                                  ...mapToSupabase(
                                                    {
                                                      'usermassage': FieldValue
                                                          .arrayRemove([
                                                        stackRoomRecord
                                                            .userrecive
                                                      ]),
                                                    },
                                                  ),
                                                });

                                                await stackRoomRecord
                                                    .userrecive!
                                                    .update({
                                                  ...mapToSupabase(
                                                    {
                                                      'usermassageRead':
                                                          FieldValue
                                                              .arrayRemove([
                                                        currentUserReference
                                                      ]),
                                                    },
                                                  ),
                                                });
                                              } else {
                                                await currentUserReference!
                                                    .update({
                                                  ...mapToSupabase(
                                                    {
                                                      'usermassage': FieldValue
                                                          .arrayRemove([
                                                        stackRoomRecord.usersend
                                                      ]),
                                                    },
                                                  ),
                                                });

                                                await stackRoomRecord.usersend!
                                                    .update({
                                                  ...mapToSupabase(
                                                    {
                                                      'usermassageRead':
                                                          FieldValue
                                                              .arrayRemove([
                                                        currentUserReference
                                                      ]),
                                                    },
                                                  ),
                                                });
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(),
                                            child: Icon(
                                              Icons.arrow_back_ios_new,
                                              color: Color(0xFFBDBDBD),
                                              size: 30.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                          child: Container(
                                            width: 42.0,
                                            height: 42.0,
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {},
                                                  child: Container(
                                                    width: 42.0,
                                                    height: 42.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      valueOrDefault<String>(
                                                        widget.userProfile,
                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                if ((widget.online == true) &&
                                                    (widget.openchat == false))
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.13, 1.13),
                                                    child: Container(
                                                      width: 15.0,
                                                      height: 15.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Container(
                                                              width: 15.0,
                                                              height: 15.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          10.0,
                                                                      height:
                                                                          10.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xFF00D333),
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              Image.network(
                                                                            '',
                                                                          ).image,
                                                                        ),
                                                                        shape: BoxShape
                                                                            .circle,
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
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.gift = true;
                                                  safeSetState(() {});
                                                },
                                                child: Text(
                                                  widget.name,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 17.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
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
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 48.0,
                                  icon: Icon(
                                    Icons.more_vert_sharp,
                                    color: Color(0xFFBDBDBD),
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    if (!widget.openchat!) {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
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
                                                  context),
                                              child: DelallchatWidget(
                                                idroom: widget.roomref!,
                                                userref: stackRoomRecord
                                                            .usersend?.id ==
                                                        currentUserReference?.id
                                                    ? stackRoomRecord
                                                        .userrecive!
                                                    : stackRoomRecord.usersend!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (((currentUserDocument?.cheersEnd.toList() ?? [])
                                .length !=
                            (currentUserDocument?.showprofilecheers.toList() ??
                                    [])
                                .length) &&
                        ((currentUserDocument?.cheersEnd.toList() ?? [])
                                .length !=
                            0))
                      AuthUserStreamWidget(
                        builder: (context) => StreamBuilder<UsersRecord>(
                          stream: UsersRecord.getDocument(
                              (currentUserDocument?.cheersEnd.toList() ?? [])
                                  .elementAtOrNull((currentUserDocument
                                              ?.showprofilecheers
                                              .toList() ??
                                          [])
                                      .length)!),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
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

                            final card33UserGridUsersRecord = snapshot.data!;

                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(HomePageWidget.routeName);

                                await currentUserReference!.update({
                                  ...mapToSupabase(
                                    {
                                      'showprofilecheers':
                                          FieldValue.arrayUnion([
                                        card33UserGridUsersRecord.reference
                                      ]),
                                    },
                                  ),
                                });
                              },
                              child: wrapWithModel(
                                model: _model.card33UserGridModel,
                                updateCallback: () => safeSetState(() {}),
                                updateOnChange: true,
                                child: Card33UserGridWidget(
                                  name: valueOrDefault<String>(
                                    card33UserGridUsersRecord.displayName,
                                    'ไม่ระบุ',
                                  ),
                                  image: valueOrDefault<String>(
                                    card33UserGridUsersRecord.photoUrl,
                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png',
                                  ),
                                  uid: card33UserGridUsersRecord.reference,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
