// product_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/config/app_config.dart';
import '../data/model/product.dart';

class ProductState {
  final List<Product> products;
  final List<Product> filtered;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  ProductState(
      {this.products = const [],
      this.filtered = const [],
      this.isLoading = false,
      this.isError = false,
      this.errorMessage});

  ProductState copyWith(
      {List<Product>? products,
      List<Product>? filtered,
      bool? isLoading,
      bool? isError,
      String? errorMessage}) {
    return ProductState(
        products: products ?? this.products,
        filtered: filtered ?? this.filtered,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(ProductState());

  String _currentSort = 'newest';

  Future<void> fetchProduct({String? sort, String? page, String? limit}) async {
    final sortParams = sort ?? _currentSort;
    _currentSort = sortParams;

    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      await _updateProductsState(sortBy: sortParams, page: page, limit: limit);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
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
    state = state.copyWith(isLoading: true, isError: false, errorMessage: null);
    await _updateProductsState();
  }

  Future<void> _updateProductsState(
      {String? sortBy, String? page, String? limit}) async {
    try {
      final products =
          await api.fetchProduct(sortBy: sortBy, page: page, limit: limit);

      state = state.copyWith(
          products: products,
          filtered: products,
          isLoading: false,
          isError: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final productProvider =
    StateNotifierProvider.autoDispose<ProductNotifier, ProductState>((ref) {
  final notifier = ProductNotifier();
  notifier.fetchProduct();
  return notifier;
});
