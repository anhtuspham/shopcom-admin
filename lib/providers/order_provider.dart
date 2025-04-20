import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/order.dart';

class OrderState {
  final Order order;
  final bool isLoading;
  final bool isError;

  const OrderState({
    required this.order,
    this.isLoading = false,
    this.isError = false,
  });

  factory OrderState.initial() => OrderState(order: Order.empty());

  OrderState copyWith({Order? order, bool? isLoading, bool? isError}) {
    return OrderState(
      order: order ?? this.order,
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
      final order = await api.fetchOrder();
      state = state.copyWith(order: order, isLoading: false);
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
