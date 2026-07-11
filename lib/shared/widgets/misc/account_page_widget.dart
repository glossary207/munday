import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/core/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account_page_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'account_page_model.dart';

class AccountPageWidget extends ConsumerStatefulWidget {
  const AccountPageWidget({super.key});

  @override
  ConsumerState<AccountPageWidget> createState() => _AccountPageWidgetState();
}

class _AccountPageWidgetState extends ConsumerState<AccountPageWidget> {
  late AccountPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = AccountPageModel()..internalInit(context);

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Container(
              width: double.infinity,
              height: 20.0,
              decoration: BoxDecoration(
                color: Color(0xFF111111),
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
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        8.0,
                        0.0,
                        0.0,
                      ),
                      child: Container(
                        width: 40.0,
                        height: 3.5,
                        decoration: BoxDecoration(
                          color: Color(0xFF414141),
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.85,
            decoration: BoxDecoration(color: Color(0xFF111111)),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        10.0,
                        0.0,
                        0.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.k_1tuf3zdu,
                        style: Theme.of(context).textTheme.bodyMedium!.override(
                          font: GoogleFonts.openSans(
                            fontWeight: FontWeight.w500,
                            fontStyle: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.fontStyle,
                          ),
                          fontSize: 25.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.fontStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        5.0,
                        0.0,
                        5.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.k_thg66gfp,
                        style: Theme.of(context).textTheme.bodyMedium!.override(
                          font: GoogleFonts.openSans(
                            fontWeight: FontWeight.normal,
                            fontStyle: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.fontStyle,
                          ),
                          color: Color(0xFFB3B3B3),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.fontStyle,
                        ),
                      ),
                    ),
                    Divider(
                      height: 24.0,
                      thickness: 2.0,
                      color: Color(0xFF252525),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        0.0,
                        10.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              0.0,
                              0.0,
                              1.0,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.k_d2x52u28,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.fontWeight,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.fontStyle,
                                  ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  5.0,
                                  0.0,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.k_ky5kczto,
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge!.fontWeight,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge!.fontStyle,
                                        ),
                                        color: Color(0xFF888888),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.fontWeight,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            8.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF690000),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Color(0xFFFF0000),
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                12.0,
                                8.0,
                                12.0,
                                8.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://www.k-bigc.com/wp-content/uploads/2021/08/product982.jpg',
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_v0s1yakg,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    4.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_plpi8ac3,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontStyle,
                                                      ),
                                                      color: Color(0xFFB3B3B3),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontWeight,
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.k_iz8upluc,
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontWeight,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontWeight,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            8.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF111111),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Color(0xFF252525),
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                12.0,
                                8.0,
                                12.0,
                                8.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://www.k-bigc.com/wp-content/uploads/2021/08/product974.jpg',
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_1taykv9o,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    4.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_61koln9m,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontStyle,
                                                      ),
                                                      color: Color(0xFFB3B3B3),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontWeight,
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.k_gxtxed0h,
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontWeight,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontWeight,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            8.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF111111),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Color(0xFF252525),
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                12.0,
                                8.0,
                                12.0,
                                8.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://live.siammedia.org/wp-content/uploads/2021/04/CH3.jpg',
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_fopxh6ut,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    4.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_o45tq0eo,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontStyle,
                                                      ),
                                                      color: Color(0xFFB3B3B3),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontWeight,
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.k_6xd7h8om,
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontWeight,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontWeight,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            8.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF111111),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Color(0xFF252525),
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                12.0,
                                8.0,
                                12.0,
                                8.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://wishbeer.com/cdn/shop/products/NEW_CHANG_CLASS_CRTN_BOTT_320X24_FLEXO_preview-rev-1_600x600.png?v=1607305684',
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_ktst41ad,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    4.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_jr24icaw,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontStyle,
                                                      ),
                                                      color: Color(0xFFB3B3B3),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontWeight,
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.k_ivx746hh,
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontWeight,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontWeight,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            8.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF111111),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Color(0xFF252525),
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                12.0,
                                8.0,
                                12.0,
                                8.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://cdn.veluga.kr/drinks/0/main/2bdea498bf824cb89d491f44fd456f5e_5.png',
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_6qsq9emi,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontStyle,
                                                ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    4.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.k_tte3l895,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .fontStyle,
                                                      ),
                                                      color: Color(0xFFB3B3B3),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontWeight,
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.k_sw0y7mzx,
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontWeight,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontStyle,
                                          ),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.fontWeight,
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
                      ],
                    ),
                    Divider(
                      height: 24.0,
                      thickness: 2.0,
                      color: Color(0xFF252525),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        0.0,
                        10.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              0.0,
                              0.0,
                              1.0,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.k_6ld7endt,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.fontWeight,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.fontStyle,
                                  ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  5.0,
                                  0.0,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.k_uhdtdr8l,
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge!.fontWeight,
                                          fontStyle: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge!.fontStyle,
                                        ),
                                        color: Color(0xFF888888),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.fontWeight,
                                        fontStyle: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                          ),
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                10.0,
                                10.0,
                                10.0,
                                10.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        0.0,
                                        12.0,
                                        0.0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_y7p97833,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_p4wxhn1k,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .fontStyle,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4.0,
                                          ),
                                        ),
                                      ),
                                      unselectedWidgetColor: Color(0xFF6A6A6A),
                                    ),
                                    child: Checkbox(
                                      value: _model.checkboxValue1 ??= true,
                                      onChanged: (newValue) async {
                                        safeSetState(
                                          () =>
                                              _model.checkboxValue1 = newValue!,
                                        );
                                      },
                                      side: (Color(0xFF6A6A6A) != null)
                                          ? BorderSide(
                                              width: 2,
                                              color: Color(0xFF6A6A6A),
                                            )
                                          : null,
                                      activeColor: Color(0xFFD50606),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                          ),
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                10.0,
                                10.0,
                                10.0,
                                10.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        0.0,
                                        12.0,
                                        0.0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_8jyip9q8,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_m8saqwv0,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .fontStyle,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4.0,
                                          ),
                                        ),
                                      ),
                                      unselectedWidgetColor: Color(0xFF6A6A6A),
                                    ),
                                    child: Checkbox(
                                      value: _model.checkboxValue2 ??= true,
                                      onChanged: (newValue) async {
                                        safeSetState(
                                          () =>
                                              _model.checkboxValue2 = newValue!,
                                        );
                                      },
                                      side: (Color(0xFF6A6A6A) != null)
                                          ? BorderSide(
                                              width: 2,
                                              color: Color(0xFF6A6A6A),
                                            )
                                          : null,
                                      activeColor: Color(0xFFD50606),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                          ),
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                10.0,
                                10.0,
                                10.0,
                                10.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        0.0,
                                        12.0,
                                        0.0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_e74jcwol,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_h2eowim4,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .fontStyle,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4.0,
                                          ),
                                        ),
                                      ),
                                      unselectedWidgetColor: Color(0xFF6A6A6A),
                                    ),
                                    child: Checkbox(
                                      value: _model.checkboxValue3 ??= false,
                                      onChanged: (newValue) async {
                                        safeSetState(
                                          () =>
                                              _model.checkboxValue3 = newValue!,
                                        );
                                      },
                                      side: (Color(0xFF6A6A6A) != null)
                                          ? BorderSide(
                                              width: 2,
                                              color: Color(0xFF6A6A6A),
                                            )
                                          : null,
                                      activeColor: Color(0xFFD50606),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 24.0,
                      thickness: 2.0,
                      color: Color(0xFF252525),
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: Theme.of(context).textTheme.labelMedium!
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.labelMedium!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.labelMedium!.fontStyle,
                                ),
                                color: Color(0xFFB3B3B3),
                                letterSpacing: 0.0,
                                fontWeight: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.fontWeight,
                                fontStyle: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.fontStyle,
                              ),
                          hintText: AppLocalizations.of(context)!.k_2c0ttz1g,
                          hintStyle: Theme.of(context).textTheme.labelMedium!
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: Theme.of(
                                    context,
                                  ).textTheme.labelMedium!.fontWeight,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.labelMedium!.fontStyle,
                                ),
                                color: Color(0xFFB3B3B3),
                                letterSpacing: 0.0,
                                fontWeight: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.fontWeight,
                                fontStyle: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.fontStyle,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF1C1C1C),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFF050505),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium!.override(
                          font: GoogleFonts.openSans(
                            fontWeight: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.fontWeight,
                            fontStyle: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.fontWeight,
                          fontStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.fontStyle,
                        ),
                        maxLines: 3,
                        cursorColor: Theme.of(
                          context,
                        ).extension<CustomColors>()!.primaryText,
                        validator: _model.textControllerValidator.asValidator(
                          context,
                        ),
                      ),
                    ),
                  ].addToEnd(SizedBox(height: 250.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
