import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:munday/core/state/app_state.dart';

import '/features/discovery/presentation/events/events_page.dart';
import '/features/discovery/presentation/main/main_page.dart';
import '/features/discovery/presentation/promotion/promotion_page.dart';
import '/features/discovery/presentation/venues/venues_page.dart';

export 'nav_bar_model.dart';

String? _navIconAsset(String menuItem) {
  switch (menuItem) {
    case 'Home':
      return 'assets/images/nav_home.png';
    case 'Events':
      return 'assets/images/nav_events.png';
    case 'Venues':
      return 'assets/images/nav_venues.png';
    case 'Promotion':
      return 'assets/images/nav_promotion.png';
    default:
      return null;
  }
}

String _fallbackIcon(String menuItem) {
  switch (menuItem) {
    case 'Home':
      return 'house.fill';
    case 'Events':
      return 'ticket.fill';
    case 'Venues':
      return 'building.2.fill';
    case 'Promotion':
      return 'tag.fill';
    default:
      return 'circle.fill';
  }
}

dynamic _buildNavIcon(String menuItem) {
  final assetPath = _navIconAsset(menuItem);
  if (assetPath == null) {
    return _fallbackIcon(menuItem);
  }
  return AssetImage(assetPath);
}

void _handleMenuTap(BuildContext context, String menuItem) {
  if (menuItem == context.appState.menuActiveitem) {
    return;
  }

  if (menuItem == 'Events') {
    context.goNamed(EventsPage.routeName);
  } else if (menuItem == 'Venues') {
    context.goNamed(VenuesPage.routeName);
  } else if (menuItem == 'Promotion') {
    context.goNamed(PromotionPage.routeName);
  } else if (menuItem == 'Home') {
    context.goNamed(MainPage.routeName);
  }

  context.appState.menuActiveitem = menuItem;
}

AdaptiveBottomNavigationBar buildAdaptiveNavBar(BuildContext context) {
  final menuItems = context.appState.menuItems;
  final activeItem = context.appState.menuActiveitem;
  final activeIndex = menuItems.indexOf(activeItem);

  final destinations = <AdaptiveNavigationDestination>[];

  for (int i = 0; i < menuItems.length; i++) {
    final item = menuItems[i];
    destinations.add(
      AdaptiveNavigationDestination(
        icon: _buildNavIcon(item),
        label: item,
        // Spacer after the last standard menu item ensures the search button gets pushed
        addSpacerAfter: i == menuItems.length - 1,
      ),
    );
  }

  final currentPath = GoRouterState.of(context).uri.toString();
  final isSearchActive = currentPath.startsWith('/search');

  // Add the custom AI Search button
  destinations.add(
    AdaptiveNavigationDestination(
      isSearch: true, // Native iOS 26+ search layout
      icon: Image.asset(
        'assets/images/ Gemini_Generated_Image_9r9y1j9r9y1j9r9y ขนาดใหญ่.png',
        color: isSearchActive
            ? const Color(0xFFFF0000)
            : const Color(0xFFFFFFFF),
        width: 24,
        height: 24,
      ),
      label: 'Search',
    ),
  );

  int finalSelectedIndex = activeIndex >= 0 ? activeIndex : 0;
  if (isSearchActive) {
    finalSelectedIndex = menuItems.length;
  }

  return AdaptiveBottomNavigationBar(
    useNativeBottomBar: true,
    items: destinations,
    selectedIndex: finalSelectedIndex,
    selectedItemColor: const Color(0xFFFF0000), // Red when selected
    unselectedItemColor: const Color(0xFFFFFFFF), // White when unselected
    onTap: (index) {
      if (index < menuItems.length) {
        _handleMenuTap(context, menuItems[index]);
      } else {
        context.goNamed('Search');
      }
    },
  );
}
