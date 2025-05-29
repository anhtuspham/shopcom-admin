import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/order_month.dart';
import '../data/model/order_status.dart';

class OrderMonthStat {
  final List<OrderMonth> order;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const OrderMonthStat(
      {required this.order,
        this.isLoading = false,
        this.isError = false,
        this.errorMessage});

  factory OrderMonthStat.initial() => const OrderMonthStat(order: []);

  OrderMonthStat copyWith(
      {List<OrderMonth>? order,
        bool? isLoading,
        bool? isError,
        String? errorMessage}) {
    return OrderMonthStat(
        order: order ?? this.order,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class OrderStatusStatNotifier extends StateNotifier<OrderMonthStat> {
  OrderStatusStatNotifier() : super(OrderMonthStat.initial());

  Future<void> fetchOrders() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final order = await api.getOrderMonth();
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
      final order = await api.getOrderMonth();
      state = state.copyWith(order: order, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final orderMonthStatProvider = StateNotifierProvider<OrderStatusStatNotifier, OrderMonthStat>((ref) {
  final notifier = OrderStatusStatNotifier();
  notifier.fetchOrders();
  return notifier;
});
