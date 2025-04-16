import 'package:flutter/material.dart';
import '../data/config/app_config.dart';
import '../data/model/product.dart';

class ProductDetailProvider with ChangeNotifier {
  static final ProductDetailProvider _instance = ProductDetailProvider._internal();
  static ProductDetailProvider get instance => _instance;

  ProductDetailProvider._internal();

  Product _product = Product.empty();
  bool _isLoading = false;
  bool _isError = false;
  String id = '';

  Product get product => _product;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  List<String> get images => product.variants?.expand((v) => v.images ?? []).cast<String>().toList() ?? [];
  List<String> get ram => product.variants?.map((e) => e.ram ?? '').toSet().toList() ?? [];
  List<String> get rom => product.variants?.map((e) => e.rom ?? '').toSet().toList() ?? [];
  List<String> get color => product.variants?.map((e) => e.color ?? '').toSet().toList() ?? [];

  Future<void> fetchProductDetail() async {
    if (id.isEmpty) return;
    _isLoading = true;
    _isError = false;
    notifyListeners();
    try {
      _product = await api.fetchProductDetail(id: id);
    } catch (_) {
      _product = Product.empty();
      _isError = true;
    }
    _isLoading = false;
    if (hasListeners) notifyListeners();
  }

  void setProductId(String newId) {
    id = newId;
    fetchProductDetail();
  }
}
