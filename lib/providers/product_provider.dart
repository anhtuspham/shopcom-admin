// product_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/config/app_config.dart';
import '../data/model/product.dart';

class ProductState {
  final List<Product> products;
  final List<Product> filtered;
  final bool isLoading;
  final bool isError;

  ProductState({
    this.products = const [],
    this.filtered = const [],
    this.isLoading = false,
    this.isError = false,
  });

  ProductState copyWith({
    List<Product>? products,
    List<Product>? filtered,
    bool? isLoading,
    bool? isError,
  }) {
    return ProductState(
      products: products ?? this.products,
      filtered: filtered ?? this.filtered,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(ProductState());

  Future<void> fetchProduct() async {
    if (state.isLoading || state.products.isNotEmpty) return;
    state = state.copyWith(isLoading: true, isError: false);

    try {
      final products = await api.fetchProduct();
      state = state.copyWith(
        products: products,
        filtered: products,
        isLoading: false,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false, isError: true);
    }
  }

  void search(String query) {
    final filtered = query.isEmpty
        ? state.products
        : state.products
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    state = state.copyWith(filtered: filtered);
  }

  Future<void> refresh() async {
    state = ProductState();
    await fetchProduct();
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final notifier = ProductNotifier();
  print('fetchProduct');
  notifier.fetchProduct();
  return notifier;
});
