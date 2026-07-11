import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  final Widget child;
  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/mainChat') || location.startsWith('/chats')) {
      return 0; // Home is index 0
    }
    if (location.startsWith('/events')) return 1;
    if (location.startsWith('/venues')) return 3;
    if (location.startsWith('/promotion')) return 4;
    return 0; // Default to home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed('mainChat');
        break;
      case 1:
        context.goNamed('events');
        break;
      case 2:
        // Center button is likely search or add, handled elsewhere or ignored
        break;
      case 3:
        context.goNamed('venues');
        break;
      case 4:
        context.goNamed('promotion');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: widget.child,
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        selectedItemColor: Colors.red, // Makes the active label RED
        unselectedItemColor: Colors.grey, // Makes the inactive label GREY
        useNativeBottomBar: false, // Use standard CupertinoTabBar/NavigationBar
        items: [
          AdaptiveNavigationDestination(
            icon: Image.network(
              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/2nj8yl2yaelb/21.png',
              width: 24,
              height: 24,
            ),
            label: 'Home',
          ),
          AdaptiveNavigationDestination(
            icon: Image.network(
              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/dutfa1nii34m/20.png',
              width: 24,
              height: 24,
            ),
            label: 'Events',
          ),
          AdaptiveNavigationDestination(
            icon: Image.asset(
              'assets/images/search_ai_icon.png',
              width: 48,
              height: 48,
            ),
            label: '',
          ),
          AdaptiveNavigationDestination(
            icon: Image.network(
              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/lgesbg9egut8/toast.png',
              width: 24,
              height: 24,
            ),
            label: 'Venues',
          ),
          AdaptiveNavigationDestination(
            icon: Image.network(
              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/biv861aii9ne/promotions.png',
              width: 24,
              height: 24,
            ),
            label: 'Promotion',
          ),
        ],
      ),
    );
  }
}
