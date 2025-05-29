import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/order_month.dart';
import '../data/model/order_status.dart';
import '../data/model/revenue_month.dart';

class RevenueMonthStat {
  final List<RevenueMonth> order;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const RevenueMonthStat(
      {required this.order,
        this.isLoading = false,
        this.isError = false,
        this.errorMessage});

  factory RevenueMonthStat.initial() => const RevenueMonthStat(order: []);

  RevenueMonthStat copyWith(
      {List<RevenueMonth>? order,
        bool? isLoading,
        bool? isError,
        String? errorMessage}) {
    return RevenueMonthStat(
        order: order ?? this.order,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class RevenueMonthStatProvider extends StateNotifier<RevenueMonthStat> {
  RevenueMonthStatProvider() : super(RevenueMonthStat.initial());

  Future<void> fetchOrders() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final order = await api.getRevenueByMonth();
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
      final order = await api.getRevenueByMonth();
      state = state.copyWith(order: order, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final revenueMonthStatProvider = StateNotifierProvider<RevenueMonthStatProvider, RevenueMonthStat>((ref) {
  final notifier = RevenueMonthStatProvider();
  notifier.fetchOrders();
  return notifier;
});
