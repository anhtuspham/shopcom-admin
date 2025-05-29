import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_com_admin_web/screens/home/widgets/column_chart_order_month.dart';
import 'package:shop_com_admin_web/screens/home/widgets/column_chart_revenue_month.dart';
import 'package:shop_com_admin_web/screens/home/widgets/pie_chart_order_status.dart';
import 'package:shop_com_admin_web/screens/home/widgets/pie_chart_revenue_category.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/dashboard_stat.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            DashboardStats(),
            const SizedBox(height: 10,),
            const Row(
              children: [
                Expanded(child: ColumnChartOrderMonth()),
                SizedBox(width: 12),
                Expanded(child: ColumnChartRevenueMonth()),
              ]
            ),
            const SizedBox(height: 5,),
            const Row(
              children: [
                Expanded(child: PieChartOrderStatus()),
                SizedBox(width: 12,),
                Expanded(child: PieChartRevenueCategory()),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
