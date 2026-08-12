import 'package:go_router/go_router.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' hide Provider, ChangeNotifierProvider;
import 'package:munday/core/routing/serialization_util.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';
import '/auth/supabase_auth/auth_util.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/core/utils/app_util.dart';

import '/index.dart';
import '/features/auth/presentation/welcome/welcome_new_account_page.dart';
import '/features/search/presentation/search_page.dart';
import 'package:munday/shared/widgets/layout/nav_bar_widget.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:munday/core/state/app_state.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

GoRouter? _router;
GoRouter get appRouter => _router ??= createRouter(AppStateNotifier.instance);

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading {
    final result = showSplashImage;
    debugPrint(
      'AppStateNotifier.loading called -> $result (user: ${user?.uid}, showSplashImage: $showSplashImage)',
    );
    return result;
  }

  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    debugPrint('AppStateNotifier: stopShowingSplashImage executed');
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: appStateNotifier,
    navigatorKey: appNavigatorKey,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Router Error: ${state.error}'))),
    redirect: (context, state) {
      if (appStateNotifier.loading) return null;

      final loggedIn = appStateNotifier.loggedIn;
      final uri = state.uri.toString();
      final isAuthPage = uri == '/phone-login' || uri.startsWith('/otp-verify');

      if (!loggedIn && !isAuthPage) {
        return '/phone-login';
      }

      // Redirect users who have not completed onboarding yet.
      final isWelcomePage = uri == '/welcome-new-account';
      final needsOnboarding = currentUserNeedsOnboarding;
      if (loggedIn && needsOnboarding && !isWelcomePage && !isAuthPage) {
        return '/welcome-new-account';
      }

      return null;
    },
    routes: [
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          final isMapModeOn = context.watchAppState.mapModeOn;
          final uri = state.uri.toString();
          final showNav =
              (!isMapModeOn) &&
              (uri == '/' ||
                  uri.startsWith('/main') ||
                  uri.startsWith('/events') ||
                  uri.startsWith('/venues') ||
                  uri.startsWith('/ticket') ||
                  uri.startsWith('/search'));

          if (!showNav) return child;

          return AdaptiveScaffold(
            minimizeBehavior: TabBarMinimizeBehavior.never,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: buildAdaptiveNavBar(context),
            body: child,
          );
        },
        routes: [
          MundayRoute(
            name: '_initialize',
            path: '/',
            builder: (context, _) => MainPage(),
            routes: [
              MundayRoute(
                name: MainChatPage.routeName,
                path: MainChatPage.routePath,
                requireAuth: true,
                builder: (context, params) => MainChatPage(),
              ),
              MundayRoute(
                name: ChatsPage.routeName,
                path: ChatsPage.routePath,
                requireAuth: true,
                builder: (context, params) => ChatsPage(
                  userProfile: params.getParam('userProfile', ParamType.String),
                  roomref: params.getParam(
                    'roomref',
                    ParamType.SupabaseDocRef,
                    isList: false,
                    collectionNamePath: ['chat_rooms'],
                  ),
                  name: params.getParam('name', ParamType.String),
                  online: params.getParam('online', ParamType.bool),
                  openchat: params.getParam('openchat', ParamType.bool),
                ),
              ),
              MundayRoute(
                name: ProfilePage.routeName,
                path: ProfilePage.routePath,
                requireAuth: true,
                builder: (context, params) => ProfilePage(
                  fromSeting: params.getParam('fromSeting', ParamType.bool),
                ),
              ),
              MundayRoute(
                name: PhoneLoginPage.routeName,
                path: PhoneLoginPage.routePath,
                builder: (context, params) => const PhoneLoginPage(),
              ),
              MundayRoute(
                name: OtpVerifyPage.routeName,
                path: OtpVerifyPage.routePath,
                builder: (context, params) => OtpVerifyPage(
                  phone: params.getParam('phone', ParamType.String) ?? '',
                  loginType:
                      params.getParam('loginType', ParamType.String) ?? 'user',
                  isTestPhone:
                      params.getParam('isTestPhone', ParamType.bool) ?? false,
                ),
              ),
              MundayRoute(
                name: WelcomeNewAccountPage.routeName,
                path: WelcomeNewAccountPage.routePath,
                builder: (context, params) => const WelcomeNewAccountPage(),
              ),
              MundayRoute(
                name: SocialInVenusePage.routeName,
                path: SocialInVenusePage.routePath,
                requireAuth: true,
                builder: (context, params) => SocialInVenusePage(),
              ),
              MundayRoute(
                name: AccountSettingsPage.routeName,
                path: AccountSettingsPage.routePath,
                requireAuth: true,
                builder: (context, params) => const AccountSettingsPage(),
              ),
              MundayRoute(
                name: 'Profile06',
                path: 'profile06',
                requireAuth: true,
                builder: (context, params) => const AccountSettingsPage(),
              ),
              MundayRoute(
                name: PrivacyPolicyPage.routeName,
                path: PrivacyPolicyPage.routePath,
                requireAuth: true,
                builder: (context, params) => PrivacyPolicyPage(),
              ),
              MundayRoute(
                name: SupportPage.routeName,
                path: SupportPage.routePath,
                requireAuth: true,
                builder: (context, params) => SupportPage(),
              ),
              MundayRoute(
                name: BlocklistPage.routeName,
                path: BlocklistPage.routePath,
                requireAuth: true,
                builder: (context, params) => BlocklistPage(),
              ),
              MundayRoute(
                name: MainPage.routeName,
                path: MainPage.routePath,
                requireAuth: false,
                builder: (context, params) => MainPage(),
              ),
              MundayRoute(
                name: EventsPage.routeName,
                path: EventsPage.routePath,
                requireAuth: false,
                builder: (context, params) => EventsPage(),
              ),
              MundayRoute(
                name: VenuesPage.routeName,
                path: VenuesPage.routePath,
                requireAuth: false,
                builder: (context, params) => VenuesPage(),
              ),
              MundayRoute(
                name: PromotionPage.routeName,
                path: PromotionPage.routePath,
                requireAuth: false,
                builder: (context, params) => PromotionPage(),
              ),
              MundayRoute(
                name: InVenusePage.routeName,
                path: InVenusePage.routePath,
                requireAuth: false,
                builder: (context, params) => InVenusePage(
                  idVenues: params.getParam(
                    'idVenues',
                    ParamType.SupabaseDocRef,
                    isList: false,
                    collectionNamePath: ['venues'],
                  ),
                  distance: params.getParam('distance', ParamType.String),
                  dateclick: params.getParam('dateclick', ParamType.DateTime),
                  index: params.getParam('index', ParamType.int),
                ),
              ),
              MundayRoute(
                name: VeerPage.routeName,
                path: VeerPage.routePath,
                requireAuth: true,
                builder: (context, params) => VeerPage(),
              ),
              MundayRoute(
                name: TicketPage.routeName,
                path: TicketPage.routePath,
                requireAuth: true,
                // TODO: swap back to TicketWidget() when backend is ready
                builder: (context, params) => const TicketMockPage(),
              ),
              MundayRoute(
                name: BookingPage.routeName,
                path: BookingPage.routePath,
                requireAuth: true,
                builder: (context, params) => BookingPage(
                  id: params.getParam(
                    'id',
                    ParamType.SupabaseDocRef,
                    isList: false,
                    collectionNamePath: ['venues'],
                  ),
                  location: params.getParam('location', ParamType.LatLng),
                  date: params.getParam('date', ParamType.DateTime),
                  currentuid: params.getParam('currentuid', ParamType.String),
                  floorId: params.getParam('floorId', ParamType.String),
                ),
              ),
              MundayRoute(
                name: ShowallphotoPage.routeName,
                path: ShowallphotoPage.routePath,
                requireAuth: false,
                builder: (context, params) => ShowallphotoPage(
                  dataphoto: params.getParam<String>(
                    'dataphoto',
                    ParamType.String,
                    isList: true,
                  ),
                ),
              ),
              MundayRoute(
                name: SharePage.routeName,
                path: SharePage.routePath,
                requireAuth: true,
                builder: (context, params) => SharePage(
                  idVenues: params.getParam(
                    'idVenues',
                    ParamType.SupabaseDocRef,
                    isList: false,
                    collectionNamePath: ['venues'],
                  ),
                  distance: params.getParam('distance', ParamType.String),
                  dateclick: params.getParam('dateclick', ParamType.DateTime),
                  index: params.getParam('index', ParamType.int),
                ),
              ),
              MundayRoute(
                name: PayreservenormdayPage.routeName,
                path: PayreservenormdayPage.routePath,
                requireAuth: true,
                builder: (context, params) => PayreservenormdayPage(
                  venueId: params.getParam('venueId', ParamType.String),
                  date: params.getParam('date', ParamType.DateTime),
                  tableIds:
                      params.getParam<String>(
                        'tableIds',
                        ParamType.String,
                        isList: true,
                      ) ??
                      const [],
                  amount: params.getParam('amount', ParamType.double),
                  partySize: params.getParam('partySize', ParamType.int),
                ),
              ),
              MundayRoute(
                name: NotificationPage.routeName,
                path: NotificationPage.routePath,
                requireAuth: true,
                builder: (context, params) => const NotificationPage(),
              ),
              MundayRoute(
                name: SearchPage.routeName,
                path: SearchPage.routePath,
                requireAuth: false,
                builder: (context, params) => const SearchPage(),
              ),
            ].map((r) => r.toRoute(appStateNotifier)).toList(),
          ).toRoute(appStateNotifier),
        ], // Closes routes array for ShellRoute
      ), // Closes ShellRoute
    ], // Closes routes array for GoRouter
    observers: [routeObserver],
  );
}

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
    entries.where((e) => e.value != null).map((e) => MapEntry(e.key, e.value!)),
  );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) => !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
      ? null
      : goNamed(
          name,
          pathParameters: {},
          queryParameters: queryParameters,
          extra: extra,
        );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) => !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
      ? null
      : pushNamed(
          name,
          pathParameters: {},
          queryParameters: queryParameters,
          extra: extra,
        );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
      ? null
      : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra is Map ? Map<String, dynamic>.from(extra as Map) : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class MundayParameters {
  MundayParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
    state.allParams.entries.where(isAsyncParam).map((param) async {
      final doc = await asyncParams[param.key]!(
        param.value,
      ).onError((_, __) => null);
      if (doc != null) {
        futureParamValues[param.key] = doc;
        return true;
      }
      return false;
    }),
  ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class MundayRoute {
  const MundayRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, MundayParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
    name: name,
    path: path,
    redirect: (context, state) {
      if (appStateNotifier.shouldRedirect) {
        final redirectLocation = appStateNotifier.getRedirectLocation();
        appStateNotifier.clearRedirectLocation();
        return redirectLocation;
      }

      if (requireAuth && !appStateNotifier.loggedIn) {
        appStateNotifier.setRedirectLocationIfUnset(Uri().toString());
        return '/phone-login';
      }
      return null;
    },
    pageBuilder: (context, state) {
      fixStatusBarOniOS16AndBelow(context);
      final ffParams = MundayParameters(state, asyncParams);
      final page = ffParams.hasFutures
          ? FutureBuilder(
              future: ffParams.completeFutures(),
              builder: (context, _) => builder(context, ffParams),
            )
          : builder(context, ffParams);
      final child = AnimatedBuilder(
        animation: appStateNotifier,
        builder: (context, _) => appStateNotifier.loading
            ? Container(
                color: Colors.black,
                child: Center(
                  child: Image.asset(
                    'assets/images/Munday-logo.png',
                    width: 250.0,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : PushNotificationsHandler(child: page),
      );

      final transitionInfo = state.transitionInfo;
      return transitionInfo.hasTransition
          ? CustomTransitionPage(
              key: state.pageKey,
              child: child,
              transitionDuration: transitionInfo.duration,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      PageTransition(
                        type: transitionInfo.transitionType,
                        duration: transitionInfo.duration,
                        reverseDuration: transitionInfo.duration,
                        alignment: transitionInfo.alignment,
                        child: child,
                      ).buildTransitions(
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ),
            )
          : MaterialPage(key: state.pageKey, child: child);
    },
    routes: routes,
  );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(
    hasTransition: true,
    transitionType: PageTransitionType.fade,
    duration: Duration(milliseconds: 300),
  );
}

class RootPageContext extends InheritedWidget {
  const RootPageContext({
    super.key,
    this.isRootPage = false,
    this.errorRoute,
    required super.child,
  });

  final bool isRootPage;
  final String? errorRoute;

  static RootPageContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RootPageContext>();
  }

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = RootPageContext.of(context);
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) =>
      RootPageContext(isRootPage: true, errorRoute: errorRoute, child: child);

  @override
  bool updateShouldNotify(RootPageContext oldWidget) {
    return isRootPage != oldWidget.isRootPage ||
        errorRoute != oldWidget.errorRoute;
  }
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
