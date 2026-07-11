import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:munday/core/state/app_state.dart';

import '/features/discovery/presentation/events/events_page.dart';
import '/features/discovery/presentation/main/main_page.dart';
import '/features/discovery/presentation/promotion/promotion_page.dart';
import '/features/discovery/presentation/venues/venues_page.dart';

class CustomNavBar extends StatelessWidget {
  final BuildContext context;
  const CustomNavBar(this.context, {super.key});

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

  void _handleMenuTap(String menuItem) {
    if (menuItem == context.appState.menuActiveitem) return;

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

  @override
  Widget build(BuildContext context) {
    final menuItems = context.appState.menuItems;
    final activeItem = context.appState.menuActiveitem;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final item in menuItems)
                  GestureDetector(
                    onTap: () => _handleMenuTap(item),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_navIconAsset(item) != null)
                            Image.asset(
                              _navIconAsset(item)!,
                              width: 24,
                              height: 24,
                              color: Colors.white,
                            )
                          else
                            const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 24,
                            ),
                          const SizedBox(height: 4),
                          Text(
                            item,
                            style: TextStyle(
                              color: activeItem == item
                                  ? Colors.red
                                  : Colors.white,
                              fontSize: 10,
                              fontWeight: activeItem == item
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                // Search button
                GestureDetector(
                  onTap: () {
                    // Handle search tap
                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ Gemini_Generated_Image_9r9y1j9r9y1j9r9y ขนาดใหญ่.png',
                          width: 32,
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
