import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'mock_search_data.dart';
import '../../../../core/routing/serialization_util.dart';
import '../../venue_detail/presentation/in_venuse/in_venuse_page.dart';
import 'package:ff_commons/flutter_flow/flutter_flow_util.dart';

class SearchListItem extends StatelessWidget {
  final SearchResultItem item;
  final VoidCallback? onTap;

  const SearchListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      onTap: () {
        if (item.venueRef != null &&
            (item.type == SearchItemType.event ||
                item.type == SearchItemType.venue)) {
          context.pushNamed(
            InVenusePage.routeName,
            queryParameters: {
              'idVenues': serializeParam(
                item.venueRef,
                ParamType.SupabaseDocRef,
              ),
            }.withoutNulls,
          );
        } else if (onTap != null) {
          onTap!();
        }
      },
      leading: _buildLeading(),
      title: Text(
        item.title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: item.subtitle.isNotEmpty
          ? Text(
              item.subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            )
          : null,
      trailing: _buildTrailing(),
    );
  }

  Widget _buildLeading() {
    if (item.type == SearchItemType.category) {
      return CircleAvatar(
        backgroundColor: Colors.grey[900],
        radius: 28,
        child: const Icon(Icons.local_offer_outlined, color: Colors.white),
      );
    }

    final bool isEvent = item.type == SearchItemType.event;
    final imageWidget = item.imageUrl != null
        ? Image.network(item.imageUrl!, fit: BoxFit.cover)
        : Container(color: Colors.grey[800]);

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: isEvent ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isEvent ? BorderRadius.circular(8.0) : null,
      ),
      clipBehavior: Clip.hardEdge,
      child: imageWidget,
    );
  }

  Widget? _buildTrailing() {
    if (item.type == SearchItemType.category) return null;

    if (item.type == SearchItemType.artist ||
        item.type == SearchItemType.venue) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          minimumSize: const Size(0, 32),
        ),
        child: const Text(
          'FOLLOW',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      );
    } else {
      return IconButton(
        icon: Icon(
          item.isSaved ? Icons.bookmark : Icons.bookmark_border,
          color: Colors.white,
        ),
        onPressed: () {},
      );
    }
  }
}
