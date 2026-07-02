import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:munday/integrations/supabase_service.dart';
import 'core/routing/app_router.dart';

import '/core/utils/app_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/supabase_auth/supabase_user_provider.dart';
import 'auth/supabase_auth/auth_util.dart';
import 'backend/backend.dart';
import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/supabase/supabase_config.dart';
import 'core/utils/locale_util.dart';
import 'package:munday/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/state/app_state.dart';
import 'core/theme/app_theme.dart';

import 'package:provider/provider.dart';

late SharedPreferences sharedPrefs;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  await SupabaseService().initialize();
  runApp(
    ProviderScope(
      child: ChangeNotifierProvider(
        create: (context) => AppState(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  // This widget is the root of your application.
  @override
  ConsumerState<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends ConsumerState<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = AppTheme.themeMode;

  late AppStateNotifier _appStateNotifier;

  

  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});

  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  String getRoute([RouteMatchBase? routeMatch]) {
    final configuration = appRouter.routerDelegate.currentConfiguration;
    if (configuration == null) return '';
    final RouteMatchBase lastMatch = routeMatch ?? configuration.last;
    final RouteMatchList matchList =
        lastMatch is ImperativeRouteMatch ? lastMatch.matches : configuration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() {
    final configuration = appRouter.routerDelegate.currentConfiguration;
    if (configuration == null) return [];
    return configuration.matches.map((e) => getRoute(e)).toList();
  }

  Future<void> _bootstrapPersistedSession(User? persistedUser) async {
    if (persistedUser != null) {
      try {
        await maybeCreateUser(persistedUser).timeout(const Duration(seconds: 5));
      } catch (_) {}
    }
    if (!mounted) {
      return;
    }
    _appStateNotifier.stopShowingSplashImage();
  }

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    final persistedUser = Supabase.instance.client.auth.currentUser;
    _appStateNotifier.update(MundaySupabaseUser(persistedUser));
    
    
    _bootstrapPersistedSession(persistedUser);
    userStream = mundaySupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) {
    return safeSetState(() {
      _themeMode = mode;
      AppTheme.saveThemeMode(mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = appRouter;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Munday',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('th')],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      routerConfig: router,
    );
  }
}
