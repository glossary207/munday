import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['th', 'en', 'zh_Hans'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? thText = '',
    String? enText = '',
    String? zh_HansText = '',
  }) =>
      [thText, enText, zh_HansText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    '1o27ut5s': {
      'th': 'Search for user',
      'en': 'Search for user',
      'zh_Hans': '搜索用户',
    },
    'hxg0fy2b': {
      'th': 'Latest Users',
      'en': 'Latest Users',
      'zh_Hans': '最新用户',
    },
    '4v2upbkr': {
      'th': 'Open Chat',
      'en': 'Open Chat',
      'zh_Hans': '开放聊天',
    },
    'rm6x99oo': {
      'th': ':',
      'en': ':',
      'zh_Hans': '：',
    },
    '8ckfqaoi': {
      'th': ':',
      'en': ':',
      'zh_Hans': '：',
    },
    'zy6vv0j5': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Chats
  {
    'mtwb7kux': {
      'th': 'Message',
      'en': 'Message',
      'zh_Hans': '信息',
    },
    'kmovo8pm': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Profile
  {
    'wkp4og0j': {
      'th': 'Profile',
      'en': 'Profile',
      'zh_Hans': '轮廓',
    },
    '6ju9gvsj': {
      'th': 'Your name',
      'en': 'Your name',
      'zh_Hans': '你的名字',
    },
    'cy6tkoqn': {
      'th': 'Your caption',
      'en': 'Your caption',
      'zh_Hans': '你的标题',
    },
    'f6ab0k03': {
      'th': 'Profile preview',
      'en': 'Profile preview',
      'zh_Hans': '个人资料预览',
    },
    'eihlwqu6': {
      'th': 'Name Instagram',
      'en': 'Name Instagram',
      'zh_Hans': 'Instagram账号',
    },
    'gqwxd6cb': {
      'th': '143.5 k',
      'en': '143.5 k',
      'zh_Hans': '143.5千',
    },
    '3589bxvt': {
      'th': 'ID  login  Facebook',
      'en': 'Facebook login ID',
      'zh_Hans': 'Facebook登录ID',
    },
    'vl6gjvrd': {
      'th': '143.5 k',
      'en': '143.5 k',
      'zh_Hans': '143.5千',
    },
    'bn6ivwlz': {
      'th': '__',
      'en': '__',
      'zh_Hans': '__',
    },
  },
  // Authentication
  {
    '4dmtkxzc': {
      'th': 'Online Chat Room',
      'en': 'Online Chat Room',
      'zh_Hans': '在线聊天室',
    },
    'vmtn1rxv': {
      'th': 'เข้าสู่ระบบ',
      'en': 'Log in',
      'zh_Hans': '登录',
    },
    '0xkfcss4': {
      'th': 'Email Address',
      'en': 'Email Address',
      'zh_Hans': '电子邮件',
    },
    'gpnbo7nu': {
      'th': 'Enter your email...',
      'en': 'Enter your email...',
      'zh_Hans': '请输入您的邮箱地址……',
    },
    'szr0piqh': {
      'th': 'Password',
      'en': 'Password',
      'zh_Hans': '密码',
    },
    'orzhvtj0': {
      'th': 'Enter your password...',
      'en': 'Enter your password...',
      'zh_Hans': '请输入密码……',
    },
    'h1u9vi3l': {
      'th': 'You agree to the acknowledge the ',
      'en': 'You agree to the acknowledge the',
      'zh_Hans': '您同意承认',
    },
    'dcz85izi': {
      'th': ' privacy policy ',
      'en': 'privacy policy',
      'zh_Hans': '隐私政策',
    },
    'tpiawz92': {
      'th': 'Sign In',
      'en': 'Sign In',
      'zh_Hans': '登入',
    },
    't9sqbre9': {
      'th': 'Or sign up with',
      'en': 'Or sign up with',
      'zh_Hans': '或者注册',
    },
    'uyv0vowy': {
      'th': 'Google',
      'en': 'Google',
      'zh_Hans': '谷歌',
    },
    '05z2v5xy': {
      'th': 'Apple',
      'en': 'Apple',
      'zh_Hans': '苹果',
    },
    '6pm2klvz': {
      'th': 'Forgot Password?',
      'en': 'Forgot Password?',
      'zh_Hans': '忘记密码？',
    },
    'pqvzdk1f': {
      'th': 'สร้างบัญชี',
      'en': 'Create an account',
      'zh_Hans': '创建一个帐户',
    },
    've4fd3yg': {
      'th': 'Nickname',
      'en': 'Nickname',
      'zh_Hans': '昵称',
    },
    'hlqecs1a': {
      'th': 'Enter your Nickname...',
      'en': 'Enter your nickname...',
      'zh_Hans': '请输入您的昵称……',
    },
    'nbo1j458': {
      'th': 'Email Address',
      'en': 'Email Address',
      'zh_Hans': '电子邮件',
    },
    'zegwzt1d': {
      'th': 'Enter your email...',
      'en': 'Enter your email...',
      'zh_Hans': '请输入您的邮箱地址……',
    },
    'wqxzevpm': {
      'th': 'Password',
      'en': 'Password',
      'zh_Hans': '密码',
    },
    '2spsf6j4': {
      'th': 'Enter your password...',
      'en': 'Enter your password...',
      'zh_Hans': '请输入密码……',
    },
    'kcb3k2ox': {
      'th': 'Confirm Password',
      'en': 'Confirm Password',
      'zh_Hans': '确认密码',
    },
    '6sfr1rhd': {
      'th': 'Enter your password...',
      'en': 'Enter your password...',
      'zh_Hans': '请输入密码……',
    },
    'aqzpd3sr': {
      'th': 'You agree to the acknowledge the ',
      'en': 'You agree to the acknowledge the',
      'zh_Hans': '您同意承认',
    },
    'ae7yssaw': {
      'th': ' privacy policy ',
      'en': 'privacy policy',
      'zh_Hans': '隐私政策',
    },
    '53vetovi': {
      'th': 'Create Account',
      'en': 'Create Account',
      'zh_Hans': '创建账户',
    },
    '41twzn6a': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // home
  {
    'jza53d0o': {
      'th': 'คุณมี 10 points',
      'en': 'You have 10 points.',
      'zh_Hans': '你得了10分。',
    },
    'ifexozan': {
      'th': 'ระดับ :',
      'en': 'level :',
      'zh_Hans': '等级 ：',
    },
    '1lam8xke': {
      'th': 'VVVIP',
      'en': 'VVVIP',
      'zh_Hans': '极致贵宾',
    },
    'sx8oo1l5': {
      'th': 'VIP',
      'en': 'VIP',
      'zh_Hans': 'VIP',
    },
    'n9q37elg': {
      'th': 'A78',
      'en': 'A78',
      'zh_Hans': 'A78',
    },
    '89nb8pgs': {
      'th': '3',
      'en': '3',
      'zh_Hans': '3',
    },
    'zzwut81b': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'bvjy4cxr': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'zrv1h23o': {
      'th': 'Online Chat Room',
      'en': 'Online Chat Room',
      'zh_Hans': '在线聊天室',
    },
    's679s8bf': {
      'th': 'ค้นหาผู้คน',
      'en': 'Find people',
      'zh_Hans': '寻找人',
    },
    '95hbq33e': {
      'th': 'Leave',
      'en': 'Leave',
      'zh_Hans': '离开',
    },
    'nmf23spl': {
      'th': 'Menu',
      'en': 'Menu',
      'zh_Hans': '菜单',
    },
    '7dqx0x2h': {
      'th': 'Promotion',
      'en': 'Promotion',
      'zh_Hans': '晋升',
    },
    'l8eqk9pq': {
      'th': 'Menu',
      'en': 'Menu',
      'zh_Hans': '菜单',
    },
    'gxdi3f2f': {
      'th': 'Events',
      'en': 'Events',
      'zh_Hans': '活动',
    },
    'c3ihn4ll': {
      'th': 'SOHO Sigature',
      'en': 'SOHO Sigature',
      'zh_Hans': 'SOHO 签名',
    },
    '2ijyibzr': {
      'th': 'SOHO แซบ',
      'en': 'SOHO is spicy',
      'zh_Hans': 'SOHO很辣',
    },
    'wkacxyok': {
      'th': 'เบียร์',
      'en': 'beer',
      'zh_Hans': '啤酒',
    },
    'jd24thiw': {
      'th': 'โซจู',
      'en': 'Soju',
      'zh_Hans': '烧酒',
    },
    'hydaiewz': {
      'th': 'SOHO Signature',
      'en': 'SOHO Signature',
      'zh_Hans': 'SOHO 签名',
    },
    'h7aigha6': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    '20jz9941': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'hka3eg74': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '7mzxbnk8': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '0zspz9jz': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    '8gfoe3yr': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '8r09trlg': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'x9gjvmx0': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'kbmfk8fb': {
      'th': '2',
      'en': '2',
      'zh_Hans': '2',
    },
    'h5zmj9ni': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    't6ieq3ei': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'y32xdul9': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'cz6xp9fo': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '3ahooyxh': {
      'th': 'SOHO แซบ',
      'en': 'SOHO is spicy',
      'zh_Hans': 'SOHO很辣',
    },
    'lrh68n8q': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'br3pzi55': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '8bb0vlf1': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'he7h9ja5': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'axhfriq1': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'ina1urn0': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'v0aqh8ec': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'a43vuqtp': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '2cd1vune': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'r71bjun7': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'xp6v8pyx': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'u07ufrnd': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '0b8362q5': {
      'th': 'SOJU',
      'en': 'SOJU',
      'zh_Hans': '烧酒',
    },
    'mjmzivy5': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    '8bfn0gcf': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '1av5niej': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '6bxywujx': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'vv5dih4q': {
      'th': '9',
      'en': '9',
      'zh_Hans': '9',
    },
    'a69x38g0': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'lrltctfx': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '1pj155l0': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '3o58br8y': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '6p4hnzd2': {
      'th': 'BEER',
      'en': 'BEER',
      'zh_Hans': '啤酒',
    },
    'wrs8y16r': {
      'th': 'Budweiser',
      'en': 'Budweiser',
      'zh_Hans': '百威啤酒',
    },
    'lu0f1jur': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'yy47n67q': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'f6b4yj4k': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    's5qrh9ui': {
      'th': 'Chang',
      'en': 'Chang',
      'zh_Hans': '张',
    },
    'esyddpqt': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'z9tti8vi': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'flhphdak': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'lugtyj44': {
      'th': 'heineken',
      'en': 'Heineken',
      'zh_Hans': '喜力',
    },
    'bmp2ct9r': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'whutjxis': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '9lui9235': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '50kpigt7': {
      'th': 'heineken',
      'en': 'Heineken',
      'zh_Hans': '喜力',
    },
    '9x2oese4': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '7ym9zp16': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'vn7gl7fc': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'akpgxm0s': {
      'th': 'Colona',
      'en': 'Colona',
      'zh_Hans': '科洛纳',
    },
    '9hodobhf': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '7k7z8fu7': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'scwzxz88': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '53y13stq': {
      'th': 'My Tickets',
      'en': 'My Tickets',
      'zh_Hans': '我的门票',
    },
    'qmh6yd5j': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '0a32enq7': {
      'th': 'VVIP',
      'en': 'VVIP',
      'zh_Hans': '贵宾',
    },
    'jan7y48v': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '67vpqajh': {
      'th': 'A31',
      'en': 'A31',
      'zh_Hans': 'A31',
    },
    'nsq5ypne': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '2xdxwvhh': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'oa4jb8x0': {
      'th': '฿ 2,500',
      'en': '฿ 2,500',
      'zh_Hans': '2,500 泰铢',
    },
    '0fzvnm0i': {
      'th': '฿ 1,500',
      'en': '฿ 1,500',
      'zh_Hans': '1,500 泰铢',
    },
    'd8rx3oht': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'c5e19q8a': {
      'th': 'VIP',
      'en': 'VIP',
      'zh_Hans': 'VIP',
    },
    'pzu2mk3c': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'xgb5c10h': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'y7bqz7se': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'bhswa6w6': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'o868lv4g': {
      'th': '฿ 1,000',
      'en': '฿ 1,000',
      'zh_Hans': '1,000 泰铢',
    },
    'omo6k280': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'zgu7klph': {
      'th': 'A',
      'en': 'A',
      'zh_Hans': '一个',
    },
    'coke8r44': {
      'th': '฿ 500',
      'en': '฿ 500',
      'zh_Hans': '500 泰铢',
    },
    'a7wsrjh8': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'z1c4xn1e': {
      'th': 'B',
      'en': 'B',
      'zh_Hans': 'B',
    },
    'shq99fqr': {
      'th': '฿ 300',
      'en': '฿ 300',
      'zh_Hans': '฿ 300',
    },
    '0pngncto': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '7wbou916': {
      'th': 'C',
      'en': 'C',
      'zh_Hans': 'C',
    },
    '6wdsan0b': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'c419ikq1': {
      'th': 'C31',
      'en': 'C31',
      'zh_Hans': 'C31',
    },
    'y2pex1lp': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'zl6jbews': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '5os2reb5': {
      'th': '฿ Free',
      'en': '฿ Free',
      'zh_Hans': '免费',
    },
    'gabivqc0': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'kbv179q0': {
      'th': 'Regular',
      'en': 'Regular',
      'zh_Hans': '常规的',
    },
    'fhll1d2g': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'y6dte3q4': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'syvfu0z9': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'z1owagsh': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'ry2h7926': {
      'th': 'Check In',
      'en': 'Check In',
      'zh_Hans': '报到',
    },
    'sxhp3nkh': {
      'th': '3',
      'en': '3',
      'zh_Hans': '3',
    },
    'zozupo7c': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'kcxm5sm8': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'clujchkv': {
      'th': 'You',
      'en': 'You',
      'zh_Hans': '你',
    },
    '0dgp04cp': {
      'th': 'PANK',
      'en': 'PANK',
      'zh_Hans': '潘克',
    },
    'a314cm4r': {
      'th': 'PUK_66',
      'en': 'PUK_66',
      'zh_Hans': 'PUK_66',
    },
    '53lbeu8e': {
      'th':
          'เงื่อนไขการจอง\nเงื่อนไขการจองคิวรายวัน\n\nทางร้านรับเฉพาะกลุ่มนักศึกษา\nและพนักงานออฟฟิศ แต่งกายดี\n⚠️ ❗️ ไม่รับทรงเอและเด็กช่าง ❗️⚠️ \n\n❗️ค่าจอง คิวละ 500 บาท\n❗ค่าจองคืนเต็มจำนวน เมื่อมารับโต๊ะ\n❗️1 โต๊ะนั่งได้สูงสุด 20 ท่าน\n❗️จองได้ล่วงหน้า 30 วัน\n❗️ปิดรับจองโต๊ะ 16.00\n\nเงื่อนไขการปล่อยคิว\n❗️ปล่อยโต๊ะ 21.00 สำหรับ อาทิตย์-พฤหัส❗️\n❗ปล่อยโต๊ะ 20.30 สำหรับศุกร์-เสาร์-concert❗️\n\n** หากมาไม่ทันเวลารับโต๊ะ ไม่คืนเงินค่าจองทุกกรณี** 🙏',
      'en':
          'Booking Conditions\nDaily Booking Conditions\n\nWe only accept students\nand office workers. Please dress appropriately.\n⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️\n\n❗️Booking Fee: 500 baht per queue.\n❗Fully refunded upon table pick-up.\n❗️Maximum 20 people per table.\n❗️Book 30 days in advance.\n❗️Bookings close at 4:00 PM.\n\nQueue Release Conditions:\n❗️Tables release at 9:00 PM for Sunday-Thursday❗️\n❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️\n\n**If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏',
      'zh_Hans':
          '预订须知\n\n每日预订须知\n\n我们仅接受学生\n\n和上班族。请着装得体。\n\n⚠️❗️我们不接受A字裙或技校学生。❗️⚠️\n\n❗️预订费：每排500泰铢。\n\n❗️取桌时全额退款。\n\n❗️每桌最多20人。\n\n❗️请提前30天预订。\n\n❗️预订截止时间为下午4:00。\n\n排队释放须知：\n\n❗️周日至周四晚上9:00释放桌位❗️\n\n❗️周五、周六及音乐会期间晚上8:30释放桌位❗️\n\n**如果您错过取桌时间，预订费将不予退还。** 🙏',
    },
    '220hsncj': {
      'th': 'Let\'s Cheers to Chat',
      'en': 'Let\'s Cheers to Chat',
      'zh_Hans': '让我们一起畅聊吧！',
    },
    'qlbe2u09': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // AccountSettings
  {
    '7pvmel5f': {
      'th': 'General',
      'en': 'General',
      'zh_Hans': '一般的',
    },
    'ds3pryja': {
      'th': 'Privacy Policy',
      'en': 'Privacy Policy',
      'zh_Hans': '隐私政策',
    },
    'mpdkrpd2': {
      'th': 'Support',
      'en': 'Support',
      'zh_Hans': '支持',
    },
    'ppvcpis6': {
      'th': 'languages',
      'en': 'languages',
      'zh_Hans': '语言',
    },
    'rva4ipva': {
      'th': 'Showdisplay Vertical',
      'en': 'Vertical Display',
      'zh_Hans': '垂直显示',
    },
    'hageibjl': {
      'th': 'Showdisplay Horizontal',
      'en': 'Showdisplay Horizontal',
      'zh_Hans': '水平显示',
    },
    'hj4c6tri': {
      'th': 'Block list',
      'en': 'Block list',
      'zh_Hans': '阻止列表',
    },
    '6adcjh05': {
      'th': 'Delete Account',
      'en': 'Delete Account',
      'zh_Hans': '删除帐户',
    },
    'ip7gorf2': {
      'th': 'Log Out',
      'en': 'Log Out',
      'zh_Hans': '退出登录',
    },
    '88720ul7': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // privacyPolicy
  {
    '5tsyrm42': {
      'th':
          'Privacy Policy  \n==============\n\nLast updated: February 01, 2024\n\nThis Privacy Policy describes Our policies and procedures on the collection,\nuse and disclosure of Your information when You use the Service and tells You\nabout Your privacy rights and how the law protects You.\n\nWe use Your Personal data to provide and improve the Service. By using the\nService, You agree to the collection and use of information in accordance with\nthis Privacy Policy. This Privacy Policy has been created with the help of Termsfeed.com\n\nInterpretation and Definitions  \n------------------------------\n\nInterpretation  \n~~~~~~~~~~~~~~\n\nThe words of which the initial letter is capitalized have meanings defined\nunder the following conditions. The following definitions shall have the same\nmeaning regardless of whether they appear in singular or in plural.\n\nDefinitions  \n~~~~~~~~~~~\n\nFor the purposes of this Privacy Policy:\n\n  * Account means a unique account created for You to access our Service or\n    parts of our Service.\n\n  * Affiliate means an entity that controls, is controlled by or is under\n    common control with a party, where \"control\" means ownership of 50% or\n    more of the shares, equity interest or other securities entitled to vote\n    for election of directors or other managing authority.\n\n  * Company (referred to as either \"the Company\", \"We\", \"Us\" or \"Our\" in this\n    Agreement) refers to MUNDAY.\n\n  * Cookies are small files that are placed on Your computer, mobile device or\n    any other device by a website, containing the details of Your browsing\n    history on that website among its many uses.\n\n  * Country refers to: Thailand\n\n  * Device means any device that can access the Service such as a computer, a\n    cellphone or a digital tablet.\n\n  * Personal Data is any information that relates to an identified or\n    identifiable individual.\n\n  * Service refers to the Website.\n\n  * Service Provider means any natural or legal person who processes the data\n    on behalf of the Company. It refers to third-party companies or\n    individuals employed by the Company to facilitate the Service, to provide\n    the Service on behalf of the Company, to perform services related to the\n    Service or to assist the Company in analyzing how the Service is used.\n\n  * Third-party Social Media Service refers to any website or any social\n    network website through which a User can log in or create an account to\n    use the Service.\n\n  * Usage Data refers to data collected automatically, either generated by the\n    use of the Service or from the Service infrastructure itself (for example,\n    the duration of a page visit).\n\n  * Website refers to MUNDAY, accessible from mun-day.com\n\n  * You means the individual accessing or using the Service, or the company,\n    or other legal entity on behalf of which such individual is accessing or\n    using the Service, as applicable.\n\nCollecting and Using Your Personal Data  \n---------------------------------------\n\nTypes of Data Collected  \n~~~~~~~~~~~~~~~~~~~~~~~\n\nPersonal Data  \n*************\n\nWhile using Our Service, We may ask You to provide Us with certain personally\nidentifiable information that can be used to contact or identify You.\nPersonally identifiable information may include, but is not limited to:\n\n  * Email address\n\n  * Usage Data\n\nUsage Data  \n**********\n\nUsage Data is collected automatically when using the Service.\n\nUsage Data may include information such as Your Device\'s Internet Protocol\naddress (e.g. IP address), browser type, browser version, the pages of our\nService that You visit, the time and date of Your visit, the time spent on\nthose pages, unique device identifiers and other diagnostic data.\n\nWhen You access the Service by or through a mobile device, We may collect\ncertain information automatically, including, but not limited to, the type of\nmobile device You use, Your mobile device unique ID, the IP address of Your\nmobile device, Your mobile operating system, the type of mobile Internet\nbrowser You use, unique device identifiers and other diagnostic data.\n\nWe may also collect information that Your browser sends whenever You visit our\nService or when You access the Service by or through a mobile device.\n\nInformation from Third-Party Social Media Services  \n**************************************************\n\nThe Company allows You to create an account and log in to use the Service\nthrough the following Third-party Social Media Services:\n\n  * Google\n\nIf You decide to register through or otherwise grant us access to a Third-\nParty Social Media Service, We may collect Personal data that is already\nassociated with Your Third-Party Social Media Service\'s account, such as Your\nname, Your email address, Your activities or Your contact list associated with\nthat account.\n\nYou may also have the option of sharing additional information with the\nCompany through Your Third-Party Social Media Service\'s account. If You choose\nto provide such information and Personal Data, during registration or\notherwise, You are giving the Company permission to use, share, and store it\nin a manner consistent with this Privacy Policy.\n\nTracking Technologies and Cookies  \n*********************************\n\nWe use Cookies and similar tracking technologies to track the activity on Our\nService and store certain information. Tracking technologies used are beacons,\ntags, and scripts to collect and track information and to improve and analyze\nOur Service. The technologies We use may include:\n\n  * Cookies or Browser Cookies. A cookie is a small file placed on Your\n    Device. You can instruct Your browser to refuse all Cookies or to indicate\n    when a Cookie is being sent. However, if You do not accept Cookies, You\n    may not be able to use some parts of our Service. Unless you have adjusted\n    Your browser setting so that it will refuse Cookies, our Service may use\n    Cookies.\n  * Web Beacons. Certain sections of our Service and our emails may contain\n    small electronic files known as web beacons (also referred to as clear\n    gifs, pixel tags, and single-pixel gifs) that permit the Company, for\n    example, to count users who have visited those pages or opened an email\n    and for other related website statistics (for example, recording the\n    popularity of a certain section and verifying system and server\n    integrity).\n\nCookies can be \"Persistent\" or \"Session\" Cookies. Persistent Cookies remain on\nYour personal computer or mobile device when You go offline, while Session\nCookies are deleted as soon as You close Your web browser. You can learn more\nabout cookies on [TermsFeed\nwebsite](https://www.termsfeed.com/blog/cookies/#What_Are_Cookies) article.\n\nWe use both Session and Persistent Cookies for the purposes set out below:\n\n  * Necessary / Essential Cookies\n\n    Type: Session Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies are essential to provide You with services\n    available through the Website and to enable You to use some of its\n    features. They help to authenticate users and prevent fraudulent use of\n    user accounts. Without these Cookies, the services that You have asked for\n    cannot be provided, and We only use these Cookies to provide You with\n    those services.\n\n  * Cookies Policy / Notice Acceptance Cookies\n\n    Type: Persistent Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies identify if users have accepted the use of cookies\n    on the Website.\n\n  * Functionality Cookies\n\n    Type: Persistent Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies allow us to remember choices You make when You use\n    the Website, such as remembering your login details or language\n    preference. The purpose of these Cookies is to provide You with a more\n    personal experience and to avoid You having to re-enter your preferences\n    every time You use the Website.\n\nFor more information about the cookies we use and your choices regarding\ncookies, please visit our Cookies Policy or the Cookies section of our Privacy\nPolicy.\n\nUse of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe Company may use Personal Data for the following purposes:\n\n  * To provide and maintain our Service , including to monitor the usage of\n    our Service.\n\n  * To manage Your Account: to manage Your registration as a user of the\n    Service. The Personal Data You provide can give You access to different\n    functionalities of the Service that are available to You as a registered\n    user.\n\n  * For the performance of a contract: the development, compliance and\n    undertaking of the purchase contract for the products, items or services\n    You have purchased or of any other contract with Us through the Service.\n\n  * To contact You: To contact You by email, telephone calls, SMS, or other\n    equivalent forms of electronic communication, such as a mobile\n    application\'s push notifications regarding updates or informative\n    communications related to the functionalities, products or contracted\n    services, including the security updates, when necessary or reasonable for\n    their implementation.\n\n  * To provide You with news, special offers and general information about\n    other goods, services and events which we offer that are similar to those\n    that you have already purchased or enquired about unless You have opted\n    not to receive such information.\n\n  * To manage Your requests: To attend and manage Your requests to Us.\n\n  * For business transfers: We may use Your information to evaluate or conduct\n    a merger, divestiture, restructuring, reorganization, dissolution, or\n    other sale or transfer of some or all of Our assets, whether as a going\n    concern or as part of bankruptcy, liquidation, or similar proceeding, in\n    which Personal Data held by Us about our Service users is among the assets\n    transferred.\n\n  * For other purposes : We may use Your information for other purposes, such\n    as data analysis, identifying usage trends, determining the effectiveness\n    of our promotional campaigns and to evaluate and improve our Service,\n    products, services, marketing and your experience.\n\nWe may share Your personal information in the following situations:\n\n  * With Service Providers: We may share Your personal information with\n    Service Providers to monitor and analyze the use of our Service, to\n    contact You.\n  * For business transfers: We may share or transfer Your personal information\n    in connection with, or during negotiations of, any merger, sale of Company\n    assets, financing, or acquisition of all or a portion of Our business to\n    another company.\n  * With Affiliates: We may share Your information with Our affiliates, in\n    which case we will require those affiliates to honor this Privacy Policy.\n    Affiliates include Our parent company and any other subsidiaries, joint\n    venture partners or other companies that We control or that are under\n    common control with Us.\n  * With business partners: We may share Your information with Our business\n    partners to offer You certain products, services or promotions.\n  * With other users: when You share personal information or otherwise\n    interact in the public areas with other users, such information may be\n    viewed by all users and may be publicly distributed outside. If You\n    interact with other users or register through a Third-Party Social Media\n    Service, Your contacts on the Third-Party Social Media Service may see\n    Your name, profile, pictures and description of Your activity. Similarly,\n    other users will be able to view descriptions of Your activity,\n    communicate with You and view Your profile.\n  * With Your consent : We may disclose Your personal information for any\n    other purpose with Your consent.\n\nRetention of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe Company will retain Your Personal Data only for as long as is necessary\nfor the purposes set out in this Privacy Policy. We will retain and use Your\nPersonal Data to the extent necessary to comply with our legal obligations\n(for example, if we are required to retain your data to comply with applicable\nlaws), resolve disputes, and enforce our legal agreements and policies.\n\nThe Company will also retain Usage Data for internal analysis purposes. Usage\nData is generally retained for a shorter period of time, except when this data\nis used to strengthen the security or to improve the functionality of Our\nService, or We are legally obligated to retain this data for longer time\nperiods.\n\nTransfer of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nYour information, including Personal Data, is processed at the Company\'s\noperating offices and in any other places where the parties involved in the\nprocessing are located. It means that this information may be transferred to —\nand maintained on — computers located outside of Your state, province, country\nor other governmental jurisdiction where the data protection laws may differ\nthan those from Your jurisdiction.\n\nYour consent to this Privacy Policy followed by Your submission of such\ninformation represents Your agreement to that transfer.\n\nThe Company will take all steps reasonably necessary to ensure that Your data\nis treated securely and in accordance with this Privacy Policy and no transfer\nof Your Personal Data will take place to an organization or a country unless\nthere are adequate controls in place including the security of Your data and\nother personal information.\n\nDelete Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~\n\nYou have the right to delete or request that We assist in deleting the\nPersonal Data that We have collected about You.\n\nOur Service may give You the ability to delete certain information about You\nfrom within the Service.\n\nYou may update, amend, or delete Your information at any time by signing in to\nYour Account, if you have one, and visiting the account settings section that\nallows you to manage Your personal information. You may also contact Us to\nrequest access to, correct, or delete any personal information that You have\nprovided to Us.\n\nPlease note, however, that We may need to retain certain information when we\nhave a legal obligation or lawful basis to do so.\n\nDisclosure of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nBusiness Transactions  \n*********************\n\nIf the Company is involved in a merger, acquisition or asset sale, Your\nPersonal Data may be transferred. We will provide notice before Your Personal\nData is transferred and becomes subject to a different Privacy Policy.\n\nLaw enforcement  \n***************\n\nUnder certain circumstances, the Company may be required to disclose Your\nPersonal Data if required to do so by law or in response to valid requests by\npublic authorities (e.g. a court or a government agency).\n\nOther legal requirements  \n************************\n\nThe Company may disclose Your Personal Data in the good faith belief that such\naction is necessary to:\n\n  * Comply with a legal obligation\n  * Protect and defend the rights or property of the Company\n  * Prevent or investigate possible wrongdoing in connection with the Service\n  * Protect the personal safety of Users of the Service or the public\n  * Protect against legal liability\n\nSecurity of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe security of Your Personal Data is important to Us, but remember that no\nmethod of transmission over the Internet, or method of electronic storage is\n100% secure. While We strive to use commercially acceptable means to protect\nYour Personal Data, We cannot guarantee its absolute security.\n\nChildren\'s Privacy  \n------------------\n\nOur Service does not address anyone under the age of 13. We do not knowingly\ncollect personally identifiable information from anyone under the age of 13.\nIf You are a parent or guardian and You are aware that Your child has provided\nUs with Personal Data, please contact Us. If We become aware that We have\ncollected Personal Data from anyone under the age of 13 without verification\nof parental consent, We take steps to remove that information from Our\nservers.\n\nIf We need to rely on consent as a legal basis for processing Your information\nand Your country requires consent from a parent, We may require Your parent\'s\nconsent before We collect and use that information.\n\nLinks to Other Websites  \n-----------------------\n\nOur Service may contain links to other websites that are not operated by Us.\nIf You click on a third party link, You will be directed to that third party\'s\nsite. We strongly advise You to review the Privacy Policy of every site You\nvisit.\n\nWe have no control over and assume no responsibility for the content, privacy\npolicies or practices of any third party sites or services.\n\nChanges to this Privacy Policy  \n------------------------------\n\nWe may update Our Privacy Policy from time to time. We will notify You of any\nchanges by posting the new Privacy Policy on this page.\n\nWe will let You know via email and/or a prominent notice on Our Service, prior\nto the change becoming effective and update the \"Last updated\" date at the top\nof this Privacy Policy.\n\nYou are advised to review this Privacy Policy periodically for any changes.\nChanges to this Privacy Policy are effective when they are posted on this\npage.\n\nContact Us  \n----------\n\nIf you have any questions about this Privacy Policy, You can contact us by email: info.munday@gmail.com\n\n\n\n',
      'en':
          'Privacy Policy  \n==============\n\nLast updated: February 01, 2024\n\nThis Privacy Policy describes Our policies and procedures on the collection,\nuse and disclosure of Your information when You use the Service and tells You\nabout Your privacy rights and how the law protects You.\n\nWe use Your Personal data to provide and improve the Service. By using the\nService, You agree to the collection and use of information in accordance with\nthis Privacy Policy. This Privacy Policy has been created with the help of Termsfeed.com\n\nInterpretation and Definitions  \n------------------------------\n\nInterpretation  \n~~~~~~~~~~~~~~\n\nThe words of which the initial letter is capitalized have meanings defined\nunder the following conditions. The following definitions shall have the same\nmeaning regardless of whether they appear in singular or in plural.\n\nDefinitions  \n~~~~~~~~~~~\n\nFor the purposes of this Privacy Policy:\n\n  * Account means a unique account created for You to access our Service or\n    parts of our Service.\n\n  * Affiliate means an entity that controls, is controlled by or is under\n    common control with a party, where \"control\" means ownership of 50% or\n    more of the shares, equity interest or other securities entitled to vote\n    for election of directors or other managing authority.\n\n  * Company (referred to as either \"the Company\", \"We\", \"Us\" or \"Our\" in this\n    Agreement) refers to MUNDAY.\n\n  * Cookies are small files that are placed on Your computer, mobile device or\n    any other device by a website, containing the details of Your browsing\n    history on that website among its many uses.\n\n  * Country refers to: Thailand\n\n  * Device means any device that can access the Service such as a computer, a\n    cellphone or a digital tablet.\n\n  * Personal Data is any information that relates to an identified or\n    identifiable individual.\n\n  * Service refers to the Website.\n\n  * Service Provider means any natural or legal person who processes the data\n    on behalf of the Company. It refers to third-party companies or\n    individuals employed by the Company to facilitate the Service, to provide\n    the Service on behalf of the Company, to perform services related to the\n    Service or to assist the Company in analyzing how the Service is used.\n\n  * Third-party Social Media Service refers to any website or any social\n    network website through which a User can log in or create an account to\n    use the Service.\n\n  * Usage Data refers to data collected automatically, either generated by the\n    use of the Service or from the Service infrastructure itself (for example,\n    the duration of a page visit).\n\n  * Website refers to MUNDAY, accessible from mun-day.com\n\n  * You means the individual accessing or using the Service, or the company,\n    or other legal entity on behalf of which such individual is accessing or\n    using the Service, as applicable.\n\nCollecting and Using Your Personal Data  \n---------------------------------------\n\nTypes of Data Collected  \n~~~~~~~~~~~~~~~~~~~~~~~\n\nPersonal Data  \n*************\n\nWhile using Our Service, We may ask You to provide Us with certain personally\nidentifiable information that can be used to contact or identify You.\nPersonally identifiable information may include, but is not limited to:\n\n  * Email address\n\n  * Usage Data\n\nUsage Data  \n**********\n\nUsage Data is collected automatically when using the Service.\n\nUsage Data may include information such as Your Device\'s Internet Protocol\naddress (e.g. IP address), browser type, browser version, the pages of our\nService that You visit, the time and date of Your visit, the time spent on\nthose pages, unique device identifiers and other diagnostic data.\n\nWhen You access the Service by or through a mobile device, We may collect\ncertain information automatically, including, but not limited to, the type of\nmobile device You use, Your mobile device unique ID, the IP address of Your\nmobile device, Your mobile operating system, the type of mobile Internet\nbrowser You use, unique device identifiers and other diagnostic data.\n\nWe may also collect information that Your browser sends whenever You visit our\nService or when You access the Service by or through a mobile device.\n\nInformation from Third-Party Social Media Services  \n**************************************************\n\nThe Company allows You to create an account and log in to use the Service\nthrough the following Third-party Social Media Services:\n\n  * Google\n\nIf You decide to register through or otherwise grant us access to a Third-\nParty Social Media Service, We may collect Personal data that is already\nassociated with Your Third-Party Social Media Service\'s account, such as Your\nname, Your email address, Your activities or Your contact list associated with\nthat account.\n\nYou may also have the option of sharing additional information with the\nCompany through Your Third-Party Social Media Service\'s account. If You choose\nto provide such information and Personal Data, during registration or\notherwise, You are giving the Company permission to use, share, and store it\nin a manner consistent with this Privacy Policy.\n\nTracking Technologies and Cookies  \n*********************************\n\nWe use Cookies and similar tracking technologies to track the activity on Our\nService and store certain information. Tracking technologies used are beacons,\ntags, and scripts to collect and track information and to improve and analyze\nOur Service. The technologies We use may include:\n\n  * Cookies or Browser Cookies. A cookie is a small file placed on Your\n    Device. You can instruct Your browser to refuse all Cookies or to indicate\n    when a Cookie is being sent. However, if You do not accept Cookies, You\n    may not be able to use some parts of our Service. Unless you have adjusted\n    Your browser setting so that it will refuse Cookies, our Service may use\n    Cookies.\n  * Web Beacons. Certain sections of our Service and our emails may contain\n    small electronic files known as web beacons (also referred to as clear\n    gifs, pixel tags, and single-pixel gifs) that permit the Company, for\n    example, to count users who have visited those pages or opened an email\n    and for other related website statistics (for example, recording the\n    popularity of a certain section and verifying system and server\n    integrity).\n\nCookies can be \"Persistent\" or \"Session\" Cookies. Persistent Cookies remain on\nYour personal computer or mobile device when You go offline, while Session\nCookies are deleted as soon as You close Your web browser. You can learn more\nabout cookies on [TermsFeed\nwebsite](https://www.termsfeed.com/blog/cookies/#What_Are_Cookies) article.\n\nWe use both Session and Persistent Cookies for the purposes set out below:\n\n  * Necessary / Essential Cookies\n\n    Type: Session Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies are essential to provide You with services\n    available through the Website and to enable You to use some of its\n    features. They help to authenticate users and prevent fraudulent use of\n    user accounts. Without these Cookies, the services that You have asked for\n    cannot be provided, and We only use these Cookies to provide You with\n    those services.\n\n  * Cookies Policy / Notice Acceptance Cookies\n\n    Type: Persistent Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies identify if users have accepted the use of cookies\n    on the Website.\n\n  * Functionality Cookies\n\n    Type: Persistent Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies allow us to remember choices You make when You use\n    the Website, such as remembering your login details or language\n    preference. The purpose of these Cookies is to provide You with a more\n    personal experience and to avoid You having to re-enter your preferences\n    every time You use the Website.\n\nFor more information about the cookies we use and your choices regarding\ncookies, please visit our Cookies Policy or the Cookies section of our Privacy\nPolicy.\n\nUse of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe Company may use Personal Data for the following purposes:\n\n  * To provide and maintain our Service , including to monitor the usage of\n    our Service.\n\n  * To manage Your Account: to manage Your registration as a user of the\n    Service. The Personal Data You provide can give You access to different\n    functionalities of the Service that are available to You as a registered\n    user.\n\n  * For the performance of a contract: the development, compliance and\n    undertaking of the purchase contract for the products, items or services\n    You have purchased or of any other contract with Us through the Service.\n\n  * To contact You: To contact You by email, telephone calls, SMS, or other\n    equivalent forms of electronic communication, such as a mobile\n    application\'s push notifications regarding updates or informative\n    communications related to the functionalities, products or contracted\n    services, including the security updates, when necessary or reasonable for\n    their implementation.\n\n  * To provide You with news, special offers and general information about\n    other goods, services and events which we offer that are similar to those\n    that you have already purchased or enquired about unless You have opted\n    not to receive such information.\n\n  * To manage Your requests: To attend and manage Your requests to Us.\n\n  * For business transfers: We may use Your information to evaluate or conduct\n    a merger, divestiture, restructuring, reorganization, dissolution, or\n    other sale or transfer of some or all of Our assets, whether as a going\n    concern or as part of bankruptcy, liquidation, or similar proceeding, in\n    which Personal Data held by Us about our Service users is among the assets\n    transferred.\n\n  * For other purposes : We may use Your information for other purposes, such\n    as data analysis, identifying usage trends, determining the effectiveness\n    of our promotional campaigns and to evaluate and improve our Service,\n    products, services, marketing and your experience.\n\nWe may share Your personal information in the following situations:\n\n  * With Service Providers: We may share Your personal information with\n    Service Providers to monitor and analyze the use of our Service, to\n    contact You.\n  * For business transfers: We may share or transfer Your personal information\n    in connection with, or during negotiations of, any merger, sale of Company\n    assets, financing, or acquisition of all or a portion of Our business to\n    another company.\n  * With Affiliates: We may share Your information with Our affiliates, in\n    which case we will require those affiliates to honor this Privacy Policy.\n    Affiliates include Our parent company and any other subsidiaries, joint\n    venture partners or other companies that We control or that are under\n    common control with Us.\n  * With business partners: We may share Your information with Our business\n    partners to offer You certain products, services or promotions.\n  * With other users: when You share personal information or otherwise\n    interact in the public areas with other users, such information may be\n    viewed by all users and may be publicly distributed outside. If You\n    interact with other users or register through a Third-Party Social Media\n    Service, Your contacts on the Third-Party Social Media Service may see\n    Your name, profile, pictures and description of Your activity. Similarly,\n    other users will be able to view descriptions of Your activity,\n    communicate with You and view Your profile.\n  * With Your consent : We may disclose Your personal information for any\n    other purpose with Your consent.\n\nRetention of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe Company will retain Your Personal Data only for as long as is necessary\nfor the purposes set out in this Privacy Policy. We will retain and use Your\nPersonal Data to the extent necessary to comply with our legal obligations\n(for example, if we are required to retain your data to comply with applicable\nlaws), resolve disputes, and enforce our legal agreements and policies.\n\nThe Company will also retain Usage Data for internal analysis purposes. Usage\nData is generally retained for a shorter period of time, except when this data\nis used to strengthen the security or to improve the functionality of Our\nService, or We are legally obligated to retain this data for longer time\nperiods.\n\nTransfer of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nYour information, including Personal Data, is processed at the Company\'s\noperating offices and in any other places where the parties involved in the\nprocessing are located. It means that this information may be transferred to —\nand maintained on — computers located outside of Your state, province, country\nor other governmental jurisdiction where the data protection laws may differ\nthan those from Your jurisdiction.\n\nYour consent to this Privacy Policy followed by Your submission of such\ninformation represents Your agreement to that transfer.\n\nThe Company will take all steps reasonably necessary to ensure that Your data\nis treated securely and in accordance with this Privacy Policy and no transfer\nof Your Personal Data will take place to an organization or a country unless\nthere are adequate controls in place including the security of Your data and\nother personal information.\n\nDelete Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~\n\nYou have the right to delete or request that We assist in deleting the\nPersonal Data that We have collected about You.\n\nOur Service may give You the ability to delete certain information about You\nfrom within the Service.\n\nYou may update, amend, or delete Your information at any time by signing in to\nYour Account, if you have one, and visiting the account settings section that\nallows you to manage Your personal information. You may also contact Us to\nrequest access to, correct, or delete any personal information that You have\nprovided to Us.\n\nPlease note, however, that We may need to retain certain information when we\nhave a legal obligation or lawful basis to do so.\n\nDisclosure of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nBusiness Transactions  \n*********************\n\nIf the Company is involved in a merger, acquisition or asset sale, Your\nPersonal Data may be transferred. We will provide notice before Your Personal\nData is transferred and becomes subject to a different Privacy Policy.\n\nLaw enforcement  \n***************\n\nUnder certain circumstances, the Company may be required to disclose Your\nPersonal Data if required to do so by law or in response to valid requests by\npublic authorities (e.g. a court or a government agency).\n\nOther legal requirements  \n************************\n\nThe Company may disclose Your Personal Data in the good faith belief that such\naction is necessary to:\n\n  * Comply with a legal obligation\n  * Protect and defend the rights or property of the Company\n  * Prevent or investigate possible wrongdoing in connection with the Service\n  * Protect the personal safety of Users of the Service or the public\n  * Protect against legal liability\n\nSecurity of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe security of Your Personal Data is important to Us, but remember that no\nmethod of transmission over the Internet, or method of electronic storage is\n100% secure. While We strive to use commercially acceptable means to protect\nYour Personal Data, We cannot guarantee its absolute security.\n\nChildren\'s Privacy  \n------------------\n\nOur Service does not address anyone under the age of 13. We do not knowingly\ncollect personally identifiable information from anyone under the age of 13.\nIf You are a parent or guardian and You are aware that Your child has provided\nUs with Personal Data, please contact Us. If We become aware that We have\ncollected Personal Data from anyone under the age of 13 without verification\nof parental consent, We take steps to remove that information from Our\nservers.\n\nIf We need to rely on consent as a legal basis for processing Your information\nand Your country requires consent from a parent, We may require Your parent\'s\nconsent before We collect and use that information.\n\nLinks to Other Websites  \n-----------------------\n\nOur Service may contain links to other websites that are not operated by Us.\nIf You click on a third party link, You will be directed to that third party\'s\nsite. We strongly advise You to review the Privacy Policy of every site You\nvisit.\n\nWe have no control over and assume no responsibility for the content, privacy\npolicies or practices of any third party sites or services.\n\nChanges to this Privacy Policy  \n------------------------------\n\nWe may update Our Privacy Policy from time to time. We will notify You of any\nchanges by posting the new Privacy Policy on this page.\n\nWe will let You know via email and/or a prominent notice on Our Service, prior\nto the change becoming effective and update the \"Last updated\" date at the top\nof this Privacy Policy.\n\nYou are advised to review this Privacy Policy periodically for any changes.\nChanges to this Privacy Policy are effective when they are posted on this\npage.\n\nContact Us  \n----------\n\nIf you have any questions about this Privacy Policy, You can contact us by email: info.munday@gmail.com\n\n\n\n',
      'zh_Hans':
          'Privacy Policy  \n==============\n\nLast updated: February 01, 2024\n\nThis Privacy Policy describes Our policies and procedures on the collection,\nuse and disclosure of Your information when You use the Service and tells You\nabout Your privacy rights and how the law protects You.\n\nWe use Your Personal data to provide and improve the Service. By using the\nService, You agree to the collection and use of information in accordance with\nthis Privacy Policy. This Privacy Policy has been created with the help of Termsfeed.com\n\nInterpretation and Definitions  \n------------------------------\n\nInterpretation  \n~~~~~~~~~~~~~~\n\nThe words of which the initial letter is capitalized have meanings defined\nunder the following conditions. The following definitions shall have the same\nmeaning regardless of whether they appear in singular or in plural.\n\nDefinitions  \n~~~~~~~~~~~\n\nFor the purposes of this Privacy Policy:\n\n  * Account means a unique account created for You to access our Service or\n    parts of our Service.\n\n  * Affiliate means an entity that controls, is controlled by or is under\n    common control with a party, where \"control\" means ownership of 50% or\n    more of the shares, equity interest or other securities entitled to vote\n    for election of directors or other managing authority.\n\n  * Company (referred to as either \"the Company\", \"We\", \"Us\" or \"Our\" in this\n    Agreement) refers to MUNDAY.\n\n  * Cookies are small files that are placed on Your computer, mobile device or\n    any other device by a website, containing the details of Your browsing\n    history on that website among its many uses.\n\n  * Country refers to: Thailand\n\n  * Device means any device that can access the Service such as a computer, a\n    cellphone or a digital tablet.\n\n  * Personal Data is any information that relates to an identified or\n    identifiable individual.\n\n  * Service refers to the Website.\n\n  * Service Provider means any natural or legal person who processes the data\n    on behalf of the Company. It refers to third-party companies or\n    individuals employed by the Company to facilitate the Service, to provide\n    the Service on behalf of the Company, to perform services related to the\n    Service or to assist the Company in analyzing how the Service is used.\n\n  * Third-party Social Media Service refers to any website or any social\n    network website through which a User can log in or create an account to\n    use the Service.\n\n  * Usage Data refers to data collected automatically, either generated by the\n    use of the Service or from the Service infrastructure itself (for example,\n    the duration of a page visit).\n\n  * Website refers to MUNDAY, accessible from mun-day.com\n\n  * You means the individual accessing or using the Service, or the company,\n    or other legal entity on behalf of which such individual is accessing or\n    using the Service, as applicable.\n\nCollecting and Using Your Personal Data  \n---------------------------------------\n\nTypes of Data Collected  \n~~~~~~~~~~~~~~~~~~~~~~~\n\nPersonal Data  \n*************\n\nWhile using Our Service, We may ask You to provide Us with certain personally\nidentifiable information that can be used to contact or identify You.\nPersonally identifiable information may include, but is not limited to:\n\n  * Email address\n\n  * Usage Data\n\nUsage Data  \n**********\n\nUsage Data is collected automatically when using the Service.\n\nUsage Data may include information such as Your Device\'s Internet Protocol\naddress (e.g. IP address), browser type, browser version, the pages of our\nService that You visit, the time and date of Your visit, the time spent on\nthose pages, unique device identifiers and other diagnostic data.\n\nWhen You access the Service by or through a mobile device, We may collect\ncertain information automatically, including, but not limited to, the type of\nmobile device You use, Your mobile device unique ID, the IP address of Your\nmobile device, Your mobile operating system, the type of mobile Internet\nbrowser You use, unique device identifiers and other diagnostic data.\n\nWe may also collect information that Your browser sends whenever You visit our\nService or when You access the Service by or through a mobile device.\n\nInformation from Third-Party Social Media Services  \n**************************************************\n\nThe Company allows You to create an account and log in to use the Service\nthrough the following Third-party Social Media Services:\n\n  * Google\n\nIf You decide to register through or otherwise grant us access to a Third-\nParty Social Media Service, We may collect Personal data that is already\nassociated with Your Third-Party Social Media Service\'s account, such as Your\nname, Your email address, Your activities or Your contact list associated with\nthat account.\n\nYou may also have the option of sharing additional information with the\nCompany through Your Third-Party Social Media Service\'s account. If You choose\nto provide such information and Personal Data, during registration or\notherwise, You are giving the Company permission to use, share, and store it\nin a manner consistent with this Privacy Policy.\n\nTracking Technologies and Cookies  \n*********************************\n\nWe use Cookies and similar tracking technologies to track the activity on Our\nService and store certain information. Tracking technologies used are beacons,\ntags, and scripts to collect and track information and to improve and analyze\nOur Service. The technologies We use may include:\n\n  * Cookies or Browser Cookies. A cookie is a small file placed on Your\n    Device. You can instruct Your browser to refuse all Cookies or to indicate\n    when a Cookie is being sent. However, if You do not accept Cookies, You\n    may not be able to use some parts of our Service. Unless you have adjusted\n    Your browser setting so that it will refuse Cookies, our Service may use\n    Cookies.\n  * Web Beacons. Certain sections of our Service and our emails may contain\n    small electronic files known as web beacons (also referred to as clear\n    gifs, pixel tags, and single-pixel gifs) that permit the Company, for\n    example, to count users who have visited those pages or opened an email\n    and for other related website statistics (for example, recording the\n    popularity of a certain section and verifying system and server\n    integrity).\n\nCookies can be \"Persistent\" or \"Session\" Cookies. Persistent Cookies remain on\nYour personal computer or mobile device when You go offline, while Session\nCookies are deleted as soon as You close Your web browser. You can learn more\nabout cookies on [TermsFeed\nwebsite](https://www.termsfeed.com/blog/cookies/#What_Are_Cookies) article.\n\nWe use both Session and Persistent Cookies for the purposes set out below:\n\n  * Necessary / Essential Cookies\n\n    Type: Session Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies are essential to provide You with services\n    available through the Website and to enable You to use some of its\n    features. They help to authenticate users and prevent fraudulent use of\n    user accounts. Without these Cookies, the services that You have asked for\n    cannot be provided, and We only use these Cookies to provide You with\n    those services.\n\n  * Cookies Policy / Notice Acceptance Cookies\n\n    Type: Persistent Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies identify if users have accepted the use of cookies\n    on the Website.\n\n  * Functionality Cookies\n\n    Type: Persistent Cookies\n\n    Administered by: Us\n\n    Purpose: These Cookies allow us to remember choices You make when You use\n    the Website, such as remembering your login details or language\n    preference. The purpose of these Cookies is to provide You with a more\n    personal experience and to avoid You having to re-enter your preferences\n    every time You use the Website.\n\nFor more information about the cookies we use and your choices regarding\ncookies, please visit our Cookies Policy or the Cookies section of our Privacy\nPolicy.\n\nUse of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe Company may use Personal Data for the following purposes:\n\n  * To provide and maintain our Service , including to monitor the usage of\n    our Service.\n\n  * To manage Your Account: to manage Your registration as a user of the\n    Service. The Personal Data You provide can give You access to different\n    functionalities of the Service that are available to You as a registered\n    user.\n\n  * For the performance of a contract: the development, compliance and\n    undertaking of the purchase contract for the products, items or services\n    You have purchased or of any other contract with Us through the Service.\n\n  * To contact You: To contact You by email, telephone calls, SMS, or other\n    equivalent forms of electronic communication, such as a mobile\n    application\'s push notifications regarding updates or informative\n    communications related to the functionalities, products or contracted\n    services, including the security updates, when necessary or reasonable for\n    their implementation.\n\n  * To provide You with news, special offers and general information about\n    other goods, services and events which we offer that are similar to those\n    that you have already purchased or enquired about unless You have opted\n    not to receive such information.\n\n  * To manage Your requests: To attend and manage Your requests to Us.\n\n  * For business transfers: We may use Your information to evaluate or conduct\n    a merger, divestiture, restructuring, reorganization, dissolution, or\n    other sale or transfer of some or all of Our assets, whether as a going\n    concern or as part of bankruptcy, liquidation, or similar proceeding, in\n    which Personal Data held by Us about our Service users is among the assets\n    transferred.\n\n  * For other purposes : We may use Your information for other purposes, such\n    as data analysis, identifying usage trends, determining the effectiveness\n    of our promotional campaigns and to evaluate and improve our Service,\n    products, services, marketing and your experience.\n\nWe may share Your personal information in the following situations:\n\n  * With Service Providers: We may share Your personal information with\n    Service Providers to monitor and analyze the use of our Service, to\n    contact You.\n  * For business transfers: We may share or transfer Your personal information\n    in connection with, or during negotiations of, any merger, sale of Company\n    assets, financing, or acquisition of all or a portion of Our business to\n    another company.\n  * With Affiliates: We may share Your information with Our affiliates, in\n    which case we will require those affiliates to honor this Privacy Policy.\n    Affiliates include Our parent company and any other subsidiaries, joint\n    venture partners or other companies that We control or that are under\n    common control with Us.\n  * With business partners: We may share Your information with Our business\n    partners to offer You certain products, services or promotions.\n  * With other users: when You share personal information or otherwise\n    interact in the public areas with other users, such information may be\n    viewed by all users and may be publicly distributed outside. If You\n    interact with other users or register through a Third-Party Social Media\n    Service, Your contacts on the Third-Party Social Media Service may see\n    Your name, profile, pictures and description of Your activity. Similarly,\n    other users will be able to view descriptions of Your activity,\n    communicate with You and view Your profile.\n  * With Your consent : We may disclose Your personal information for any\n    other purpose with Your consent.\n\nRetention of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe Company will retain Your Personal Data only for as long as is necessary\nfor the purposes set out in this Privacy Policy. We will retain and use Your\nPersonal Data to the extent necessary to comply with our legal obligations\n(for example, if we are required to retain your data to comply with applicable\nlaws), resolve disputes, and enforce our legal agreements and policies.\n\nThe Company will also retain Usage Data for internal analysis purposes. Usage\nData is generally retained for a shorter period of time, except when this data\nis used to strengthen the security or to improve the functionality of Our\nService, or We are legally obligated to retain this data for longer time\nperiods.\n\nTransfer of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nYour information, including Personal Data, is processed at the Company\'s\noperating offices and in any other places where the parties involved in the\nprocessing are located. It means that this information may be transferred to —\nand maintained on — computers located outside of Your state, province, country\nor other governmental jurisdiction where the data protection laws may differ\nthan those from Your jurisdiction.\n\nYour consent to this Privacy Policy followed by Your submission of such\ninformation represents Your agreement to that transfer.\n\nThe Company will take all steps reasonably necessary to ensure that Your data\nis treated securely and in accordance with this Privacy Policy and no transfer\nof Your Personal Data will take place to an organization or a country unless\nthere are adequate controls in place including the security of Your data and\nother personal information.\n\nDelete Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~\n\nYou have the right to delete or request that We assist in deleting the\nPersonal Data that We have collected about You.\n\nOur Service may give You the ability to delete certain information about You\nfrom within the Service.\n\nYou may update, amend, or delete Your information at any time by signing in to\nYour Account, if you have one, and visiting the account settings section that\nallows you to manage Your personal information. You may also contact Us to\nrequest access to, correct, or delete any personal information that You have\nprovided to Us.\n\nPlease note, however, that We may need to retain certain information when we\nhave a legal obligation or lawful basis to do so.\n\nDisclosure of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nBusiness Transactions  \n*********************\n\nIf the Company is involved in a merger, acquisition or asset sale, Your\nPersonal Data may be transferred. We will provide notice before Your Personal\nData is transferred and becomes subject to a different Privacy Policy.\n\nLaw enforcement  \n***************\n\nUnder certain circumstances, the Company may be required to disclose Your\nPersonal Data if required to do so by law or in response to valid requests by\npublic authorities (e.g. a court or a government agency).\n\nOther legal requirements  \n************************\n\nThe Company may disclose Your Personal Data in the good faith belief that such\naction is necessary to:\n\n  * Comply with a legal obligation\n  * Protect and defend the rights or property of the Company\n  * Prevent or investigate possible wrongdoing in connection with the Service\n  * Protect the personal safety of Users of the Service or the public\n  * Protect against legal liability\n\nSecurity of Your Personal Data  \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nThe security of Your Personal Data is important to Us, but remember that no\nmethod of transmission over the Internet, or method of electronic storage is\n100% secure. While We strive to use commercially acceptable means to protect\nYour Personal Data, We cannot guarantee its absolute security.\n\nChildren\'s Privacy  \n------------------\n\nOur Service does not address anyone under the age of 13. We do not knowingly\ncollect personally identifiable information from anyone under the age of 13.\nIf You are a parent or guardian and You are aware that Your child has provided\nUs with Personal Data, please contact Us. If We become aware that We have\ncollected Personal Data from anyone under the age of 13 without verification\nof parental consent, We take steps to remove that information from Our\nservers.\n\nIf We need to rely on consent as a legal basis for processing Your information\nand Your country requires consent from a parent, We may require Your parent\'s\nconsent before We collect and use that information.\n\nLinks to Other Websites  \n-----------------------\n\nOur Service may contain links to other websites that are not operated by Us.\nIf You click on a third party link, You will be directed to that third party\'s\nsite. We strongly advise You to review the Privacy Policy of every site You\nvisit.\n\nWe have no control over and assume no responsibility for the content, privacy\npolicies or practices of any third party sites or services.\n\nChanges to this Privacy Policy  \n------------------------------\n\nWe may update Our Privacy Policy from time to time. We will notify You of any\nchanges by posting the new Privacy Policy on this page.\n\nWe will let You know via email and/or a prominent notice on Our Service, prior\nto the change becoming effective and update the \"Last updated\" date at the top\nof this Privacy Policy.\n\nYou are advised to review this Privacy Policy periodically for any changes.\nChanges to this Privacy Policy are effective when they are posted on this\npage.\n\nContact Us  \n----------\n\nIf you have any questions about this Privacy Policy, You can contact us by email: info.munday@gmail.com\n\n\n\n',
    },
    'ol9f5363': {
      'th': 'privacy Policy',
      'en': 'Privacy Policy',
      'zh_Hans': '隐私政策',
    },
    'nyr91ho1': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Support
  {
    '6q9pqn76': {
      'th': 'Contact us',
      'en': 'Contact us',
      'zh_Hans': '联系我们',
    },
    'eti5mtll': {
      'th': 'Email: info.mundayapp@gmail.com',
      'en': 'Email: info.mundayapp@gmail.com',
      'zh_Hans': '邮箱：info.mundayapp@gmail.com',
    },
    'f42ba7ou': {
      'th': 'Line: @munday',
      'en': 'Line: @munday',
      'zh_Hans': 'Line：@munday',
    },
    'w7c5dn9i': {
      'th': 'Support',
      'en': 'Support',
      'zh_Hans': '支持',
    },
    'xdep69mw': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // forgetpassword
  {
    '5unxb279': {
      'th': 'Back',
      'en': 'Back',
      'zh_Hans': '后退',
    },
    'jt1i4wyn': {
      'th': 'Forgot Password',
      'en': 'Forgot Password',
      'zh_Hans': '忘记密码',
    },
    'qtjmhbfx': {
      'th':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'zh_Hans': '我们将向您发送一封包含重置密码链接的电子邮件，请在下方输入与您的帐户关联的电子邮件地址。',
    },
    '24n18xzp': {
      'th': 'Your email address...',
      'en': 'Your email address...',
      'zh_Hans': '您的电子邮件地址...',
    },
    '55v2evrj': {
      'th': 'Enter your email...',
      'en': 'Enter your email...',
      'zh_Hans': '请输入您的邮箱地址……',
    },
    'dslb6q52': {
      'th': 'Send Link',
      'en': 'Send Link',
      'zh_Hans': '发送链接',
    },
    'dl303af0': {
      'th': 'Back',
      'en': 'Back',
      'zh_Hans': '后退',
    },
    'jgaiuo1f': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // success
  {
    '6ipk5727': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Blocklist
  {
    'gywtp2u9': {
      'th': 'Block list',
      'en': 'Block list',
      'zh_Hans': '阻止列表',
    },
    'duz479wu': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // AUT
  {
    'ae0ej04b': {
      'th': 'Comunity Night Party',
      'en': 'Community Night Party',
      'zh_Hans': '社区之夜派对',
    },
    'b29lklz7': {
      'th': 'เข้าสู่ระบบ',
      'en': 'Log in',
      'zh_Hans': '登录',
    },
    'toger6ar': {
      'th': 'Email Address',
      'en': 'Email Address',
      'zh_Hans': '电子邮件',
    },
    '8luef2oj': {
      'th': 'Enter your email...',
      'en': 'Enter your email...',
      'zh_Hans': '请输入您的邮箱地址……',
    },
    'ayg4l2lc': {
      'th': 'Password',
      'en': 'Password',
      'zh_Hans': '密码',
    },
    'ak6ywz2g': {
      'th': 'Enter your password...',
      'en': 'Enter your password...',
      'zh_Hans': '请输入密码……',
    },
    '9a6cw689': {
      'th': 'You agree to the acknowledge the ',
      'en': 'You agree to the acknowledge the',
      'zh_Hans': '您同意承认',
    },
    '3w4l8lir': {
      'th': ' privacy policy ',
      'en': 'privacy policy',
      'zh_Hans': '隐私政策',
    },
    '83yh8myq': {
      'th': 'Sign In',
      'en': 'Sign In',
      'zh_Hans': '登入',
    },
    'ur28kqq5': {
      'th': 'Or sign up with',
      'en': 'Or sign up with',
      'zh_Hans': '或者注册',
    },
    'vivm12g9': {
      'th': 'Google',
      'en': 'Google',
      'zh_Hans': '谷歌',
    },
    'vykvvchk': {
      'th': 'Apple',
      'en': 'Apple',
      'zh_Hans': '苹果',
    },
    'xho00c8d': {
      'th': 'Forgot Password?',
      'en': 'Forgot Password?',
      'zh_Hans': '忘记密码？',
    },
    'i80k6h0x': {
      'th': 'สร้างบัญชี',
      'en': 'Create an account',
      'zh_Hans': '创建一个帐户',
    },
    'd88s0zgt': {
      'th': 'Nickname',
      'en': 'Nickname',
      'zh_Hans': '昵称',
    },
    'r8q69s0j': {
      'th': 'Enter your Nickname...',
      'en': 'Enter your nickname...',
      'zh_Hans': '请输入您的昵称……',
    },
    '6gx7adqi': {
      'th': 'Email Address',
      'en': 'Email Address',
      'zh_Hans': '电子邮件',
    },
    'jwa3og5p': {
      'th': 'Enter your email...',
      'en': 'Enter your email...',
      'zh_Hans': '请输入您的邮箱地址……',
    },
    'yshyzboh': {
      'th': 'Password',
      'en': 'Password',
      'zh_Hans': '密码',
    },
    'ugubc4jh': {
      'th': 'Enter your password...',
      'en': 'Enter your password...',
      'zh_Hans': '请输入密码……',
    },
    'girjygmd': {
      'th': 'Confirm Password',
      'en': 'Confirm Password',
      'zh_Hans': '确认密码',
    },
    'kywolpk5': {
      'th': 'Enter your password...',
      'en': 'Enter your password...',
      'zh_Hans': '请输入密码……',
    },
    'bumlzs2y': {
      'th': 'You agree to the acknowledge the ',
      'en': 'You agree to the acknowledge the',
      'zh_Hans': '您同意承认',
    },
    'oig6fkry': {
      'th': ' privacy policy ',
      'en': 'privacy policy',
      'zh_Hans': '隐私政策',
    },
    '6u91e20k': {
      'th': 'Create Account',
      'en': 'Create Account',
      'zh_Hans': '创建账户',
    },
    '592ek084': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Main
  {
    'v8x293bi': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
    'nsfmdrd0': {
      'th': '5',
      'en': '5',
      'zh_Hans': '5',
    },
    'vm5iljxq': {
      'th': '5',
      'en': '5',
      'zh_Hans': '5',
    },
    'cdj1gcwr': {
      'th': 'รูปแบบร้าน',
      'en': 'Shop layout',
      'zh_Hans': '店铺布局',
    },
    'wpv7p399': {
      'th': 'อื่นๆ',
      'en': 'other',
      'zh_Hans': '其他',
    },
    'y426u6mw': {
      'th': 'ผับ',
      'en': 'pub',
      'zh_Hans': '酒吧',
    },
    'b2dksnid': {
      'th': 'บาร์',
      'en': 'bar',
      'zh_Hans': '酒吧',
    },
    '5lg3q8vz': {
      'th': 'นั่งชิล',
      'en': 'Sit and chill',
      'zh_Hans': '坐下来放松一下',
    },
    'axxg89b0': {
      'th': 'ลานเบียร์',
      'en': 'Beer garden',
      'zh_Hans': '啤酒花园',
    },
    'faqekyeu': {
      'th': 'Events สำหรับคุณ',
      'en': 'Events for you',
      'zh_Hans': '为您准备的活动',
    },
    '9ksqi8gl': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    '8wo43ybd': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'z11k2yxp': {
      'th': 'ร้านสำหรับคุณ',
      'en': 'Shop for you',
      'zh_Hans': '为您购物',
    },
    'yids60ee': {
      'th': 'Pub',
      'en': 'Pub',
      'zh_Hans': '酒吧',
    },
    '87a74d13': {
      'th': 'LiveMusic',
      'en': 'LiveMusic',
      'zh_Hans': '现场音乐',
    },
    'ef5snpoq': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'f7mjf40s': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'f98dkc1b': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Events
  {
    'sf7y15sd': {
      'th': 'No Events Today',
      'en': 'No Events Today',
      'zh_Hans': '今日无活动',
    },
    'z4axt11t': {
      'th':
          'Please reschedule or change the location if more information is needed.',
      'en':
          'Please reschedule or change the location if more information is needed.',
      'zh_Hans': '如果需要更多信息，请重新安排时间或更改地点。',
    },
    'wgbetsw7': {
      'th': 'Search All Day',
      'en': 'Search All Day',
      'zh_Hans': '全天搜索',
    },
    'gfa27afd': {
      'th': 'Another Day',
      'en': 'Another Day',
      'zh_Hans': '又一天',
    },
    '27dxtl2j': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    '3fd0zq8r': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'l73fai7v': {
      'th': 'FREE',
      'en': 'FREE',
      'zh_Hans': '自由的',
    },
    'hf127elb': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    '5am4kqpc': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'zsbddjf5': {
      'th': 'FREE',
      'en': 'FREE',
      'zh_Hans': '自由的',
    },
    'z1r3or6y': {
      'th': 'Search this Area',
      'en': 'Search this area',
      'zh_Hans': '搜索此区域',
    },
    'djg788wu': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'cbd0lvds': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'ebkvitz2': {
      'th': 'FREE',
      'en': 'FREE',
      'zh_Hans': '自由的',
    },
    '16vbnwxq': {
      'th': 'No Events Today',
      'en': 'No Events Today',
      'zh_Hans': '今日无活动',
    },
    'jxcp0zzg': {
      'th':
          'Please reschedule or change the location if more information is needed.',
      'en':
          'Please reschedule or change the location if more information is needed.',
      'zh_Hans': '如果需要更多信息，请重新安排时间或更改地点。',
    },
    'twcppxxh': {
      'th': 'Search All Day',
      'en': 'Search All Day',
      'zh_Hans': '全天搜索',
    },
    'glanqxhx': {
      'th': 'ดอนเมือง,สงค์ประภา',
      'en': 'Don Mueang, Songprapa',
      'zh_Hans': '东孟，松帕帕',
    },
    '8in2y4rt': {
      'th': 'Events',
      'en': 'Events',
      'zh_Hans': '活动',
    },
    'adc3yo98': {
      'th': '5',
      'en': '5',
      'zh_Hans': '5',
    },
    'x0xmiqba': {
      'th': '5',
      'en': '5',
      'zh_Hans': '5',
    },
    'k93w5ytl': {
      'th': 'ชื่อศิลปิน',
      'en': 'Artist name',
      'zh_Hans': '艺术家姓名',
    },
    '58xy52fz': {
      'th': 'All Day',
      'en': 'All Day',
      'zh_Hans': '全天',
    },
    'kc51jfwx': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'psht3tot': {
      'th': 'FREE',
      'en': 'FREE',
      'zh_Hans': '自由的',
    },
    '3b91k8ff': {
      'th': '-',
      'en': '-',
      'zh_Hans': '-',
    },
    '3t9g2w44': {
      'th': '2000฿',
      'en': '2000฿',
      'zh_Hans': '2000泰铢',
    },
    'eajhhuhm': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Venues
  {
    'sas13dus': {
      'th': 'No Venues',
      'en': 'No Venues',
      'zh_Hans': '无场地',
    },
    'x4tfqa1w': {
      'th':
          'Please reschedule or change the location if more information is needed.',
      'en':
          'Please reschedule or change the location if more information is needed.',
      'zh_Hans': '如果需要更多信息，请重新安排时间或更改地点。',
    },
    'bzok1v08': {
      'th': 'Pub',
      'en': 'Pub',
      'zh_Hans': '酒吧',
    },
    '40wk9ahf': {
      'th': 'LiveMusic',
      'en': 'LiveMusic',
      'zh_Hans': '现场音乐',
    },
    '64vssocb': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'uspi5h7x': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'llm1xn4n': {
      'th': 'Search this Area',
      'en': 'Search this area',
      'zh_Hans': '搜索此区域',
    },
    'x1d4qe53': {
      'th': 'Pub',
      'en': 'Pub',
      'zh_Hans': '酒吧',
    },
    '463p001w': {
      'th': 'LiveMusic',
      'en': 'LiveMusic',
      'zh_Hans': '现场音乐',
    },
    'v2gfpxfo': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'p5358ybs': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'a9sq8iz0': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'kgh2do3h': {
      'th': 'ดอนเมือง,สงค์ประภา',
      'en': 'Don Mueang, Songprapa',
      'zh_Hans': '东孟，松帕帕',
    },
    'nvcmanls': {
      'th': 'Venues',
      'en': 'Venues',
      'zh_Hans': '场地',
    },
    'pmv6w9qo': {
      'th': '5',
      'en': '5',
      'zh_Hans': '5',
    },
    'j9qedsry': {
      'th': '5',
      'en': '5',
      'zh_Hans': '5',
    },
    'wtlekh8b': {
      'th': 'ค้นหาร้าน',
      'en': 'Find a store',
      'zh_Hans': '查找门店',
    },
    '9v2v1ujq': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    '1a1uvhwd': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // HomeMain
  {
    'j4x9ooi5': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Promotion
  {
    '2bv6uviu': {
      'th': 'ดอนเมือง,สงค์ประภา',
      'en': 'Don Mueang, Songprapa',
      'zh_Hans': '东孟，松帕帕',
    },
    'k71hd6bj': {
      'th': 'Promotions',
      'en': 'Promotions',
      'zh_Hans': '促销',
    },
    'nhgg0eae': {
      'th': '5',
      'en': '5',
      'zh_Hans': '5',
    },
    '50bt8hhj': {
      'th': '5',
      'en': '5',
      'zh_Hans': '5',
    },
    'ez53ir4h': {
      'th': 'ชื่อร้าน',
      'en': 'Shop name',
      'zh_Hans': '店铺名称',
    },
    'o4wwef6a': {
      'th': 'Today',
      'en': 'Today',
      'zh_Hans': '今天',
    },
    'w7vyug83': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    '555r3j0f': {
      'th': 'No Promotion',
      'en': 'No Promotion',
      'zh_Hans': '无推广',
    },
    'cbaj3ek2': {
      'th':
          'Please reschedule or change the location if more information is needed.',
      'en':
          'Please reschedule or change the location if more information is needed.',
      'zh_Hans': '如果需要更多信息，请重新安排时间或更改地点。',
    },
    '3vjcbwd5': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'kwswtvn9': {
      'th': 'Book',
      'en': 'Book',
      'zh_Hans': '书',
    },
    'phyd3j8s': {
      'th': 'Now',
      'en': 'Now',
      'zh_Hans': '现在',
    },
    'cywub16n': {
      'th': 'Search this Area',
      'en': 'Search this area',
      'zh_Hans': '搜索此区域',
    },
    'sf7p9ehg': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'fxsoj2vd': {
      'th': 'No Promotion',
      'en': 'No Promotion',
      'zh_Hans': '无推广',
    },
    'ijdk14y1': {
      'th':
          'Please reschedule or change the location if more information is needed.',
      'en':
          'Please reschedule or change the location if more information is needed.',
      'zh_Hans': '如果需要更多信息，请重新安排时间或更改地点。',
    },
    'vh5d6o63': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // InVenuse
  {
    'znwljmuz': {
      'th': 'PUB',
      'en': 'PUB',
      'zh_Hans': '酒吧',
    },
    '5yp7ypsm': {
      'th': 'Hiphop',
      'en': 'Hiphop',
      'zh_Hans': '嘻哈',
    },
    '8ueny3ds': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    '203t8lnr': {
      'th': 'cars',
      'en': 'cars',
      'zh_Hans': '汽车',
    },
    'we9kgu84': {
      'th': 'Max',
      'en': 'Max',
      'zh_Hans': '最大限度',
    },
    'kd32zbfm': {
      'th': '100',
      'en': '100',
      'zh_Hans': '100',
    },
    'bpvwlxqt': {
      'th': '+',
      'en': '+',
      'zh_Hans': '+',
    },
    '17ibcz68': {
      'th': 'Link Contact',
      'en': 'Link Contact',
      'zh_Hans': '联系方式',
    },
    'd98iv601': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'z0ulu30f': {
      'th': 'Events',
      'en': 'Events',
      'zh_Hans': '活动',
    },
    'nfc8d6s8': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'ru3pw87v': {
      'th': 'No Events',
      'en': 'No Events',
      'zh_Hans': '无事件',
    },
    'ff7cf9o6': {
      'th': 'Sorry, we don\'t have events today',
      'en': 'Sorry, we don\'t have events today',
      'zh_Hans': '抱歉，今天没有活动。',
    },
    'l41wx1tf': {
      'th': 'Promotion',
      'en': 'Promotion',
      'zh_Hans': '晋升',
    },
    'ufk1gvu8': {
      'th': 'No Promotion',
      'en': 'No Promotion',
      'zh_Hans': '无推广',
    },
    '9v0vv7rb': {
      'th': 'Sorry, we don’t have promotion today',
      'en': 'Sorry, we don\'t have promotion today',
      'zh_Hans': '抱歉，今天没有促销活动。',
    },
    'jo5htnm4': {
      'th': 'Photos',
      'en': 'Photos',
      'zh_Hans': '照片',
    },
    '5fy6v03b': {
      'th': 'Show More',
      'en': 'Show More',
      'zh_Hans': '显示更多',
    },
    'msgdr2kn': {
      'th': 'ข้อเสนอ',
      'en': 'Offer',
      'zh_Hans': '提供',
    },
    'rxpcsy4y': {
      'th': 'Halloween',
      'en': 'Halloween',
      'zh_Hans': '万圣节',
    },
    '3mbf3ujq': {
      'th': '2 ตน',
      'en': '2 people',
      'zh_Hans': '2人',
    },
    '6z9zg4yc': {
      'th': '99',
      'en': '99',
      'zh_Hans': '99',
    },
    'nawxs7oi': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'vqonn8mz': {
      'th': 'โปรจัดหนัก',
      'en': 'Big promotion',
      'zh_Hans': '大促销',
    },
    'mh90obeb': {
      'th': 'โปรเหล้า',
      'en': 'Liquor promotion',
      'zh_Hans': '酒类促销',
    },
    '8eiogcop': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'eosk366z': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'tt381dwt': {
      'th': 'วันเกิด',
      'en': 'birthday',
      'zh_Hans': '生日',
    },
    '8ww8v0t5': {
      'th': 'มา 5 คน',
      'en': '5 people came',
      'zh_Hans': '来了5个人',
    },
    'cs9oms2v': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'j3pfoanq': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'vamjb92x': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    'l5csrspf': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'h7vgc50h': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '2ron4yx3': {
      'th': 'Check in',
      'en': 'Check in',
      'zh_Hans': '报到',
    },
    'e4fx9nlv': {
      'th': 'join room',
      'en': 'join room',
      'zh_Hans': '加入房间',
    },
    'ajawujz7': {
      'th': 'Booking Tables',
      'en': 'Booking Tables',
      'zh_Hans': '预订餐桌',
    },
    '4cfjxu9d': {
      'th': 'invite',
      'en': 'invite',
      'zh_Hans': '邀请',
    },
    'f56db5sz': {
      'th': 'Going',
      'en': 'Going',
      'zh_Hans': '去',
    },
    'ifymhz2z': {
      'th': 'Maybe',
      'en': 'Maybe',
      'zh_Hans': '或许',
    },
    'gkhwh8ji': {
      'th': 'Not Going',
      'en': 'Not Going',
      'zh_Hans': '不去',
    },
    '3kzdm2df': {
      'th': 'Member',
      'en': 'Member',
      'zh_Hans': '成员',
    },
    'ffx98bbd': {
      'th': 'เปลี่ยนร้าน',
      'en': 'Change store',
      'zh_Hans': '零钱商店',
    },
    'dvgerlhc': {
      'th': 'ยกเลิก',
      'en': 'cancel',
      'zh_Hans': '取消',
    },
    'eo1pf729': {
      'th': 'Add New',
      'en': 'Add New',
      'zh_Hans': '添加新',
    },
    'f0jkfy7q': {
      'th': 'Booking Tables',
      'en': 'Booking Tables',
      'zh_Hans': '预订餐桌',
    },
    'l53tynrs': {
      'th': 'Group Chat',
      'en': 'Group Chat',
      'zh_Hans': '群聊',
    },
    '3yxqhkts': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // veer
  {
    'akurgq59': {
      'th': 'Congrats!',
      'en': 'Congrats!',
      'zh_Hans': '恭喜！',
    },
    '19sjwccm': {
      'th': 'Thanks for taking the quiz.',
      'en': 'Thanks for taking the quiz.',
      'zh_Hans': '感谢您参加测试。',
    },
    'vjy12zui': {
      'th': 'Go Home',
      'en': 'Go Home',
      'zh_Hans': '回家',
    },
    'xozbz4je': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // bookng
  {
    'vlfp2539': {
      'th': 'Hello World',
      'en': 'Hello World',
      'zh_Hans': '你好世界',
    },
    'dsvu1hgf': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    'bmpazhfc': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'qyq9eqlq': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '2jto5pmm': {
      'th': '78',
      'en': '78',
      'zh_Hans': '78',
    },
    'ceawiqto': {
      'th': 'How many people ?',
      'en': 'How many people?',
      'zh_Hans': '有多少人？',
    },
    'lvdm945o': {
      'th': '3',
      'en': '3',
      'zh_Hans': '3',
    },
    '8qw5vun8': {
      'th': 'Choose your table',
      'en': 'Choose your table',
      'zh_Hans': '选择您的餐桌',
    },
    'pzvbgoye': {
      'th': 'Choose',
      'en': 'Choose',
      'zh_Hans': '选择',
    },
    '2qtlmdak': {
      'th': 'Available',
      'en': 'Available',
      'zh_Hans': '可用的',
    },
    'v9zgpa2n': {
      'th': 'Not Available',
      'en': 'Not Available',
      'zh_Hans': '无法使用',
    },
    '0zr7w5mx': {
      'th': 'PAY',
      'en': 'PAY',
      'zh_Hans': '支付',
    },
    'sm8zt9mj': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // ticket
  {
    'um0tzanu': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'ms688xec': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'q5fl9it3': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'fo4qjvz8': {
      'th':
          'เงื่อนไขการจอง\nเงื่อนไขการจองคิวรายวัน\n\nทางร้านรับเฉพาะกลุ่มนักศึกษา\nและพนักงานออฟฟิศ แต่งกายดี\n⚠️ ❗️ ไม่รับทรงเอและเด็กช่าง ❗️⚠️ \n\n❗️ค่าจอง คิวละ 500 บาท\n❗ค่าจองคืนเต็มจำนวน เมื่อมารับโต๊ะ\n❗️1 โต๊ะนั่งได้สูงสุด 20 ท่าน\n❗️จองได้ล่วงหน้า 30 วัน\n❗️ปิดรับจองโต๊ะ 16.00\n\nเงื่อนไขการปล่อยคิว\n❗️ปล่อยโต๊ะ 21.00 สำหรับ อาทิตย์-พฤหัส❗️\n❗ปล่อยโต๊ะ 20.30 สำหรับศุกร์-เสาร์-concert❗️\n\n** หากมาไม่ทันเวลารับโต๊ะ ไม่คืนเงินค่าจองทุกกรณี** 🙏',
      'en':
          'Booking Conditions\nDaily Booking Conditions\n\nWe only accept students\nand office workers. Please dress appropriately.\n⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️\n\n❗️Booking Fee: 500 baht per queue.\n❗Fully refunded upon table pick-up.\n❗️Maximum 20 people per table.\n❗️Book 30 days in advance.\n❗️Bookings close at 4:00 PM.\n\nQueue Release Conditions:\n❗️Tables release at 9:00 PM for Sunday-Thursday❗️\n❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️\n\n**If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏',
      'zh_Hans':
          '预订须知\n\n每日预订须知\n\n我们仅接受学生\n\n和上班族。请着装得体。\n\n⚠️❗️我们不接受A字裙或技校学生。❗️⚠️\n\n❗️预订费：每排500泰铢。\n\n❗️取桌时全额退款。\n\n❗️每桌最多20人。\n\n❗️请提前30天预订。\n\n❗️预订截止时间为下午4:00。\n\n排队释放须知：\n\n❗️周日至周四晚上9:00释放桌位❗️\n\n❗️周五、周六及音乐会期间晚上8:30释放桌位❗️\n\n**如果您错过取桌时间，预订费将不予退还。** 🙏',
    },
    'pn3wac0c': {
      'th': 'ยกเลิกกาจอง',
      'en': 'Cancel booking',
      'zh_Hans': '取消预订',
    },
    'euoa19dw': {
      'th': 'Tickets list',
      'en': 'Tickets list',
      'zh_Hans': '门票列表',
    },
    'utzl4v9d': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    'pp45zg7u': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Booking
  {
    'zl6cyp0w': {
      'th': 'Select Table',
      'en': 'Select Table',
      'zh_Hans': '选择表',
    },
    'dy9gu5p1': {
      'th': 'Your  Tickets',
      'en': 'Your Tickets',
      'zh_Hans': '您的门票',
    },
    '4des514z': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'b4pc5eeq': {
      'th': 'VVIP',
      'en': 'VVIP',
      'zh_Hans': '贵宾',
    },
    'xf0pjhr5': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '39iwpxhc': {
      'th': 'A31',
      'en': 'A31',
      'zh_Hans': 'A31',
    },
    'qsxwdzjs': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '75j6wza8': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'incqu7ni': {
      'th': '฿ 2,500',
      'en': '฿ 2,500',
      'zh_Hans': '2,500 泰铢',
    },
    '6z1g905j': {
      'th': '฿ 1,500',
      'en': '฿ 1,500',
      'zh_Hans': '1,500 泰铢',
    },
    '7pxafyej': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'triic0tj': {
      'th': 'VIP',
      'en': 'VIP',
      'zh_Hans': 'VIP',
    },
    'f6rcpgao': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '6o9r564w': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'onlyzhuu': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '46ld0x0r': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'b5zdps8w': {
      'th': '฿ 1,000',
      'en': '฿ 1,000',
      'zh_Hans': '1,000 泰铢',
    },
    'ckldbpe2': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'vdk5ujss': {
      'th': 'A',
      'en': 'A',
      'zh_Hans': '一个',
    },
    'stf94dvd': {
      'th': '฿ 500',
      'en': '฿ 500',
      'zh_Hans': '500 泰铢',
    },
    'dol4vivl': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'f5zj3cbu': {
      'th': 'B',
      'en': 'B',
      'zh_Hans': 'B',
    },
    'uyk8szzk': {
      'th': '฿ 300',
      'en': '฿ 300',
      'zh_Hans': '฿ 300',
    },
    'yavq9jpy': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '9t0uxohd': {
      'th': 'C',
      'en': 'C',
      'zh_Hans': 'C',
    },
    'th3wrju8': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'aw8qx9xu': {
      'th': 'C31',
      'en': 'C31',
      'zh_Hans': 'C31',
    },
    'oyyp5zzz': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'dyqvszfp': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'zf2xwvnz': {
      'th': '฿ Free',
      'en': '฿ Free',
      'zh_Hans': '免费',
    },
    '64igi5he': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '9msn8ey3': {
      'th': 'Regular',
      'en': 'Regular',
      'zh_Hans': '常规的',
    },
    'nd22qcfs': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'b2c81k0m': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    '8ztwtbdl': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'ygi4rynl': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '3pliwr7o': {
      'th': 'Information',
      'en': 'Information',
      'zh_Hans': '信息',
    },
    'quog03jp': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '13x9uqs0': {
      'th': 'VVIP',
      'en': 'VVIP',
      'zh_Hans': '贵宾',
    },
    'zzal3cp1': {
      'th': '฿ 2,500',
      'en': '฿ 2,500',
      'zh_Hans': '2,500 泰铢',
    },
    'r2j8yc5b': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'vs7xdzmi': {
      'th': '4+2',
      'en': '4+2',
      'zh_Hans': '4+2',
    },
    'b346r7d7': {
      'th': '- สิงห์ 8 ขวด                - เหล้า รีเจนซี่',
      'en': '- 8 bottles of Singha - Regency liquor',
      'zh_Hans': '- 8瓶胜狮酒 - 丽晶酒',
    },
    't2g5fbkh': {
      'th': '- Mixer 15 อย่าง        - ริชแบรน',
      'en': '- 15 Mixers - Rich Brand',
      'zh_Hans': '- 15 款搅拌机 - Rich Brand',
    },
    'pkz408a3': {
      'th': '- เป็นข้อไก่',
      'en': '- It\'s a chicken joint.',
      'zh_Hans': '这是一家炸鸡店。',
    },
    '7nteuc8q': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '0ndc7z7a': {
      'th': 'VIP',
      'en': 'VIP',
      'zh_Hans': 'VIP',
    },
    'zjqoai57': {
      'th': '฿ 1,500',
      'en': '฿ 1,500',
      'zh_Hans': '1,500 泰铢',
    },
    '6elfinwi': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'zlj2bvxv': {
      'th': '4+2',
      'en': '4+2',
      'zh_Hans': '4+2',
    },
    'cc82j5o4': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '4g50bw3t': {
      'th': 'A',
      'en': 'A',
      'zh_Hans': '一个',
    },
    'rvzbnzim': {
      'th': '฿ 1,000',
      'en': '฿ 1,000',
      'zh_Hans': '1,000 泰铢',
    },
    'sa7il9cu': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    't2nhsu2z': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '9z9bvdw7': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'u5splgyl': {
      'th': 'B',
      'en': 'B',
      'zh_Hans': 'B',
    },
    '1btagzga': {
      'th': '฿ 500',
      'en': '฿ 500',
      'zh_Hans': '500 泰铢',
    },
    '061te4or': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'i2yqt0vg': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'h6uupi1b': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '8t91guy8': {
      'th': 'C',
      'en': 'C',
      'zh_Hans': 'C',
    },
    '27xmauca': {
      'th': '฿ 300',
      'en': '฿ 300',
      'zh_Hans': '฿ 300',
    },
    'tlm9qy3p': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'vc6bzueu': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '3j2l4cnb': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'v0p6ewim': {
      'th': 'Regular',
      'en': 'Regular',
      'zh_Hans': '常规的',
    },
    'ebhvfrkk': {
      'th': '฿ Free',
      'en': '฿ Free',
      'zh_Hans': '免费',
    },
    'c6l6yvfu': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '77ws4uwr': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '8uod5ty9': {
      'th':
          'เงื่อนไขการจอง\nเงื่อนไขการจองคิวรายวัน\n\nทางร้านรับเฉพาะกลุ่มนักศึกษา\nและพนักงานออฟฟิศ แต่งกายดี\n⚠️ ❗️ ไม่รับทรงเอและเด็กช่าง ❗️⚠️ \n\n❗️ค่าจอง คิวละ 500 บาท\n❗ค่าจองคืนเต็มจำนวน เมื่อมารับโต๊ะ\n❗️1 โต๊ะนั่งได้สูงสุด 20 ท่าน\n❗️จองได้ล่วงหน้า 30 วัน\n❗️ปิดรับจองโต๊ะ 16.00\n\nเงื่อนไขการปล่อยคิว\n❗️ปล่อยโต๊ะ 21.00 สำหรับ อาทิตย์-พฤหัส❗️\n❗ปล่อยโต๊ะ 20.30 สำหรับศุกร์-เสาร์-concert❗️\n\n** หากมาไม่ทันเวลารับโต๊ะ ไม่คืนเงินค่าจองทุกกรณี** 🙏',
      'en':
          'Booking Conditions\nDaily Booking Conditions\n\nWe only accept students\nand office workers. Please dress appropriately.\n⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️\n\n❗️Booking Fee: 500 baht per queue.\n❗Fully refunded upon table pick-up.\n❗️Maximum 20 people per table.\n❗️Book 30 days in advance.\n❗️Bookings close at 4:00 PM.\n\nQueue Release Conditions:\n❗️Tables release at 9:00 PM for Sunday-Thursday❗️\n❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️\n\n**If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏',
      'zh_Hans':
          '预订须知\n\n每日预订须知\n\n我们仅接受学生\n\n和上班族。请着装得体。\n\n⚠️❗️我们不接受A字裙或技校学生。❗️⚠️\n\n❗️预订费：每排500泰铢。\n\n❗️取桌时全额退款。\n\n❗️每桌最多20人。\n\n❗️请提前30天预订。\n\n❗️预订截止时间为下午4:00。\n\n排队释放须知：\n\n❗️周日至周四晚上9:00释放桌位❗️\n\n❗️周五、周六及音乐会期间晚上8:30释放桌位❗️\n\n**如果您错过取桌时间，预订费将不予退还。** 🙏',
    },
    'nrbqwlw0': {
      'th': 'Buy Ticket',
      'en': 'Buy Ticket',
      'zh_Hans': '购票',
    },
    'i56am3ch': {
      'th': 'Pay',
      'en': 'Pay',
      'zh_Hans': '支付',
    },
    'a5zorp3n': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'nc4g8d1b': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // mapdum
  {
    'v0stl0ay': {
      'th': 'Page Title',
      'en': 'Page Title',
      'zh_Hans': '页面标题',
    },
    'ze672l2s': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // mapEx
  {
    '6dz0u7le': {
      'th': 'Page Title',
      'en': 'Page Title',
      'zh_Hans': '页面标题',
    },
    'yhumgfb5': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // showallphoto
  {
    'umb3na4q': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // booking2c
  {
    'bh9llm47': {
      'th': 'Page Title',
      'en': 'Page Title',
      'zh_Hans': '页面标题',
    },
    'tznvksq5': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // sharepage
  {
    'jprjtruw': {
      'th': 'PUB',
      'en': 'PUB',
      'zh_Hans': '酒吧',
    },
    'vazpnzbl': {
      'th': 'Hiphop',
      'en': 'Hiphop',
      'zh_Hans': '嘻哈',
    },
    'hyr1m536': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    '4vhkf00u': {
      'th': 'cars',
      'en': 'cars',
      'zh_Hans': '汽车',
    },
    '8ibd3age': {
      'th': 'Max',
      'en': 'Max',
      'zh_Hans': '最大限度',
    },
    'kpr56ubu': {
      'th': '100',
      'en': '100',
      'zh_Hans': '100',
    },
    '6ncos6jz': {
      'th': '+',
      'en': '+',
      'zh_Hans': '+',
    },
    'o1lqg7m6': {
      'th': 'Link Contact',
      'en': 'Link Contact',
      'zh_Hans': '联系方式',
    },
    'j2keth1e': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'g973dz4s': {
      'th': 'Events',
      'en': 'Events',
      'zh_Hans': '活动',
    },
    'cwokgpu5': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'z6bqmqln': {
      'th': 'Promotion',
      'en': 'Promotion',
      'zh_Hans': '晋升',
    },
    '0odyt35u': {
      'th': 'Photos',
      'en': 'Photos',
      'zh_Hans': '照片',
    },
    'yr1eol7o': {
      'th': 'Show More',
      'en': 'Show More',
      'zh_Hans': '显示更多',
    },
    'juznlzd5': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    'm8736qv2': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    '3u1rmglv': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'k36olntr': {
      'th': 'Checkin',
      'en': 'Check-in',
      'zh_Hans': '报到',
    },
    '8dx4s51x': {
      'th': 'Booking Tables',
      'en': 'Booking Tables',
      'zh_Hans': '预订餐桌',
    },
    'rj6ljkjw': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // test
  {
    'hviyrnsx': {
      'th': 'Page Title',
      'en': 'Page Title',
      'zh_Hans': '页面标题',
    },
    '3qfn1tp7': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // Booking2
  {
    'dipbnczb': {
      'th': 'Page Title',
      'en': 'Page Title',
      'zh_Hans': '页面标题',
    },
    'vrvedkjs': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // homeCopy2
  {
    '4wo3bij4': {
      'th': 'คุณมี 10 points',
      'en': 'You have 10 points.',
      'zh_Hans': '你得了10分。',
    },
    '4prk2pr3': {
      'th': 'ระดับ :',
      'en': 'level :',
      'zh_Hans': '等级 ：',
    },
    'fnmvz65b': {
      'th': 'VVVIP',
      'en': 'VVVIP',
      'zh_Hans': '极致贵宾',
    },
    'i7c3b8nn': {
      'th': 'Online Chat Room',
      'en': 'Online Chat Room',
      'zh_Hans': '在线聊天室',
    },
    'pvej8jdo': {
      'th': 'พิมพ์...',
      'en': 'print...',
      'zh_Hans': '打印...',
    },
    '64n77liv': {
      'th': 'LIVE chat',
      'en': 'LIVE chat',
      'zh_Hans': '在线聊天',
    },
    'sv3t1aqu': {
      'th': 'Menu',
      'en': 'Menu',
      'zh_Hans': '菜单',
    },
    '4u7jdhej': {
      'th': 'Promotion',
      'en': 'Promotion',
      'zh_Hans': '晋升',
    },
    '4zw13kyv': {
      'th': 'Menu',
      'en': 'Menu',
      'zh_Hans': '菜单',
    },
    '3mm0oina': {
      'th': 'Events',
      'en': 'Events',
      'zh_Hans': '活动',
    },
    'wvqzbcxy': {
      'th': 'SOHO Sigature',
      'en': 'SOHO Sigature',
      'zh_Hans': 'SOHO 签名',
    },
    'apq6pa5h': {
      'th': 'SOHO แซบ',
      'en': 'SOHO is spicy',
      'zh_Hans': 'SOHO很辣',
    },
    '4uvtmvmc': {
      'th': 'เบียร์',
      'en': 'beer',
      'zh_Hans': '啤酒',
    },
    'qvyga35a': {
      'th': 'โซจู',
      'en': 'Soju',
      'zh_Hans': '烧酒',
    },
    'qjldag6s': {
      'th': 'SOHO Signature',
      'en': 'SOHO Signature',
      'zh_Hans': 'SOHO 签名',
    },
    '2rlog5ie': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    '6lsnykdy': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'y323cr4r': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '79pon8yh': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'dc2n7a62': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    't50e7uwi': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    't8ovilvs': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'vql9o092': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'ndoszkx1': {
      'th': '2',
      'en': '2',
      'zh_Hans': '2',
    },
    'r4cspops': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'ra56fthj': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'jknu10fi': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'k8tm9w0z': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'mxiu0bbn': {
      'th': 'SOHO แซบ',
      'en': 'SOHO is spicy',
      'zh_Hans': 'SOHO很辣',
    },
    'zef0s0u7': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'jaixvpmy': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '6p9d78fm': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'uhjogkeu': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'uv0vajby': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'v1ozjslp': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'dyfej5th': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'zyvw2f8e': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'tlenjoc6': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'k3vyqlbs': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'x9qnow21': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '4oiiwbg7': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '648hbk3b': {
      'th': 'SOJU',
      'en': 'SOJU',
      'zh_Hans': '烧酒',
    },
    'kqilvvox': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'wxt840b4': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'znqfxrt2': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '41oko2j7': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '1j29gwzl': {
      'th': '9',
      'en': '9',
      'zh_Hans': '9',
    },
    '3fnz43vq': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'zm9awdoh': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '5llm0ked': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'rrbe7olv': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'on6o51s1': {
      'th': 'BEER',
      'en': 'BEER',
      'zh_Hans': '啤酒',
    },
    'null1kwy': {
      'th': 'Budweiser',
      'en': 'Budweiser',
      'zh_Hans': '百威啤酒',
    },
    'o4pjs7kx': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '28v7itj0': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'zcvkwu12': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'hsc7lxja': {
      'th': 'Chang',
      'en': 'Chang',
      'zh_Hans': '张',
    },
    'hspm448z': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'zrstnz99': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '3c99ju5l': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '88ao1820': {
      'th': 'heineken',
      'en': 'Heineken',
      'zh_Hans': '喜力',
    },
    'ormms5cs': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'bagd2xgm': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'vxh94qn6': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'xn4peof8': {
      'th': 'heineken',
      'en': 'Heineken',
      'zh_Hans': '喜力',
    },
    'tmu03wlm': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'cpfyoa07': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'gb9jhpgk': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'l8rq7vck': {
      'th': 'Colona',
      'en': 'Colona',
      'zh_Hans': '科洛纳',
    },
    '4bt0gm3n': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'rqpvn24h': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'e8jqjrwo': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '5578gt2i': {
      'th': 'My Tickets',
      'en': 'My Tickets',
      'zh_Hans': '我的门票',
    },
    '9uv5q34c': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'sxnlq3fb': {
      'th': 'VVIP',
      'en': 'VVIP',
      'zh_Hans': '贵宾',
    },
    'sxlhrakm': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'iia4f40z': {
      'th': 'A31',
      'en': 'A31',
      'zh_Hans': 'A31',
    },
    'f6lm0lyz': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'yyg9jzv0': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'cji3uh29': {
      'th': '฿ 2,500',
      'en': '฿ 2,500',
      'zh_Hans': '2,500 泰铢',
    },
    '9dsvw40w': {
      'th': '฿ 1,500',
      'en': '฿ 1,500',
      'zh_Hans': '1,500 泰铢',
    },
    '3zdq0dyx': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '4jyp4oms': {
      'th': 'VIP',
      'en': 'VIP',
      'zh_Hans': 'VIP',
    },
    'c5g2p3v1': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'zhgx1486': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'h6p9p54r': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'yke60pea': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'qoiiqz69': {
      'th': '฿ 1,000',
      'en': '฿ 1,000',
      'zh_Hans': '1,000 泰铢',
    },
    'z6zfmcic': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'tt7znzhx': {
      'th': 'A',
      'en': 'A',
      'zh_Hans': '一个',
    },
    '21apkl4n': {
      'th': '฿ 500',
      'en': '฿ 500',
      'zh_Hans': '500 泰铢',
    },
    'wvgkntw8': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'yu0ecv5t': {
      'th': 'B',
      'en': 'B',
      'zh_Hans': 'B',
    },
    '0v2cb7ps': {
      'th': '฿ 300',
      'en': '฿ 300',
      'zh_Hans': '฿ 300',
    },
    'gd4zum2q': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'z2e1mh4n': {
      'th': 'C',
      'en': 'C',
      'zh_Hans': 'C',
    },
    '4z32vj1c': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'j89moibh': {
      'th': 'C31',
      'en': 'C31',
      'zh_Hans': 'C31',
    },
    'wpskxpnu': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'ptvagr3c': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'fwx1jft5': {
      'th': '฿ Free',
      'en': '฿ Free',
      'zh_Hans': '免费',
    },
    'o639mc0f': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'pjhjggdd': {
      'th': 'Regular',
      'en': 'Regular',
      'zh_Hans': '常规的',
    },
    'sgkjbkzy': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '6gfnkxwb': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'm3ezq3jz': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'ybormi51': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '1wlz2o0d': {
      'th': 'Check In',
      'en': 'Check In',
      'zh_Hans': '报到',
    },
    '056i0rz7': {
      'th': '3',
      'en': '3',
      'zh_Hans': '3',
    },
    'u2te9qjn': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'bpfrjboe': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'zydmy3o3': {
      'th': 'You',
      'en': 'You',
      'zh_Hans': '你',
    },
    'k6vb4ee3': {
      'th': 'PANK',
      'en': 'PANK',
      'zh_Hans': '潘克',
    },
    'ryfsyvi5': {
      'th': 'PUK_66',
      'en': 'PUK_66',
      'zh_Hans': 'PUK_66',
    },
    'ndwikeks': {
      'th':
          'เงื่อนไขการจอง\nเงื่อนไขการจองคิวรายวัน\n\nทางร้านรับเฉพาะกลุ่มนักศึกษา\nและพนักงานออฟฟิศ แต่งกายดี\n⚠️ ❗️ ไม่รับทรงเอและเด็กช่าง ❗️⚠️ \n\n❗️ค่าจอง คิวละ 500 บาท\n❗ค่าจองคืนเต็มจำนวน เมื่อมารับโต๊ะ\n❗️1 โต๊ะนั่งได้สูงสุด 20 ท่าน\n❗️จองได้ล่วงหน้า 30 วัน\n❗️ปิดรับจองโต๊ะ 16.00\n\nเงื่อนไขการปล่อยคิว\n❗️ปล่อยโต๊ะ 21.00 สำหรับ อาทิตย์-พฤหัส❗️\n❗ปล่อยโต๊ะ 20.30 สำหรับศุกร์-เสาร์-concert❗️\n\n** หากมาไม่ทันเวลารับโต๊ะ ไม่คืนเงินค่าจองทุกกรณี** 🙏',
      'en':
          'Booking Conditions\nDaily Booking Conditions\n\nWe only accept students\nand office workers. Please dress appropriately.\n⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️\n\n❗️Booking Fee: 500 baht per queue.\n❗Fully refunded upon table pick-up.\n❗️Maximum 20 people per table.\n❗️Book 30 days in advance.\n❗️Bookings close at 4:00 PM.\n\nQueue Release Conditions:\n❗️Tables release at 9:00 PM for Sunday-Thursday❗️\n❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️\n\n**If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏',
      'zh_Hans':
          '预订须知\n\n每日预订须知\n\n我们仅接受学生\n\n和上班族。请着装得体。\n\n⚠️❗️我们不接受A字裙或技校学生。❗️⚠️\n\n❗️预订费：每排500泰铢。\n\n❗️取桌时全额退款。\n\n❗️每桌最多20人。\n\n❗️请提前30天预订。\n\n❗️预订截止时间为下午4:00。\n\n排队释放须知：\n\n❗️周日至周四晚上9:00释放桌位❗️\n\n❗️周五、周六及音乐会期间晚上8:30释放桌位❗️\n\n**如果您错过取桌时间，预订费将不予退还。** 🙏',
    },
    'wkxwd54x': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // testui
  {
    'e9hqe04l': {
      'th': 'สวัสดี',
      'en': 'hello',
      'zh_Hans': '你好',
    },
    'xhkv9wgf': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // payreservenormday
  {
    'glw1miga': {
      'th': 'Page Title',
      'en': 'Page Title',
      'zh_Hans': '页面标题',
    },
    'a1iudyde': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // homeCopy2Copy
  {
    'w2wh6a9n': {
      'th': 'Online Chat Room',
      'en': 'Online Chat Room',
      'zh_Hans': '在线聊天室',
    },
    '2v1nt967': {
      'th': 'พิมพ์...',
      'en': 'print...',
      'zh_Hans': '打印...',
    },
    'hlnyfwtv': {
      'th': 'LIVE chat',
      'en': 'LIVE chat',
      'zh_Hans': '在线聊天',
    },
    'v2kzvykl': {
      'th': 'My Tickets',
      'en': 'My Tickets',
      'zh_Hans': '我的门票',
    },
    'gft872n2': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'xvgvp5b6': {
      'th': 'VVIP',
      'en': 'VVIP',
      'zh_Hans': '贵宾',
    },
    '0iiv5xxw': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'ekzj9n9p': {
      'th': 'A31',
      'en': 'A31',
      'zh_Hans': 'A31',
    },
    'wrt9jrnn': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '7sg9h4fd': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '5vq81do6': {
      'th': '฿ 2,500',
      'en': '฿ 2,500',
      'zh_Hans': '2,500 泰铢',
    },
    '9uyxq2cp': {
      'th': '฿ 1,500',
      'en': '฿ 1,500',
      'zh_Hans': '1,500 泰铢',
    },
    '4agscpws': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '8n4z6077': {
      'th': 'VIP',
      'en': 'VIP',
      'zh_Hans': 'VIP',
    },
    '71auxs7t': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '0u417nvy': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'a7aao6m3': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'i0i6rs12': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'dq1k0zb7': {
      'th': '฿ 1,000',
      'en': '฿ 1,000',
      'zh_Hans': '1,000 泰铢',
    },
    '6b9r8wok': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'bn1ckzq3': {
      'th': 'A',
      'en': 'A',
      'zh_Hans': '一个',
    },
    'zgdlc1ls': {
      'th': '฿ 500',
      'en': '฿ 500',
      'zh_Hans': '500 泰铢',
    },
    '8nhm2kar': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'yry045go': {
      'th': 'B',
      'en': 'B',
      'zh_Hans': 'B',
    },
    'soors5ex': {
      'th': '฿ 300',
      'en': '฿ 300',
      'zh_Hans': '฿ 300',
    },
    '60xpx86y': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'gmknknyt': {
      'th': 'C',
      'en': 'C',
      'zh_Hans': 'C',
    },
    '1zy28w2f': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'ggiokpn4': {
      'th': 'C31',
      'en': 'C31',
      'zh_Hans': 'C31',
    },
    '6z502j02': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'l3nzym2i': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'j6a85dww': {
      'th': '฿ Free',
      'en': '฿ Free',
      'zh_Hans': '免费',
    },
    'haba2hgu': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'orfq0mn7': {
      'th': 'Regular',
      'en': 'Regular',
      'zh_Hans': '常规的',
    },
    '7lyn96ig': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'vu6065xm': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'xwpv7x6l': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '5bhcwqof': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'ypg8wzob': {
      'th': 'Check In',
      'en': 'Check In',
      'zh_Hans': '报到',
    },
    'tf3dnkge': {
      'th': '3',
      'en': '3',
      'zh_Hans': '3',
    },
    'juurp6dq': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'is3r5xqn': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    's6r2ykml': {
      'th': 'You',
      'en': 'You',
      'zh_Hans': '你',
    },
    'ywjx9289': {
      'th': 'PANK',
      'en': 'PANK',
      'zh_Hans': '潘克',
    },
    'cgj1fm77': {
      'th': 'PUK_66',
      'en': 'PUK_66',
      'zh_Hans': 'PUK_66',
    },
    'eo64n89p': {
      'th':
          'เงื่อนไขการจอง\nเงื่อนไขการจองคิวรายวัน\n\nทางร้านรับเฉพาะกลุ่มนักศึกษา\nและพนักงานออฟฟิศ แต่งกายดี\n⚠️ ❗️ ไม่รับทรงเอและเด็กช่าง ❗️⚠️ \n\n❗️ค่าจอง คิวละ 500 บาท\n❗ค่าจองคืนเต็มจำนวน เมื่อมารับโต๊ะ\n❗️1 โต๊ะนั่งได้สูงสุด 20 ท่าน\n❗️จองได้ล่วงหน้า 30 วัน\n❗️ปิดรับจองโต๊ะ 16.00\n\nเงื่อนไขการปล่อยคิว\n❗️ปล่อยโต๊ะ 21.00 สำหรับ อาทิตย์-พฤหัส❗️\n❗ปล่อยโต๊ะ 20.30 สำหรับศุกร์-เสาร์-concert❗️\n\n** หากมาไม่ทันเวลารับโต๊ะ ไม่คืนเงินค่าจองทุกกรณี** 🙏',
      'en':
          'Booking Conditions\nDaily Booking Conditions\n\nWe only accept students\nand office workers. Please dress appropriately.\n⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️\n\n❗️Booking Fee: 500 baht per queue.\n❗Fully refunded upon table pick-up.\n❗️Maximum 20 people per table.\n❗️Book 30 days in advance.\n❗️Bookings close at 4:00 PM.\n\nQueue Release Conditions:\n❗️Tables release at 9:00 PM for Sunday-Thursday❗️\n❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️\n\n**If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏',
      'zh_Hans':
          '预订须知\n\n每日预订须知\n\n我们仅接受学生\n\n和上班族。请着装得体。\n\n⚠️❗️我们不接受A字裙或技校学生。❗️⚠️\n\n❗️预订费：每排500泰铢。\n\n❗️取桌时全额退款。\n\n❗️每桌最多20人。\n\n❗️请提前30天预订。\n\n❗️预订截止时间为下午4:00。\n\n排队释放须知：\n\n❗️周日至周四晚上9:00释放桌位❗️\n\n❗️周五、周六及音乐会期间晚上8:30释放桌位❗️\n\n**如果您错过取桌时间，预订费将不予退还。** 🙏',
    },
    'egtual1b': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // ticketCopy
  {
    '7ovbkwp3': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'xzv4f36w': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'bw9ltw03': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'cjy3nyvn': {
      'th':
          'เงื่อนไขการจอง\nเงื่อนไขการจองคิวรายวัน\n\nทางร้านรับเฉพาะกลุ่มนักศึกษา\nและพนักงานออฟฟิศ แต่งกายดี\n⚠️ ❗️ ไม่รับทรงเอและเด็กช่าง ❗️⚠️ \n\n❗️ค่าจอง คิวละ 500 บาท\n❗ค่าจองคืนเต็มจำนวน เมื่อมารับโต๊ะ\n❗️1 โต๊ะนั่งได้สูงสุด 20 ท่าน\n❗️จองได้ล่วงหน้า 30 วัน\n❗️ปิดรับจองโต๊ะ 16.00\n\nเงื่อนไขการปล่อยคิว\n❗️ปล่อยโต๊ะ 21.00 สำหรับ อาทิตย์-พฤหัส❗️\n❗ปล่อยโต๊ะ 20.30 สำหรับศุกร์-เสาร์-concert❗️\n\n** หากมาไม่ทันเวลารับโต๊ะ ไม่คืนเงินค่าจองทุกกรณี** 🙏',
      'en':
          'Booking Conditions\nDaily Booking Conditions\n\nWe only accept students\nand office workers. Please dress appropriately.\n⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️\n\n❗️Booking Fee: 500 baht per queue.\n❗Fully refunded upon table pick-up.\n❗️Maximum 20 people per table.\n❗️Book 30 days in advance.\n❗️Bookings close at 4:00 PM.\n\nQueue Release Conditions:\n❗️Tables release at 9:00 PM for Sunday-Thursday❗️\n❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️\n\n**If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏',
      'zh_Hans':
          '预订须知\n\n每日预订须知\n\n我们仅接受学生\n\n和上班族。请着装得体。\n\n⚠️❗️我们不接受A字裙或技校学生。❗️⚠️\n\n❗️预订费：每排500泰铢。\n\n❗️取桌时全额退款。\n\n❗️每桌最多20人。\n\n❗️请提前30天预订。\n\n❗️预订截止时间为下午4:00。\n\n排队释放须知：\n\n❗️周日至周四晚上9:00释放桌位❗️\n\n❗️周五、周六及音乐会期间晚上8:30释放桌位❗️\n\n**如果您错过取桌时间，预订费将不予退还。** 🙏',
    },
    '4q2u0p3t': {
      'th': 'ยกเลิกกาจอง',
      'en': 'Cancel booking',
      'zh_Hans': '取消预订',
    },
    'xtbwanld': {
      'th': 'Tickets list',
      'en': 'Tickets list',
      'zh_Hans': '门票列表',
    },
    '48zondbs': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    '36f7nsef': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // InVenuseCopy
  {
    'd8f6lovw': {
      'th': 'PUB',
      'en': 'PUB',
      'zh_Hans': '酒吧',
    },
    '1rqcy1ed': {
      'th': 'Hiphop',
      'en': 'Hiphop',
      'zh_Hans': '嘻哈',
    },
    'pj45icmd': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    'nspc1yuz': {
      'th': 'cars',
      'en': 'cars',
      'zh_Hans': '汽车',
    },
    'myby50ga': {
      'th': 'Max',
      'en': 'Max',
      'zh_Hans': '最大限度',
    },
    '7zyopoiw': {
      'th': '100',
      'en': '100',
      'zh_Hans': '100',
    },
    'ygqwxgwn': {
      'th': '+',
      'en': '+',
      'zh_Hans': '+',
    },
    'cpm3t5y5': {
      'th': 'Link Contact',
      'en': 'Link Contact',
      'zh_Hans': '联系方式',
    },
    'v8d16drz': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'ftk53xdg': {
      'th': 'Events',
      'en': 'Events',
      'zh_Hans': '活动',
    },
    'zhpjfz03': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'xqct6dec': {
      'th': 'No Events',
      'en': 'No Events',
      'zh_Hans': '无事件',
    },
    'el6ri3xf': {
      'th': 'Sorry, we don\'t have events today',
      'en': 'Sorry, we don\'t have events today',
      'zh_Hans': '抱歉，今天没有活动。',
    },
    '747m08nh': {
      'th': 'Promotion',
      'en': 'Promotion',
      'zh_Hans': '晋升',
    },
    'bdrgr6h2': {
      'th': 'No Promotion',
      'en': 'No Promotion',
      'zh_Hans': '无推广',
    },
    'mhrkr17v': {
      'th': 'Sorry, we don’t have promotion today',
      'en': 'Sorry, we don\'t have promotion today',
      'zh_Hans': '抱歉，今天没有促销活动。',
    },
    'l21inzuk': {
      'th': 'Photos',
      'en': 'Photos',
      'zh_Hans': '照片',
    },
    'n8dn3vae': {
      'th': 'Show More',
      'en': 'Show More',
      'zh_Hans': '显示更多',
    },
    'wydeq06y': {
      'th': 'ข้อเสนอ',
      'en': 'Offer',
      'zh_Hans': '提供',
    },
    'm9f9snmw': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    't8j990o3': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '0eq2ljyv': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '8om8y1ff': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'tsmhuyoa': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    '23rkums5': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'hori9t1o': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'tr6fhmka': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '3v4emk0i': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'b2amftd7': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '1toslqmx': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'qwpf7e96': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'kjnpr9di': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    'krxpeiro': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'ae3use38': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'j58u31xa': {
      'th': 'Checkin',
      'en': 'Check-in',
      'zh_Hans': '报到',
    },
    'bf79j07e': {
      'th': 'join room',
      'en': 'join room',
      'zh_Hans': '加入房间',
    },
    'q3kv67h4': {
      'th': 'Home',
      'en': 'Home',
      'zh_Hans': '家',
    },
  },
  // popupuser
  {
    'simcn6td': {
      'th': 'Block',
      'en': 'Block',
      'zh_Hans': '堵塞',
    },
    'apsy2i5q': {
      'th': '2.1 K',
      'en': '2.1 K',
      'zh_Hans': '2.1千',
    },
    'fowb1nw4': {
      'th': '12.5 K',
      'en': '12.5 K',
      'zh_Hans': '12.5千',
    },
    'oe059td2': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    '5gvgklgz': {
      'th': '12',
      'en': '12',
      'zh_Hans': '12',
    },
  },
  // youarenothere
  {
    'nyazsf47': {
      'th': 'คุณอยู่ไกลจากร้าน',
      'en': 'You are far from the store.',
      'zh_Hans': '你离商店还很远。',
    },
    'mp8ty4ge': {
      'th': 'ขออภัยคุณต้องอยู่ในระยะ 50 เมตรจากร้าน',
      'en': 'Sorry, you must be within 50 meters of the shop.',
      'zh_Hans': '抱歉，您必须在距离商店50米以内。',
    },
  },
  // option
  {
    'u2te43sd': {
      'th': 'Cheers Package',
      'en': 'Cheers Package',
      'zh_Hans': '祝您一切顺利',
    },
    'qdjyp8zy': {
      'th': 'ชำระเงินด้วยระบบ  PromptPay  สะดวก ปลอดภัย',
      'en': 'Pay with PromptPay, convenient and safe.',
      'zh_Hans': '使用 PromptPay 付款，方便又安全。',
    },
    'xx981ba6': {
      'th': 'เลือก   Package',
      'en': 'Select Package',
      'zh_Hans': '选择套餐',
    },
    '6d4njuve': {
      'th': 'X',
      'en': 'X',
      'zh_Hans': 'X',
    },
    '9fp2n6rz': {
      'th': '฿ 29 .00',
      'en': '฿ 29.00',
      'zh_Hans': '29.00 泰铢',
    },
    'iw5wjf5x': {
      'th': 'X',
      'en': 'X',
      'zh_Hans': 'X',
    },
    'jxm19659': {
      'th': '฿ 49 .00',
      'en': '฿ 49.00',
      'zh_Hans': '49.00 泰铢',
    },
    'fxmmzfdq': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    '12bdn60y': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    'y14bta82': {
      'th': 'เห็นทุกคนที่  Cheers  คุณ',
      'en': 'See everyone cheering you on',
      'zh_Hans': '看到大家都在为你加油',
    },
    't766gvxc': {
      'th': '฿ 99 .00',
      'en': '฿ 99.00',
      'zh_Hans': '99.00',
    },
  },
  // Card33UserGrid
  {
    'nifsved0': {
      'th': 'Cheers!!',
      'en': 'Cheers!!',
      'zh_Hans': '干杯！！',
    },
    '7hzb9e7k': {
      'th': 'อีกฝ่าย  Match กับคุณ',
      'en': 'The other party matches you.',
      'zh_Hans': '对方与你匹配。',
    },
  },
  // delchat
  {
    'quxzlxti': {
      'th': 'ลบแชท',
      'en': 'Delete chat',
      'zh_Hans': '删除聊天记录',
    },
    'biyxjvln': {
      'th': 'ยกเลิก',
      'en': 'cancel',
      'zh_Hans': '取消',
    },
  },
  // delallchat
  {
    'u58jdqpe': {
      'th': 'ลบห้องแชท',
      'en': 'Delete chat room',
      'zh_Hans': '删除聊天室',
    },
    'crot8jmc': {
      'th': 'ยกเลิก',
      'en': 'cancel',
      'zh_Hans': '取消',
    },
  },
  // confirmdel
  {
    '1lw0tlcq': {
      'th': 'ยืนยัน ที่จะลบข้อมูลผู้ใช้ทั้งหมด',
      'en': 'Confirm to delete all user data.',
      'zh_Hans': '确认删除所有用户数据。',
    },
    'ka4eqgjx': {
      'th': 'ยกเลิก',
      'en': 'cancel',
      'zh_Hans': '取消',
    },
  },
  // block
  {
    '4xgiypcj': {
      'th': 'รายงาน พฤติกรรมไม่เหมาะสม',
      'en': 'Report inappropriate behavior',
      'zh_Hans': '举报不当行为',
    },
    '2zyj6fm1': {
      'th': 'Block การมองเห็น',
      'en': 'Block visibility',
      'zh_Hans': '块可见性',
    },
    '6pmw7gnn': {
      'th': 'ยกเลิก',
      'en': 'cancel',
      'zh_Hans': '取消',
    },
  },
  // language
  {
    'fvrj4p08': {
      'th': 'language',
      'en': 'language',
      'zh_Hans': '语言',
    },
    'bd2xz340': {
      'th': 'Thai',
      'en': 'Thai',
      'zh_Hans': '泰国',
    },
    '6w69b1uq': {
      'th': 'English',
      'en': 'English',
      'zh_Hans': '英语',
    },
    '74gcpyy4': {
      'th': 'Chinese',
      'en': 'Chinese',
      'zh_Hans': '中国人',
    },
  },
  // profilepopup
  {
    '4zmi1y5v': {
      'th': 'Your  Profile',
      'en': 'Your Profile',
      'zh_Hans': '您的个人资料',
    },
    'il4lzk8b': {
      'th': 'Your name',
      'en': 'Your name',
      'zh_Hans': '你的名字',
    },
    'iteqjwb6': {
      'th': 'Your caption',
      'en': 'Your caption',
      'zh_Hans': '你的标题',
    },
    '3ewakt6y': {
      'th': 'Name Instagram',
      'en': 'Name Instagram',
      'zh_Hans': 'Instagram账号',
    },
    '82kov3yv': {
      'th': 'ID  login  Facebook',
      'en': 'Facebook login ID',
      'zh_Hans': 'Facebook登录ID',
    },
    'z7555l2i': {
      'th': 'บันทึก โปรไฟล์',
      'en': 'Save Profile',
      'zh_Hans': '保存个人资料',
    },
  },
  // meassageoption
  {
    'bbesdap1': {
      'th': 'Cheers&Chat  Package',
      'en': 'Cheers & Chat Package',
      'zh_Hans': '欢呼与聊天套餐',
    },
    '9f3d66nc': {
      'th': 'ชำระเงินด้วยระบบ  PromptPay  สะดวก ปลอดภัย',
      'en': 'Pay with PromptPay, convenient and safe.',
      'zh_Hans': '使用 PromptPay 付款，方便又安全。',
    },
    'r5tus9bg': {
      'th': 'เลือก   Package',
      'en': 'Select Package',
      'zh_Hans': '选择套餐',
    },
    '6nasx7c3': {
      'th': 'X',
      'en': 'X',
      'zh_Hans': 'X',
    },
    'j5cs2fbe': {
      'th': 'Chat ไม่จำกัด',
      'en': 'Unlimited Chat',
      'zh_Hans': '无限聊天',
    },
    'ekfyd6a3': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    'pou7t511': {
      'th': 'Cheers ไม่จำกัด',
      'en': 'Unlimited Cheers',
      'zh_Hans': '无限欢呼',
    },
    'mb8tr2sr': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    '7a9j6lfn': {
      'th': 'เห็นทุกคนที่  Cheers  คุณ',
      'en': 'See everyone cheering you on',
      'zh_Hans': '看到大家都在为你加油',
    },
    'okhzxrz6': {
      'th': 'Unlimited',
      'en': 'Unlimited',
      'zh_Hans': '无限',
    },
    'vfu8w88q': {
      'th': '฿ 49 .00',
      'en': '฿ 49.00',
      'zh_Hans': '49.00 泰铢',
    },
  },
  // popupusershow
  {
    'v8twwbro': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    'er53rk14': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'kcgzbjrg': {
      'th': 'Block',
      'en': 'Block',
      'zh_Hans': '堵塞',
    },
  },
  // linecheck
  {
    'jad00i83': {
      'th': 'ไม่รองรับการเล่นผ่าน Line',
      'en': 'Play via Line is not supported.',
      'zh_Hans': '不支持通过 Line 播放。',
    },
    'zzsabprf': {
      'th': 'กดที่มุมขวาล่างเพื่อเปิดใน browser ของคุณ',
      'en': 'Click on the bottom right corner to open it in your browser.',
      'zh_Hans': '点击右下角即可在浏览器中打开。',
    },
    'yw9mzhw0': {
      'th': 'Click Here!',
      'en': 'Click Here!',
      'zh_Hans': '点击这里！',
    },
  },
  // CheckCheers
  {
    '46da8ms1': {
      'th': 'Cheers  Match',
      'en': 'Cheers Match',
      'zh_Hans': '祝你好运',
    },
    '0d3y4v1l': {
      'th': 'มีคน Cheers คุณ',
      'en': 'Someone is cheering you on.',
      'zh_Hans': '有人在为你加油。',
    },
    's757cb9p': {
      'th': 'x',
      'en': 'x',
      'zh_Hans': 'x',
    },
    '4fxmvmsu': {
      'th': 'ดูว่าใคร Cheers คุณ',
      'en': 'See who Cheers you',
      'zh_Hans': '看看谁会为你欢呼',
    },
  },
  // showphotoCopy
  {
    'rnbxlb0h': {
      'th': 'Black',
      'en': 'Black',
      'zh_Hans': '黑色的',
    },
  },
  // posterPresent
  {
    'sjar8369': {
      'th': 'About Event',
      'en': 'About Event',
      'zh_Hans': '关于活动',
    },
    '13ru3pxc': {
      'th': 'Booking Table',
      'en': 'Booking Table',
      'zh_Hans': '预订餐桌',
    },
  },
  // filter
  {
    '61ovuoqq': {
      'th': 'Filters',
      'en': 'Filters',
      'zh_Hans': '过滤器',
    },
    'ax962ez4': {
      'th': 'Distance',
      'en': 'Distance',
      'zh_Hans': '距离',
    },
    'q0tqvw1e': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
    'nlvb3wjv': {
      'th': 'Type Venuses',
      'en': 'Type Venuses',
      'zh_Hans': '维纳斯类型',
    },
    'gy667nbh': {
      'th': 'Pub',
      'en': 'Pub',
      'zh_Hans': '酒吧',
    },
    'u6srszey': {
      'th': 'Bar',
      'en': 'Bar',
      'zh_Hans': '酒吧',
    },
    'eeyxdmdw': {
      'th': 'Chill',
      'en': 'Chill',
      'zh_Hans': '寒意',
    },
    'rl0ga10m': {
      'th': 'CraftBeer',
      'en': 'CraftBeer',
      'zh_Hans': '精酿啤酒',
    },
    's9yaj8wb': {
      'th': 'Out Door',
      'en': 'Outdoor',
      'zh_Hans': '户外的',
    },
    's7cwbfue': {
      'th': 'Style Musics',
      'en': 'Style Musics',
      'zh_Hans': '风格音乐',
    },
    'rmzseyr4': {
      'th': 'LiveMusic',
      'en': 'LiveMusic',
      'zh_Hans': '现场音乐',
    },
    'zchvxgoo': {
      'th': 'Hiphop',
      'en': 'Hiphop',
      'zh_Hans': '嘻哈',
    },
    'qtwraypg': {
      'th': 'ลูกทุ่ง',
      'en': 'Country music',
      'zh_Hans': '乡村音乐',
    },
    'hddmmpbl': {
      'th': 'เพื่อชีวิต',
      'en': 'For life',
      'zh_Hans': '一生',
    },
    'kcsysckt': {
      'th': 'EDM',
      'en': 'EDM',
      'zh_Hans': '电子舞曲',
    },
    '3kdu52bs': {
      'th': 'Jazz',
      'en': 'Jazz',
      'zh_Hans': '爵士乐',
    },
    '22jap4o5': {
      'th': 'Rock',
      'en': 'Rock',
      'zh_Hans': '岩石',
    },
    'ms1qtkw9': {
      'th': 'Clear filter',
      'en': 'Clear filter',
      'zh_Hans': '清除过滤器',
    },
    'zqtx4gzg': {
      'th': 'Confirm',
      'en': 'Confirm',
      'zh_Hans': '确认',
    },
  },
  // review
  {
    '25bukxun': {
      'th': 'Overall Rate',
      'en': 'Overall Rate',
      'zh_Hans': '总体评分',
    },
    'wnzwymdq': {
      'th': 'Reviews',
      'en': 'Reviews',
      'zh_Hans': '评论',
    },
    'fg7k7qoa': {
      'th': 'Reviews',
      'en': 'Reviews',
      'zh_Hans': '评论',
    },
  },
  // reviewgive
  {
    'xfvpitv9': {
      'th': 'Review',
      'en': 'Review',
      'zh_Hans': '审查',
    },
    'z0f12e5c': {
      'th': 'โปรดให้คะแนนและบอกเล่าประสบการณ์ของคุณ',
      'en': 'Please rate and tell us about your experience.',
      'zh_Hans': '请评价并告诉我们您的体验。',
    },
    'yb1d4pp3': {
      'th': 'เขียนรีวิวร้าน และประสบการณ์ของคุณ',
      'en': 'Write a review of the store and your experience.',
      'zh_Hans': '请写下您对这家商店和购物体验的评价。',
    },
    '059j9bih': {
      'th': 'Cancel',
      'en': 'Cancel',
      'zh_Hans': '取消',
    },
    '66yuaryw': {
      'th': 'Submit',
      'en': 'Submit',
      'zh_Hans': '提交',
    },
  },
  // datapromotion
  {
    'cg9krkdo': {
      'th': 'Book',
      'en': 'Book',
      'zh_Hans': '书',
    },
    'jv4kh6nx': {
      'th': 'Now',
      'en': 'Now',
      'zh_Hans': '现在',
    },
    'pt91hugb': {
      'th': 'Today',
      'en': 'Today',
      'zh_Hans': '今天',
    },
  },
  // joinroom
  {
    'jx86187c': {
      'th': 'Online Chat Room',
      'en': 'Online Chat Room',
      'zh_Hans': '在线聊天室',
    },
    'pxtc8g70': {
      'th': 'select a place near you',
      'en': 'Select a place near you',
      'zh_Hans': '选择您附近的地点',
    },
    'rjsbq731': {
      'th': 'Pub',
      'en': 'Pub',
      'zh_Hans': '酒吧',
    },
    'ojlqgeqn': {
      'th': 'LiveMusic',
      'en': 'LiveMusic',
      'zh_Hans': '现场音乐',
    },
    'sr5wx9kx': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    '7xe2ctzx': {
      'th': 'Join Room',
      'en': 'Join Room',
      'zh_Hans': '加入房间',
    },
  },
  // nodata
  {
    'x3apx9v8': {
      'th': 'No Events',
      'en': 'No Events',
      'zh_Hans': '无事件',
    },
    '2q2gbild': {
      'th': 'Please select another day for more information.',
      'en': 'Please select another day for more information.',
      'zh_Hans': '请选择其他日期查看更多信息。',
    },
  },
  // stage
  {
    'oxahnggw': {
      'th': 'STAGE',
      'en': 'STAGE',
      'zh_Hans': '阶段',
    },
  },
  // rowpromotion
  {
    'kzrbch3h': {
      'th': 'Today',
      'en': 'Today',
      'zh_Hans': '今天',
    },
  },
  // popupmap
  {
    'gyu7n4jr': {
      'th': 'km',
      'en': 'km',
      'zh_Hans': '公里',
    },
  },
  // Checkout1Products
  {
    'royeqo90': {
      'th': 'Order Summary',
      'en': 'Order Summary',
      'zh_Hans': '订单摘要',
    },
    '8wy4lzsi': {
      'th': 'Review your order below before checking out.',
      'en': 'Review your order below before checking out.',
      'zh_Hans': '结账前请仔细核对以下订单信息。',
    },
    '87ignsq1': {
      'th': 'Item Name',
      'en': 'Item Name',
      'zh_Hans': '物品名称',
    },
    '8s594cw7': {
      'th': 'Secondary text',
      'en': 'Secondary text',
      'zh_Hans': '次要文本',
    },
    'mbsg9qyp': {
      'th': '\$1.50',
      'en': '\$1.50',
      'zh_Hans': '1.50美元',
    },
    'z5pw81su': {
      'th': 'Item Name',
      'en': 'Item Name',
      'zh_Hans': '物品名称',
    },
    '3cq4s8eu': {
      'th': 'Secondary text',
      'en': 'Secondary text',
      'zh_Hans': '次要文本',
    },
    'mkmibosn': {
      'th': '\$1.50',
      'en': '\$1.50',
      'zh_Hans': '1.50美元',
    },
    'dqy8fn2h': {
      'th': 'Price Breakdown',
      'en': 'Price Breakdown',
      'zh_Hans': '价格明细',
    },
    '6tmtds3l': {
      'th': 'Base Price',
      'en': 'Base Price',
      'zh_Hans': '基价',
    },
    'cjvm3e6o': {
      'th': '\$156.00',
      'en': '\$156.00',
      'zh_Hans': '156.00美元',
    },
    'sig6jceg': {
      'th': 'Taxes',
      'en': 'Taxes',
      'zh_Hans': '税收',
    },
    '0isy8zei': {
      'th': '\$24.20',
      'en': '\$24.20',
      'zh_Hans': '24.20美元',
    },
    'eo89xty2': {
      'th': 'Cleaning Fee',
      'en': 'Cleaning Fee',
      'zh_Hans': '清洁费',
    },
    'imxohj9c': {
      'th': '\$40.00',
      'en': '\$40.00',
      'zh_Hans': '40.00美元',
    },
    'bwiua023': {
      'th': 'Total',
      'en': 'Total',
      'zh_Hans': '全部的',
    },
    '38m358vu': {
      'th': '\$230.20',
      'en': '\$230.20',
      'zh_Hans': '230.20美元',
    },
    '7eflhlmh': {
      'th': 'Proceed to Checkout',
      'en': 'Proceed to Checkout',
      'zh_Hans': '进行结算',
    },
  },
  // SelectAppMap
  {
    'vs27b27y': {
      'th': 'Apple Map',
      'en': 'Apple Map',
      'zh_Hans': '苹果地图',
    },
    'pbykxkt1': {
      'th': 'Google Map',
      'en': 'Google Map',
      'zh_Hans': '谷歌地图',
    },
    '6sh1ybvc': {
      'th': 'Cancel',
      'en': 'Cancel',
      'zh_Hans': '取消',
    },
  },
  // showpeopleNoswipe
  {
    'hx4cxq5v': {
      'th': 'Block',
      'en': 'Block',
      'zh_Hans': '堵塞',
    },
  },
  // items
  {
    'f12op9xo': {
      'th': 'Spacial Gift',
      'en': 'Special Gift',
      'zh_Hans': '特别礼物',
    },
    'oa6v3cc3': {
      'th': '999',
      'en': '999',
      'zh_Hans': '999',
    },
    'jkyommuk': {
      'th': '10',
      'en': '10',
      'zh_Hans': '10',
    },
    'jp1w1d7g': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    'ijdk6wqn': {
      'th': '40',
      'en': '40',
      'zh_Hans': '40',
    },
    'alcb5pdg': {
      'th': '80',
      'en': '80',
      'zh_Hans': '80',
    },
    '1b7vl2lu': {
      'th': '150',
      'en': '150',
      'zh_Hans': '150',
    },
    'j02x1gwu': {
      'th': '200',
      'en': '200',
      'zh_Hans': '200',
    },
  },
  // item
  {
    'uzvcm3j4': {
      'th': 'Spacial Gift',
      'en': 'Special Gift',
      'zh_Hans': '特别礼物',
    },
    'g913ncyq': {
      'th': 'ของขวัญใช้แทนเงินสดในร้านได้',
      'en': 'Gifts can be used in place of cash in the store.',
      'zh_Hans': '礼品可以在店内代替现金使用。',
    },
    '2mx0g8d7': {
      'th': '999',
      'en': '999',
      'zh_Hans': '999',
    },
    'yn990my0': {
      'th': 'THB',
      'en': 'THB',
      'zh_Hans': '泰铢',
    },
    'hqi0oom7': {
      'th': '10',
      'en': '10',
      'zh_Hans': '10',
    },
    'ti4uoq5m': {
      'th': 'THB',
      'en': 'THB',
      'zh_Hans': '泰铢',
    },
    'gbv4rvjr': {
      'th': '20',
      'en': '20',
      'zh_Hans': '20',
    },
    '8bgisnej': {
      'th': 'THB',
      'en': 'THB',
      'zh_Hans': '泰铢',
    },
    '0zg3bhe0': {
      'th': '40',
      'en': '40',
      'zh_Hans': '40',
    },
    'lriu4nm4': {
      'th': 'THB',
      'en': 'THB',
      'zh_Hans': '泰铢',
    },
    '1hfhux4n': {
      'th': '80',
      'en': '80',
      'zh_Hans': '80',
    },
    'h9cxh1eb': {
      'th': 'THB',
      'en': 'THB',
      'zh_Hans': '泰铢',
    },
    'e5jla5tg': {
      'th': '150',
      'en': '150',
      'zh_Hans': '150',
    },
    'm418myc2': {
      'th': 'THB',
      'en': 'THB',
      'zh_Hans': '泰铢',
    },
    'iwc8qe38': {
      'th': '200',
      'en': '200',
      'zh_Hans': '200',
    },
  },
  // accountPage
  {
    '1tuf3zdu': {
      'th': 'เบียร์ ช้าง',
      'en': 'Chang beer',
      'zh_Hans': '昌啤酒',
    },
    'thg66gfp': {
      'th':
          'นำกระทะตั้งไฟปานกลาง ใส่น้ำมันพอร้อน ตามด้วยกระเทียม หอมใหญ่ แคร์รอต ผัดให้กระเทียมพอเหลือง พักทุกอย่างไว้ข้างกระทะ',
      'en':
          'Place a pan over medium heat and add oil. Once hot, add garlic, onion, and carrot. Stir-fry until the garlic turns yellow. Set everything aside.',
      'zh_Hans': '平底锅中火加热，倒入油。油热后，加入蒜末、洋葱碎和胡萝卜碎。翻炒至蒜末变黄。盛出备用。',
    },
    'd2x52u28': {
      'th': 'รายการหลัก',
      'en': 'Main items',
      'zh_Hans': '主要项目',
    },
    'ky5kczto': {
      'th': '( เลือก 1 รายการ )',
      'en': '(Choose 1 item)',
      'zh_Hans': '（选择1项）',
    },
    'v0s1yakg': {
      'th': 'กระป๋อง',
      'en': 'can',
      'zh_Hans': '能',
    },
    'plpi8ac3': {
      'th': '490 ml',
      'en': '490 ml',
      'zh_Hans': '490毫升',
    },
    'iz8upluc': {
      'th': '฿80.00',
      'en': '฿80.00',
      'zh_Hans': '80.00 泰铢',
    },
    '1taykv9o': {
      'th': 'ขวด',
      'en': 'bottle',
      'zh_Hans': '瓶子',
    },
    '61koln9m': {
      'th': '960 ml',
      'en': '960 ml',
      'zh_Hans': '960毫升',
    },
    'gxtxed0h': {
      'th': '฿125.00',
      'en': '฿125.00',
      'zh_Hans': '125.00 泰铢',
    },
    'fopxh6ut': {
      'th': 'ขวด x6',
      'en': 'Bottle x6',
      'zh_Hans': '6瓶',
    },
    'o45tq0eo': {
      'th': 'Secondary text',
      'en': 'Secondary text',
      'zh_Hans': '次要文本',
    },
    '6xd7h8om': {
      'th': '฿600.00',
      'en': '฿600.00',
      'zh_Hans': '600.00 泰铢',
    },
    'ktst41ad': {
      'th': 'โปร 24 ขวด',
      'en': '24 bottle promotion',
      'zh_Hans': '24瓶装促销',
    },
    'jr24icaw': {
      'th': 'ก่อน 3 ทุ่ม\n - เฟรนฟราย 1 จาน\n - ลูกชิ้น 1 จาน',
      'en': 'Before 9 PM\n- 1 plate of French fries\n- 1 plate of meatballs',
      'zh_Hans': '晚上9点前\n\n- 一份炸薯条\n\n- 一份肉丸',
    },
    'ivx746hh': {
      'th': '฿2200.00',
      'en': '฿2200.00',
      'zh_Hans': '2200.00 泰铢',
    },
    '6qsq9emi': {
      'th': 'tower',
      'en': 'tower',
      'zh_Hans': '塔',
    },
    'tte3l895': {
      'th': '2800 ml',
      'en': '2800 ml',
      'zh_Hans': '2800毫升',
    },
    'sw0y7mzx': {
      'th': '฿1,200.00',
      'en': '฿1,200.00',
      'zh_Hans': '1,200.00 泰铢',
    },
    '6ld7endt': {
      'th': 'รายการเสริม 1#',
      'en': 'Additional item 1#',
      'zh_Hans': '附加项目 1#',
    },
    'uhdtdr8l': {
      'th': '( เลือก 2  รายการ )',
      'en': '(Choose 2 items)',
      'zh_Hans': '（选择两项）',
    },
    'y7p97833': {
      'th': 'ข้าวไข่เจียว',
      'en': 'Omelet rice',
      'zh_Hans': '蛋包饭',
    },
    'p4wxhn1k': {
      'th': '+ ฿100',
      'en': '+ ฿100',
      'zh_Hans': '+ 100 泰铢',
    },
    '8jyip9q8': {
      'th': 'ข้าวไข่ขาหมู',
      'en': 'Pork leg and egg rice',
      'zh_Hans': '猪脚蛋饭',
    },
    'm8saqwv0': {
      'th': '+ ฿100',
      'en': '+ ฿100',
      'zh_Hans': '+ 100 泰铢',
    },
    'e74jcwol': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'h2eowim4': {
      'th': '+ ฿100',
      'en': '+ ฿100',
      'zh_Hans': '+ 100 泰铢',
    },
    '2c0ttz1g': {
      'th': 'ระบุรายละเอียดเพิ่มเติม',
      'en': 'Provide additional details',
      'zh_Hans': '请提供更多详情',
    },
  },
  // header
  {
    'uh6abhr2': {
      'th': 'A55',
      'en': 'A55',
      'zh_Hans': 'A55',
    },
    '5m6bre6h': {
      'th': '5+',
      'en': '5+',
      'zh_Hans': '5岁以上',
    },
    'bupf1vmm': {
      'th': 'เปิดโต๊ะเวลา  :  21:00',
      'en': 'Table opens at 9:00 PM',
      'zh_Hans': '餐桌晚上9点开放',
    },
    '5stsf6tj': {
      'th': 'สถานะ : ',
      'en': 'status :',
      'zh_Hans': '地位 ：',
    },
    '94faegm6': {
      'th': 'กำลังบริการ',
      'en': 'Service in progress',
      'zh_Hans': '服务进行中',
    },
    'wvshhx7i': {
      'th': '3',
      'en': '3',
      'zh_Hans': '3',
    },
    '3yhupuy0': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'd031gm2m': {
      'th': '8',
      'en': '8',
      'zh_Hans': '8',
    },
  },
  // appbarmenuCopy
  {
    '4w7okaiq': {
      'th': 'เบียร์ ช้าง',
      'en': 'Chang beer',
      'zh_Hans': '昌啤酒',
    },
    'ccy14dp5': {
      'th':
          'นำกระทะตั้งไฟปานกลาง ใส่น้ำมันพอร้อน ตามด้วยกระเทียม หอมใหญ่ แคร์รอต ผัดให้กระเทียมพอเหลือง พักทุกอย่างไว้ข้างกระทะ',
      'en':
          'Place a pan over medium heat and add oil. Once hot, add garlic, onion, and carrot. Stir-fry until the garlic turns yellow. Set everything aside.',
      'zh_Hans': '平底锅中火加热，倒入油。油热后，加入蒜末、洋葱碎和胡萝卜碎。翻炒至蒜末变黄。盛出备用。',
    },
    '5t3fx476': {
      'th': 'รายการหลัก',
      'en': 'Main items',
      'zh_Hans': '主要项目',
    },
    'w26z0txk': {
      'th': '( เลือก 1 รายการ )',
      'en': '(Choose 1 item)',
      'zh_Hans': '（选择1项）',
    },
    'li0i93h8': {
      'th': 'กระป๋อง',
      'en': 'can',
      'zh_Hans': '能',
    },
    '2i4emeiv': {
      'th': '490 ml',
      'en': '490 ml',
      'zh_Hans': '490毫升',
    },
    'nowa5wqq': {
      'th': '฿80.00',
      'en': '฿80.00',
      'zh_Hans': '80.00 泰铢',
    },
    'lzlwyz5p': {
      'th': 'ขวด',
      'en': 'bottle',
      'zh_Hans': '瓶子',
    },
    'syd2fvo2': {
      'th': '960 ml',
      'en': '960 ml',
      'zh_Hans': '960毫升',
    },
    'uneymy43': {
      'th': '฿125.00',
      'en': '฿125.00',
      'zh_Hans': '125.00 泰铢',
    },
    'roc84uh6': {
      'th': 'ขวด x6',
      'en': 'Bottle x6',
      'zh_Hans': '6瓶',
    },
    'almm9ins': {
      'th': 'Secondary text',
      'en': 'Secondary text',
      'zh_Hans': '次要文本',
    },
    'jbn0op93': {
      'th': '฿600.00',
      'en': '฿600.00',
      'zh_Hans': '600.00 泰铢',
    },
    'ouyh24oe': {
      'th': 'โปร 24 ขวด',
      'en': '24 bottle promotion',
      'zh_Hans': '24瓶装促销',
    },
    'ijkpx5mr': {
      'th': 'ก่อน 3 ทุ่ม\n - เฟรนฟราย 1 จาน\n - ลูกชิ้น 1 จาน',
      'en': 'Before 9 PM\n- 1 plate of French fries\n- 1 plate of meatballs',
      'zh_Hans': '晚上9点前\n\n- 一份炸薯条\n\n- 一份肉丸',
    },
    '6vbc4toe': {
      'th': '฿2200.00',
      'en': '฿2200.00',
      'zh_Hans': '2200.00 泰铢',
    },
    '2racoy76': {
      'th': 'tower',
      'en': 'tower',
      'zh_Hans': '塔',
    },
    '8xk87fm0': {
      'th': '2800 ml',
      'en': '2800 ml',
      'zh_Hans': '2800毫升',
    },
    'i0gt64q8': {
      'th': '฿1,200.00',
      'en': '฿1,200.00',
      'zh_Hans': '1,200.00 泰铢',
    },
    'y4adjn7e': {
      'th': 'รายการเสริม 1#',
      'en': 'Additional item 1#',
      'zh_Hans': '附加项目 1#',
    },
    'gdgvi36s': {
      'th': '( เลือก 2  รายการ )',
      'en': '(Choose 2 items)',
      'zh_Hans': '（选择两项）',
    },
    '2xcu1n0d': {
      'th': 'ข้าวไข่เจียว',
      'en': 'Omelet rice',
      'zh_Hans': '蛋包饭',
    },
    'bpu0xdyl': {
      'th': '+ ฿100',
      'en': '+ ฿100',
      'zh_Hans': '+ 100 泰铢',
    },
    'nrwvz2da': {
      'th': 'ข้าวไข่ขาหมู',
      'en': 'Pork leg and egg rice',
      'zh_Hans': '猪脚蛋饭',
    },
    'cs747arq': {
      'th': '+ ฿100',
      'en': '+ ฿100',
      'zh_Hans': '+ 100 泰铢',
    },
    '90dh6gtj': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    '7dbah7v6': {
      'th': '+ ฿100',
      'en': '+ ฿100',
      'zh_Hans': '+ 100 泰铢',
    },
    'bpluj4b5': {
      'th': 'ระบุรายละเอียดเพิ่มเติม',
      'en': 'Provide additional details',
      'zh_Hans': '请提供更多详情',
    },
    'i41sqnrr': {
      'th': '฿ 1,500.00',
      'en': '฿ 1,500.00',
      'zh_Hans': '1,500.00',
    },
    'x9dyn1hg': {
      'th': '1',
      'en': '1',
      'zh_Hans': '1',
    },
    'cobkynbg': {
      'th': 'Add Order',
      'en': 'Add Order',
      'zh_Hans': '添加订单',
    },
  },
  // MaterialList1
  {
    '1f0kqucw': {
      'th': 'ข้าวไข่าว',
      'en': 'Rice',
      'zh_Hans': '米',
    },
    'lz1gfean': {
      'th': '+ ฿100',
      'en': '+ ฿100',
      'zh_Hans': '+ 100 泰铢',
    },
  },
  // appbarsilver
  {
    'zay1saue': {
      'th': '฿ 1,500.00',
      'en': '฿ 1,500.00',
      'zh_Hans': '1,500.00',
    },
    'jph82c73': {
      'th': '1',
      'en': '1',
      'zh_Hans': '1',
    },
    'r5xcsk95': {
      'th': 'Add Order',
      'en': 'Add Order',
      'zh_Hans': '添加订单',
    },
  },
  // partOptionInVenuseActive
  {
    'd6e8v4g3': {
      'th': 'Online Chat Room',
      'en': 'Online Chat Room',
      'zh_Hans': '在线聊天室',
    },
    'h3gma7d3': {
      'th': 'ค้นหาผู้คน',
      'en': 'Find people',
      'zh_Hans': '寻找人',
    },
    'g2x0u4xf': {
      'th': 'Leave',
      'en': 'Leave',
      'zh_Hans': '离开',
    },
    'wmiwgemt': {
      'th': 'Menu',
      'en': 'Menu',
      'zh_Hans': '菜单',
    },
    'fewdyg33': {
      'th': 'SOHO Sigature',
      'en': 'SOHO Sigature',
      'zh_Hans': 'SOHO 签名',
    },
    'aan7mvlt': {
      'th': 'SOHO แซบ',
      'en': 'SOHO is spicy',
      'zh_Hans': 'SOHO很辣',
    },
    'ccol7ngk': {
      'th': 'เบียร์',
      'en': 'beer',
      'zh_Hans': '啤酒',
    },
    '5kpoea0e': {
      'th': 'โซจู',
      'en': 'Soju',
      'zh_Hans': '烧酒',
    },
    'nxnq138n': {
      'th': 'Promotion',
      'en': 'Promotion',
      'zh_Hans': '晋升',
    },
    'ia675ltr': {
      'th': 'Menu',
      'en': 'Menu',
      'zh_Hans': '菜单',
    },
    'x3zr9781': {
      'th': 'Events',
      'en': 'Events',
      'zh_Hans': '活动',
    },
    'ggu4hagg': {
      'th': 'SOHO Signature',
      'en': 'SOHO Signature',
      'zh_Hans': 'SOHO 签名',
    },
    'mozp8hvv': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'n2qvq4u4': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'bxyi01qd': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'ocrnb5fm': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'e41z25dn': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'i64s3x67': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'y1xv6kjo': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'ng76lwjb': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '1lp2gl8m': {
      'th': '2',
      'en': '2',
      'zh_Hans': '2',
    },
    'ikg6aitr': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'kum4si3w': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '947e88tx': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '1wctir00': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '6yfl41tj': {
      'th': 'SOHO แซบ',
      'en': 'SOHO is spicy',
      'zh_Hans': 'SOHO很辣',
    },
    'ssgnr50l': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'ggqgcxpk': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'oczqyicu': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'lc9zguf6': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'bse2b9ts': {
      'th': '9',
      'en': '9',
      'zh_Hans': '9',
    },
    'z3akpbyx': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'igeaepqg': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'g0ehcspj': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'h3bm1clw': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '27tet0fu': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'uv0vnoxl': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'edxd414d': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'gxdtlg64': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '6wy1b60a': {
      'th': 'SOJU',
      'en': 'SOJU',
      'zh_Hans': '烧酒',
    },
    '16kggjf8': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'g26oxpq2': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'hwe9thng': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'mhrx3vom': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '74jc8aky': {
      'th': '9',
      'en': '9',
      'zh_Hans': '9',
    },
    'lfeh1g45': {
      'th': 'ข้าวไข่ข้น',
      'en': 'Omelet Rice',
      'zh_Hans': '煎蛋饭',
    },
    'ulgc418v': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'pvmg4zto': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'cv22cjfa': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'pzmks6g0': {
      'th': 'BEER',
      'en': 'BEER',
      'zh_Hans': '啤酒',
    },
    'm9dipmav': {
      'th': 'Budweiser',
      'en': 'Budweiser',
      'zh_Hans': '百威啤酒',
    },
    'j1e4ee5l': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'e3q09p5b': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    '5sy0ayt4': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'pcjzmh60': {
      'th': 'Chang',
      'en': 'Chang',
      'zh_Hans': '张',
    },
    'cpq635c7': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'vjw2zpem': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    't1v5chjo': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'headvq2r': {
      'th': 'heineken',
      'en': 'Heineken',
      'zh_Hans': '喜力',
    },
    'hz23m7sx': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    'z284sq5a': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'z8bmqjg0': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'sqe8yn32': {
      'th': 'heineken',
      'en': 'Heineken',
      'zh_Hans': '喜力',
    },
    'ojffu2bf': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '00751b0b': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'fkty4t4r': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    'ger8q0sn': {
      'th': 'Colona',
      'en': 'Colona',
      'zh_Hans': '科洛纳',
    },
    '0bqpihe7': {
      'th': 'fire rice egg',
      'en': 'Fire rice egg',
      'zh_Hans': '火米饭蛋',
    },
    '58w4o50o': {
      'th': '120',
      'en': '120',
      'zh_Hans': '120',
    },
    'anwikqaw': {
      'th': '฿',
      'en': '฿',
      'zh_Hans': '฿',
    },
    '8i2gstae': {
      'th': 'My Ticket',
      'en': 'My Ticket',
      'zh_Hans': '我的票',
    },
    'b81gf5it': {
      'th': 'ณ บางเขน',
      'en': 'At Bang Khen',
      'zh_Hans': '在邦肯',
    },
    'kv9vrl9l': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'z82bno7c': {
      'th': 'VVIP',
      'en': 'VVIP',
      'zh_Hans': '贵宾',
    },
    '9sj9hzbo': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '4ncy5uo7': {
      'th': 'A31',
      'en': 'A31',
      'zh_Hans': 'A31',
    },
    'cbjakro2': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'ca8y9xo5': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'n8mhccnf': {
      'th': '฿ 2,500',
      'en': '฿ 2,500',
      'zh_Hans': '2,500 泰铢',
    },
    'guuz3sjk': {
      'th': '฿ 1,500',
      'en': '฿ 1,500',
      'zh_Hans': '1,500 泰铢',
    },
    '4b0gsnpb': {
      'th': 'ณ บางเขน',
      'en': 'At Bang Khen',
      'zh_Hans': '在邦肯',
    },
    '0sfmpf3f': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '7lbn16bw': {
      'th': 'VIP',
      'en': 'VIP',
      'zh_Hans': 'VIP',
    },
    'pyuumycw': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'fu4l1bn7': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'z1abokhc': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'vcdav4o3': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'dvygpfg5': {
      'th': '฿ 1,000',
      'en': '฿ 1,000',
      'zh_Hans': '1,000 泰铢',
    },
    'xzgrf3xp': {
      'th': 'ณ บางเขน',
      'en': 'At Bang Khen',
      'zh_Hans': '在邦肯',
    },
    'uzzpq4pf': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '9gtjxitw': {
      'th': 'A',
      'en': 'A',
      'zh_Hans': '一个',
    },
    'f7qxmwpb': {
      'th': '฿ 500',
      'en': '฿ 500',
      'zh_Hans': '500 泰铢',
    },
    'odp62rs3': {
      'th': 'ณ บางเขน',
      'en': 'At Bang Khen',
      'zh_Hans': '在邦肯',
    },
    'fckewycb': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    'f70bzf7k': {
      'th': 'B',
      'en': 'B',
      'zh_Hans': 'B',
    },
    'c1ikjgfb': {
      'th': '฿ 300',
      'en': '฿ 300',
      'zh_Hans': '฿ 300',
    },
    '38h9uedb': {
      'th': 'ณ บางเขน',
      'en': 'At Bang Khen',
      'zh_Hans': '在邦肯',
    },
    '35pa20i3': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '759bx3ul': {
      'th': 'C',
      'en': 'C',
      'zh_Hans': 'C',
    },
    'bgszrtyw': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'eis79ors': {
      'th': 'C31',
      'en': 'C31',
      'zh_Hans': 'C31',
    },
    'qt2em628': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '51cczc1m': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '9ljfrmhh': {
      'th': '฿ Free',
      'en': '฿ Free',
      'zh_Hans': '免费',
    },
    'sbacgt37': {
      'th': 'ณ บางเขน',
      'en': 'At Bang Khen',
      'zh_Hans': '在邦肯',
    },
    'qr231cy8': {
      'th': 'Zone :',
      'en': 'Zone :',
      'zh_Hans': '区域：',
    },
    '09vtgxz2': {
      'th': 'Regular',
      'en': 'Regular',
      'zh_Hans': '常规的',
    },
    'vwn1q4jb': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    '17d0xiw7': {
      'th': 'B31',
      'en': 'B31',
      'zh_Hans': 'B31',
    },
    'zemblpfr': {
      'th': ': ',
      'en': ':',
      'zh_Hans': '：',
    },
    'c5j2ji7y': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    '69vaov15': {
      'th': 'Check In',
      'en': 'Check In',
      'zh_Hans': '报到',
    },
    'qazljgsj': {
      'th': '3',
      'en': '3',
      'zh_Hans': '3',
    },
    '9yohsgjh': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'q2sw6ifr': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
    'wpff1y6i': {
      'th': 'You',
      'en': 'You',
      'zh_Hans': '你',
    },
    'i2dcgvz2': {
      'th': 'PANK',
      'en': 'PANK',
      'zh_Hans': '潘克',
    },
    'lfcg4fw9': {
      'th': 'PUK_66',
      'en': 'PUK_66',
      'zh_Hans': 'PUK_66',
    },
    'dpnkemim': {
      'th':
          'เงื่อนไขการจอง\nเงื่อนไขการจองคิวรายวัน\n\nทางร้านรับเฉพาะกลุ่มนักศึกษา\nและพนักงานออฟฟิศ แต่งกายดี\n⚠️ ❗️ ไม่รับทรงเอและเด็กช่าง ❗️⚠️ \n\n❗️ค่าจอง คิวละ 500 บาท\n❗ค่าจองคืนเต็มจำนวน เมื่อมารับโต๊ะ\n❗️1 โต๊ะนั่งได้สูงสุด 20 ท่าน\n❗️จองได้ล่วงหน้า 30 วัน\n❗️ปิดรับจองโต๊ะ 16.00\n\nเงื่อนไขการปล่อยคิว\n❗️ปล่อยโต๊ะ 21.00 สำหรับ อาทิตย์-พฤหัส❗️\n❗ปล่อยโต๊ะ 20.30 สำหรับศุกร์-เสาร์-concert❗️\n\n** หากมาไม่ทันเวลารับโต๊ะ ไม่คืนเงินค่าจองทุกกรณี** 🙏',
      'en':
          'Booking Conditions\nDaily Booking Conditions\n\nWe only accept students\nand office workers. Please dress appropriately.\n⚠️❗️ We do not accept A-line dresses or technical school students.❗️⚠️\n\n❗️Booking Fee: 500 baht per queue.\n❗Fully refunded upon table pick-up.\n❗️Maximum 20 people per table.\n❗️Book 30 days in advance.\n❗️Bookings close at 4:00 PM.\n\nQueue Release Conditions:\n❗️Tables release at 9:00 PM for Sunday-Thursday❗️\n❗️Tables release at 8:30 PM for Friday-Saturday-concerts❗️\n\n**If you miss your table pick-up time, the reservation fee will not be refunded.** 🙏',
      'zh_Hans':
          '预订须知\n\n每日预订须知\n\n我们仅接受学生\n\n和上班族。请着装得体。\n\n⚠️❗️我们不接受A字裙或技校学生。❗️⚠️\n\n❗️预订费：每排500泰铢。\n\n❗️取桌时全额退款。\n\n❗️每桌最多20人。\n\n❗️请提前30天预订。\n\n❗️预订截止时间为下午4:00。\n\n排队释放须知：\n\n❗️周日至周四晚上9:00释放桌位❗️\n\n❗️周五、周六及音乐会期间晚上8:30释放桌位❗️\n\n**如果您错过取桌时间，预订费将不予退还。** 🙏',
    },
  },
  // partHeaderInVenuseActive
  {
    '94svsvck': {
      'th': 'VIP',
      'en': 'VIP',
      'zh_Hans': 'VIP',
    },
    '438ypd8x': {
      'th': 'A78',
      'en': 'A78',
      'zh_Hans': 'A78',
    },
    'rpsc4srs': {
      'th': '3',
      'en': '3',
      'zh_Hans': '3',
    },
    'csixm5s9': {
      'th': '/',
      'en': '/',
      'zh_Hans': '/',
    },
    'bvr3hfec': {
      'th': '4',
      'en': '4',
      'zh_Hans': '4',
    },
  },
  // Miscellaneous
  {
    '8r7nuo39': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'obsa885p': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'uo4zwnei': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    '5nhehlyq': {
      'th': 'อนุญาตให้แจ้งเตือนเมื่อมีข้อความ',
      'en': 'Allow notifications when there is a message',
      'zh_Hans': '允许在收到消息时接收通知',
    },
    '74a1bg54': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'ioz1n3pt': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'q2j4wjbg': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'a1rg12q7': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    '3atwkrb4': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'yrnp0iq6': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'y4u3l9yl': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'kw39ccow': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    '3kjfrgqw': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'f76gnavv': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'k1jg7nle': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    '4gvm1zse': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'tiygw2nj': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    '7dljogm6': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    's3v9gzs8': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'vwri7ojf': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'ofmb8xwi': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    '08uidtcv': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'gpsg454i': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    '9jnzf9rp': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'jwzozuza': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    '9rrxuxys': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'da10qil4': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'a4s50y0i': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
    'geoqsrif': {
      'th': '',
      'en': '',
      'zh_Hans': '',
    },
  },
].reduce((a, b) => a..addAll(b));
