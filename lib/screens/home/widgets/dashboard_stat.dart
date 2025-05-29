import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardStats extends StatelessWidget {
  final List<StatCardData> stats = [
    StatCardData(
        icon: FontAwesomeIcons.dollarSign,
        value: '\$92k',
        label: 'Tổng doanh thu',
        change: '+15%',
        isPositive: true),
    StatCardData(
        icon: FontAwesomeIcons.shopify,
        value: '12',
        label: 'Tổng đơn hàng',
        change: '+19%',
        isPositive: true),
    StatCardData(
        icon: FontAwesomeIcons.userCheck,
        value: '100',
        label: 'Người dùng',
        change: '+13%',
        isPositive: true),
    StatCardData(
        icon: FontAwesomeIcons.box,
        value: '10',
        label: 'Sản phẩm',
        change: '-8%',
        isPositive: false),
  ];

  DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: stats.length,
            itemBuilder: (context, index) {
              return StatCard(data: stats[index]);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        ),
      ),
    );
  }
}

class StatCardData {
  final IconData icon;
  final String value;
  final String label;
  final String change;
  final bool isPositive;

  StatCardData(
      {required this.icon,
      required this.value,
      required this.label,
      required this.change,
      required this.isPositive});
}

class StatCard extends StatelessWidget {
  final StatCardData data;

  const StatCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(data.icon, size: 32, color: Colors.orangeAccent),
            Text(data.value,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(data.label, style: TextStyle(color: Colors.grey[700])),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    data.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: data.isPositive ? Colors.green : Colors.red,
                    size: 16),
                const SizedBox(width: 4),
                Text(
                  data.change,
                  style: TextStyle(
                    color: data.isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
