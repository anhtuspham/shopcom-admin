import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/order.dart';

class OrderState {
  final List<Order>? orders;
  final bool isLoading;
  final bool isError;

  const OrderState({
    this.orders,
    this.isLoading = false,
    this.isError = false,
  });

  factory OrderState.initial() => const OrderState();
  OrderState copyWith({List<Order>? orders, bool? isLoading, bool? isError}) {
    return OrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState.initial());

  Future<void> fetchOrder() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final orders = await api.fetchOrder();
      state = state.copyWith(orders: orders, isLoading: false, isError: false);
    } catch (_) {
      state = state.copyWith(isLoading: false, isError: true);
    }
  }

  Future<void> refresh() async {
    state = OrderState.initial();
    await fetchOrder();
  }

  Future<void> createOrder({
    required String productId,
    required int variantIndex,
    required int quantity,
  }) async {
    state = state.copyWith(isLoading: true, isError: false);
    final result = await api.createOrder();
    if (result.isValue) {
      await fetchOrder();
    } else {
      state = state.copyWith(isLoading: false, isError: true);
    }
  }

}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  final notifier = OrderNotifier();
  notifier.fetchOrder();
  return notifier;
});
