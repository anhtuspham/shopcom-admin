import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shop_com_admin_web/providers/currency_provider.dart';

import '../../../providers/stat_dashboard_provider.dart';
import '../../../utils/util.dart';

class DashboardStats extends ConsumerWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(dashboardStatsProvider);

    if (statsState.isLoading) {
      return const Card(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (statsState.isError) {
      return Card(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                statsState.errorMessage ?? 'Lỗi khi tải dữ liệu',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(dashboardStatsProvider.notifier).refresh();
                },
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    final stats = statsState.stats;


    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard(
              title: 'Tổng Doanh Thu',
              value: formatMoney(money: stats.totalRevenue,currency: ref.watch(currencyProvider)),
              icon: Icons.monetization_on,
              color: Colors.green,
            ),
            _buildStatCard(
              title: 'Tổng Đơn Hàng',
              value: stats.totalOrders.toString(),
              icon: Icons.shopping_cart,
              color: Colors.blue,
            ),
            _buildStatCard(
              title: 'Tổng Người Dùng',
              value: stats.totalUsers.toString(),
              icon: Icons.people,
              color: Colors.orange,
            ),
            _buildStatCard(
              title: 'Tổng Sản Phẩm',
              value: stats.totalProducts.toString(),
              icon: Icons.inventory,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}