import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../data/config/app_config.dart';
import '../data/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  bool _isLoading = false;
  bool _isError = false;

  List<Product> get products => _products;

  final searchTF = TextEditingController();

  List<Product> get filteredGroups => _filteredProducts.isEmpty
      ? searchTF.text.isEmpty
          ? _products
          : []
      : _filteredProducts;

  bool get isLoading => _isLoading;

  bool get isError => _isError;

  Future<void> fetchProduct() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await api.fetchProduct();
    } catch (_) {
      _products = [];
      _isError = true;
    }

    _isLoading = false;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void searchProduct() {
    if (searchTF.text.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products.where((e) => e.name.toLowerCase().trim().contains(searchTF.text.toLowerCase().trim())).toList();
    }
    notifyListeners();
  }

  Future<void> notifier() async {
    _products = await api.fetchProduct();
    notifyListeners();
  }
}
