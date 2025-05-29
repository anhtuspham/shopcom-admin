import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/order_status.dart';

class OrderStatusStat {
  final List<OrderStatus> order;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const OrderStatusStat(
      {required this.order,
        this.isLoading = false,
        this.isError = false,
        this.errorMessage});

  factory OrderStatusStat.initial() => const OrderStatusStat(order: []);

  OrderStatusStat copyWith(
      {List<OrderStatus>? order,
        bool? isLoading,
        bool? isError,
        String? errorMessage}) {
    return OrderStatusStat(
        order: order ?? this.order,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class OrderStatusStatNotifier extends StateNotifier<OrderStatusStat> {
  OrderStatusStatNotifier() : super(OrderStatusStat.initial());

  Future<void> fetchOrders() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final order = await api.getOrderStatus();
      state = state.copyWith(order: order, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, isError: false, errorMessage: null);
    await _updateOrderStatusStat();
  }

  Future<void> _updateOrderStatusStat() async {
    try {
      final order = await api.getOrderStatus();
      state = state.copyWith(order: order, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final orderStatusStatProvider = StateNotifierProvider<OrderStatusStatNotifier, OrderStatusStat>((ref) {
  final notifier = OrderStatusStatNotifier();
  notifier.fetchOrders();
  return notifier;
});
