import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
    Locale('zh'),
  ];

  /// No description provided for @k_1o27ut5s.
  ///
  /// In en, this message translates to:
  /// **'Search for user'**
  String get k_1o27ut5s;

  /// No description provided for @k_hxg0fy2b.
  ///
  /// In en, this message translates to:
  /// **'Latest Users'**
  String get k_hxg0fy2b;

  /// No description provided for @k_4v2upbkr.
  ///
  /// In en, this message translates to:
  /// **'Open Chat'**
  String get k_4v2upbkr;

  /// No description provided for @k_rm6x99oo.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_rm6x99oo;

  /// No description provided for @k_8ckfqaoi.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_8ckfqaoi;

  /// No description provided for @k_zy6vv0j5.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_zy6vv0j5;

  /// No description provided for @k_mtwb7kux.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get k_mtwb7kux;

  /// No description provided for @k_kmovo8pm.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_kmovo8pm;

  /// No description provided for @k_wkp4og0j.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get k_wkp4og0j;

  /// No description provided for @k_6ju9gvsj.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get k_6ju9gvsj;

  /// No description provided for @k_cy6tkoqn.
  ///
  /// In en, this message translates to:
  /// **'Your caption'**
  String get k_cy6tkoqn;

  /// No description provided for @k_f6ab0k03.
  ///
  /// In en, this message translates to:
  /// **'Profile preview'**
  String get k_f6ab0k03;

  /// No description provided for @k_eihlwqu6.
  ///
  /// In en, this message translates to:
  /// **'Name Instagram'**
  String get k_eihlwqu6;

  /// No description provided for @k_gqwxd6cb.
  ///
  /// In en, this message translates to:
  /// **'143.5 k'**
  String get k_gqwxd6cb;

  /// No description provided for @k_3589bxvt.
  ///
  /// In en, this message translates to:
  /// **'Facebook login ID'**
  String get k_3589bxvt;

  /// No description provided for @k_vl6gjvrd.
  ///
  /// In en, this message translates to:
  /// **'143.5 k'**
  String get k_vl6gjvrd;

  /// No description provided for @k_bn6ivwlz.
  ///
  /// In en, this message translates to:
  /// **'__'**
  String get k_bn6ivwlz;

  /// No description provided for @k_4dmtkxzc.
  ///
  /// In en, this message translates to:
  /// **'Online Chat Room'**
  String get k_4dmtkxzc;

  /// No description provided for @k_vmtn1rxv.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get k_vmtn1rxv;

  /// No description provided for @k_0xkfcss4.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get k_0xkfcss4;

  /// No description provided for @k_gpnbo7nu.
  ///
  /// In en, this message translates to:
  /// **'Enter your email...'**
  String get k_gpnbo7nu;

  /// No description provided for @k_szr0piqh.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get k_szr0piqh;

  /// No description provided for @k_orzhvtj0.
  ///
  /// In en, this message translates to:
  /// **'Enter your password...'**
  String get k_orzhvtj0;

  /// No description provided for @k_h1u9vi3l.
  ///
  /// In en, this message translates to:
  /// **'You agree to the acknowledge the'**
  String get k_h1u9vi3l;

  /// No description provided for @k_dcz85izi.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get k_dcz85izi;

  /// No description provided for @k_tpiawz92.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get k_tpiawz92;

  /// No description provided for @k_t9sqbre9.
  ///
  /// In en, this message translates to:
  /// **'Or sign up with'**
  String get k_t9sqbre9;

  /// No description provided for @k_uyv0vowy.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get k_uyv0vowy;

  /// No description provided for @k_05z2v5xy.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get k_05z2v5xy;

  /// No description provided for @k_6pm2klvz.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get k_6pm2klvz;

  /// No description provided for @k_pqvzdk1f.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get k_pqvzdk1f;

  /// No description provided for @k_ve4fd3yg.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get k_ve4fd3yg;

  /// No description provided for @k_hlqecs1a.
  ///
  /// In en, this message translates to:
  /// **'Enter your nickname...'**
  String get k_hlqecs1a;

  /// No description provided for @k_nbo1j458.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get k_nbo1j458;

  /// No description provided for @k_zegwzt1d.
  ///
  /// In en, this message translates to:
  /// **'Enter your email...'**
  String get k_zegwzt1d;

  /// No description provided for @k_wqxzevpm.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get k_wqxzevpm;

  /// No description provided for @k_2spsf6j4.
  ///
  /// In en, this message translates to:
  /// **'Enter your password...'**
  String get k_2spsf6j4;

  /// No description provided for @k_kcb3k2ox.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get k_kcb3k2ox;

  /// No description provided for @k_6sfr1rhd.
  ///
  /// In en, this message translates to:
  /// **'Enter your password...'**
  String get k_6sfr1rhd;

  /// No description provided for @k_aqzpd3sr.
  ///
  /// In en, this message translates to:
  /// **'You agree to the acknowledge the'**
  String get k_aqzpd3sr;

  /// No description provided for @k_ae7yssaw.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get k_ae7yssaw;

  /// No description provided for @k_53vetovi.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get k_53vetovi;

  /// No description provided for @k_41twzn6a.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_41twzn6a;

  /// No description provided for @k_jza53d0o.
  ///
  /// In en, this message translates to:
  /// **'You have 10 points.'**
  String get k_jza53d0o;

  /// No description provided for @k_ifexozan.
  ///
  /// In en, this message translates to:
  /// **'level :'**
  String get k_ifexozan;

  /// No description provided for @k_1lam8xke.
  ///
  /// In en, this message translates to:
  /// **'VVVIP'**
  String get k_1lam8xke;

  /// No description provided for @k_sx8oo1l5.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get k_sx8oo1l5;

  /// No description provided for @k_n9q37elg.
  ///
  /// In en, this message translates to:
  /// **'A78'**
  String get k_n9q37elg;

  /// No description provided for @k_89nb8pgs.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get k_89nb8pgs;

  /// No description provided for @k_zzwut81b.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_zzwut81b;

  /// No description provided for @k_bvjy4cxr.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_bvjy4cxr;

  /// No description provided for @k_zrv1h23o.
  ///
  /// In en, this message translates to:
  /// **'Online Chat Room'**
  String get k_zrv1h23o;

  /// No description provided for @k_s679s8bf.
  ///
  /// In en, this message translates to:
  /// **'Find people'**
  String get k_s679s8bf;

  /// No description provided for @k_95hbq33e.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get k_95hbq33e;

  /// No description provided for @k_nmf23spl.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get k_nmf23spl;

  /// No description provided for @k_7dqx0x2h.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get k_7dqx0x2h;

  /// No description provided for @k_l8eqk9pq.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get k_l8eqk9pq;

  /// No description provided for @k_gxdi3f2f.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get k_gxdi3f2f;

  /// No description provided for @k_c3ihn4ll.
  ///
  /// In en, this message translates to:
  /// **'SOHO Sigature'**
  String get k_c3ihn4ll;

  /// No description provided for @k_2ijyibzr.
  ///
  /// In en, this message translates to:
  /// **'SOHO is spicy'**
  String get k_2ijyibzr;

  /// No description provided for @k_wkacxyok.
  ///
  /// In en, this message translates to:
  /// **'beer'**
  String get k_wkacxyok;

  /// No description provided for @k_jd24thiw.
  ///
  /// In en, this message translates to:
  /// **'Soju'**
  String get k_jd24thiw;

  /// No description provided for @k_hydaiewz.
  ///
  /// In en, this message translates to:
  /// **'SOHO Signature'**
  String get k_hydaiewz;

  /// No description provided for @k_h7aigha6.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_h7aigha6;

  /// No description provided for @k_20jz9941.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_20jz9941;

  /// No description provided for @k_hka3eg74.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_hka3eg74;

  /// No description provided for @k_7mzxbnk8.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_7mzxbnk8;

  /// No description provided for @k_0zspz9jz.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_0zspz9jz;

  /// No description provided for @k_8gfoe3yr.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_8gfoe3yr;

  /// No description provided for @k_8r09trlg.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_8r09trlg;

  /// No description provided for @k_x9gjvmx0.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_x9gjvmx0;

  /// No description provided for @k_kbmfk8fb.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get k_kbmfk8fb;

  /// No description provided for @k_h5zmj9ni.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_h5zmj9ni;

  /// No description provided for @k_t6ieq3ei.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_t6ieq3ei;

  /// No description provided for @k_y32xdul9.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_y32xdul9;

  /// No description provided for @k_cz6xp9fo.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_cz6xp9fo;

  /// No description provided for @k_3ahooyxh.
  ///
  /// In en, this message translates to:
  /// **'SOHO is spicy'**
  String get k_3ahooyxh;

  /// No description provided for @k_lrh68n8q.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_lrh68n8q;

  /// No description provided for @k_br3pzi55.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_br3pzi55;

  /// No description provided for @k_8bb0vlf1.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_8bb0vlf1;

  /// No description provided for @k_he7h9ja5.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_he7h9ja5;

  /// No description provided for @k_axhfriq1.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_axhfriq1;

  /// No description provided for @k_ina1urn0.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_ina1urn0;

  /// No description provided for @k_v0aqh8ec.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_v0aqh8ec;

  /// No description provided for @k_a43vuqtp.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_a43vuqtp;

  /// No description provided for @k_2cd1vune.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_2cd1vune;

  /// No description provided for @k_r71bjun7.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_r71bjun7;

  /// No description provided for @k_xp6v8pyx.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_xp6v8pyx;

  /// No description provided for @k_u07ufrnd.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_u07ufrnd;

  /// No description provided for @k_0b8362q5.
  ///
  /// In en, this message translates to:
  /// **'SOJU'**
  String get k_0b8362q5;

  /// No description provided for @k_mjmzivy5.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_mjmzivy5;

  /// No description provided for @k_8bfn0gcf.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_8bfn0gcf;

  /// No description provided for @k_1av5niej.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_1av5niej;

  /// No description provided for @k_6bxywujx.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_6bxywujx;

  /// No description provided for @k_vv5dih4q.
  ///
  /// In en, this message translates to:
  /// **'9'**
  String get k_vv5dih4q;

  /// No description provided for @k_a69x38g0.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_a69x38g0;

  /// No description provided for @k_lrltctfx.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_lrltctfx;

  /// No description provided for @k_1pj155l0.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_1pj155l0;

  /// No description provided for @k_3o58br8y.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_3o58br8y;

  /// No description provided for @k_6p4hnzd2.
  ///
  /// In en, this message translates to:
  /// **'BEER'**
  String get k_6p4hnzd2;

  /// No description provided for @k_wrs8y16r.
  ///
  /// In en, this message translates to:
  /// **'Budweiser'**
  String get k_wrs8y16r;

  /// No description provided for @k_lu0f1jur.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_lu0f1jur;

  /// No description provided for @k_yy47n67q.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_yy47n67q;

  /// No description provided for @k_f6b4yj4k.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_f6b4yj4k;

  /// No description provided for @k_s5qrh9ui.
  ///
  /// In en, this message translates to:
  /// **'Chang'**
  String get k_s5qrh9ui;

  /// No description provided for @k_esyddpqt.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_esyddpqt;

  /// No description provided for @k_z9tti8vi.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_z9tti8vi;

  /// No description provided for @k_flhphdak.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_flhphdak;

  /// No description provided for @k_lugtyj44.
  ///
  /// In en, this message translates to:
  /// **'Heineken'**
  String get k_lugtyj44;

  /// No description provided for @k_bmp2ct9r.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_bmp2ct9r;

  /// No description provided for @k_whutjxis.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_whutjxis;

  /// No description provided for @k_9lui9235.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_9lui9235;

  /// No description provided for @k_50kpigt7.
  ///
  /// In en, this message translates to:
  /// **'Heineken'**
  String get k_50kpigt7;

  /// No description provided for @k_9x2oese4.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_9x2oese4;

  /// No description provided for @k_7ym9zp16.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_7ym9zp16;

  /// No description provided for @k_vn7gl7fc.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_vn7gl7fc;

  /// No description provided for @k_akpgxm0s.
  ///
  /// In en, this message translates to:
  /// **'Colona'**
  String get k_akpgxm0s;

  /// No description provided for @k_9hodobhf.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_9hodobhf;

  /// No description provided for @k_7k7z8fu7.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_7k7z8fu7;

  /// No description provided for @k_scwzxz88.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_scwzxz88;

  /// No description provided for @k_53y13stq.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get k_53y13stq;

  /// No description provided for @k_qmh6yd5j.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_qmh6yd5j;

  /// No description provided for @k_0a32enq7.
  ///
  /// In en, this message translates to:
  /// **'VVIP'**
  String get k_0a32enq7;

  /// No description provided for @k_jan7y48v.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_jan7y48v;

  /// No description provided for @k_67vpqajh.
  ///
  /// In en, this message translates to:
  /// **'A31'**
  String get k_67vpqajh;

  /// No description provided for @k_nsq5ypne.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_nsq5ypne;

  /// No description provided for @k_2xdxwvhh.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_2xdxwvhh;

  /// No description provided for @k_oa4jb8x0.
  ///
  /// In en, this message translates to:
  /// **'฿ 2,500'**
  String get k_oa4jb8x0;

  /// No description provided for @k_0fzvnm0i.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,500'**
  String get k_0fzvnm0i;

  /// No description provided for @k_d8rx3oht.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_d8rx3oht;

  /// No description provided for @k_c5e19q8a.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get k_c5e19q8a;

  /// No description provided for @k_pzu2mk3c.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_pzu2mk3c;

  /// No description provided for @k_xgb5c10h.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_xgb5c10h;

  /// No description provided for @k_y7bqz7se.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_y7bqz7se;

  /// No description provided for @k_bhswa6w6.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_bhswa6w6;

  /// No description provided for @k_o868lv4g.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,000'**
  String get k_o868lv4g;

  /// No description provided for @k_omo6k280.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_omo6k280;

  /// No description provided for @k_zgu7klph.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get k_zgu7klph;

  /// No description provided for @k_coke8r44.
  ///
  /// In en, this message translates to:
  /// **'฿ 500'**
  String get k_coke8r44;

  /// No description provided for @k_a7wsrjh8.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_a7wsrjh8;

  /// No description provided for @k_z1c4xn1e.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get k_z1c4xn1e;

  /// No description provided for @k_shq99fqr.
  ///
  /// In en, this message translates to:
  /// **'฿ 300'**
  String get k_shq99fqr;

  /// No description provided for @k_0pngncto.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_0pngncto;

  /// No description provided for @k_7wbou916.
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get k_7wbou916;

  /// No description provided for @k_6wdsan0b.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_6wdsan0b;

  /// No description provided for @k_c419ikq1.
  ///
  /// In en, this message translates to:
  /// **'C31'**
  String get k_c419ikq1;

  /// No description provided for @k_y2pex1lp.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_y2pex1lp;

  /// No description provided for @k_zl6jbews.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_zl6jbews;

  /// No description provided for @k_5os2reb5.
  ///
  /// In en, this message translates to:
  /// **'฿ Free'**
  String get k_5os2reb5;

  /// No description provided for @k_gabivqc0.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_gabivqc0;

  /// No description provided for @k_kbv179q0.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get k_kbv179q0;

  /// No description provided for @k_fhll1d2g.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_fhll1d2g;

  /// No description provided for @k_y6dte3q4.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_y6dte3q4;

  /// No description provided for @k_syvfu0z9.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_syvfu0z9;

  /// No description provided for @k_z1owagsh.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_z1owagsh;

  /// No description provided for @k_ry2h7926.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get k_ry2h7926;

  /// No description provided for @k_sxhp3nkh.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get k_sxhp3nkh;

  /// No description provided for @k_zozupo7c.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_zozupo7c;

  /// No description provided for @k_kcxm5sm8.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_kcxm5sm8;

  /// No description provided for @k_clujchkv.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get k_clujchkv;

  /// No description provided for @k_0dgp04cp.
  ///
  /// In en, this message translates to:
  /// **'PANK'**
  String get k_0dgp04cp;

  /// No description provided for @k_a314cm4r.
  ///
  /// In en, this message translates to:
  /// **'PUK_66'**
  String get k_a314cm4r;

  /// No description provided for @k_53lbeu8e.
  ///
  /// In en, this message translates to:
  /// **'Booking Conditions Daily Booking Conditions  We only accept students and office workers. Please dress appropriately. ⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️  ❗️Booking Fee: 500 baht per queue. ❗Fully refunded upon table pick-up. ❗️Maximum 20 people per table. ❗️Book 30 days in advance. ❗️Bookings close at 4:00 PM.  Queue Release Conditions: ❗️Tables release at 9:00 PM for Sunday-Thursday❗️ ❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️  **If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏'**
  String get k_53lbeu8e;

  /// No description provided for @k_220hsncj.
  ///
  /// In en, this message translates to:
  /// **'Let\\'**
  String get k_220hsncj;

  /// No description provided for @k_qlbe2u09.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_qlbe2u09;

  /// No description provided for @k_7pvmel5f.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get k_7pvmel5f;

  /// No description provided for @k_ds3pryja.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get k_ds3pryja;

  /// No description provided for @k_mpdkrpd2.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get k_mpdkrpd2;

  /// No description provided for @k_ppvcpis6.
  ///
  /// In en, this message translates to:
  /// **'languages'**
  String get k_ppvcpis6;

  /// No description provided for @k_rva4ipva.
  ///
  /// In en, this message translates to:
  /// **'Vertical Display'**
  String get k_rva4ipva;

  /// No description provided for @k_hageibjl.
  ///
  /// In en, this message translates to:
  /// **'Showdisplay Horizontal'**
  String get k_hageibjl;

  /// No description provided for @k_hj4c6tri.
  ///
  /// In en, this message translates to:
  /// **'Block list'**
  String get k_hj4c6tri;

  /// No description provided for @k_6adcjh05.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get k_6adcjh05;

  /// No description provided for @k_ip7gorf2.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get k_ip7gorf2;

  /// No description provided for @k_88720ul7.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_88720ul7;

  /// No description provided for @k_5tsyrm42.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy   ==============  Last updated: February 01, 2024  This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.  We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of Termsfeed.com  Interpretation and Definitions   ------------------------------  Interpretation   ~~~~~~~~~~~~~~  The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.  Definitions   ~~~~~~~~~~~  For the purposes of this Privacy Policy:    * Account means a unique account created for You to access our Service or     parts of our Service.    * Affiliate means an entity that controls, is controlled by or is under     common control with a party, where \\\"control\\\" means ownership of 50% or     more of the shares, equity interest or other securities entitled to vote     for election of directors or other managing authority.    * Company (referred to as either \\\"the Company\\\", \\\"We\\\", \\\"Us\\\" or \\\"Our\\\" in this     Agreement) refers to MUNDAY.    * Cookies are small files that are placed on Your computer, mobile device or     any other device by a website, containing the details of Your browsing     history on that website among its many uses.    * Country refers to: Thailand    * Device means any device that can access the Service such as a computer, a     cellphone or a digital tablet.    * Personal Data is any information that relates to an identified or     identifiable individual.    * Service refers to the Website.    * Service Provider means any natural or legal person who processes the data     on behalf of the Company. It refers to third-party companies or     individuals employed by the Company to facilitate the Service, to provide     the Service on behalf of the Company, to perform services related to the     Service or to assist the Company in analyzing how the Service is used.    * Third-party Social Media Service refers to any website or any social     network website through which a User can log in or create an account to     use the Service.    * Usage Data refers to data collected automatically, either generated by the     use of the Service or from the Service infrastructure itself (for example,     the duration of a page visit).    * Website refers to MUNDAY, accessible from mun-day.com    * You means the individual accessing or using the Service, or the company,     or other legal entity on behalf of which such individual is accessing or     using the Service, as applicable.  Collecting and Using Your Personal Data   ---------------------------------------  Types of Data Collected   ~~~~~~~~~~~~~~~~~~~~~~~  Personal Data   *************  While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:    * Email address    * Usage Data  Usage Data   **********  Usage Data is collected automatically when using the Service.  Usage Data may include information such as Your Device\\'**
  String get k_5tsyrm42;

  /// No description provided for @k_ol9f5363.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get k_ol9f5363;

  /// No description provided for @k_nyr91ho1.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_nyr91ho1;

  /// No description provided for @k_6q9pqn76.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get k_6q9pqn76;

  /// No description provided for @k_eti5mtll.
  ///
  /// In en, this message translates to:
  /// **'Email: info.mundayapp@gmail.com'**
  String get k_eti5mtll;

  /// No description provided for @k_f42ba7ou.
  ///
  /// In en, this message translates to:
  /// **'Line: @munday'**
  String get k_f42ba7ou;

  /// No description provided for @k_w7c5dn9i.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get k_w7c5dn9i;

  /// No description provided for @k_xdep69mw.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_xdep69mw;

  /// No description provided for @k_5unxb279.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get k_5unxb279;

  /// No description provided for @k_jt1i4wyn.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get k_jt1i4wyn;

  /// No description provided for @k_qtjmhbfx.
  ///
  /// In en, this message translates to:
  /// **'We will send you an email with a link to reset your password, please enter the email associated with your account below.'**
  String get k_qtjmhbfx;

  /// No description provided for @k_24n18xzp.
  ///
  /// In en, this message translates to:
  /// **'Your email address...'**
  String get k_24n18xzp;

  /// No description provided for @k_55v2evrj.
  ///
  /// In en, this message translates to:
  /// **'Enter your email...'**
  String get k_55v2evrj;

  /// No description provided for @k_dslb6q52.
  ///
  /// In en, this message translates to:
  /// **'Send Link'**
  String get k_dslb6q52;

  /// No description provided for @k_dl303af0.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get k_dl303af0;

  /// No description provided for @k_jgaiuo1f.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_jgaiuo1f;

  /// No description provided for @k_6ipk5727.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_6ipk5727;

  /// No description provided for @k_gywtp2u9.
  ///
  /// In en, this message translates to:
  /// **'Block list'**
  String get k_gywtp2u9;

  /// No description provided for @k_duz479wu.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_duz479wu;

  /// No description provided for @k_ae0ej04b.
  ///
  /// In en, this message translates to:
  /// **'Community Night Party'**
  String get k_ae0ej04b;

  /// No description provided for @k_b29lklz7.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get k_b29lklz7;

  /// No description provided for @k_toger6ar.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get k_toger6ar;

  /// No description provided for @k_8luef2oj.
  ///
  /// In en, this message translates to:
  /// **'Enter your email...'**
  String get k_8luef2oj;

  /// No description provided for @k_ayg4l2lc.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get k_ayg4l2lc;

  /// No description provided for @k_ak6ywz2g.
  ///
  /// In en, this message translates to:
  /// **'Enter your password...'**
  String get k_ak6ywz2g;

  /// No description provided for @k_9a6cw689.
  ///
  /// In en, this message translates to:
  /// **'You agree to the acknowledge the'**
  String get k_9a6cw689;

  /// No description provided for @k_3w4l8lir.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get k_3w4l8lir;

  /// No description provided for @k_83yh8myq.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get k_83yh8myq;

  /// No description provided for @k_ur28kqq5.
  ///
  /// In en, this message translates to:
  /// **'Or sign up with'**
  String get k_ur28kqq5;

  /// No description provided for @k_vivm12g9.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get k_vivm12g9;

  /// No description provided for @k_vykvvchk.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get k_vykvvchk;

  /// No description provided for @k_xho00c8d.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get k_xho00c8d;

  /// No description provided for @k_i80k6h0x.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get k_i80k6h0x;

  /// No description provided for @k_d88s0zgt.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get k_d88s0zgt;

  /// No description provided for @k_r8q69s0j.
  ///
  /// In en, this message translates to:
  /// **'Enter your nickname...'**
  String get k_r8q69s0j;

  /// No description provided for @k_6gx7adqi.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get k_6gx7adqi;

  /// No description provided for @k_jwa3og5p.
  ///
  /// In en, this message translates to:
  /// **'Enter your email...'**
  String get k_jwa3og5p;

  /// No description provided for @k_yshyzboh.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get k_yshyzboh;

  /// No description provided for @k_ugubc4jh.
  ///
  /// In en, this message translates to:
  /// **'Enter your password...'**
  String get k_ugubc4jh;

  /// No description provided for @k_girjygmd.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get k_girjygmd;

  /// No description provided for @k_kywolpk5.
  ///
  /// In en, this message translates to:
  /// **'Enter your password...'**
  String get k_kywolpk5;

  /// No description provided for @k_bumlzs2y.
  ///
  /// In en, this message translates to:
  /// **'You agree to the acknowledge the'**
  String get k_bumlzs2y;

  /// No description provided for @k_oig6fkry.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get k_oig6fkry;

  /// No description provided for @k_6u91e20k.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get k_6u91e20k;

  /// No description provided for @k_592ek084.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_592ek084;

  /// No description provided for @k_v8x293bi.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_v8x293bi;

  /// No description provided for @k_nsfmdrd0.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get k_nsfmdrd0;

  /// No description provided for @k_vm5iljxq.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get k_vm5iljxq;

  /// No description provided for @k_cdj1gcwr.
  ///
  /// In en, this message translates to:
  /// **'Shop layout'**
  String get k_cdj1gcwr;

  /// No description provided for @k_wpv7p399.
  ///
  /// In en, this message translates to:
  /// **'other'**
  String get k_wpv7p399;

  /// No description provided for @k_y426u6mw.
  ///
  /// In en, this message translates to:
  /// **'pub'**
  String get k_y426u6mw;

  /// No description provided for @k_b2dksnid.
  ///
  /// In en, this message translates to:
  /// **'bar'**
  String get k_b2dksnid;

  /// No description provided for @k_5lg3q8vz.
  ///
  /// In en, this message translates to:
  /// **'Sit and chill'**
  String get k_5lg3q8vz;

  /// No description provided for @k_axxg89b0.
  ///
  /// In en, this message translates to:
  /// **'Beer garden'**
  String get k_axxg89b0;

  /// No description provided for @k_faqekyeu.
  ///
  /// In en, this message translates to:
  /// **'Events for you'**
  String get k_faqekyeu;

  /// No description provided for @k_9ksqi8gl.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_9ksqi8gl;

  /// No description provided for @k_8wo43ybd.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_8wo43ybd;

  /// No description provided for @k_z11k2yxp.
  ///
  /// In en, this message translates to:
  /// **'Shop for you'**
  String get k_z11k2yxp;

  /// No description provided for @k_yids60ee.
  ///
  /// In en, this message translates to:
  /// **'Pub'**
  String get k_yids60ee;

  /// No description provided for @k_87a74d13.
  ///
  /// In en, this message translates to:
  /// **'LiveMusic'**
  String get k_87a74d13;

  /// No description provided for @k_ef5snpoq.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_ef5snpoq;

  /// No description provided for @k_f7mjf40s.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_f7mjf40s;

  /// No description provided for @k_f98dkc1b.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_f98dkc1b;

  /// No description provided for @k_sf7y15sd.
  ///
  /// In en, this message translates to:
  /// **'No Events Today'**
  String get k_sf7y15sd;

  /// No description provided for @k_z4axt11t.
  ///
  /// In en, this message translates to:
  /// **'Please reschedule or change the location if more information is needed.'**
  String get k_z4axt11t;

  /// No description provided for @k_wgbetsw7.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get k_wgbetsw7;

  /// No description provided for @k_gfa27afd.
  ///
  /// In en, this message translates to:
  /// **'Another Day'**
  String get k_gfa27afd;

  /// No description provided for @k_27dxtl2j.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_27dxtl2j;

  /// No description provided for @k_3fd0zq8r.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_3fd0zq8r;

  /// No description provided for @k_l73fai7v.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get k_l73fai7v;

  /// No description provided for @k_hf127elb.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_hf127elb;

  /// No description provided for @k_5am4kqpc.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_5am4kqpc;

  /// No description provided for @k_zsbddjf5.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get k_zsbddjf5;

  /// No description provided for @k_z1r3or6y.
  ///
  /// In en, this message translates to:
  /// **'Search this area'**
  String get k_z1r3or6y;

  /// No description provided for @k_djg788wu.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_djg788wu;

  /// No description provided for @k_cbd0lvds.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_cbd0lvds;

  /// No description provided for @k_ebkvitz2.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get k_ebkvitz2;

  /// No description provided for @k_16vbnwxq.
  ///
  /// In en, this message translates to:
  /// **'No Events Today'**
  String get k_16vbnwxq;

  /// No description provided for @k_jxcp0zzg.
  ///
  /// In en, this message translates to:
  /// **'Please reschedule or change the location if more information is needed.'**
  String get k_jxcp0zzg;

  /// No description provided for @k_twcppxxh.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get k_twcppxxh;

  /// No description provided for @k_glanqxhx.
  ///
  /// In en, this message translates to:
  /// **'Don Mueang, Songprapa'**
  String get k_glanqxhx;

  /// No description provided for @k_8in2y4rt.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get k_8in2y4rt;

  /// No description provided for @k_adc3yo98.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get k_adc3yo98;

  /// No description provided for @k_x0xmiqba.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get k_x0xmiqba;

  /// No description provided for @k_k93w5ytl.
  ///
  /// In en, this message translates to:
  /// **'Artist name'**
  String get k_k93w5ytl;

  /// No description provided for @k_58xy52fz.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get k_58xy52fz;

  /// No description provided for @k_kc51jfwx.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_kc51jfwx;

  /// No description provided for @k_psht3tot.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get k_psht3tot;

  /// No description provided for @k_3b91k8ff.
  ///
  /// In en, this message translates to:
  /// **'-'**
  String get k_3b91k8ff;

  /// No description provided for @k_3t9g2w44.
  ///
  /// In en, this message translates to:
  /// **'2000฿'**
  String get k_3t9g2w44;

  /// No description provided for @k_eajhhuhm.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_eajhhuhm;

  /// No description provided for @k_sas13dus.
  ///
  /// In en, this message translates to:
  /// **'No Venues'**
  String get k_sas13dus;

  /// No description provided for @k_x4tfqa1w.
  ///
  /// In en, this message translates to:
  /// **'Please reschedule or change the location if more information is needed.'**
  String get k_x4tfqa1w;

  /// No description provided for @k_bzok1v08.
  ///
  /// In en, this message translates to:
  /// **'Pub'**
  String get k_bzok1v08;

  /// No description provided for @k_40wk9ahf.
  ///
  /// In en, this message translates to:
  /// **'LiveMusic'**
  String get k_40wk9ahf;

  /// No description provided for @k_64vssocb.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_64vssocb;

  /// No description provided for @k_uspi5h7x.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_uspi5h7x;

  /// No description provided for @k_llm1xn4n.
  ///
  /// In en, this message translates to:
  /// **'Search this area'**
  String get k_llm1xn4n;

  /// No description provided for @k_x1d4qe53.
  ///
  /// In en, this message translates to:
  /// **'Pub'**
  String get k_x1d4qe53;

  /// No description provided for @k_463p001w.
  ///
  /// In en, this message translates to:
  /// **'LiveMusic'**
  String get k_463p001w;

  /// No description provided for @k_v2gfpxfo.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_v2gfpxfo;

  /// No description provided for @k_p5358ybs.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_p5358ybs;

  /// No description provided for @k_a9sq8iz0.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_a9sq8iz0;

  /// No description provided for @k_kgh2do3h.
  ///
  /// In en, this message translates to:
  /// **'Don Mueang, Songprapa'**
  String get k_kgh2do3h;

  /// No description provided for @k_nvcmanls.
  ///
  /// In en, this message translates to:
  /// **'Venues'**
  String get k_nvcmanls;

  /// No description provided for @k_pmv6w9qo.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get k_pmv6w9qo;

  /// No description provided for @k_j9qedsry.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get k_j9qedsry;

  /// No description provided for @k_wtlekh8b.
  ///
  /// In en, this message translates to:
  /// **'Find a store'**
  String get k_wtlekh8b;

  /// No description provided for @k_9v2v1ujq.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_9v2v1ujq;

  /// No description provided for @k_1a1uvhwd.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_1a1uvhwd;

  /// No description provided for @k_j4x9ooi5.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_j4x9ooi5;

  /// No description provided for @k_2bv6uviu.
  ///
  /// In en, this message translates to:
  /// **'Don Mueang, Songprapa'**
  String get k_2bv6uviu;

  /// No description provided for @k_k71hd6bj.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get k_k71hd6bj;

  /// No description provided for @k_nhgg0eae.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get k_nhgg0eae;

  /// No description provided for @k_50bt8hhj.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get k_50bt8hhj;

  /// No description provided for @k_ez53ir4h.
  ///
  /// In en, this message translates to:
  /// **'Shop name'**
  String get k_ez53ir4h;

  /// No description provided for @k_o4wwef6a.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get k_o4wwef6a;

  /// No description provided for @k_w7vyug83.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_w7vyug83;

  /// No description provided for @k_555r3j0f.
  ///
  /// In en, this message translates to:
  /// **'No Promotion'**
  String get k_555r3j0f;

  /// No description provided for @k_cbaj3ek2.
  ///
  /// In en, this message translates to:
  /// **'Please reschedule or change the location if more information is needed.'**
  String get k_cbaj3ek2;

  /// No description provided for @k_3vjcbwd5.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_3vjcbwd5;

  /// No description provided for @k_kwswtvn9.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get k_kwswtvn9;

  /// No description provided for @k_phyd3j8s.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get k_phyd3j8s;

  /// No description provided for @k_cywub16n.
  ///
  /// In en, this message translates to:
  /// **'Search this area'**
  String get k_cywub16n;

  /// No description provided for @k_sf7p9ehg.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_sf7p9ehg;

  /// No description provided for @k_fxsoj2vd.
  ///
  /// In en, this message translates to:
  /// **'No Promotion'**
  String get k_fxsoj2vd;

  /// No description provided for @k_ijdk14y1.
  ///
  /// In en, this message translates to:
  /// **'Please reschedule or change the location if more information is needed.'**
  String get k_ijdk14y1;

  /// No description provided for @k_vh5d6o63.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_vh5d6o63;

  /// No description provided for @k_znwljmuz.
  ///
  /// In en, this message translates to:
  /// **'PUB'**
  String get k_znwljmuz;

  /// No description provided for @k_5yp7ypsm.
  ///
  /// In en, this message translates to:
  /// **'Hiphop'**
  String get k_5yp7ypsm;

  /// No description provided for @k_8ueny3ds.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_8ueny3ds;

  /// No description provided for @k_203t8lnr.
  ///
  /// In en, this message translates to:
  /// **'cars'**
  String get k_203t8lnr;

  /// No description provided for @k_we9kgu84.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get k_we9kgu84;

  /// No description provided for @k_kd32zbfm.
  ///
  /// In en, this message translates to:
  /// **'100'**
  String get k_kd32zbfm;

  /// No description provided for @k_bpvwlxqt.
  ///
  /// In en, this message translates to:
  /// **'+'**
  String get k_bpvwlxqt;

  /// No description provided for @k_17ibcz68.
  ///
  /// In en, this message translates to:
  /// **'Link Contact'**
  String get k_17ibcz68;

  /// No description provided for @k_d98iv601.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_d98iv601;

  /// No description provided for @k_z0ulu30f.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get k_z0ulu30f;

  /// No description provided for @k_nfc8d6s8.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_nfc8d6s8;

  /// No description provided for @k_ru3pw87v.
  ///
  /// In en, this message translates to:
  /// **'No Events'**
  String get k_ru3pw87v;

  /// No description provided for @k_ff7cf9o6.
  ///
  /// In en, this message translates to:
  /// **'Sorry, we don\\'**
  String get k_ff7cf9o6;

  /// No description provided for @k_l41wx1tf.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get k_l41wx1tf;

  /// No description provided for @k_ufk1gvu8.
  ///
  /// In en, this message translates to:
  /// **'No Promotion'**
  String get k_ufk1gvu8;

  /// No description provided for @k_9v0vv7rb.
  ///
  /// In en, this message translates to:
  /// **'Sorry, we don\\'**
  String get k_9v0vv7rb;

  /// No description provided for @k_jo5htnm4.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get k_jo5htnm4;

  /// No description provided for @k_5fy6v03b.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get k_5fy6v03b;

  /// No description provided for @k_msgdr2kn.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get k_msgdr2kn;

  /// No description provided for @k_rxpcsy4y.
  ///
  /// In en, this message translates to:
  /// **'Halloween'**
  String get k_rxpcsy4y;

  /// No description provided for @k_3mbf3ujq.
  ///
  /// In en, this message translates to:
  /// **'2 people'**
  String get k_3mbf3ujq;

  /// No description provided for @k_6z9zg4yc.
  ///
  /// In en, this message translates to:
  /// **'99'**
  String get k_6z9zg4yc;

  /// No description provided for @k_nawxs7oi.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_nawxs7oi;

  /// No description provided for @k_vqonn8mz.
  ///
  /// In en, this message translates to:
  /// **'Big promotion'**
  String get k_vqonn8mz;

  /// No description provided for @k_mh90obeb.
  ///
  /// In en, this message translates to:
  /// **'Liquor promotion'**
  String get k_mh90obeb;

  /// No description provided for @k_8eiogcop.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_8eiogcop;

  /// No description provided for @k_eosk366z.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_eosk366z;

  /// No description provided for @k_tt381dwt.
  ///
  /// In en, this message translates to:
  /// **'birthday'**
  String get k_tt381dwt;

  /// No description provided for @k_8ww8v0t5.
  ///
  /// In en, this message translates to:
  /// **'5 people came'**
  String get k_8ww8v0t5;

  /// No description provided for @k_cs9oms2v.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_cs9oms2v;

  /// No description provided for @k_j3pfoanq.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_j3pfoanq;

  /// No description provided for @k_vamjb92x.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_vamjb92x;

  /// No description provided for @k_l5csrspf.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_l5csrspf;

  /// No description provided for @k_h7vgc50h.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_h7vgc50h;

  /// No description provided for @k_2ron4yx3.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get k_2ron4yx3;

  /// No description provided for @k_e4fx9nlv.
  ///
  /// In en, this message translates to:
  /// **'join room'**
  String get k_e4fx9nlv;

  /// No description provided for @k_ajawujz7.
  ///
  /// In en, this message translates to:
  /// **'Booking Tables'**
  String get k_ajawujz7;

  /// No description provided for @k_4cfjxu9d.
  ///
  /// In en, this message translates to:
  /// **'invite'**
  String get k_4cfjxu9d;

  /// No description provided for @k_f56db5sz.
  ///
  /// In en, this message translates to:
  /// **'Going'**
  String get k_f56db5sz;

  /// No description provided for @k_ifymhz2z.
  ///
  /// In en, this message translates to:
  /// **'Maybe'**
  String get k_ifymhz2z;

  /// No description provided for @k_gkhwh8ji.
  ///
  /// In en, this message translates to:
  /// **'Not Going'**
  String get k_gkhwh8ji;

  /// No description provided for @k_3kzdm2df.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get k_3kzdm2df;

  /// No description provided for @k_ffx98bbd.
  ///
  /// In en, this message translates to:
  /// **'Change store'**
  String get k_ffx98bbd;

  /// No description provided for @k_dvgerlhc.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get k_dvgerlhc;

  /// No description provided for @k_eo1pf729.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get k_eo1pf729;

  /// No description provided for @k_f0jkfy7q.
  ///
  /// In en, this message translates to:
  /// **'Booking Tables'**
  String get k_f0jkfy7q;

  /// No description provided for @k_l53tynrs.
  ///
  /// In en, this message translates to:
  /// **'Group Chat'**
  String get k_l53tynrs;

  /// No description provided for @k_3yxqhkts.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_3yxqhkts;

  /// No description provided for @k_akurgq59.
  ///
  /// In en, this message translates to:
  /// **'Congrats!'**
  String get k_akurgq59;

  /// No description provided for @k_19sjwccm.
  ///
  /// In en, this message translates to:
  /// **'Thanks for taking the quiz.'**
  String get k_19sjwccm;

  /// No description provided for @k_vjy12zui.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get k_vjy12zui;

  /// No description provided for @k_xozbz4je.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_xozbz4je;

  /// No description provided for @k_vlfp2539.
  ///
  /// In en, this message translates to:
  /// **'Hello World'**
  String get k_vlfp2539;

  /// No description provided for @k_dsvu1hgf.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_dsvu1hgf;

  /// No description provided for @k_bmpazhfc.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_bmpazhfc;

  /// No description provided for @k_qyq9eqlq.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_qyq9eqlq;

  /// No description provided for @k_2jto5pmm.
  ///
  /// In en, this message translates to:
  /// **'78'**
  String get k_2jto5pmm;

  /// No description provided for @k_ceawiqto.
  ///
  /// In en, this message translates to:
  /// **'How many people?'**
  String get k_ceawiqto;

  /// No description provided for @k_lvdm945o.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get k_lvdm945o;

  /// No description provided for @k_8qw5vun8.
  ///
  /// In en, this message translates to:
  /// **'Choose your table'**
  String get k_8qw5vun8;

  /// No description provided for @k_pzvbgoye.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get k_pzvbgoye;

  /// No description provided for @k_2qtlmdak.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get k_2qtlmdak;

  /// No description provided for @k_v9zgpa2n.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get k_v9zgpa2n;

  /// No description provided for @k_0zr7w5mx.
  ///
  /// In en, this message translates to:
  /// **'PAY'**
  String get k_0zr7w5mx;

  /// No description provided for @k_sm8zt9mj.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_sm8zt9mj;

  /// No description provided for @k_um0tzanu.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_um0tzanu;

  /// No description provided for @k_ms688xec.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_ms688xec;

  /// No description provided for @k_q5fl9it3.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_q5fl9it3;

  /// No description provided for @k_fo4qjvz8.
  ///
  /// In en, this message translates to:
  /// **'Booking Conditions Daily Booking Conditions  We only accept students and office workers. Please dress appropriately. ⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️  ❗️Booking Fee: 500 baht per queue. ❗Fully refunded upon table pick-up. ❗️Maximum 20 people per table. ❗️Book 30 days in advance. ❗️Bookings close at 4:00 PM.  Queue Release Conditions: ❗️Tables release at 9:00 PM for Sunday-Thursday❗️ ❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️  **If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏'**
  String get k_fo4qjvz8;

  /// No description provided for @k_pn3wac0c.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get k_pn3wac0c;

  /// No description provided for @k_euoa19dw.
  ///
  /// In en, this message translates to:
  /// **'Tickets list'**
  String get k_euoa19dw;

  /// No description provided for @k_utzl4v9d.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_utzl4v9d;

  /// No description provided for @k_pp45zg7u.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_pp45zg7u;

  /// No description provided for @k_zl6cyp0w.
  ///
  /// In en, this message translates to:
  /// **'Select Table'**
  String get k_zl6cyp0w;

  /// No description provided for @k_dy9gu5p1.
  ///
  /// In en, this message translates to:
  /// **'Your Tickets'**
  String get k_dy9gu5p1;

  /// No description provided for @k_4des514z.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_4des514z;

  /// No description provided for @k_b4pc5eeq.
  ///
  /// In en, this message translates to:
  /// **'VVIP'**
  String get k_b4pc5eeq;

  /// No description provided for @k_xf0pjhr5.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_xf0pjhr5;

  /// No description provided for @k_39iwpxhc.
  ///
  /// In en, this message translates to:
  /// **'A31'**
  String get k_39iwpxhc;

  /// No description provided for @k_qsxwdzjs.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_qsxwdzjs;

  /// No description provided for @k_75j6wza8.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_75j6wza8;

  /// No description provided for @k_incqu7ni.
  ///
  /// In en, this message translates to:
  /// **'฿ 2,500'**
  String get k_incqu7ni;

  /// No description provided for @k_6z1g905j.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,500'**
  String get k_6z1g905j;

  /// No description provided for @k_7pxafyej.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_7pxafyej;

  /// No description provided for @k_triic0tj.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get k_triic0tj;

  /// No description provided for @k_f6rcpgao.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_f6rcpgao;

  /// No description provided for @k_6o9r564w.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_6o9r564w;

  /// No description provided for @k_onlyzhuu.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_onlyzhuu;

  /// No description provided for @k_46ld0x0r.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_46ld0x0r;

  /// No description provided for @k_b5zdps8w.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,000'**
  String get k_b5zdps8w;

  /// No description provided for @k_ckldbpe2.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_ckldbpe2;

  /// No description provided for @k_vdk5ujss.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get k_vdk5ujss;

  /// No description provided for @k_stf94dvd.
  ///
  /// In en, this message translates to:
  /// **'฿ 500'**
  String get k_stf94dvd;

  /// No description provided for @k_dol4vivl.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_dol4vivl;

  /// No description provided for @k_f5zj3cbu.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get k_f5zj3cbu;

  /// No description provided for @k_uyk8szzk.
  ///
  /// In en, this message translates to:
  /// **'฿ 300'**
  String get k_uyk8szzk;

  /// No description provided for @k_yavq9jpy.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_yavq9jpy;

  /// No description provided for @k_9t0uxohd.
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get k_9t0uxohd;

  /// No description provided for @k_th3wrju8.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_th3wrju8;

  /// No description provided for @k_aw8qx9xu.
  ///
  /// In en, this message translates to:
  /// **'C31'**
  String get k_aw8qx9xu;

  /// No description provided for @k_oyyp5zzz.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_oyyp5zzz;

  /// No description provided for @k_dyqvszfp.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_dyqvszfp;

  /// No description provided for @k_zf2xwvnz.
  ///
  /// In en, this message translates to:
  /// **'฿ Free'**
  String get k_zf2xwvnz;

  /// No description provided for @k_64igi5he.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_64igi5he;

  /// No description provided for @k_9msn8ey3.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get k_9msn8ey3;

  /// No description provided for @k_nd22qcfs.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_nd22qcfs;

  /// No description provided for @k_b2c81k0m.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_b2c81k0m;

  /// No description provided for @k_8ztwtbdl.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_8ztwtbdl;

  /// No description provided for @k_ygi4rynl.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_ygi4rynl;

  /// No description provided for @k_3pliwr7o.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get k_3pliwr7o;

  /// No description provided for @k_quog03jp.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_quog03jp;

  /// No description provided for @k_13x9uqs0.
  ///
  /// In en, this message translates to:
  /// **'VVIP'**
  String get k_13x9uqs0;

  /// No description provided for @k_zzal3cp1.
  ///
  /// In en, this message translates to:
  /// **'฿ 2,500'**
  String get k_zzal3cp1;

  /// No description provided for @k_r2j8yc5b.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_r2j8yc5b;

  /// No description provided for @k_vs7xdzmi.
  ///
  /// In en, this message translates to:
  /// **'4+2'**
  String get k_vs7xdzmi;

  /// No description provided for @k_b346r7d7.
  ///
  /// In en, this message translates to:
  /// **'- 8 bottles of Singha - Regency liquor'**
  String get k_b346r7d7;

  /// No description provided for @k_t2g5fbkh.
  ///
  /// In en, this message translates to:
  /// **'- 15 Mixers - Rich Brand'**
  String get k_t2g5fbkh;

  /// No description provided for @k_pkz408a3.
  ///
  /// In en, this message translates to:
  /// **'- It\\'**
  String get k_pkz408a3;

  /// No description provided for @k_7nteuc8q.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_7nteuc8q;

  /// No description provided for @k_0ndc7z7a.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get k_0ndc7z7a;

  /// No description provided for @k_zjqoai57.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,500'**
  String get k_zjqoai57;

  /// No description provided for @k_6elfinwi.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_6elfinwi;

  /// No description provided for @k_zlj2bvxv.
  ///
  /// In en, this message translates to:
  /// **'4+2'**
  String get k_zlj2bvxv;

  /// No description provided for @k_cc82j5o4.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_cc82j5o4;

  /// No description provided for @k_4g50bw3t.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get k_4g50bw3t;

  /// No description provided for @k_rvzbnzim.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,000'**
  String get k_rvzbnzim;

  /// No description provided for @k_sa7il9cu.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_sa7il9cu;

  /// No description provided for @k_t2nhsu2z.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_t2nhsu2z;

  /// No description provided for @k_9z9bvdw7.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_9z9bvdw7;

  /// No description provided for @k_u5splgyl.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get k_u5splgyl;

  /// No description provided for @k_1btagzga.
  ///
  /// In en, this message translates to:
  /// **'฿ 500'**
  String get k_1btagzga;

  /// No description provided for @k_061te4or.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_061te4or;

  /// No description provided for @k_i2yqt0vg.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_i2yqt0vg;

  /// No description provided for @k_h6uupi1b.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_h6uupi1b;

  /// No description provided for @k_8t91guy8.
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get k_8t91guy8;

  /// No description provided for @k_27xmauca.
  ///
  /// In en, this message translates to:
  /// **'฿ 300'**
  String get k_27xmauca;

  /// No description provided for @k_tlm9qy3p.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_tlm9qy3p;

  /// No description provided for @k_vc6bzueu.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_vc6bzueu;

  /// No description provided for @k_3j2l4cnb.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_3j2l4cnb;

  /// No description provided for @k_v0p6ewim.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get k_v0p6ewim;

  /// No description provided for @k_ebhvfrkk.
  ///
  /// In en, this message translates to:
  /// **'฿ Free'**
  String get k_ebhvfrkk;

  /// No description provided for @k_c6l6yvfu.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_c6l6yvfu;

  /// No description provided for @k_77ws4uwr.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_77ws4uwr;

  /// No description provided for @k_8uod5ty9.
  ///
  /// In en, this message translates to:
  /// **'Booking Conditions Daily Booking Conditions  We only accept students and office workers. Please dress appropriately. ⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️  ❗️Booking Fee: 500 baht per queue. ❗Fully refunded upon table pick-up. ❗️Maximum 20 people per table. ❗️Book 30 days in advance. ❗️Bookings close at 4:00 PM.  Queue Release Conditions: ❗️Tables release at 9:00 PM for Sunday-Thursday❗️ ❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️  **If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏'**
  String get k_8uod5ty9;

  /// No description provided for @k_nrbqwlw0.
  ///
  /// In en, this message translates to:
  /// **'Buy Ticket'**
  String get k_nrbqwlw0;

  /// No description provided for @k_i56am3ch.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get k_i56am3ch;

  /// No description provided for @k_a5zorp3n.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_a5zorp3n;

  /// No description provided for @k_nc4g8d1b.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_nc4g8d1b;

  /// No description provided for @k_v0stl0ay.
  ///
  /// In en, this message translates to:
  /// **'Page Title'**
  String get k_v0stl0ay;

  /// No description provided for @k_ze672l2s.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_ze672l2s;

  /// No description provided for @k_6dz0u7le.
  ///
  /// In en, this message translates to:
  /// **'Page Title'**
  String get k_6dz0u7le;

  /// No description provided for @k_yhumgfb5.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_yhumgfb5;

  /// No description provided for @k_umb3na4q.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_umb3na4q;

  /// No description provided for @k_bh9llm47.
  ///
  /// In en, this message translates to:
  /// **'Page Title'**
  String get k_bh9llm47;

  /// No description provided for @k_tznvksq5.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_tznvksq5;

  /// No description provided for @k_jprjtruw.
  ///
  /// In en, this message translates to:
  /// **'PUB'**
  String get k_jprjtruw;

  /// No description provided for @k_vazpnzbl.
  ///
  /// In en, this message translates to:
  /// **'Hiphop'**
  String get k_vazpnzbl;

  /// No description provided for @k_hyr1m536.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_hyr1m536;

  /// No description provided for @k_4vhkf00u.
  ///
  /// In en, this message translates to:
  /// **'cars'**
  String get k_4vhkf00u;

  /// No description provided for @k_8ibd3age.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get k_8ibd3age;

  /// No description provided for @k_kpr56ubu.
  ///
  /// In en, this message translates to:
  /// **'100'**
  String get k_kpr56ubu;

  /// No description provided for @k_6ncos6jz.
  ///
  /// In en, this message translates to:
  /// **'+'**
  String get k_6ncos6jz;

  /// No description provided for @k_o1lqg7m6.
  ///
  /// In en, this message translates to:
  /// **'Link Contact'**
  String get k_o1lqg7m6;

  /// No description provided for @k_j2keth1e.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_j2keth1e;

  /// No description provided for @k_g973dz4s.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get k_g973dz4s;

  /// No description provided for @k_cwokgpu5.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_cwokgpu5;

  /// No description provided for @k_z6bqmqln.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get k_z6bqmqln;

  /// No description provided for @k_0odyt35u.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get k_0odyt35u;

  /// No description provided for @k_yr1eol7o.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get k_yr1eol7o;

  /// No description provided for @k_juznlzd5.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_juznlzd5;

  /// No description provided for @k_m8736qv2.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_m8736qv2;

  /// No description provided for @k_3u1rmglv.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_3u1rmglv;

  /// No description provided for @k_k36olntr.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get k_k36olntr;

  /// No description provided for @k_8dx4s51x.
  ///
  /// In en, this message translates to:
  /// **'Booking Tables'**
  String get k_8dx4s51x;

  /// No description provided for @k_rj6ljkjw.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_rj6ljkjw;

  /// No description provided for @k_hviyrnsx.
  ///
  /// In en, this message translates to:
  /// **'Page Title'**
  String get k_hviyrnsx;

  /// No description provided for @k_3qfn1tp7.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_3qfn1tp7;

  /// No description provided for @k_dipbnczb.
  ///
  /// In en, this message translates to:
  /// **'Page Title'**
  String get k_dipbnczb;

  /// No description provided for @k_vrvedkjs.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_vrvedkjs;

  /// No description provided for @k_4wo3bij4.
  ///
  /// In en, this message translates to:
  /// **'You have 10 points.'**
  String get k_4wo3bij4;

  /// No description provided for @k_4prk2pr3.
  ///
  /// In en, this message translates to:
  /// **'level :'**
  String get k_4prk2pr3;

  /// No description provided for @k_fnmvz65b.
  ///
  /// In en, this message translates to:
  /// **'VVVIP'**
  String get k_fnmvz65b;

  /// No description provided for @k_i7c3b8nn.
  ///
  /// In en, this message translates to:
  /// **'Online Chat Room'**
  String get k_i7c3b8nn;

  /// No description provided for @k_pvej8jdo.
  ///
  /// In en, this message translates to:
  /// **'print...'**
  String get k_pvej8jdo;

  /// No description provided for @k_64n77liv.
  ///
  /// In en, this message translates to:
  /// **'LIVE chat'**
  String get k_64n77liv;

  /// No description provided for @k_sv3t1aqu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get k_sv3t1aqu;

  /// No description provided for @k_4u7jdhej.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get k_4u7jdhej;

  /// No description provided for @k_4zw13kyv.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get k_4zw13kyv;

  /// No description provided for @k_3mm0oina.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get k_3mm0oina;

  /// No description provided for @k_wvqzbcxy.
  ///
  /// In en, this message translates to:
  /// **'SOHO Sigature'**
  String get k_wvqzbcxy;

  /// No description provided for @k_apq6pa5h.
  ///
  /// In en, this message translates to:
  /// **'SOHO is spicy'**
  String get k_apq6pa5h;

  /// No description provided for @k_4uvtmvmc.
  ///
  /// In en, this message translates to:
  /// **'beer'**
  String get k_4uvtmvmc;

  /// No description provided for @k_qvyga35a.
  ///
  /// In en, this message translates to:
  /// **'Soju'**
  String get k_qvyga35a;

  /// No description provided for @k_qjldag6s.
  ///
  /// In en, this message translates to:
  /// **'SOHO Signature'**
  String get k_qjldag6s;

  /// No description provided for @k_2rlog5ie.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_2rlog5ie;

  /// No description provided for @k_6lsnykdy.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_6lsnykdy;

  /// No description provided for @k_y323cr4r.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_y323cr4r;

  /// No description provided for @k_79pon8yh.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_79pon8yh;

  /// No description provided for @k_dc2n7a62.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_dc2n7a62;

  /// No description provided for @k_t50e7uwi.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_t50e7uwi;

  /// No description provided for @k_t8ovilvs.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_t8ovilvs;

  /// No description provided for @k_vql9o092.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_vql9o092;

  /// No description provided for @k_ndoszkx1.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get k_ndoszkx1;

  /// No description provided for @k_r4cspops.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_r4cspops;

  /// No description provided for @k_ra56fthj.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_ra56fthj;

  /// No description provided for @k_jknu10fi.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_jknu10fi;

  /// No description provided for @k_k8tm9w0z.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_k8tm9w0z;

  /// No description provided for @k_mxiu0bbn.
  ///
  /// In en, this message translates to:
  /// **'SOHO is spicy'**
  String get k_mxiu0bbn;

  /// No description provided for @k_zef0s0u7.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_zef0s0u7;

  /// No description provided for @k_jaixvpmy.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_jaixvpmy;

  /// No description provided for @k_6p9d78fm.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_6p9d78fm;

  /// No description provided for @k_uhjogkeu.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_uhjogkeu;

  /// No description provided for @k_uv0vajby.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_uv0vajby;

  /// No description provided for @k_v1ozjslp.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_v1ozjslp;

  /// No description provided for @k_dyfej5th.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_dyfej5th;

  /// No description provided for @k_zyvw2f8e.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_zyvw2f8e;

  /// No description provided for @k_tlenjoc6.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_tlenjoc6;

  /// No description provided for @k_k3vyqlbs.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_k3vyqlbs;

  /// No description provided for @k_x9qnow21.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_x9qnow21;

  /// No description provided for @k_4oiiwbg7.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_4oiiwbg7;

  /// No description provided for @k_648hbk3b.
  ///
  /// In en, this message translates to:
  /// **'SOJU'**
  String get k_648hbk3b;

  /// No description provided for @k_kqilvvox.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_kqilvvox;

  /// No description provided for @k_wxt840b4.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_wxt840b4;

  /// No description provided for @k_znqfxrt2.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_znqfxrt2;

  /// No description provided for @k_41oko2j7.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_41oko2j7;

  /// No description provided for @k_1j29gwzl.
  ///
  /// In en, this message translates to:
  /// **'9'**
  String get k_1j29gwzl;

  /// No description provided for @k_3fnz43vq.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_3fnz43vq;

  /// No description provided for @k_zm9awdoh.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_zm9awdoh;

  /// No description provided for @k_5llm0ked.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_5llm0ked;

  /// No description provided for @k_rrbe7olv.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_rrbe7olv;

  /// No description provided for @k_on6o51s1.
  ///
  /// In en, this message translates to:
  /// **'BEER'**
  String get k_on6o51s1;

  /// No description provided for @k_null1kwy.
  ///
  /// In en, this message translates to:
  /// **'Budweiser'**
  String get k_null1kwy;

  /// No description provided for @k_o4pjs7kx.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_o4pjs7kx;

  /// No description provided for @k_28v7itj0.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_28v7itj0;

  /// No description provided for @k_zcvkwu12.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_zcvkwu12;

  /// No description provided for @k_hsc7lxja.
  ///
  /// In en, this message translates to:
  /// **'Chang'**
  String get k_hsc7lxja;

  /// No description provided for @k_hspm448z.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_hspm448z;

  /// No description provided for @k_zrstnz99.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_zrstnz99;

  /// No description provided for @k_3c99ju5l.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_3c99ju5l;

  /// No description provided for @k_88ao1820.
  ///
  /// In en, this message translates to:
  /// **'Heineken'**
  String get k_88ao1820;

  /// No description provided for @k_ormms5cs.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_ormms5cs;

  /// No description provided for @k_bagd2xgm.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_bagd2xgm;

  /// No description provided for @k_vxh94qn6.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_vxh94qn6;

  /// No description provided for @k_xn4peof8.
  ///
  /// In en, this message translates to:
  /// **'Heineken'**
  String get k_xn4peof8;

  /// No description provided for @k_tmu03wlm.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_tmu03wlm;

  /// No description provided for @k_cpfyoa07.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_cpfyoa07;

  /// No description provided for @k_gb9jhpgk.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_gb9jhpgk;

  /// No description provided for @k_l8rq7vck.
  ///
  /// In en, this message translates to:
  /// **'Colona'**
  String get k_l8rq7vck;

  /// No description provided for @k_4bt0gm3n.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_4bt0gm3n;

  /// No description provided for @k_rqpvn24h.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_rqpvn24h;

  /// No description provided for @k_e8jqjrwo.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_e8jqjrwo;

  /// No description provided for @k_5578gt2i.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get k_5578gt2i;

  /// No description provided for @k_9uv5q34c.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_9uv5q34c;

  /// No description provided for @k_sxnlq3fb.
  ///
  /// In en, this message translates to:
  /// **'VVIP'**
  String get k_sxnlq3fb;

  /// No description provided for @k_sxlhrakm.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_sxlhrakm;

  /// No description provided for @k_iia4f40z.
  ///
  /// In en, this message translates to:
  /// **'A31'**
  String get k_iia4f40z;

  /// No description provided for @k_f6lm0lyz.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_f6lm0lyz;

  /// No description provided for @k_yyg9jzv0.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_yyg9jzv0;

  /// No description provided for @k_cji3uh29.
  ///
  /// In en, this message translates to:
  /// **'฿ 2,500'**
  String get k_cji3uh29;

  /// No description provided for @k_9dsvw40w.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,500'**
  String get k_9dsvw40w;

  /// No description provided for @k_3zdq0dyx.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_3zdq0dyx;

  /// No description provided for @k_4jyp4oms.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get k_4jyp4oms;

  /// No description provided for @k_c5g2p3v1.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_c5g2p3v1;

  /// No description provided for @k_zhgx1486.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_zhgx1486;

  /// No description provided for @k_h6p9p54r.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_h6p9p54r;

  /// No description provided for @k_yke60pea.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_yke60pea;

  /// No description provided for @k_qoiiqz69.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,000'**
  String get k_qoiiqz69;

  /// No description provided for @k_z6zfmcic.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_z6zfmcic;

  /// No description provided for @k_tt7znzhx.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get k_tt7znzhx;

  /// No description provided for @k_21apkl4n.
  ///
  /// In en, this message translates to:
  /// **'฿ 500'**
  String get k_21apkl4n;

  /// No description provided for @k_wvgkntw8.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_wvgkntw8;

  /// No description provided for @k_yu0ecv5t.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get k_yu0ecv5t;

  /// No description provided for @k_0v2cb7ps.
  ///
  /// In en, this message translates to:
  /// **'฿ 300'**
  String get k_0v2cb7ps;

  /// No description provided for @k_gd4zum2q.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_gd4zum2q;

  /// No description provided for @k_z2e1mh4n.
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get k_z2e1mh4n;

  /// No description provided for @k_4z32vj1c.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_4z32vj1c;

  /// No description provided for @k_j89moibh.
  ///
  /// In en, this message translates to:
  /// **'C31'**
  String get k_j89moibh;

  /// No description provided for @k_wpskxpnu.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_wpskxpnu;

  /// No description provided for @k_ptvagr3c.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_ptvagr3c;

  /// No description provided for @k_fwx1jft5.
  ///
  /// In en, this message translates to:
  /// **'฿ Free'**
  String get k_fwx1jft5;

  /// No description provided for @k_o639mc0f.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_o639mc0f;

  /// No description provided for @k_pjhjggdd.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get k_pjhjggdd;

  /// No description provided for @k_sgkjbkzy.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_sgkjbkzy;

  /// No description provided for @k_6gfnkxwb.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_6gfnkxwb;

  /// No description provided for @k_m3ezq3jz.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_m3ezq3jz;

  /// No description provided for @k_ybormi51.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_ybormi51;

  /// No description provided for @k_1wlz2o0d.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get k_1wlz2o0d;

  /// No description provided for @k_056i0rz7.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get k_056i0rz7;

  /// No description provided for @k_u2te9qjn.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_u2te9qjn;

  /// No description provided for @k_bpfrjboe.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_bpfrjboe;

  /// No description provided for @k_zydmy3o3.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get k_zydmy3o3;

  /// No description provided for @k_k6vb4ee3.
  ///
  /// In en, this message translates to:
  /// **'PANK'**
  String get k_k6vb4ee3;

  /// No description provided for @k_ryfsyvi5.
  ///
  /// In en, this message translates to:
  /// **'PUK_66'**
  String get k_ryfsyvi5;

  /// No description provided for @k_ndwikeks.
  ///
  /// In en, this message translates to:
  /// **'Booking Conditions Daily Booking Conditions  We only accept students and office workers. Please dress appropriately. ⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️  ❗️Booking Fee: 500 baht per queue. ❗Fully refunded upon table pick-up. ❗️Maximum 20 people per table. ❗️Book 30 days in advance. ❗️Bookings close at 4:00 PM.  Queue Release Conditions: ❗️Tables release at 9:00 PM for Sunday-Thursday❗️ ❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️  **If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏'**
  String get k_ndwikeks;

  /// No description provided for @k_wkxwd54x.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_wkxwd54x;

  /// No description provided for @k_e9hqe04l.
  ///
  /// In en, this message translates to:
  /// **'hello'**
  String get k_e9hqe04l;

  /// No description provided for @k_xhkv9wgf.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_xhkv9wgf;

  /// No description provided for @k_glw1miga.
  ///
  /// In en, this message translates to:
  /// **'Page Title'**
  String get k_glw1miga;

  /// No description provided for @k_a1iudyde.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_a1iudyde;

  /// No description provided for @k_w2wh6a9n.
  ///
  /// In en, this message translates to:
  /// **'Online Chat Room'**
  String get k_w2wh6a9n;

  /// No description provided for @k_2v1nt967.
  ///
  /// In en, this message translates to:
  /// **'print...'**
  String get k_2v1nt967;

  /// No description provided for @k_hlnyfwtv.
  ///
  /// In en, this message translates to:
  /// **'LIVE chat'**
  String get k_hlnyfwtv;

  /// No description provided for @k_v2kzvykl.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get k_v2kzvykl;

  /// No description provided for @k_gft872n2.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_gft872n2;

  /// No description provided for @k_xvgvp5b6.
  ///
  /// In en, this message translates to:
  /// **'VVIP'**
  String get k_xvgvp5b6;

  /// No description provided for @k_0iiv5xxw.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_0iiv5xxw;

  /// No description provided for @k_ekzj9n9p.
  ///
  /// In en, this message translates to:
  /// **'A31'**
  String get k_ekzj9n9p;

  /// No description provided for @k_wrt9jrnn.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_wrt9jrnn;

  /// No description provided for @k_7sg9h4fd.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_7sg9h4fd;

  /// No description provided for @k_5vq81do6.
  ///
  /// In en, this message translates to:
  /// **'฿ 2,500'**
  String get k_5vq81do6;

  /// No description provided for @k_9uyxq2cp.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,500'**
  String get k_9uyxq2cp;

  /// No description provided for @k_4agscpws.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_4agscpws;

  /// No description provided for @k_8n4z6077.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get k_8n4z6077;

  /// No description provided for @k_71auxs7t.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_71auxs7t;

  /// No description provided for @k_0u417nvy.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_0u417nvy;

  /// No description provided for @k_a7aao6m3.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_a7aao6m3;

  /// No description provided for @k_i0i6rs12.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_i0i6rs12;

  /// No description provided for @k_dq1k0zb7.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,000'**
  String get k_dq1k0zb7;

  /// No description provided for @k_6b9r8wok.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_6b9r8wok;

  /// No description provided for @k_bn1ckzq3.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get k_bn1ckzq3;

  /// No description provided for @k_zgdlc1ls.
  ///
  /// In en, this message translates to:
  /// **'฿ 500'**
  String get k_zgdlc1ls;

  /// No description provided for @k_8nhm2kar.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_8nhm2kar;

  /// No description provided for @k_yry045go.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get k_yry045go;

  /// No description provided for @k_soors5ex.
  ///
  /// In en, this message translates to:
  /// **'฿ 300'**
  String get k_soors5ex;

  /// No description provided for @k_60xpx86y.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_60xpx86y;

  /// No description provided for @k_gmknknyt.
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get k_gmknknyt;

  /// No description provided for @k_1zy28w2f.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_1zy28w2f;

  /// No description provided for @k_ggiokpn4.
  ///
  /// In en, this message translates to:
  /// **'C31'**
  String get k_ggiokpn4;

  /// No description provided for @k_6z502j02.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_6z502j02;

  /// No description provided for @k_l3nzym2i.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_l3nzym2i;

  /// No description provided for @k_j6a85dww.
  ///
  /// In en, this message translates to:
  /// **'฿ Free'**
  String get k_j6a85dww;

  /// No description provided for @k_haba2hgu.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_haba2hgu;

  /// No description provided for @k_orfq0mn7.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get k_orfq0mn7;

  /// No description provided for @k_7lyn96ig.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_7lyn96ig;

  /// No description provided for @k_vu6065xm.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_vu6065xm;

  /// No description provided for @k_xwpv7x6l.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_xwpv7x6l;

  /// No description provided for @k_5bhcwqof.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_5bhcwqof;

  /// No description provided for @k_ypg8wzob.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get k_ypg8wzob;

  /// No description provided for @k_tf3dnkge.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get k_tf3dnkge;

  /// No description provided for @k_juurp6dq.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_juurp6dq;

  /// No description provided for @k_is3r5xqn.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_is3r5xqn;

  /// No description provided for @k_s6r2ykml.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get k_s6r2ykml;

  /// No description provided for @k_ywjx9289.
  ///
  /// In en, this message translates to:
  /// **'PANK'**
  String get k_ywjx9289;

  /// No description provided for @k_cgj1fm77.
  ///
  /// In en, this message translates to:
  /// **'PUK_66'**
  String get k_cgj1fm77;

  /// No description provided for @k_eo64n89p.
  ///
  /// In en, this message translates to:
  /// **'Booking Conditions Daily Booking Conditions  We only accept students and office workers. Please dress appropriately. ⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️  ❗️Booking Fee: 500 baht per queue. ❗Fully refunded upon table pick-up. ❗️Maximum 20 people per table. ❗️Book 30 days in advance. ❗️Bookings close at 4:00 PM.  Queue Release Conditions: ❗️Tables release at 9:00 PM for Sunday-Thursday❗️ ❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️  **If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏'**
  String get k_eo64n89p;

  /// No description provided for @k_egtual1b.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_egtual1b;

  /// No description provided for @k_7ovbkwp3.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_7ovbkwp3;

  /// No description provided for @k_xzv4f36w.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_xzv4f36w;

  /// No description provided for @k_bw9ltw03.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_bw9ltw03;

  /// No description provided for @k_cjy3nyvn.
  ///
  /// In en, this message translates to:
  /// **'Booking Conditions Daily Booking Conditions  We only accept students and office workers. Please dress appropriately. ⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️  ❗️Booking Fee: 500 baht per queue. ❗Fully refunded upon table pick-up. ❗️Maximum 20 people per table. ❗️Book 30 days in advance. ❗️Bookings close at 4:00 PM.  Queue Release Conditions: ❗️Tables release at 9:00 PM for Sunday-Thursday❗️ ❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️  **If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏'**
  String get k_cjy3nyvn;

  /// No description provided for @k_4q2u0p3t.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get k_4q2u0p3t;

  /// No description provided for @k_xtbwanld.
  ///
  /// In en, this message translates to:
  /// **'Tickets list'**
  String get k_xtbwanld;

  /// No description provided for @k_48zondbs.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_48zondbs;

  /// No description provided for @k_36f7nsef.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_36f7nsef;

  /// No description provided for @k_d8f6lovw.
  ///
  /// In en, this message translates to:
  /// **'PUB'**
  String get k_d8f6lovw;

  /// No description provided for @k_1rqcy1ed.
  ///
  /// In en, this message translates to:
  /// **'Hiphop'**
  String get k_1rqcy1ed;

  /// No description provided for @k_pj45icmd.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_pj45icmd;

  /// No description provided for @k_nspc1yuz.
  ///
  /// In en, this message translates to:
  /// **'cars'**
  String get k_nspc1yuz;

  /// No description provided for @k_myby50ga.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get k_myby50ga;

  /// No description provided for @k_7zyopoiw.
  ///
  /// In en, this message translates to:
  /// **'100'**
  String get k_7zyopoiw;

  /// No description provided for @k_ygqwxgwn.
  ///
  /// In en, this message translates to:
  /// **'+'**
  String get k_ygqwxgwn;

  /// No description provided for @k_cpm3t5y5.
  ///
  /// In en, this message translates to:
  /// **'Link Contact'**
  String get k_cpm3t5y5;

  /// No description provided for @k_v8d16drz.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_v8d16drz;

  /// No description provided for @k_ftk53xdg.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get k_ftk53xdg;

  /// No description provided for @k_zhpjfz03.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_zhpjfz03;

  /// No description provided for @k_xqct6dec.
  ///
  /// In en, this message translates to:
  /// **'No Events'**
  String get k_xqct6dec;

  /// No description provided for @k_el6ri3xf.
  ///
  /// In en, this message translates to:
  /// **'Sorry, we don\\'**
  String get k_el6ri3xf;

  /// No description provided for @k_747m08nh.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get k_747m08nh;

  /// No description provided for @k_bdrgr6h2.
  ///
  /// In en, this message translates to:
  /// **'No Promotion'**
  String get k_bdrgr6h2;

  /// No description provided for @k_mhrkr17v.
  ///
  /// In en, this message translates to:
  /// **'Sorry, we don\\'**
  String get k_mhrkr17v;

  /// No description provided for @k_l21inzuk.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get k_l21inzuk;

  /// No description provided for @k_n8dn3vae.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get k_n8dn3vae;

  /// No description provided for @k_wydeq06y.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get k_wydeq06y;

  /// No description provided for @k_m9f9snmw.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_m9f9snmw;

  /// No description provided for @k_t8j990o3.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_t8j990o3;

  /// No description provided for @k_0eq2ljyv.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_0eq2ljyv;

  /// No description provided for @k_8om8y1ff.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_8om8y1ff;

  /// No description provided for @k_tsmhuyoa.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_tsmhuyoa;

  /// No description provided for @k_23rkums5.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_23rkums5;

  /// No description provided for @k_hori9t1o.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_hori9t1o;

  /// No description provided for @k_tr6fhmka.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_tr6fhmka;

  /// No description provided for @k_3v4emk0i.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_3v4emk0i;

  /// No description provided for @k_b2amftd7.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_b2amftd7;

  /// No description provided for @k_1toslqmx.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_1toslqmx;

  /// No description provided for @k_qwpf7e96.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_qwpf7e96;

  /// No description provided for @k_kjnpr9di.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_kjnpr9di;

  /// No description provided for @k_krxpeiro.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_krxpeiro;

  /// No description provided for @k_ae3use38.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_ae3use38;

  /// No description provided for @k_j58u31xa.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get k_j58u31xa;

  /// No description provided for @k_bf79j07e.
  ///
  /// In en, this message translates to:
  /// **'join room'**
  String get k_bf79j07e;

  /// No description provided for @k_q3kv67h4.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get k_q3kv67h4;

  /// No description provided for @k_simcn6td.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get k_simcn6td;

  /// No description provided for @k_apsy2i5q.
  ///
  /// In en, this message translates to:
  /// **'2.1 K'**
  String get k_apsy2i5q;

  /// No description provided for @k_fowb1nw4.
  ///
  /// In en, this message translates to:
  /// **'12.5 K'**
  String get k_fowb1nw4;

  /// No description provided for @k_oe059td2.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_oe059td2;

  /// No description provided for @k_5gvgklgz.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get k_5gvgklgz;

  /// No description provided for @k_nyazsf47.
  ///
  /// In en, this message translates to:
  /// **'You are far from the store.'**
  String get k_nyazsf47;

  /// No description provided for @k_mp8ty4ge.
  ///
  /// In en, this message translates to:
  /// **'Sorry, you must be within 50 meters of the shop.'**
  String get k_mp8ty4ge;

  /// No description provided for @k_u2te43sd.
  ///
  /// In en, this message translates to:
  /// **'Cheers Package'**
  String get k_u2te43sd;

  /// No description provided for @k_qdjyp8zy.
  ///
  /// In en, this message translates to:
  /// **'Pay with PromptPay, convenient and safe.'**
  String get k_qdjyp8zy;

  /// No description provided for @k_xx981ba6.
  ///
  /// In en, this message translates to:
  /// **'Select Package'**
  String get k_xx981ba6;

  /// No description provided for @k_6d4njuve.
  ///
  /// In en, this message translates to:
  /// **'X'**
  String get k_6d4njuve;

  /// No description provided for @k_9fp2n6rz.
  ///
  /// In en, this message translates to:
  /// **'฿ 29.00'**
  String get k_9fp2n6rz;

  /// No description provided for @k_iw5wjf5x.
  ///
  /// In en, this message translates to:
  /// **'X'**
  String get k_iw5wjf5x;

  /// No description provided for @k_jxm19659.
  ///
  /// In en, this message translates to:
  /// **'฿ 49.00'**
  String get k_jxm19659;

  /// No description provided for @k_fxmmzfdq.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_fxmmzfdq;

  /// No description provided for @k_12bdn60y.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_12bdn60y;

  /// No description provided for @k_y14bta82.
  ///
  /// In en, this message translates to:
  /// **'See everyone cheering you on'**
  String get k_y14bta82;

  /// No description provided for @k_t766gvxc.
  ///
  /// In en, this message translates to:
  /// **'฿ 99.00'**
  String get k_t766gvxc;

  /// No description provided for @k_nifsved0.
  ///
  /// In en, this message translates to:
  /// **'Cheers!!'**
  String get k_nifsved0;

  /// No description provided for @k_7hzb9e7k.
  ///
  /// In en, this message translates to:
  /// **'The other party matches you.'**
  String get k_7hzb9e7k;

  /// No description provided for @k_quxzlxti.
  ///
  /// In en, this message translates to:
  /// **'Delete chat'**
  String get k_quxzlxti;

  /// No description provided for @k_biyxjvln.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get k_biyxjvln;

  /// No description provided for @k_u58jdqpe.
  ///
  /// In en, this message translates to:
  /// **'Delete chat room'**
  String get k_u58jdqpe;

  /// No description provided for @k_crot8jmc.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get k_crot8jmc;

  /// No description provided for @k_1lw0tlcq.
  ///
  /// In en, this message translates to:
  /// **'Confirm to delete all user data.'**
  String get k_1lw0tlcq;

  /// No description provided for @k_ka4eqgjx.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get k_ka4eqgjx;

  /// No description provided for @k_4xgiypcj.
  ///
  /// In en, this message translates to:
  /// **'Report inappropriate behavior'**
  String get k_4xgiypcj;

  /// No description provided for @k_2zyj6fm1.
  ///
  /// In en, this message translates to:
  /// **'Block visibility'**
  String get k_2zyj6fm1;

  /// No description provided for @k_6pmw7gnn.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get k_6pmw7gnn;

  /// No description provided for @k_fvrj4p08.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get k_fvrj4p08;

  /// No description provided for @k_bd2xz340.
  ///
  /// In en, this message translates to:
  /// **'Thai'**
  String get k_bd2xz340;

  /// No description provided for @k_6w69b1uq.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get k_6w69b1uq;

  /// No description provided for @k_74gcpyy4.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get k_74gcpyy4;

  /// No description provided for @k_4zmi1y5v.
  ///
  /// In en, this message translates to:
  /// **'Your Profile'**
  String get k_4zmi1y5v;

  /// No description provided for @k_il4lzk8b.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get k_il4lzk8b;

  /// No description provided for @k_iteqjwb6.
  ///
  /// In en, this message translates to:
  /// **'Your caption'**
  String get k_iteqjwb6;

  /// No description provided for @k_3ewakt6y.
  ///
  /// In en, this message translates to:
  /// **'Name Instagram'**
  String get k_3ewakt6y;

  /// No description provided for @k_82kov3yv.
  ///
  /// In en, this message translates to:
  /// **'Facebook login ID'**
  String get k_82kov3yv;

  /// No description provided for @k_z7555l2i.
  ///
  /// In en, this message translates to:
  /// **'Save Profile'**
  String get k_z7555l2i;

  /// No description provided for @k_bbesdap1.
  ///
  /// In en, this message translates to:
  /// **'Cheers & Chat Package'**
  String get k_bbesdap1;

  /// No description provided for @k_9f3d66nc.
  ///
  /// In en, this message translates to:
  /// **'Pay with PromptPay, convenient and safe.'**
  String get k_9f3d66nc;

  /// No description provided for @k_r5tus9bg.
  ///
  /// In en, this message translates to:
  /// **'Select Package'**
  String get k_r5tus9bg;

  /// No description provided for @k_6nasx7c3.
  ///
  /// In en, this message translates to:
  /// **'X'**
  String get k_6nasx7c3;

  /// No description provided for @k_j5cs2fbe.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Chat'**
  String get k_j5cs2fbe;

  /// No description provided for @k_ekfyd6a3.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_ekfyd6a3;

  /// No description provided for @k_pou7t511.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Cheers'**
  String get k_pou7t511;

  /// No description provided for @k_mb8tr2sr.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_mb8tr2sr;

  /// No description provided for @k_7a9j6lfn.
  ///
  /// In en, this message translates to:
  /// **'See everyone cheering you on'**
  String get k_7a9j6lfn;

  /// No description provided for @k_okhzxrz6.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get k_okhzxrz6;

  /// No description provided for @k_vfu8w88q.
  ///
  /// In en, this message translates to:
  /// **'฿ 49.00'**
  String get k_vfu8w88q;

  /// No description provided for @k_v8twwbro.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_v8twwbro;

  /// No description provided for @k_er53rk14.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_er53rk14;

  /// No description provided for @k_kcgzbjrg.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get k_kcgzbjrg;

  /// No description provided for @k_jad00i83.
  ///
  /// In en, this message translates to:
  /// **'Play via Line is not supported.'**
  String get k_jad00i83;

  /// No description provided for @k_zzsabprf.
  ///
  /// In en, this message translates to:
  /// **'Click on the bottom right corner to open it in your browser.'**
  String get k_zzsabprf;

  /// No description provided for @k_yw9mzhw0.
  ///
  /// In en, this message translates to:
  /// **'Click Here!'**
  String get k_yw9mzhw0;

  /// No description provided for @k_46da8ms1.
  ///
  /// In en, this message translates to:
  /// **'Cheers Match'**
  String get k_46da8ms1;

  /// No description provided for @k_0d3y4v1l.
  ///
  /// In en, this message translates to:
  /// **'Someone is cheering you on.'**
  String get k_0d3y4v1l;

  /// No description provided for @k_s757cb9p.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get k_s757cb9p;

  /// No description provided for @k_4fxmvmsu.
  ///
  /// In en, this message translates to:
  /// **'See who Cheers you'**
  String get k_4fxmvmsu;

  /// No description provided for @k_rnbxlb0h.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get k_rnbxlb0h;

  /// No description provided for @k_sjar8369.
  ///
  /// In en, this message translates to:
  /// **'About Event'**
  String get k_sjar8369;

  /// No description provided for @k_13ru3pxc.
  ///
  /// In en, this message translates to:
  /// **'Booking Table'**
  String get k_13ru3pxc;

  /// No description provided for @k_61ovuoqq.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get k_61ovuoqq;

  /// No description provided for @k_ax962ez4.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get k_ax962ez4;

  /// No description provided for @k_q0tqvw1e.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_q0tqvw1e;

  /// No description provided for @k_nlvb3wjv.
  ///
  /// In en, this message translates to:
  /// **'Type Venuses'**
  String get k_nlvb3wjv;

  /// No description provided for @k_gy667nbh.
  ///
  /// In en, this message translates to:
  /// **'Pub'**
  String get k_gy667nbh;

  /// No description provided for @k_u6srszey.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get k_u6srszey;

  /// No description provided for @k_eeyxdmdw.
  ///
  /// In en, this message translates to:
  /// **'Chill'**
  String get k_eeyxdmdw;

  /// No description provided for @k_rl0ga10m.
  ///
  /// In en, this message translates to:
  /// **'CraftBeer'**
  String get k_rl0ga10m;

  /// No description provided for @k_s9yaj8wb.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get k_s9yaj8wb;

  /// No description provided for @k_s7cwbfue.
  ///
  /// In en, this message translates to:
  /// **'Style Musics'**
  String get k_s7cwbfue;

  /// No description provided for @k_rmzseyr4.
  ///
  /// In en, this message translates to:
  /// **'LiveMusic'**
  String get k_rmzseyr4;

  /// No description provided for @k_zchvxgoo.
  ///
  /// In en, this message translates to:
  /// **'Hiphop'**
  String get k_zchvxgoo;

  /// No description provided for @k_qtwraypg.
  ///
  /// In en, this message translates to:
  /// **'Country music'**
  String get k_qtwraypg;

  /// No description provided for @k_hddmmpbl.
  ///
  /// In en, this message translates to:
  /// **'For life'**
  String get k_hddmmpbl;

  /// No description provided for @k_kcsysckt.
  ///
  /// In en, this message translates to:
  /// **'EDM'**
  String get k_kcsysckt;

  /// No description provided for @k_3kdu52bs.
  ///
  /// In en, this message translates to:
  /// **'Jazz'**
  String get k_3kdu52bs;

  /// No description provided for @k_22jap4o5.
  ///
  /// In en, this message translates to:
  /// **'Rock'**
  String get k_22jap4o5;

  /// No description provided for @k_ms1qtkw9.
  ///
  /// In en, this message translates to:
  /// **'Clear filter'**
  String get k_ms1qtkw9;

  /// No description provided for @k_zqtx4gzg.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get k_zqtx4gzg;

  /// No description provided for @k_25bukxun.
  ///
  /// In en, this message translates to:
  /// **'Overall Rate'**
  String get k_25bukxun;

  /// No description provided for @k_wnzwymdq.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get k_wnzwymdq;

  /// No description provided for @k_fg7k7qoa.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get k_fg7k7qoa;

  /// No description provided for @k_xfvpitv9.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get k_xfvpitv9;

  /// No description provided for @k_z0f12e5c.
  ///
  /// In en, this message translates to:
  /// **'Please rate and tell us about your experience.'**
  String get k_z0f12e5c;

  /// No description provided for @k_yb1d4pp3.
  ///
  /// In en, this message translates to:
  /// **'Write a review of the store and your experience.'**
  String get k_yb1d4pp3;

  /// No description provided for @k_059j9bih.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get k_059j9bih;

  /// No description provided for @k_66yuaryw.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get k_66yuaryw;

  /// No description provided for @k_cg9krkdo.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get k_cg9krkdo;

  /// No description provided for @k_jv4kh6nx.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get k_jv4kh6nx;

  /// No description provided for @k_pt91hugb.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get k_pt91hugb;

  /// No description provided for @k_jx86187c.
  ///
  /// In en, this message translates to:
  /// **'Online Chat Room'**
  String get k_jx86187c;

  /// No description provided for @k_pxtc8g70.
  ///
  /// In en, this message translates to:
  /// **'Select a place near you'**
  String get k_pxtc8g70;

  /// No description provided for @k_rjsbq731.
  ///
  /// In en, this message translates to:
  /// **'Pub'**
  String get k_rjsbq731;

  /// No description provided for @k_ojlqgeqn.
  ///
  /// In en, this message translates to:
  /// **'LiveMusic'**
  String get k_ojlqgeqn;

  /// No description provided for @k_sr5wx9kx.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_sr5wx9kx;

  /// No description provided for @k_7xe2ctzx.
  ///
  /// In en, this message translates to:
  /// **'Join Room'**
  String get k_7xe2ctzx;

  /// No description provided for @k_x3apx9v8.
  ///
  /// In en, this message translates to:
  /// **'No Events'**
  String get k_x3apx9v8;

  /// No description provided for @k_2q2gbild.
  ///
  /// In en, this message translates to:
  /// **'Please select another day for more information.'**
  String get k_2q2gbild;

  /// No description provided for @k_oxahnggw.
  ///
  /// In en, this message translates to:
  /// **'STAGE'**
  String get k_oxahnggw;

  /// No description provided for @k_kzrbch3h.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get k_kzrbch3h;

  /// No description provided for @k_gyu7n4jr.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get k_gyu7n4jr;

  /// No description provided for @k_royeqo90.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get k_royeqo90;

  /// No description provided for @k_8wy4lzsi.
  ///
  /// In en, this message translates to:
  /// **'Review your order below before checking out.'**
  String get k_8wy4lzsi;

  /// No description provided for @k_87ignsq1.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get k_87ignsq1;

  /// No description provided for @k_8s594cw7.
  ///
  /// In en, this message translates to:
  /// **'Secondary text'**
  String get k_8s594cw7;

  /// No description provided for @k_mbsg9qyp.
  ///
  /// In en, this message translates to:
  /// **'\\\$1.50'**
  String get k_mbsg9qyp;

  /// No description provided for @k_z5pw81su.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get k_z5pw81su;

  /// No description provided for @k_3cq4s8eu.
  ///
  /// In en, this message translates to:
  /// **'Secondary text'**
  String get k_3cq4s8eu;

  /// No description provided for @k_mkmibosn.
  ///
  /// In en, this message translates to:
  /// **'\\\$1.50'**
  String get k_mkmibosn;

  /// No description provided for @k_dqy8fn2h.
  ///
  /// In en, this message translates to:
  /// **'Price Breakdown'**
  String get k_dqy8fn2h;

  /// No description provided for @k_6tmtds3l.
  ///
  /// In en, this message translates to:
  /// **'Base Price'**
  String get k_6tmtds3l;

  /// No description provided for @k_cjvm3e6o.
  ///
  /// In en, this message translates to:
  /// **'\\\$156.00'**
  String get k_cjvm3e6o;

  /// No description provided for @k_sig6jceg.
  ///
  /// In en, this message translates to:
  /// **'Taxes'**
  String get k_sig6jceg;

  /// No description provided for @k_0isy8zei.
  ///
  /// In en, this message translates to:
  /// **'\\\$24.20'**
  String get k_0isy8zei;

  /// No description provided for @k_eo89xty2.
  ///
  /// In en, this message translates to:
  /// **'Cleaning Fee'**
  String get k_eo89xty2;

  /// No description provided for @k_imxohj9c.
  ///
  /// In en, this message translates to:
  /// **'\\\$40.00'**
  String get k_imxohj9c;

  /// No description provided for @k_bwiua023.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get k_bwiua023;

  /// No description provided for @k_38m358vu.
  ///
  /// In en, this message translates to:
  /// **'\\\$230.20'**
  String get k_38m358vu;

  /// No description provided for @k_7eflhlmh.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get k_7eflhlmh;

  /// No description provided for @k_vs27b27y.
  ///
  /// In en, this message translates to:
  /// **'Apple Map'**
  String get k_vs27b27y;

  /// No description provided for @k_pbykxkt1.
  ///
  /// In en, this message translates to:
  /// **'Google Map'**
  String get k_pbykxkt1;

  /// No description provided for @k_6sh1ybvc.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get k_6sh1ybvc;

  /// No description provided for @k_hx4cxq5v.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get k_hx4cxq5v;

  /// No description provided for @k_f12op9xo.
  ///
  /// In en, this message translates to:
  /// **'Special Gift'**
  String get k_f12op9xo;

  /// No description provided for @k_oa6v3cc3.
  ///
  /// In en, this message translates to:
  /// **'999'**
  String get k_oa6v3cc3;

  /// No description provided for @k_jkyommuk.
  ///
  /// In en, this message translates to:
  /// **'10'**
  String get k_jkyommuk;

  /// No description provided for @k_jp1w1d7g.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_jp1w1d7g;

  /// No description provided for @k_ijdk6wqn.
  ///
  /// In en, this message translates to:
  /// **'40'**
  String get k_ijdk6wqn;

  /// No description provided for @k_alcb5pdg.
  ///
  /// In en, this message translates to:
  /// **'80'**
  String get k_alcb5pdg;

  /// No description provided for @k_1b7vl2lu.
  ///
  /// In en, this message translates to:
  /// **'150'**
  String get k_1b7vl2lu;

  /// No description provided for @k_j02x1gwu.
  ///
  /// In en, this message translates to:
  /// **'200'**
  String get k_j02x1gwu;

  /// No description provided for @k_uzvcm3j4.
  ///
  /// In en, this message translates to:
  /// **'Special Gift'**
  String get k_uzvcm3j4;

  /// No description provided for @k_g913ncyq.
  ///
  /// In en, this message translates to:
  /// **'Gifts can be used in place of cash in the store.'**
  String get k_g913ncyq;

  /// No description provided for @k_2mx0g8d7.
  ///
  /// In en, this message translates to:
  /// **'999'**
  String get k_2mx0g8d7;

  /// No description provided for @k_yn990my0.
  ///
  /// In en, this message translates to:
  /// **'THB'**
  String get k_yn990my0;

  /// No description provided for @k_hqi0oom7.
  ///
  /// In en, this message translates to:
  /// **'10'**
  String get k_hqi0oom7;

  /// No description provided for @k_ti4uoq5m.
  ///
  /// In en, this message translates to:
  /// **'THB'**
  String get k_ti4uoq5m;

  /// No description provided for @k_gbv4rvjr.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get k_gbv4rvjr;

  /// No description provided for @k_8bgisnej.
  ///
  /// In en, this message translates to:
  /// **'THB'**
  String get k_8bgisnej;

  /// No description provided for @k_0zg3bhe0.
  ///
  /// In en, this message translates to:
  /// **'40'**
  String get k_0zg3bhe0;

  /// No description provided for @k_lriu4nm4.
  ///
  /// In en, this message translates to:
  /// **'THB'**
  String get k_lriu4nm4;

  /// No description provided for @k_1hfhux4n.
  ///
  /// In en, this message translates to:
  /// **'80'**
  String get k_1hfhux4n;

  /// No description provided for @k_h9cxh1eb.
  ///
  /// In en, this message translates to:
  /// **'THB'**
  String get k_h9cxh1eb;

  /// No description provided for @k_e5jla5tg.
  ///
  /// In en, this message translates to:
  /// **'150'**
  String get k_e5jla5tg;

  /// No description provided for @k_m418myc2.
  ///
  /// In en, this message translates to:
  /// **'THB'**
  String get k_m418myc2;

  /// No description provided for @k_iwc8qe38.
  ///
  /// In en, this message translates to:
  /// **'200'**
  String get k_iwc8qe38;

  /// No description provided for @k_1tuf3zdu.
  ///
  /// In en, this message translates to:
  /// **'Chang beer'**
  String get k_1tuf3zdu;

  /// No description provided for @k_thg66gfp.
  ///
  /// In en, this message translates to:
  /// **'Place a pan over medium heat and add oil. Once hot, add garlic, onion, and carrot. Stir-fry until the garlic turns yellow. Set everything aside.'**
  String get k_thg66gfp;

  /// No description provided for @k_d2x52u28.
  ///
  /// In en, this message translates to:
  /// **'Main items'**
  String get k_d2x52u28;

  /// No description provided for @k_ky5kczto.
  ///
  /// In en, this message translates to:
  /// **'(Choose 1 item)'**
  String get k_ky5kczto;

  /// No description provided for @k_v0s1yakg.
  ///
  /// In en, this message translates to:
  /// **'can'**
  String get k_v0s1yakg;

  /// No description provided for @k_plpi8ac3.
  ///
  /// In en, this message translates to:
  /// **'490 ml'**
  String get k_plpi8ac3;

  /// No description provided for @k_iz8upluc.
  ///
  /// In en, this message translates to:
  /// **'฿80.00'**
  String get k_iz8upluc;

  /// No description provided for @k_1taykv9o.
  ///
  /// In en, this message translates to:
  /// **'bottle'**
  String get k_1taykv9o;

  /// No description provided for @k_61koln9m.
  ///
  /// In en, this message translates to:
  /// **'960 ml'**
  String get k_61koln9m;

  /// No description provided for @k_gxtxed0h.
  ///
  /// In en, this message translates to:
  /// **'฿125.00'**
  String get k_gxtxed0h;

  /// No description provided for @k_fopxh6ut.
  ///
  /// In en, this message translates to:
  /// **'Bottle x6'**
  String get k_fopxh6ut;

  /// No description provided for @k_o45tq0eo.
  ///
  /// In en, this message translates to:
  /// **'Secondary text'**
  String get k_o45tq0eo;

  /// No description provided for @k_6xd7h8om.
  ///
  /// In en, this message translates to:
  /// **'฿600.00'**
  String get k_6xd7h8om;

  /// No description provided for @k_ktst41ad.
  ///
  /// In en, this message translates to:
  /// **'24 bottle promotion'**
  String get k_ktst41ad;

  /// No description provided for @k_jr24icaw.
  ///
  /// In en, this message translates to:
  /// **'Before 9 PM - 1 plate of French fries - 1 plate of meatballs'**
  String get k_jr24icaw;

  /// No description provided for @k_ivx746hh.
  ///
  /// In en, this message translates to:
  /// **'฿2200.00'**
  String get k_ivx746hh;

  /// No description provided for @k_6qsq9emi.
  ///
  /// In en, this message translates to:
  /// **'tower'**
  String get k_6qsq9emi;

  /// No description provided for @k_tte3l895.
  ///
  /// In en, this message translates to:
  /// **'2800 ml'**
  String get k_tte3l895;

  /// No description provided for @k_sw0y7mzx.
  ///
  /// In en, this message translates to:
  /// **'฿1,200.00'**
  String get k_sw0y7mzx;

  /// No description provided for @k_6ld7endt.
  ///
  /// In en, this message translates to:
  /// **'Additional item 1#'**
  String get k_6ld7endt;

  /// No description provided for @k_uhdtdr8l.
  ///
  /// In en, this message translates to:
  /// **'(Choose 2 items)'**
  String get k_uhdtdr8l;

  /// No description provided for @k_y7p97833.
  ///
  /// In en, this message translates to:
  /// **'Omelet rice'**
  String get k_y7p97833;

  /// No description provided for @k_p4wxhn1k.
  ///
  /// In en, this message translates to:
  /// **'+ ฿100'**
  String get k_p4wxhn1k;

  /// No description provided for @k_8jyip9q8.
  ///
  /// In en, this message translates to:
  /// **'Pork leg and egg rice'**
  String get k_8jyip9q8;

  /// No description provided for @k_m8saqwv0.
  ///
  /// In en, this message translates to:
  /// **'+ ฿100'**
  String get k_m8saqwv0;

  /// No description provided for @k_e74jcwol.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_e74jcwol;

  /// No description provided for @k_h2eowim4.
  ///
  /// In en, this message translates to:
  /// **'+ ฿100'**
  String get k_h2eowim4;

  /// No description provided for @k_2c0ttz1g.
  ///
  /// In en, this message translates to:
  /// **'Provide additional details'**
  String get k_2c0ttz1g;

  /// No description provided for @k_uh6abhr2.
  ///
  /// In en, this message translates to:
  /// **'A55'**
  String get k_uh6abhr2;

  /// No description provided for @k_5m6bre6h.
  ///
  /// In en, this message translates to:
  /// **'5+'**
  String get k_5m6bre6h;

  /// No description provided for @k_bupf1vmm.
  ///
  /// In en, this message translates to:
  /// **'Table opens at 9:00 PM'**
  String get k_bupf1vmm;

  /// No description provided for @k_5stsf6tj.
  ///
  /// In en, this message translates to:
  /// **'status :'**
  String get k_5stsf6tj;

  /// No description provided for @k_94faegm6.
  ///
  /// In en, this message translates to:
  /// **'Service in progress'**
  String get k_94faegm6;

  /// No description provided for @k_wvshhx7i.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get k_wvshhx7i;

  /// No description provided for @k_3yhupuy0.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_3yhupuy0;

  /// No description provided for @k_d031gm2m.
  ///
  /// In en, this message translates to:
  /// **'8'**
  String get k_d031gm2m;

  /// No description provided for @k_4w7okaiq.
  ///
  /// In en, this message translates to:
  /// **'Chang beer'**
  String get k_4w7okaiq;

  /// No description provided for @k_ccy14dp5.
  ///
  /// In en, this message translates to:
  /// **'Place a pan over medium heat and add oil. Once hot, add garlic, onion, and carrot. Stir-fry until the garlic turns yellow. Set everything aside.'**
  String get k_ccy14dp5;

  /// No description provided for @k_5t3fx476.
  ///
  /// In en, this message translates to:
  /// **'Main items'**
  String get k_5t3fx476;

  /// No description provided for @k_w26z0txk.
  ///
  /// In en, this message translates to:
  /// **'(Choose 1 item)'**
  String get k_w26z0txk;

  /// No description provided for @k_li0i93h8.
  ///
  /// In en, this message translates to:
  /// **'can'**
  String get k_li0i93h8;

  /// No description provided for @k_2i4emeiv.
  ///
  /// In en, this message translates to:
  /// **'490 ml'**
  String get k_2i4emeiv;

  /// No description provided for @k_nowa5wqq.
  ///
  /// In en, this message translates to:
  /// **'฿80.00'**
  String get k_nowa5wqq;

  /// No description provided for @k_lzlwyz5p.
  ///
  /// In en, this message translates to:
  /// **'bottle'**
  String get k_lzlwyz5p;

  /// No description provided for @k_syd2fvo2.
  ///
  /// In en, this message translates to:
  /// **'960 ml'**
  String get k_syd2fvo2;

  /// No description provided for @k_uneymy43.
  ///
  /// In en, this message translates to:
  /// **'฿125.00'**
  String get k_uneymy43;

  /// No description provided for @k_roc84uh6.
  ///
  /// In en, this message translates to:
  /// **'Bottle x6'**
  String get k_roc84uh6;

  /// No description provided for @k_almm9ins.
  ///
  /// In en, this message translates to:
  /// **'Secondary text'**
  String get k_almm9ins;

  /// No description provided for @k_jbn0op93.
  ///
  /// In en, this message translates to:
  /// **'฿600.00'**
  String get k_jbn0op93;

  /// No description provided for @k_ouyh24oe.
  ///
  /// In en, this message translates to:
  /// **'24 bottle promotion'**
  String get k_ouyh24oe;

  /// No description provided for @k_ijkpx5mr.
  ///
  /// In en, this message translates to:
  /// **'Before 9 PM - 1 plate of French fries - 1 plate of meatballs'**
  String get k_ijkpx5mr;

  /// No description provided for @k_6vbc4toe.
  ///
  /// In en, this message translates to:
  /// **'฿2200.00'**
  String get k_6vbc4toe;

  /// No description provided for @k_2racoy76.
  ///
  /// In en, this message translates to:
  /// **'tower'**
  String get k_2racoy76;

  /// No description provided for @k_8xk87fm0.
  ///
  /// In en, this message translates to:
  /// **'2800 ml'**
  String get k_8xk87fm0;

  /// No description provided for @k_i0gt64q8.
  ///
  /// In en, this message translates to:
  /// **'฿1,200.00'**
  String get k_i0gt64q8;

  /// No description provided for @k_y4adjn7e.
  ///
  /// In en, this message translates to:
  /// **'Additional item 1#'**
  String get k_y4adjn7e;

  /// No description provided for @k_gdgvi36s.
  ///
  /// In en, this message translates to:
  /// **'(Choose 2 items)'**
  String get k_gdgvi36s;

  /// No description provided for @k_2xcu1n0d.
  ///
  /// In en, this message translates to:
  /// **'Omelet rice'**
  String get k_2xcu1n0d;

  /// No description provided for @k_bpu0xdyl.
  ///
  /// In en, this message translates to:
  /// **'+ ฿100'**
  String get k_bpu0xdyl;

  /// No description provided for @k_nrwvz2da.
  ///
  /// In en, this message translates to:
  /// **'Pork leg and egg rice'**
  String get k_nrwvz2da;

  /// No description provided for @k_cs747arq.
  ///
  /// In en, this message translates to:
  /// **'+ ฿100'**
  String get k_cs747arq;

  /// No description provided for @k_90dh6gtj.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_90dh6gtj;

  /// No description provided for @k_7dbah7v6.
  ///
  /// In en, this message translates to:
  /// **'+ ฿100'**
  String get k_7dbah7v6;

  /// No description provided for @k_bpluj4b5.
  ///
  /// In en, this message translates to:
  /// **'Provide additional details'**
  String get k_bpluj4b5;

  /// No description provided for @k_i41sqnrr.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,500.00'**
  String get k_i41sqnrr;

  /// No description provided for @k_x9dyn1hg.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get k_x9dyn1hg;

  /// No description provided for @k_cobkynbg.
  ///
  /// In en, this message translates to:
  /// **'Add Order'**
  String get k_cobkynbg;

  /// No description provided for @k_1f0kqucw.
  ///
  /// In en, this message translates to:
  /// **'Rice'**
  String get k_1f0kqucw;

  /// No description provided for @k_lz1gfean.
  ///
  /// In en, this message translates to:
  /// **'+ ฿100'**
  String get k_lz1gfean;

  /// No description provided for @k_zay1saue.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,500.00'**
  String get k_zay1saue;

  /// No description provided for @k_jph82c73.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get k_jph82c73;

  /// No description provided for @k_r5xcsk95.
  ///
  /// In en, this message translates to:
  /// **'Add Order'**
  String get k_r5xcsk95;

  /// No description provided for @k_d6e8v4g3.
  ///
  /// In en, this message translates to:
  /// **'Online Chat Room'**
  String get k_d6e8v4g3;

  /// No description provided for @k_h3gma7d3.
  ///
  /// In en, this message translates to:
  /// **'Find people'**
  String get k_h3gma7d3;

  /// No description provided for @k_g2x0u4xf.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get k_g2x0u4xf;

  /// No description provided for @k_wmiwgemt.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get k_wmiwgemt;

  /// No description provided for @k_fewdyg33.
  ///
  /// In en, this message translates to:
  /// **'SOHO Sigature'**
  String get k_fewdyg33;

  /// No description provided for @k_aan7mvlt.
  ///
  /// In en, this message translates to:
  /// **'SOHO is spicy'**
  String get k_aan7mvlt;

  /// No description provided for @k_ccol7ngk.
  ///
  /// In en, this message translates to:
  /// **'beer'**
  String get k_ccol7ngk;

  /// No description provided for @k_5kpoea0e.
  ///
  /// In en, this message translates to:
  /// **'Soju'**
  String get k_5kpoea0e;

  /// No description provided for @k_nxnq138n.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get k_nxnq138n;

  /// No description provided for @k_ia675ltr.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get k_ia675ltr;

  /// No description provided for @k_x3zr9781.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get k_x3zr9781;

  /// No description provided for @k_ggu4hagg.
  ///
  /// In en, this message translates to:
  /// **'SOHO Signature'**
  String get k_ggu4hagg;

  /// No description provided for @k_mozp8hvv.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_mozp8hvv;

  /// No description provided for @k_n2qvq4u4.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_n2qvq4u4;

  /// No description provided for @k_bxyi01qd.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_bxyi01qd;

  /// No description provided for @k_ocrnb5fm.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_ocrnb5fm;

  /// No description provided for @k_e41z25dn.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_e41z25dn;

  /// No description provided for @k_i64s3x67.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_i64s3x67;

  /// No description provided for @k_y1xv6kjo.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_y1xv6kjo;

  /// No description provided for @k_ng76lwjb.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_ng76lwjb;

  /// No description provided for @k_1lp2gl8m.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get k_1lp2gl8m;

  /// No description provided for @k_ikg6aitr.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_ikg6aitr;

  /// No description provided for @k_kum4si3w.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_kum4si3w;

  /// No description provided for @k_947e88tx.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_947e88tx;

  /// No description provided for @k_1wctir00.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_1wctir00;

  /// No description provided for @k_6yfl41tj.
  ///
  /// In en, this message translates to:
  /// **'SOHO is spicy'**
  String get k_6yfl41tj;

  /// No description provided for @k_ssgnr50l.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_ssgnr50l;

  /// No description provided for @k_ggqgcxpk.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_ggqgcxpk;

  /// No description provided for @k_oczqyicu.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_oczqyicu;

  /// No description provided for @k_lc9zguf6.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_lc9zguf6;

  /// No description provided for @k_bse2b9ts.
  ///
  /// In en, this message translates to:
  /// **'9'**
  String get k_bse2b9ts;

  /// No description provided for @k_z3akpbyx.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_z3akpbyx;

  /// No description provided for @k_igeaepqg.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_igeaepqg;

  /// No description provided for @k_g0ehcspj.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_g0ehcspj;

  /// No description provided for @k_h3bm1clw.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_h3bm1clw;

  /// No description provided for @k_27tet0fu.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_27tet0fu;

  /// No description provided for @k_uv0vnoxl.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_uv0vnoxl;

  /// No description provided for @k_edxd414d.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_edxd414d;

  /// No description provided for @k_gxdtlg64.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_gxdtlg64;

  /// No description provided for @k_6wy1b60a.
  ///
  /// In en, this message translates to:
  /// **'SOJU'**
  String get k_6wy1b60a;

  /// No description provided for @k_16kggjf8.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_16kggjf8;

  /// No description provided for @k_g26oxpq2.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_g26oxpq2;

  /// No description provided for @k_hwe9thng.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_hwe9thng;

  /// No description provided for @k_mhrx3vom.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_mhrx3vom;

  /// No description provided for @k_74jc8aky.
  ///
  /// In en, this message translates to:
  /// **'9'**
  String get k_74jc8aky;

  /// No description provided for @k_lfeh1g45.
  ///
  /// In en, this message translates to:
  /// **'Omelet Rice'**
  String get k_lfeh1g45;

  /// No description provided for @k_ulgc418v.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_ulgc418v;

  /// No description provided for @k_pvmg4zto.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_pvmg4zto;

  /// No description provided for @k_cv22cjfa.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_cv22cjfa;

  /// No description provided for @k_pzmks6g0.
  ///
  /// In en, this message translates to:
  /// **'BEER'**
  String get k_pzmks6g0;

  /// No description provided for @k_m9dipmav.
  ///
  /// In en, this message translates to:
  /// **'Budweiser'**
  String get k_m9dipmav;

  /// No description provided for @k_j1e4ee5l.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_j1e4ee5l;

  /// No description provided for @k_e3q09p5b.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_e3q09p5b;

  /// No description provided for @k_5sy0ayt4.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_5sy0ayt4;

  /// No description provided for @k_pcjzmh60.
  ///
  /// In en, this message translates to:
  /// **'Chang'**
  String get k_pcjzmh60;

  /// No description provided for @k_cpq635c7.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_cpq635c7;

  /// No description provided for @k_vjw2zpem.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_vjw2zpem;

  /// No description provided for @k_t1v5chjo.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_t1v5chjo;

  /// No description provided for @k_headvq2r.
  ///
  /// In en, this message translates to:
  /// **'Heineken'**
  String get k_headvq2r;

  /// No description provided for @k_hz23m7sx.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_hz23m7sx;

  /// No description provided for @k_z284sq5a.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_z284sq5a;

  /// No description provided for @k_z8bmqjg0.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_z8bmqjg0;

  /// No description provided for @k_sqe8yn32.
  ///
  /// In en, this message translates to:
  /// **'Heineken'**
  String get k_sqe8yn32;

  /// No description provided for @k_ojffu2bf.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_ojffu2bf;

  /// No description provided for @k_00751b0b.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_00751b0b;

  /// No description provided for @k_fkty4t4r.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_fkty4t4r;

  /// No description provided for @k_ger8q0sn.
  ///
  /// In en, this message translates to:
  /// **'Colona'**
  String get k_ger8q0sn;

  /// No description provided for @k_0bqpihe7.
  ///
  /// In en, this message translates to:
  /// **'Fire rice egg'**
  String get k_0bqpihe7;

  /// No description provided for @k_58w4o50o.
  ///
  /// In en, this message translates to:
  /// **'120'**
  String get k_58w4o50o;

  /// No description provided for @k_anwikqaw.
  ///
  /// In en, this message translates to:
  /// **'฿'**
  String get k_anwikqaw;

  /// No description provided for @k_8i2gstae.
  ///
  /// In en, this message translates to:
  /// **'My Ticket'**
  String get k_8i2gstae;

  /// No description provided for @k_b81gf5it.
  ///
  /// In en, this message translates to:
  /// **'At Bang Khen'**
  String get k_b81gf5it;

  /// No description provided for @k_kv9vrl9l.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_kv9vrl9l;

  /// No description provided for @k_z82bno7c.
  ///
  /// In en, this message translates to:
  /// **'VVIP'**
  String get k_z82bno7c;

  /// No description provided for @k_9sj9hzbo.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_9sj9hzbo;

  /// No description provided for @k_4ncy5uo7.
  ///
  /// In en, this message translates to:
  /// **'A31'**
  String get k_4ncy5uo7;

  /// No description provided for @k_cbjakro2.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_cbjakro2;

  /// No description provided for @k_ca8y9xo5.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_ca8y9xo5;

  /// No description provided for @k_n8mhccnf.
  ///
  /// In en, this message translates to:
  /// **'฿ 2,500'**
  String get k_n8mhccnf;

  /// No description provided for @k_guuz3sjk.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,500'**
  String get k_guuz3sjk;

  /// No description provided for @k_4b0gsnpb.
  ///
  /// In en, this message translates to:
  /// **'At Bang Khen'**
  String get k_4b0gsnpb;

  /// No description provided for @k_0sfmpf3f.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_0sfmpf3f;

  /// No description provided for @k_7lbn16bw.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get k_7lbn16bw;

  /// No description provided for @k_pyuumycw.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_pyuumycw;

  /// No description provided for @k_fu4l1bn7.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_fu4l1bn7;

  /// No description provided for @k_z1abokhc.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_z1abokhc;

  /// No description provided for @k_vcdav4o3.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_vcdav4o3;

  /// No description provided for @k_dvygpfg5.
  ///
  /// In en, this message translates to:
  /// **'฿ 1,000'**
  String get k_dvygpfg5;

  /// No description provided for @k_xzgrf3xp.
  ///
  /// In en, this message translates to:
  /// **'At Bang Khen'**
  String get k_xzgrf3xp;

  /// No description provided for @k_uzzpq4pf.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_uzzpq4pf;

  /// No description provided for @k_9gtjxitw.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get k_9gtjxitw;

  /// No description provided for @k_f7qxmwpb.
  ///
  /// In en, this message translates to:
  /// **'฿ 500'**
  String get k_f7qxmwpb;

  /// No description provided for @k_odp62rs3.
  ///
  /// In en, this message translates to:
  /// **'At Bang Khen'**
  String get k_odp62rs3;

  /// No description provided for @k_fckewycb.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_fckewycb;

  /// No description provided for @k_f70bzf7k.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get k_f70bzf7k;

  /// No description provided for @k_c1ikjgfb.
  ///
  /// In en, this message translates to:
  /// **'฿ 300'**
  String get k_c1ikjgfb;

  /// No description provided for @k_38h9uedb.
  ///
  /// In en, this message translates to:
  /// **'At Bang Khen'**
  String get k_38h9uedb;

  /// No description provided for @k_35pa20i3.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_35pa20i3;

  /// No description provided for @k_759bx3ul.
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get k_759bx3ul;

  /// No description provided for @k_bgszrtyw.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_bgszrtyw;

  /// No description provided for @k_eis79ors.
  ///
  /// In en, this message translates to:
  /// **'C31'**
  String get k_eis79ors;

  /// No description provided for @k_qt2em628.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_qt2em628;

  /// No description provided for @k_51cczc1m.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_51cczc1m;

  /// No description provided for @k_9ljfrmhh.
  ///
  /// In en, this message translates to:
  /// **'฿ Free'**
  String get k_9ljfrmhh;

  /// No description provided for @k_sbacgt37.
  ///
  /// In en, this message translates to:
  /// **'At Bang Khen'**
  String get k_sbacgt37;

  /// No description provided for @k_qr231cy8.
  ///
  /// In en, this message translates to:
  /// **'Zone :'**
  String get k_qr231cy8;

  /// No description provided for @k_09vtgxz2.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get k_09vtgxz2;

  /// No description provided for @k_vwn1q4jb.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_vwn1q4jb;

  /// No description provided for @k_17d0xiw7.
  ///
  /// In en, this message translates to:
  /// **'B31'**
  String get k_17d0xiw7;

  /// No description provided for @k_zemblpfr.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get k_zemblpfr;

  /// No description provided for @k_c5j2ji7y.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_c5j2ji7y;

  /// No description provided for @k_69vaov15.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get k_69vaov15;

  /// No description provided for @k_qazljgsj.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get k_qazljgsj;

  /// No description provided for @k_9yohsgjh.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_9yohsgjh;

  /// No description provided for @k_q2sw6ifr.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_q2sw6ifr;

  /// No description provided for @k_wpff1y6i.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get k_wpff1y6i;

  /// No description provided for @k_i2dcgvz2.
  ///
  /// In en, this message translates to:
  /// **'PANK'**
  String get k_i2dcgvz2;

  /// No description provided for @k_lfcg4fw9.
  ///
  /// In en, this message translates to:
  /// **'PUK_66'**
  String get k_lfcg4fw9;

  /// No description provided for @k_dpnkemim.
  ///
  /// In en, this message translates to:
  /// **'Booking Conditions Daily Booking Conditions  We only accept students and office workers. Please dress appropriately. ⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️  ❗️Booking Fee: 500 baht per queue. ❗Fully refunded upon table pick-up. ❗️Maximum 20 people per table. ❗️Book 30 days in advance. ❗️Bookings close at 4:00 PM.  Queue Release Conditions: ❗️Tables release at 9:00 PM for Sunday-Thursday❗️ ❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️  **If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏'**
  String get k_dpnkemim;

  /// No description provided for @k_94svsvck.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get k_94svsvck;

  /// No description provided for @k_438ypd8x.
  ///
  /// In en, this message translates to:
  /// **'A78'**
  String get k_438ypd8x;

  /// No description provided for @k_rpsc4srs.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get k_rpsc4srs;

  /// No description provided for @k_csixm5s9.
  ///
  /// In en, this message translates to:
  /// **'/'**
  String get k_csixm5s9;

  /// No description provided for @k_bvr3hfec.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get k_bvr3hfec;

  /// No description provided for @k_8r7nuo39.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_8r7nuo39;

  /// No description provided for @k_obsa885p.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_obsa885p;

  /// No description provided for @k_uo4zwnei.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_uo4zwnei;

  /// No description provided for @k_5nhehlyq.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications when there is a message'**
  String get k_5nhehlyq;

  /// No description provided for @k_74a1bg54.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_74a1bg54;

  /// No description provided for @k_ioz1n3pt.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_ioz1n3pt;

  /// No description provided for @k_q2j4wjbg.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_q2j4wjbg;

  /// No description provided for @k_a1rg12q7.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_a1rg12q7;

  /// No description provided for @k_3atwkrb4.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_3atwkrb4;

  /// No description provided for @k_yrnp0iq6.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_yrnp0iq6;

  /// No description provided for @k_y4u3l9yl.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_y4u3l9yl;

  /// No description provided for @k_kw39ccow.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_kw39ccow;

  /// No description provided for @k_3kjfrgqw.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_3kjfrgqw;

  /// No description provided for @k_f76gnavv.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_f76gnavv;

  /// No description provided for @k_k1jg7nle.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_k1jg7nle;

  /// No description provided for @k_4gvm1zse.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_4gvm1zse;

  /// No description provided for @k_tiygw2nj.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_tiygw2nj;

  /// No description provided for @k_7dljogm6.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_7dljogm6;

  /// No description provided for @k_s3v9gzs8.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_s3v9gzs8;

  /// No description provided for @k_vwri7ojf.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_vwri7ojf;

  /// No description provided for @k_ofmb8xwi.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_ofmb8xwi;

  /// No description provided for @k_08uidtcv.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_08uidtcv;

  /// No description provided for @k_gpsg454i.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_gpsg454i;

  /// No description provided for @k_9jnzf9rp.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_9jnzf9rp;

  /// No description provided for @k_jwzozuza.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_jwzozuza;

  /// No description provided for @k_9rrxuxys.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_9rrxuxys;

  /// No description provided for @k_da10qil4.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_da10qil4;

  /// No description provided for @k_a4s50y0i.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_a4s50y0i;

  /// No description provided for @k_geoqsrif.
  ///
  /// In en, this message translates to:
  /// **''**
  String get k_geoqsrif;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
