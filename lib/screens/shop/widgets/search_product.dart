import 'package:flutter/material.dart';

import '../../../providers/product_provider.dart';
import '../../../utils/color_value_key.dart';

class SearchProduct extends StatelessWidget {
  final ProductProvider productProvider;

  const SearchProduct({super.key, required this.productProvider});

  @override
  Widget build(BuildContext context) {
    // final productProvider = ProductProvider();
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 8),
      child: TextField(
        style: TextStyle(color: ColorValueKey.textColor),
        controller: productProvider.searchTF,
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
              productProvider.searchTF.clear();
              productProvider.searchProduct();
            },
          ),
        ),
        onChanged: (value) {
          productProvider.searchProduct();
        },
      ),
    );
  }
}
