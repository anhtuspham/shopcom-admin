import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/order_status.dart';
import '../data/model/revenue_category.dart';

class RevenueCategoryStat {
  final List<RevenueCategory> order;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const RevenueCategoryStat(
      {required this.order,
        this.isLoading = false,
        this.isError = false,
        this.errorMessage});

  factory RevenueCategoryStat.initial() => const RevenueCategoryStat(order: []);

  RevenueCategoryStat copyWith(
      {List<RevenueCategory>? order,
        bool? isLoading,
        bool? isError,
        String? errorMessage}) {
    return RevenueCategoryStat(
        order: order ?? this.order,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class RevenueCategoryStatNotifier extends StateNotifier<RevenueCategoryStat> {
  RevenueCategoryStatNotifier() : super(RevenueCategoryStat.initial());

  Future<void> fetchOrders() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final order = await api.getRevenueCategory();
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
      final order = await api.getRevenueCategory();
      state = state.copyWith(order: order, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final revenueCategoryStatNotifier = StateNotifierProvider<RevenueCategoryStatNotifier, RevenueCategoryStat>((ref) {
  final notifier = RevenueCategoryStatNotifier();
  notifier.fetchOrders();
  return notifier;
});
