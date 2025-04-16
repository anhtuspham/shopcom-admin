import 'package:flutter/material.dart';
import '../data/config/app_config.dart';
import '../data/model/product.dart';

class ProductProvider with ChangeNotifier {
  static ProductProvider? _instance;
  static ProductProvider get instance {
    _instance ??= ProductProvider._internal();
    return _instance!;
  }

  ProductProvider._internal();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  final searchTF = TextEditingController();
  bool _isLoading = false;
  bool _isError = false;

  List<Product> get products => _products;
  List<Product> get filteredProducts =>
      _filteredProducts.isEmpty ? _products : _filteredProducts;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  Future<void> fetchProduct() async {
    if (_isLoading || _products.isNotEmpty) return;
    _isLoading = true;
    _isError = false;
    notifyListeners();

    try {
      _products = await api.fetchProduct();
      _filteredProducts = _products;
    } catch (_) {
      _products = [];
      _isError = true;
    }

    _isLoading = false;
    notifyListeners();
  }


  void searchProduct() {
    final query = searchTF.text.toLowerCase().trim();
    _filteredProducts = query.isEmpty
        ? _products
        : _products
        .where((e) => e.name.toLowerCase().contains(query))
        .toList();
    notifyListeners();
  }

  Future<void> notifier() async {
    await fetchProduct();
  }
}
