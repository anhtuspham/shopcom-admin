import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/apis/stat_api.dart';

import '../data/config/app_config.dart';
import '../data/model/dashboard_stat.dart';

class DashboardStatsState {
  final DashboardStat stats;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const DashboardStatsState({
    required this.stats,
    this.isLoading = false,
    this.isError = false,
    this.errorMessage,
  });

  factory DashboardStatsState.initial() => DashboardStatsState(
    stats: DashboardStat(
      totalRevenue: 0,
      totalOrders: 0,
      totalUsers: 0,
      totalProducts: 0,
    ),
  );

  DashboardStatsState copyWith({
    DashboardStat? stats,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return DashboardStatsState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DashboardStatsNotifier extends StateNotifier<DashboardStatsState> {
  DashboardStatsNotifier() : super(DashboardStatsState.initial());

  Future<void> fetchStats() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final stats = await api.getDashboardStats();
      state = state.copyWith(stats: stats, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, isError: false, errorMessage: null);
    try {
      final stats = await api.getDashboardStats();
      state = state.copyWith(stats: stats, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }
}

final dashboardStatsProvider = StateNotifierProvider<DashboardStatsNotifier, DashboardStatsState>(
      (ref) {
    final notifier = DashboardStatsNotifier();
    notifier.fetchStats();
    return notifier;
  },
);