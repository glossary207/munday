part of "../social_invenuse_page.dart";

class SocialInvenuesChatTabWidget extends ConsumerStatefulWidget {
  final SocialInVenuseModel model;
  final VenuesRecord stackVenuesRecord;
  final Map<String, AnimationInfo> animationsMap;

  const SocialInvenuesChatTabWidget({
    super.key,
    required this.model,
    required this.stackVenuesRecord,
    required this.animationsMap,
  });

  @override
  ConsumerState<SocialInvenuesChatTabWidget> createState() =>
      _SocialInvenuesChatTabWidgetState();
}

@NowaGenerated()
class _SocialInvenuesChatTabWidgetState
    extends ConsumerState<SocialInvenuesChatTabWidget> {
  SocialInVenuseModel get _model {
    return widget.model;
  }

  VenuesRecord get stackVenuesRecord {
    return widget.stackVenuesRecord;
  }

  Map<String, AnimationInfo> get animationsMap {
    return widget.animationsMap;
  }

  void safeSetState(void Function() fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: const Color(0x981D1D1D),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0,
                          0.0,
                          15.0,
                          2.0,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Theme.of(
                            context,
                          ).extension<CustomColors>()!.primaryBtnText,
                          size: 22.0,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController',
                              const Duration(milliseconds: 500),
                              () => safeSetState(() {}),
                            ),
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: false,
                              hintText: AppLocalizations.of(
                                context,
                              )!.k_s679s8bf,
                              hintStyle: Theme.of(context).textTheme.bodySmall!
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.fontStyle,
                                    ),
                                    color: const Color(0xFFD8D8D8),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.bodySmall!.fontStyle,
                                  ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
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
                                  color: const Color(0xFFDADADA),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontStyle,
                                ),
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
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
                          safeSetState(() {});
                        },
                        child: Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            color: const Color(0x981D1D1D),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0x33000000),
                                offset: Offset(2.0, 2.0),
                                spreadRadius: 4.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Image.network(
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4mhd403jg5z2/fillter.png',
                                  width: 32.0,
                                  height: 32.0,
                                  fit: BoxFit.cover,
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
                    await (currentUserDocument?.iDROOMVenues.toList() ?? [])
                        .firstOrNull!
                        .update({
                          ...mapToSupabase({
                            'user': FieldValue.arrayRemove([
                              getDaSupabaseData(
                                updateDaStruct(
                                  DaStruct(
                                    user: DatauserStruct(
                                      userinstore: currentUserReference,
                                    ),
                                  ),
                                  clearUnsetFields: false,
                                ),
                                true,
                              ),
                            ]),
                          }),
                        });
                    context.pushNamed(MainPage.routeName);
                    await currentUserReference!.update({
                      ...mapToSupabase({
                        'nameLoginVenues': FieldValue.delete(),
                        'IDROOMVenues': FieldValue.delete(),
                        'loginVenuesRoom': FieldValue.delete(),
                      }),
                    });
                    await DeletepeoplefromvenueCall.call(
                      uid: currentUserReference?.id,
                      userinvenueid:
                          (currentUserDocument?.iDROOMVenues.toList() ?? [])
                              .firstOrNull
                              ?.id,
                      datetodelete: getCurrentTimestamp.secondsSinceEpoch,
                    );
                  },
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE30000),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Visibility(
                      visible: false,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                0.0,
                                0.0,
                                4.5,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/exit3.png',
                                  width: 32.0,
                                  height: 32.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          if (false)
                            Align(
                              alignment: const AlignmentDirectional(0.0, 1.4),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          Align(
                            alignment: const AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                5.0,
                                0.0,
                                5.0,
                                1.2,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.k_95hbq33e,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .override(
                                      font: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.fontStyle,
                                      ),
                                      fontSize: 7.0,
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w600,
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
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Builder(
            builder: (context) {
              final idroom = (currentUserDocument?.iDROOMVenues.toList() ?? [])
                  .toList();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(idroom.length, (idroomIndex) {
                  final idroomItem = idroom[idroomIndex];
                  return Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      0.0,
                      0.0,
                      10.0,
                    ),
                    child: StreamBuilder<UserInVenuesRecord>(
                      stream: UserInVenuesRecord.getDocument(idroomItem),
                      builder: (context, snapshot) {
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
                        final columnUserInVenuesRecord = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (false)
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    3.0,
                                    0.0,
                                    5.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              20.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      valueOrDefault<String>(
                                                        columnUserInVenuesRecord
                                                            .nameVenues,
                                                        'ณ บางเขน',
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .override(
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
                                                            fontSize: 17.0,
                                                            letterSpacing: 0.3,
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
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            10.0,
                                                            2.0,
                                                            7.0,
                                                            0.0,
                                                          ),
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
                                                          if (_model.openroom
                                                                  .elementAtOrNull(
                                                                    idroomIndex,
                                                                  ) ==
                                                              true) {
                                                            _model
                                                                .updateOpenroomAtIndex(
                                                                  idroomIndex,
                                                                  (_) => false,
                                                                );
                                                            safeSetState(() {});
                                                          } else {
                                                            _model
                                                                .updateOpenroomAtIndex(
                                                                  idroomIndex,
                                                                  (_) => true,
                                                                );
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 20.0,
                                                          height: 20.0,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                _model.openroom
                                                                    .elementAtOrNull(
                                                                      idroomIndex,
                                                                    )!
                                                                ? const Color(
                                                                    0xFF222222,
                                                                  )
                                                                : const Color(
                                                                    0xFFFF0000,
                                                                  ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10.0,
                                                                ),
                                                            shape: BoxShape
                                                                .rectangle,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional.fromSTEB(
                                                                  1.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                            child: Stack(
                                                              children: [
                                                                if (_model
                                                                        .openroom
                                                                        .elementAtOrNull(
                                                                          idroomIndex,
                                                                        ) ??
                                                                    true)
                                                                  const Align(
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
                                                                            1.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .expand_more_sharp,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            17.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (!_model
                                                                    .openroom
                                                                    .elementAtOrNull(
                                                                      idroomIndex,
                                                                    )!)
                                                                  const Align(
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
                                                                            1.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .navigate_next_rounded,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            17.0,
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
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
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
                                                    0.0,
                                                    0.0,
                                                    20.0,
                                                    0.0,
                                                  ),
                                              child: Container(
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.0,
                                                      ),
                                                  border: Border.all(
                                                    color: const Color(
                                                      0xFF1D1D1D,
                                                    ),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            10.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Icon(
                                                        Icons.people_rounded,
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                            10.0,
                                                            0.0,
                                                            10.0,
                                                            0.0,
                                                          ),
                                                      child: Text(
                                                        columnUserInVenuesRecord
                                                            .user
                                                            .where(
                                                              (e) => functions
                                                                  .checkdate(
                                                                    (e as dynamic)?.date,
                                                                    getCurrentTimestamp,
                                                                  )!,
                                                            )
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
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
                                                              color: Theme.of(context)
                                                                  .extension<
                                                                    CustomColors
                                                                  >()!
                                                                  .primaryText,
                                                              fontSize: 14.0,
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
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (_model.openroom.elementAtOrNull(idroomIndex) ??
                                true)
                              Expanded(
                                child: Align(
                                  alignment: const AlignmentDirectional(
                                    0.0,
                                    -1.0,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          5.0,
                                          5.0,
                                          5.0,
                                          0.0,
                                        ),
                                    child:
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20.0,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFF131313),
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              final userinroom =
                                                  columnUserInVenuesRecord.user
                                                      .where(
                                                        (
                                                          e,
                                                        ) => functions.checkdate(
                                                          (e as dynamic)?.date,
                                                          getCurrentTimestamp,
                                                        )!,
                                                      )
                                                      .toList()
                                                      .sortedList(
                                                        keyOf: (e) => ((e as dynamic)?.user?.view as num?),
                                                        desc: true,
                                                      )
                                                      .toList();
                                              return RefreshIndicator(
                                                color: Colors.transparent,
                                                backgroundColor:
                                                    Colors.transparent,
                                                onRefresh: () async {},
                                                child: GridView.builder(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                        0,
                                                        0,
                                                        0,
                                                        100.0,
                                                      ),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                        childAspectRatio: 0.8,
                                                      ),
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: userinroom.length,
                                                  itemBuilder: (context, userinroomIndex) {
                                                    final userinroomItem =
                                                        userinroom[userinroomIndex];
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
                                                        if (userinroomItem
                                                                .user
                                                                .userinstore !=
                                                            currentUserReference) {
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
                                                                  child: PopupuserWidget(
                                                                    offchat:
                                                                        true,
                                                                    show: true,
                                                                    listref: functions.addref1(
                                                                      columnUserInVenuesRecord
                                                                          .user
                                                                          .where(
                                                                            (
                                                                              e,
                                                                            ) => functions.checkdate(
                                                                              (e as dynamic)?.date,
                                                                              getCurrentTimestamp,
                                                                            )!,
                                                                          )
                                                                          .toList()
                                                                          .sortedList(
                                                                            keyOf: (e) => ((e as dynamic)?.user?.view as num?),
                                                                            desc:
                                                                                true,
                                                                          )
                                                                          .map(
                                                                            (
                                                                              e,
                                                                            ) =>
                                                                                (e as dynamic)?.user?.userinstore,
                                                                          )
                                                                          .withoutNulls.toList().cast<SupabaseDocRef>(),
                                                                      userinroomItem
                                                                          .user
                                                                          .userinstore,
                                                                    )!,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then(
                                                            (value) =>
                                                                safeSetState(
                                                                  () {},
                                                                ),
                                                          );
                                                          AppState()
                                                              .addToAddviewID(
                                                                userinroomItem
                                                                    .user
                                                                    .userinstore!
                                                                    .id,
                                                              );
                                                          safeSetState(() {});
                                                          if (AppState()
                                                                  .addviewID
                                                                  .length >
                                                              5) {
                                                            await UpdateotheruserviewCall.call(
                                                              viewsList:
                                                                  AppState()
                                                                      .addviewID,
                                                            );
                                                            AppState()
                                                                    .addviewID =
                                                                [];
                                                            context.appState.update(
                                                              () {},
                                                            );
                                                          }
                                                        } else {
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
                                                                  child: PopupuserWidget(
                                                                    offchat:
                                                                        false,
                                                                    show: true,
                                                                    listref: functions.addref1(
                                                                      columnUserInVenuesRecord
                                                                          .user
                                                                          .where(
                                                                            (
                                                                              e,
                                                                            ) => functions.checkdate(
                                                                              (e as dynamic)?.date,
                                                                              getCurrentTimestamp,
                                                                            )!,
                                                                          )
                                                                          .toList()
                                                                          .sortedList(
                                                                            keyOf: (e) => ((e as dynamic)?.user?.view as num?),
                                                                            desc:
                                                                                true,
                                                                          )
                                                                          .map(
                                                                            (
                                                                              e,
                                                                            ) =>
                                                                                (e as dynamic)?.user?.userinstore,
                                                                          )
                                                                          .withoutNulls.toList().cast<SupabaseDocRef>(),
                                                                      userinroomItem
                                                                          .user
                                                                          .userinstore,
                                                                    )!,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then(
                                                            (value) =>
                                                                safeSetState(
                                                                  () {},
                                                                ),
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  MediaQuery.sizeOf(
                                                                    context,
                                                                  ).width *
                                                                  0.17,
                                                              height:
                                                                  MediaQuery.sizeOf(
                                                                    context,
                                                                  ).width *
                                                                  0.17,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: const BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                            90.0,
                                                                          ),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                            90.0,
                                                                          ),
                                                                      topLeft:
                                                                          Radius.circular(
                                                                            90.0,
                                                                          ),
                                                                      topRight:
                                                                          Radius.circular(
                                                                            90.0,
                                                                          ),
                                                                    ),
                                                                    child: Image.network(
                                                                      valueOrDefault<
                                                                        String
                                                                      >(
                                                                        userinroomItem
                                                                            .user
                                                                            .photoprofile,
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                                                      ),
                                                                      width:
                                                                          100.0,
                                                                      height:
                                                                          100.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0,
                                                                        ),
                                                                    child: Container(
                                                                      width:
                                                                          22.0,
                                                                      height:
                                                                          22.0,
                                                                      decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image: Image.network(() {
                                                                            if ((currentUserDocument?.usercheerme.toList() ??
                                                                                        [])
                                                                                    .contains(
                                                                                      userinroomItem.user.userinstore,
                                                                                    ) &&
                                                                                valueOrDefault<
                                                                                  bool
                                                                                >(
                                                                                  currentUserDocument?.seeusercheers,
                                                                                  false,
                                                                                )) {
                                                                              return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/lcvfw7ee3qy1/null.png';
                                                                            } else if (userinroomIndex ==
                                                                                0) {
                                                                              return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wm7l2b47grzw/fire.png';
                                                                            } else if (userinroomIndex ==
                                                                                1) {
                                                                              return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wm7l2b47grzw/fire.png';
                                                                            } else if (userinroomIndex ==
                                                                                2) {
                                                                              return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wm7l2b47grzw/fire.png';
                                                                            } else {
                                                                              return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/lcvfw7ee3qy1/null.png';
                                                                            }
                                                                          }()).image,
                                                                        ),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (userinroomItem
                                                                      .user
                                                                      .online)
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                            0.97,
                                                                            0.97,
                                                                          ),
                                                                      child: Container(
                                                                        width:
                                                                            17.0,
                                                                        height:
                                                                            17.0,
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child: Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: const AlignmentDirectional(
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              child: Container(
                                                                                width: 17.0,
                                                                                height: 17.0,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: const AlignmentDirectional(
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Container(
                                                                                        width: 11.0,
                                                                                        height: 11.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: const Color(
                                                                                            0xFF00D333,
                                                                                          ),
                                                                                          image: DecorationImage(
                                                                                            fit: BoxFit.cover,
                                                                                            image: Image.network(
                                                                                              '',
                                                                                            ).image,
                                                                                          ),
                                                                                          shape: BoxShape.circle,
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
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    6.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                valueOrDefault<
                                                                  String
                                                                >(
                                                                  userinroomItem
                                                                      .user
                                                                      .name,
                                                                  'ไม่ระบุ',
                                                                ),
                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
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
                                                                  fontSize:
                                                                      10.0,
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
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ).animateOnPageLoad(
                                          animationsMap['containerOnPageLoadAnimation1']!,
                                        ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  );
                }).addToEnd(const SizedBox(height: 120.0)),
              );
            },
          ),
        ),
      ],
    );
  }
}
