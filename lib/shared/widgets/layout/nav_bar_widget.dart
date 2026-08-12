import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:munday/core/state/app_state.dart';

import '/features/booking/presentation/ticket/ticket_page.dart';
import '/features/discovery/presentation/events/events_page.dart';
import '/features/discovery/presentation/venues/venues_page.dart';
import '/features/social/presentation/main_chat/main_chat_page.dart';

export 'nav_bar_model.dart';

String? _navIconAsset(String menuItem) {
  switch (menuItem) {
    case 'Events':
      return 'assets/images/nav_events.png';
    case 'Venues':
      return 'assets/images/nav_venues.png';
    case 'Chat':
      return 'assets/images/icon_message.png';
    case 'Booking':
      return 'assets/images/icon_ticket.png';
    default:
      return null;
  }
}

String _fallbackIcon(String menuItem) {
  switch (menuItem) {
    case 'Events':
      return 'ticket.fill';
    case 'Venues':
      return 'building.2.fill';
    case 'Chat':
      return 'message.fill';
    case 'Booking':
      return 'ticket.fill';
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
  if (menuItem == 'Events') {
    context.goNamed(EventsPage.routeName);
  } else if (menuItem == 'Venues') {
    context.goNamed(VenuesPage.routeName);
  } else if (menuItem == 'Chat') {
    context.goNamed(MainChatPage.routeName);
  } else if (menuItem == 'Booking') {
    context.goNamed(TicketPage.routeName);
  }

  context.appState.menuActiveitem = menuItem;
}

AdaptiveBottomNavigationBar buildAdaptiveNavBar(BuildContext context) {
  final menuItems = context.appState.menuItems;
  final currentPath = GoRouterState.of(context).uri.toString();
  final activeItem = switch (currentPath) {
    final path when path.startsWith('/events') => 'Events',
    final path when path.startsWith('/venues') => 'Venues',
    final path when path.startsWith('/mainChat') => 'Chat',
    final path when path.startsWith('/ticket') || path.startsWith('/booking') =>
      'Booking',
    _ => context.appState.menuActiveitem,
  };
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

  final isSearchActive = currentPath.startsWith('/search');

  // Keep search as the separated native iOS search destination.
  destinations.add(
    const AdaptiveNavigationDestination(
      isSearch: true, // Native iOS 26+ search layout
      icon: AssetImage('assets/images/icon_search.png'),
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
    selectedItemColor: const Color(0xFFFF1E1E),
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
