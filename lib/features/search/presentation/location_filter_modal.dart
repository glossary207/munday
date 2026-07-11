import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_state.dart';

void showLocationFilterModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black,
    builder: (dialogContext) => ChangeNotifierProvider.value(
      value: context.read<SearchState>(),
      child: const _LocationFilterModal(),
    ),
  );
}

class _LocationFilterModal extends StatelessWidget {
  const _LocationFilterModal();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search location...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[900],
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildLocationItem(context, 'Bangkok', 'Thailand'),
                _buildLocationItem(context, 'London', 'United Kingdom'),
                _buildLocationItem(context, 'New York', 'USA'),
                _buildLocationItem(context, 'Tokyo', 'Japan'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItem(BuildContext context, String city, String country) {
    return ListTile(
      title: Text(
        city,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: Text(
        country,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
      onTap: () {
        context.read<SearchState>().updateSelectedLocation(city);
        Navigator.pop(context);
      },
    );
  }
}
