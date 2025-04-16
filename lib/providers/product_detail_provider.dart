import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../data/config/app_config.dart';
import '../data/model/product.dart';

class ProductDetailProvider with ChangeNotifier {
  Product _product = Product.empty();

  bool _isLoading = false;
  bool _isError = false;

  Product get product => _product;
  List<String> get images {
    final variants = product.variants;
    if (variants == null) return [];
    return variants.expand((v) => v.images ?? []).cast<String>().toList();
  }

  List<String> get ram {
    final variants = product.variants;
    if(variants == null) return [];
    return variants.map((e) => e.ram ?? '').toSet().toList();
  }

  List<String> get rom {
    final variants = product.variants;
    if(variants == null) return [];
    return variants.map((e) => e.rom ?? '').toSet().toList();
  }

  List<String> get color {
    final variants = product.variants;
    if(variants == null) return [];
    return variants.map((e) => e.color ?? '').toSet().toList();
  }

  bool get isLoading => _isLoading;
  bool get isError => _isError;

  String id = '';

  Future<void> fetchProductDetail() async{
    _isLoading = true;
    notifyListeners();
    try{
      _product = await api.fetchProductDetail(id: id);
    } catch(_){
      _product = Product.empty();
      _isError = true;
    }
    _isLoading = false;
    if(hasListeners){
      notifyListeners();
    }
  }

  Future<void> notifier() async {
    _product = await api.fetchProductDetail(id: id);
    notifyListeners();
  }
}
