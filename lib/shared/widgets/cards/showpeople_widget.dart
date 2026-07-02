import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/shared/widgets/dialogs/popupuser_widget.dart';
import '/core/utils/app_util.dart';
import '/core/utils/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'showpeople_model.dart';
import 'package:munday/core/theme/theme.dart';

class ShowpeopleWidget extends ConsumerStatefulWidget {
  const ShowpeopleWidget({super.key, required this.refdoc, required this.date});

  final SupabaseDocRef? refdoc;
  final DateTime? date;

  @override
  ConsumerState<ShowpeopleWidget> createState() => _ShowpeopleWidgetState();
}

class _ShowpeopleWidgetState extends ConsumerState<ShowpeopleWidget> {
  late ShowpeopleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = ShowpeopleModel()..internalInit(context);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, -1.0),
      child: StreamBuilder<UserInVenuesRecord>(
        stream: UserInVenuesRecord.getDocument(widget.refdoc!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF0000)),
                ),
              ),
            );
          }

          final gridViewUserInVenuesRecord = snapshot.data!;

          return Builder(
            builder: (context) {
              final datauser = gridViewUserInVenuesRecord.user
                  .where((e) => functions.checkdate((e as dynamic)?.date, widget.date)!)
                  .toList()
                  .map((e) => (e as dynamic)?.user)
                  .toList()
                  .sortedList(keyOf: (e) => e?.view, desc: false)
                  .toList();

              return RefreshIndicator(
                color: Colors.transparent,
                backgroundColor: Colors.transparent,
                onRefresh: () async {
                  safeSetState(() {});
                },
                child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.83,
                  ),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemCount: datauser.length,
                  itemBuilder: (context, datauserIndex) {
                    final datauserItem = datauser[datauserIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (datauserItem.userinstore != currentUserReference) {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: PopupuserWidget(
                                  offchat: false,
                                  show: false,
                                  listref: functions.addref1(
                                    gridViewUserInVenuesRecord.user
                                        .where(
                                          (e) => functions.checkdate(
                                            (e as dynamic)?.date,
                                            widget.date,
                                          )!,
                                        )
                                        .toList()
                                        .map((e) => (e as dynamic)?.user?.userinstore)
                                        .withoutNulls.toList().cast<SupabaseDocRef>(),
                                    datauserItem.userinstore,
                                  )!,
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));

                          context.appState.addToAddviewID(
                            datauserItem.userinstore!.id,
                          );
                          safeSetState(() {});
                          if (context.appState.addviewID.length > 5) {
                            await UpdateotheruserviewCall.call(
                              viewsList: context.appState.addviewID,
                            );

                            context.appState.addviewID = [];
                            context.appState.update(() {});
                          }
                        } else {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: PopupuserWidget(
                                  offchat: false,
                                  show: false,
                                  listref: functions.addref1(
                                    gridViewUserInVenuesRecord.user
                                        .where(
                                          (e) => functions.checkdate(
                                            (e as dynamic)?.date,
                                            widget.date,
                                          )!,
                                        )
                                        .toList()
                                        .map((e) => (e as dynamic)?.user?.userinstore)
                                        .withoutNulls.toList().cast<SupabaseDocRef>(),
                                    datauserItem.userinstore,
                                  )!,
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.17,
                              height: MediaQuery.sizeOf(context).width * 0.17,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(90.0),
                                      bottomRight: Radius.circular(90.0),
                                      topLeft: Radius.circular(90.0),
                                      topRight: Radius.circular(90.0),
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        datauserItem.photoprofile,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                      ),
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                6.0,
                                0.0,
                                20.0,
                              ),
                              child: Text(
                                valueOrDefault<String>(
                                  datauserItem.name,
                                  'ไม่ระบุ',
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
                                      fontSize: 10.0,
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
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
