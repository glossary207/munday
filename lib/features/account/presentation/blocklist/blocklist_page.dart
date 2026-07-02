import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/core/utils/app_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'blocklist_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'blocklist_model.dart';

class BlocklistPage extends ConsumerStatefulWidget {
  const BlocklistPage({super.key});

  static String routeName = 'Blocklist';
  static String routePath = 'blocklist';

  @override
  ConsumerState<BlocklistPage> createState() => _BlocklistWidgetState();
}

class _BlocklistWidgetState extends ConsumerState<BlocklistPage> {
  late BlocklistModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = BlocklistModel()..internalInit(context);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: responsiveVisibility(
          context: context,
          tablet: false,
          tabletLandscape: false,
          desktop: false,
        )
            ? AppBar(
                backgroundColor: Colors.black,
                automaticallyImplyLeading: false,
                leading: MundayIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context)
                        .extension<CustomColors>()!
                        .primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(AccountSettingsPage.routeName);
                  },
                ),
                title: Text(
                  AppLocalizations.of(context)!.k_gywtp2u9,
                  style: Theme.of(context).textTheme.bodyLarge!.override(
                        font: GoogleFonts.openSans(
                          fontWeight:
                              Theme.of(context).textTheme.bodyLarge!.fontWeight,
                          fontStyle:
                              Theme.of(context).textTheme.bodyLarge!.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            Theme.of(context).textTheme.bodyLarge!.fontWeight,
                        fontStyle:
                            Theme.of(context).textTheme.bodyLarge!.fontStyle,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 0.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Visibility(
            visible: (currentUserDocument?.blockuser.toList() ?? []).isNotEmpty,
            child: AuthUserStreamWidget(
              builder: (context) => StreamBuilder<List<UsersRecord>>(
                stream: queryUsersRecord(
                  queryBuilder: (usersRecord) => usersRecord.whereIn(
                      'uid',
                      (currentUserDocument?.blockuser.toList() ?? [])
                          .map((e) => e.id)
                          .toList()),
                ),
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
                  List<UsersRecord> columnUsersRecordList = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(columnUsersRecordList.length,
                        (columnIndex) {
                      final columnUsersRecord =
                          columnUsersRecordList[columnIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (columnUsersRecord.reference !=
                                currentUserReference) {
                              context.appState.ActiveProfileUserPopup = true;
                              context.appState.userselect =
                                  columnUsersRecord.reference;
                              safeSetState(() {});
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 90.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF111111),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.network(
                                            '',
                                          ).image,
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(90.0),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  columnUsersRecord.photoUrl,
                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png',
                                                ),
                                                width: 65.0,
                                                height: 65.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          columnUsersRecord.displayName,
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
                                                fontSize: 16.0,
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
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 7.0, 0.0, 0.0),
                                          child: Text(
                                            columnUsersRecord.caption,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  color: Color(0xFF939393),
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
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await currentUserReference!.update({
                                        ...mapToSupabase(
                                          {
                                            'Blockuser': FieldValue.arrayRemove(
                                                [columnUsersRecord.reference]),
                                          },
                                        ),
                                      });

                                      await columnUsersRecord.reference.update({
                                        ...mapToSupabase(
                                          {
                                            'BlockEDuser':
                                                FieldValue.arrayRemove(
                                                    [currentUserReference]),
                                          },
                                        ),
                                      });

                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(),
                                      child: Icon(
                                        Icons.close_sharp,
                                        color: Theme.of(context)
                                            .extension<CustomColors>()!
                                            .primaryText,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
