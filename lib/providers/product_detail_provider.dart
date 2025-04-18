import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/config/app_config.dart';
import '../data/model/product.dart';

class ProductDetailState {
  final Product product;
  final bool isLoading;
  final bool isError;

  ProductDetailState({
    required this.product,
    this.isLoading = false,
    this.isError = false,
  });

  List<String> get images =>
      product.variants?.expand((v) => v.images ?? []).cast<String>().toList() ?? [];

  List<String> get ram =>
      product.variants?.map((e) => e.ram).whereType<String>().toSet().toList() ?? [];

  List<String> get rom =>
      product.variants?.map((e) => e.rom).whereType<String>().toSet().toList() ?? [];

  List<String> get color =>
      product.variants?.map((e) => e.color).whereType<String>().toSet().toList() ?? [];
}

class ProductDetailNotifier extends StateNotifier<ProductDetailState> {
  ProductDetailNotifier() : super(ProductDetailState(product: Product.empty()));

  Future<void> fetchProduct(String id) async {
    state = ProductDetailState(product: Product.empty(), isLoading: true);
    try {
      final result = await api.fetchProductDetail(id: id);
      state = ProductDetailState(product: result);
    } catch (_) {
      state = ProductDetailState(product: Product.empty(), isError: true);
    }
  }
}

final productDetailProvider = StateNotifierProvider.autoDispose
    .family<ProductDetailNotifier, ProductDetailState, String>((ref, id) {
  final notifier = ProductDetailNotifier();
  notifier.fetchProduct(id);
  return notifier;
});
