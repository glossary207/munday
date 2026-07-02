import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/shared/widgets/layout/header_appbar_menu_widget.dart';
import 'package:provider/provider.dart';
import '/backend/supabase/supabase_shim.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appbarmenu_copy_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'appbarmenu_copy_model.dart';

class AppbarmenuCopyWidget extends ConsumerStatefulWidget {
  const AppbarmenuCopyWidget({super.key});

  @override
  ConsumerState<AppbarmenuCopyWidget> createState() => _AppbarmenuCopyWidgetState();
}

class _AppbarmenuCopyWidgetState extends ConsumerState<AppbarmenuCopyWidget> {
  late AppbarmenuCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = AppbarmenuCopyModel()..internalInit(context);

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
    return Stack(
      children: [
        ChangeNotifierProvider.value(
          value: _model.headerAppbarMenuModel
              .setOnUpdate(onUpdate: () => safeSetState(() {})),
          child: HeaderAppbarMenuWidget(),
        ),
        Align(
          alignment: AlignmentDirectional(0.0, 1.0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.6,
            decoration: BoxDecoration(
              color: Color(0xFF111111),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
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
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 5.0),
                      child: Text(
                        AppLocalizations.of(context)!.k_4w7okaiq,
                        style: Theme.of(context).textTheme.bodyMedium!.override(
                              font: GoogleFonts.openSans(
                                fontWeight: FontWeight.w500,
                                fontStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .fontStyle,
                              ),
                              fontSize: 25.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.55,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 5.0),
                                child: Text(
                                  AppLocalizations.of(context)!.k_ccy14dp5,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight: FontWeight.normal,
                                          fontStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .fontStyle,
                                        ),
                                        color: Color(0xFFB3B3B3),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .fontStyle,
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
                                    0.0, 0.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 1.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .k_5t3fx476,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight: Theme.of(context)
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
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .k_w26z0txk,
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
                                                  color: Color(0xFF888888),
                                                  fontSize: 14.0,
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
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF690000),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Color(0xFFFF0000),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 8.0, 12.0, 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://www.k-bigc.com/wp-content/uploads/2021/08/product982.jpg',
                                                width: 40.0,
                                                height: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_li0i93h8,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .k_2i4emeiv,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFB3B3B3),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
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
                                              AppLocalizations.of(context)!
                                                  .k_nowa5wqq,
                                              textAlign: TextAlign.end,
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
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF111111),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Color(0xFF252525),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 8.0, 12.0, 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://www.k-bigc.com/wp-content/uploads/2021/08/product974.jpg',
                                                width: 40.0,
                                                height: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_lzlwyz5p,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .k_syd2fvo2,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFB3B3B3),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
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
                                              AppLocalizations.of(context)!
                                                  .k_uneymy43,
                                              textAlign: TextAlign.end,
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
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF111111),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Color(0xFF252525),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 8.0, 12.0, 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://live.siammedia.org/wp-content/uploads/2021/04/CH3.jpg',
                                                width: 40.0,
                                                height: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_roc84uh6,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .k_almm9ins,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFB3B3B3),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
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
                                              AppLocalizations.of(context)!
                                                  .k_jbn0op93,
                                              textAlign: TextAlign.end,
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
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF111111),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Color(0xFF252525),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 8.0, 12.0, 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://wishbeer.com/cdn/shop/products/NEW_CHANG_CLASS_CRTN_BOTT_320X24_FLEXO_preview-rev-1_600x600.png?v=1607305684',
                                                width: 40.0,
                                                height: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_ouyh24oe,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .k_ijkpx5mr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFB3B3B3),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
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
                                              AppLocalizations.of(context)!
                                                  .k_6vbc4toe,
                                              textAlign: TextAlign.end,
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
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF111111),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Color(0xFF252525),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 8.0, 12.0, 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://cdn.veluga.kr/drinks/0/main/2bdea498bf824cb89d491f44fd456f5e_5.png',
                                                width: 40.0,
                                                height: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_2racoy76,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .k_8xk87fm0,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFB3B3B3),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
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
                                              AppLocalizations.of(context)!
                                                  .k_i0gt64q8,
                                              textAlign: TextAlign.end,
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
                                                      fontStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
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
                                    0.0, 0.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 1.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .k_y4adjn7e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight: Theme.of(context)
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
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .k_gdgvi36s,
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
                                                  color: Color(0xFF888888),
                                                  fontSize: 14.0,
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
                                        0.0, 0.0, 0.0, 1.0),
                                    child: Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 12.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_2xcu1n0d,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_bpu0xdyl,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle: Theme.of(
                                                                    context)
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
                                                checkboxTheme:
                                                    CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                ),
                                                unselectedWidgetColor:
                                                    Color(0xFF6A6A6A),
                                              ),
                                              child: Checkbox(
                                                value: _model.checkboxValue1 ??=
                                                    true,
                                                onChanged: (newValue) async {
                                                  safeSetState(() =>
                                                      _model.checkboxValue1 =
                                                          newValue!);
                                                },
                                                side: (Color(0xFF6A6A6A) !=
                                                        null)
                                                    ? BorderSide(
                                                        width: 2,
                                                        color:
                                                            Color(0xFF6A6A6A),
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
                                        0.0, 0.0, 0.0, 1.0),
                                    child: Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 12.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_nrwvz2da,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_cs747arq,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle: Theme.of(
                                                                    context)
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
                                                checkboxTheme:
                                                    CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                ),
                                                unselectedWidgetColor:
                                                    Color(0xFF6A6A6A),
                                              ),
                                              child: Checkbox(
                                                value: _model.checkboxValue2 ??=
                                                    true,
                                                onChanged: (newValue) async {
                                                  safeSetState(() =>
                                                      _model.checkboxValue2 =
                                                          newValue!);
                                                },
                                                side: (Color(0xFF6A6A6A) !=
                                                        null)
                                                    ? BorderSide(
                                                        width: 2,
                                                        color:
                                                            Color(0xFF6A6A6A),
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
                                        0.0, 0.0, 0.0, 1.0),
                                    child: Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 12.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_90dh6gtj,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .k_7dbah7v6,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle: Theme.of(
                                                                    context)
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
                                                checkboxTheme:
                                                    CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                ),
                                                unselectedWidgetColor:
                                                    Color(0xFF6A6A6A),
                                              ),
                                              child: Checkbox(
                                                value: _model.checkboxValue3 ??=
                                                    false,
                                                onChanged: (newValue) async {
                                                  safeSetState(() =>
                                                      _model.checkboxValue3 =
                                                          newValue!);
                                                },
                                                side: (Color(0xFF6A6A6A) !=
                                                        null)
                                                    ? BorderSide(
                                                        width: 2,
                                                        color:
                                                            Color(0xFF6A6A6A),
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
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .fontWeight,
                                            fontStyle: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .fontStyle,
                                          ),
                                          color: Color(0xFFB3B3B3),
                                          letterSpacing: 0.0,
                                          fontWeight: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .fontWeight,
                                          fontStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .fontStyle,
                                        ),
                                    hintText: AppLocalizations.of(context)!
                                        .k_bpluj4b5,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .fontWeight,
                                            fontStyle: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .fontStyle,
                                          ),
                                          color: Color(0xFFB3B3B3),
                                          letterSpacing: 0.0,
                                          fontWeight: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .fontWeight,
                                          fontStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .fontStyle,
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
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFF050505),
                                  ),
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
                                  maxLines: 3,
                                  cursorColor: Theme.of(context)
                                      .extension<CustomColors>()!
                                      .primaryText,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ].addToEnd(SizedBox(height: 250.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Color(0xCC000000),
                          offset: Offset(
                            0.0,
                            -3.0,
                          ),
                          spreadRadius: 10.0,
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [Color(0xFF131313), Colors.black],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 16.0, 40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 5.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 5.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .k_i41sqnrr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .fontStyle,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
                                    child: Container(
                                      width: 140.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(90.0),
                                      ),
                                      child: Stack(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .k_x9dyn1hg,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              Theme.of(context)
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
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Container(
                                              width: 30.0,
                                              height: 30.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFF0000),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 1.0, 0.0, 0.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.white,
                                                    size: 18.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, 0.0),
                                            child: Container(
                                              width: 30.0,
                                              height: 30.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFF0000),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 1.0, 0.0, 0.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.plus,
                                                    color: Colors.white,
                                                    size: 18.0,
                                                  ),
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: MundayButton(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text:
                                      AppLocalizations.of(context)!.k_cobkynbg,
                                  icon: Icon(
                                    Icons.add,
                                    size: 15.0,
                                  ),
                                  options: MundayButtonOptions(
                                    width: double.infinity,
                                    height: 50.0,
                                    padding: EdgeInsets.all(0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor: Colors.white,
                                    color: Color(0xFFFF0000),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .fontWeight,
                                            fontStyle: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .fontWeight,
                                          fontStyle: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .fontStyle,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 12.0)),
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
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
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: 100.0,
            decoration: BoxDecoration(),
          ),
        ),
      ],
    );
  }
}
