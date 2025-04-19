import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/cart.dart';

class CartState {
  final Cart cart;
  final bool isLoading;
  final bool isError;

  const CartState({
    required this.cart,
    this.isLoading = false,
    this.isError = false,
  });

  factory CartState.initial() => CartState(cart: Cart.empty());

  CartState copyWith({Cart? cart, bool? isLoading, bool? isError}) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState.initial());

  Future<void> fetchCart() async {
    if (state.isLoading || state.cart.products!.isNotEmpty) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final cart = await api.fetchCart();
      state = state.copyWith(cart: cart, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false, isError: true);
    }
  }

  Future<void> refresh() async {
    state = CartState.initial();
    await fetchCart();
  }

  Future<void> addProductToCart({
    required String productId,
    required int variantIndex,
    required int quantity,
  }) async {
    state = state.copyWith(isLoading: true, isError: false);
    final result = await api.addProductToCart(
        productId: productId, variantIndex: variantIndex, quantity: quantity);
  }
}
