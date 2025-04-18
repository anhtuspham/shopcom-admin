import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../utils/color_value_key.dart';

class SearchProduct extends ConsumerStatefulWidget {
  // final ProductProvider productProvider;
  const SearchProduct({super.key});

  @override
  ConsumerState<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends ConsumerState<SearchProduct> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // final productProvider = ProductProvider();
    final notifier = ref.watch(productProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 8),
      child: TextField(
        style: TextStyle(color: ColorValueKey.textColor),
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[300]),
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: ColorValueKey.textColor,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.close,
            ),
            color: ColorValueKey.textColor,
            onPressed: () {
              _searchController.clear();
              notifier.search('');
            },
          ),
        ),
        onChanged: (value) {
          notifier.search(value);
        },
      ),
    );
  }
}
