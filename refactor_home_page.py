import re

file_path = '/Users/bewsunattha/MundayGEN/munday/lib/features/social/presentation/home_page/home_page_widget.dart'
new_file_path = '/Users/bewsunattha/MundayGEN/munday/lib/features/social/presentation/home_page/home_page_widget_new.dart'

with open(file_path, 'r') as f:
    text = f.read()

# I will define replacement blocks using regex or string splitting

# 1. Grab everything before the AuthUserStreamWidget builder content (line ~103)
# We know `child: AuthUserStreamWidget(` is around line 102.
head, tail = text.split("child: AuthUserStreamWidget(\n              builder: (context) {\n", 1)

# Now `tail` contains the rest of the file.
# We want to grab the bottom of the file (closing AuthUserStreamWidget)
# The end is around `                },` or something.
# We will just write a new `_buildMainBody` inside `_HomePageWidgetState`!
# Wait, I can inject _buildMainBody before `Widget build(BuildContext context)`

# Let's split head into before `Widget build` and the `Widget build` signature
class_decl_split = head.rfind("  @override\n  Widget build(BuildContext context) {")
if class_decl_split == -1:
    print("Error finding build method")

before_build = head[:class_decl_split]
build_sig_to_auth = head[class_decl_split:]

main_body_code = """
  Widget _buildMainBody(
    BuildContext context,
    List<RoomRecord> containerRoomRecordList,
    dynamic checkinRef,
    StoreRecord? stackStoreRecord,
    RoomRecord? containerRoomRecord,
  ) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              context.pushNamed(HomeWidget.routeName);
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(),
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                            child: Image.network(
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/kwg045z3snx3/Munday-logo.png',
                              width: 133.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            ProfileWidget.routeName,
                            queryParameters: {
                              'fromSeting': serializeParam(false, ParamType.bool),
                            }.withoutNulls,
                          );
                        },
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF1D1D1D),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                valueOrDefault<String>(
                                  currentUserPhoto,
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                ),
                              ).image,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 20.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textController',
                            Duration(milliseconds: 400),
                            () => safeSetState(() {}),
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: FFLocalizations.of(context).getText('1o27ut5s' /* Search for user */),
                            hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.openSans(
                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                  ),
                                  color: Color(0xFFBDBDBD),
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0x00000000), width: 1.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0x00000000), width: 1.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0x00000000), width: 1.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0x00000000), width: 1.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor: Color(0x651D1D1D),
                            prefixIcon: Icon(Icons.search_sharp, color: FlutterFlowTheme.of(context).primaryText),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.openSans(),
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (checkinRef != null)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText('hxg0fy2b' /* Latest Users */),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.openSans(),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (checkinRef != null && stackStoreRecord != null)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 9.0, 10.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        ChatsWidget.routeName,
                                        queryParameters: {
                                          'userProfile': serializeParam(stackStoreRecord.logo, ParamType.String),
                                          'roomref': serializeParam(stackStoreRecord.iDroom, ParamType.SupabaseDocRef),
                                          'name': serializeParam(stackStoreRecord.namestore, ParamType.String),
                                          'online': serializeParam(false, ParamType.bool),
                                          'openchat': serializeParam(true, ParamType.bool),
                                        }.withoutNulls,
                                      );
                                      await stackStoreRecord.iDroom!.update(createRoomRecordData(timeupdate: getCurrentTimestamp));
                                    },
                                    child: Container(
                                      width: 75.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(shape: BoxShape.rectangle),
                                      child: Stack(
                                        children: [
                                          Align(
                                              alignment: AlignmentDirectional(0.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                    child: Container(
                                                      width: 75.0,
                                                      height: 75.0,
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF1D1D1D),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: Image.network(valueOrDefault(currentUserDocument?.logoRoom, '')).image,
                                                        ),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context).getText('4v2upbkr' /* Open Chat */),
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                                          fontSize: 10.0,
                                                        ),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (containerRoomRecordList.isNotEmpty)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 10.0),
                                  child: Builder(
                                    builder: (context) {
                                      final data1 = functions.jsonDataRoomAndStore(currentUserReference, containerRoomRecordList.toList(), stackStoreRecord)?.toList() ?? [];
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(data1.length, (data1Index) {
                                          final data1Item = data1[data1Index];
                                          return Visibility(
                                            visible: functions.showsearch(_model.textController.text, DatainstoreStruct.maybeFromMap(data1Item)?.name) ?? true,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 9.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    ChatsWidget.routeName,
                                                    queryParameters: {
                                                      'userProfile': serializeParam(DatainstoreStruct.maybeFromMap(data1Item)?.photoprofile, ParamType.String),
                                                      'roomref': serializeParam(DatainstoreStruct.maybeFromMap(data1Item)?.roomRef, ParamType.SupabaseDocRef),
                                                      'name': serializeParam(valueOrDefault<String>(DatainstoreStruct.maybeFromMap(data1Item)?.name, 'ไม่ระบุ'), ParamType.String),
                                                      'online': serializeParam(DatainstoreStruct.maybeFromMap(data1Item)?.online, ParamType.bool),
                                                      'openchat': serializeParam(false, ParamType.bool),
                                                    }.withoutNulls,
                                                  );
                                                  await DatainstoreStruct.maybeFromMap(data1Item)!.roomRef!.update(createRoomRecordData(timeupdate: getCurrentTimestamp));
                                                  await currentUserReference!.update({
                                                    ...mapToSupabase({
                                                      'usermassageRead': FieldValue.arrayUnion([DatainstoreStruct.maybeFromMap(data1Item)?.userRef]),
                                                    }),
                                                  });
                                                },
                                                child: Container(
                                                  width: 75.0,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(shape: BoxShape.rectangle),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                              child: Container(
                                                                width: 75.0, height: 75.0,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  border: Border.all(
                                                                    color: (currentUserDocument?.usermassage.toList() ?? []).contains(DatainstoreStruct.maybeFromMap(data1Item)?.userRef) ? FlutterFlowTheme.of(context).primaryText : Color(0xFF434343),
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Align(
                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                      child: Container(
                                                                        width: 68.0, height: 68.0,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xFF1D1D1D),
                                                                          image: DecorationImage(
                                                                            fit: BoxFit.cover,
                                                                            image: Image.network(valueOrDefault<String>(DatainstoreStruct.maybeFromMap(data1Item)?.photoprofile, 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png')).image,
                                                                          ),
                                                                          shape: BoxShape.circle,
                                                                          border: Border.all(width: 1.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (DatainstoreStruct.maybeFromMap(data1Item)?.online ?? true)
                                                                      Align(
                                                                        alignment: AlignmentDirectional(0.97, 0.97),
                                                                        child: Container(
                                                                          width: 19.0, height: 18.0,
                                                                          child: Stack(
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Container(
                                                                                  width: 19.0, height: 19.0,
                                                                                  decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                                                                                  child: Stack(
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 12.0, height: 12.0,
                                                                                          decoration: BoxDecoration(color: Color(0xFF00D333), shape: BoxShape.circle),
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
                                                            Text(
                                                              valueOrDefault<String>(DatainstoreStruct.maybeFromMap(data1Item)?.name, 'ไม่ระบุ'),
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(), fontSize: 10.0),
                                                            ),
                                                          ],
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
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (checkinRef != null && stackStoreRecord != null && containerRoomRecord != null)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              ChatsWidget.routeName,
                                              queryParameters: {
                                                'userProfile': serializeParam(stackStoreRecord.logo, ParamType.String),
                                                'roomref': serializeParam(stackStoreRecord.iDroom, ParamType.SupabaseDocRef),
                                                'name': serializeParam(stackStoreRecord.namestore, ParamType.String),
                                                'online': serializeParam(false, ParamType.bool),
                                                'openchat': serializeParam(true, ParamType.bool),
                                              }.withoutNulls,
                                            );
                                            await stackStoreRecord.iDroom!.update(createRoomRecordData(timeupdate: getCurrentTimestamp));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF131313),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Row(
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
                                                          Container(
                                                            width: 48.0, height: 48.0,
                                                            clipBehavior: Clip.antiAlias,
                                                            decoration: BoxDecoration(shape: BoxShape.circle),
                                                            child: Image.network(valueOrDefault(currentUserDocument?.logoRoom, ''), fit: BoxFit.cover),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.max,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Text(
                                                                      stackStoreRecord.namestore,
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(), color: FlutterFlowTheme.of(context).primaryText),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                      child: Text(
                                                                        containerRoomRecord.lastpersonUpdate == currentUserReference ? 'คุณ' : valueOrDefault<String>(containerRoomRecord.message.lastOrNull?.name, 'ไม่ระบุ'),
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(fontWeight: FontWeight.w500), color: Color(0xFFB8B8B8), fontSize: 12.0),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                      child: Text(':', style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(fontWeight: FontWeight.w500), color: Color(0xFFB8B8B8), fontSize: 12.0)),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                      child: Text(containerRoomRecord.lastmassage, style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(fontWeight: FontWeight.w500), color: Color(0xFFB8B8B8), fontSize: 12.0)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 17.0),
                                                        child: Text(
                                                          dateTimeFormat("Hm", containerRoomRecord.timeupdate!, locale: FFLocalizations.of(context).languageCode),
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(), color: Color(0xFFB8B8B8), fontSize: 12.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (containerRoomRecordList.isNotEmpty)
                                  Builder(builder: (context) {
                                    final dataroom2 = functions.jsonDataRoomAndStore(currentUserReference, containerRoomRecordList.toList(), stackStoreRecord)?.toList() ?? [];
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(dataroom2.length, (dataroom2Index) {
                                        final dataroom2Item = dataroom2[dataroom2Index];
                                        return Visibility(
                                          visible: functions.showsearch(_model.textController.text, DatainstoreStruct.maybeFromMap(dataroom2Item)?.name) ?? true,
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent, focusColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  ChatsWidget.routeName,
                                                  queryParameters: {
                                                    'userProfile': serializeParam(DatainstoreStruct.maybeFromMap(dataroom2Item)?.photoprofile, ParamType.String),
                                                    'roomref': serializeParam(DatainstoreStruct.maybeFromMap(dataroom2Item)?.roomRef, ParamType.SupabaseDocRef),
                                                    'name': serializeParam(DatainstoreStruct.maybeFromMap(dataroom2Item)?.name, ParamType.String),
                                                    'online': serializeParam(DatainstoreStruct.maybeFromMap(dataroom2Item)?.online, ParamType.bool),
                                                    'openchat': serializeParam(false, ParamType.bool),
                                                  }.withoutNulls,
                                                );
                                                await DatainstoreStruct.maybeFromMap(dataroom2Item)!.roomRef!.update(createRoomRecordData(timeupdate: getCurrentTimestamp));
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: (currentUserDocument?.usermassage.toList() ?? []).contains(DatainstoreStruct.maybeFromMap(dataroom2Item)?.userRef) == true ? Color(0xFFD50000) : Color(0xFF131313),
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              InkWell(
                                                                splashColor: Colors.transparent, focusColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent,
                                                                onTap: () async {},
                                                                child: Container(
                                                                  width: 48.0, height: 48.0, clipBehavior: Clip.antiAlias, decoration: BoxDecoration(shape: BoxShape.circle),
                                                                  child: Image.network(valueOrDefault<String>(DatainstoreStruct.maybeFromMap(dataroom2Item)?.photoprofile, 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png'), fit: BoxFit.cover),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      children: [
                                                                        Text(valueOrDefault<String>(DatainstoreStruct.maybeFromMap(dataroom2Item)?.name, 'ไม่ระบุ'), style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(), color: FlutterFlowTheme.of(context).primaryText)),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                          child: Text(valueOrDefault<String>(DatainstoreStruct.maybeFromMap(dataroom2Item)?.lastpersonUpdate == currentUserReference ? 'คุณ' : DatainstoreStruct.maybeFromMap(dataroom2Item)?.name, 'ไม่ระบุ'), style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(fontWeight: FontWeight.w500), color: Color(0xFFB8B8B8), fontSize: 12.0)),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                          child: Text(':', style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(fontWeight: FontWeight.w500), color: Color(0xFFB8B8B8), fontSize: 12.0)),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                          child: Text(valueOrDefault<String>(DatainstoreStruct.maybeFromMap(dataroom2Item)?.lastmassage, 'ไม่มีข้อความ'), style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(fontWeight: FontWeight.w500), color: Color(0xFFB8B8B8), fontSize: 12.0)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text(dateTimeFormat("Hm", DatainstoreStruct.maybeFromMap(dataroom2Item)!.timeupdate!, locale: FFLocalizations.of(context).languageCode), style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(), color: Color(0xFFB8B8B8), fontSize: 12.0)),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  () {
                                                                    if (DatainstoreStruct.maybeFromMap(dataroom2Item)?.startchat == false) { return 'ยังไม่มีข้อความ'; }
                                                                    else if ((currentUserDocument?.usermassage.toList() ?? []).contains(DatainstoreStruct.maybeFromMap(dataroom2Item)?.userRef) == true) { return 'มีข้อความ'; }
                                                                    else if ((currentUserDocument?.usermassageRead.toList() ?? []).contains(DatainstoreStruct.maybeFromMap(dataroom2Item)?.userRef) == false) { return 'อ่านแล้ว'; }
                                                                    else { return 'ยังไม่อ่าน'; }
                                                                  }(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.openSans(), color: Color(0xFFB8B8B8), fontSize: 12.0),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  }),
                              ].addToEnd(SizedBox(height: 80.0)),
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
        if (((currentUserDocument?.cheersEnd.toList() ?? []).length != (currentUserDocument?.showprofilecheers.toList() ?? []).length) && ((currentUserDocument?.cheersEnd.toList() ?? []).length != 0))
          StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument((currentUserDocument?.cheersEnd.toList() ?? []).elementAtOrNull((currentUserDocument?.showprofilecheers.toList() ?? []).length)!),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: SizedBox(width: 50.0, height: 50.0, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent))));
              }
              final card33UserGridUsersRecord = snapshot.data!;
              return InkWell(
                splashColor: Colors.transparent, focusColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(HomePageWidget.routeName);
                  await currentUserReference!.update({ ...mapToSupabase({ 'showprofilecheers': FieldValue.arrayUnion([card33UserGridUsersRecord.reference]), }), });
                },
                child: wrapWithModel(
                  model: _model.card33UserGridModel, updateCallback: () => safeSetState(() {}), updateOnChange: true,
                  child: Card33UserGridWidget(
                    name: valueOrDefault<String>(card33UserGridUsersRecord.displayName, 'ไม่ระบุ'),
                    image: valueOrDefault<String>(card33UserGridUsersRecord.photoUrl, 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png'),
                    uid: card33UserGridUsersRecord.reference,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
"""

new_build_logic = """
                final checkinRef = currentUserDocument?.checkinID;
                
                return StreamBuilder<List<RoomRecord>>(
                  stream: queryRoomRecord(
                    queryBuilder: (roomRecord) => roomRecord
                        .where(Filter.or(
                          Filter('usersend', isEqualTo: currentUserReference),
                          Filter('userrecive', isEqualTo: currentUserReference),
                        ))
                        .orderBy('timeupdate', descending: true),
                  ),
                  builder: (context, roomListSnapshot) {
                    if (!roomListSnapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                          ),
                        ),
                      );
                    }
                    final containerRoomRecordList = roomListSnapshot.data!;

                    if (checkinRef != null) {
                      return StreamBuilder<StoreRecord>(
                        stream: StoreRecord.getDocument(checkinRef),
                        builder: (context, storeSnapshot) {
                          if (!storeSnapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                                ),
                              ),
                            );
                          }
                          final stackStoreRecord = storeSnapshot.data!;

                          if (stackStoreRecord.iDroom != null) {
                            return StreamBuilder<RoomRecord>(
                              stream: RoomRecord.getDocument(stackStoreRecord.iDroom!),
                              builder: (context, storeRoomSnapshot) {
                                if (!storeRoomSnapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                                      ),
                                    ),
                                  );
                                }
                                final containerRoomRecord = storeRoomSnapshot.data!;
                                return _buildMainBody(context, containerRoomRecordList, checkinRef, stackStoreRecord, containerRoomRecord);
                              },
                            );
                          } else {
                            return _buildMainBody(context, containerRoomRecordList, checkinRef, stackStoreRecord, null);
                          }
                        },
                      );
                    } else {
                      return _buildMainBody(context, containerRoomRecordList, null, null, null);
                    }
                  },
                );
"""

final_text = before_build + main_body_code + build_sig_to_auth + new_build_logic + """
              },
            ),
          ),
        ),
      ),
    );
  }
}
"""

with open(new_file_path, 'w') as f:
    f.write(final_text)

print("Created refined file. Verifying lengths:")
print(len(final_text.splitlines()))

