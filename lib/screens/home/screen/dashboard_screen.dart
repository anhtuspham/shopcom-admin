import 'package:flutter/cupertino.dart';
import 'package:shop_com_admin_web/screens/home/widgets/column_chart.dart';
import 'package:shop_com_admin_web/screens/home/widgets/pie_chart.dart';
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
      child: Column(
        children: [
          DashboardStats(),
          const SizedBox(height: 10,),
          ColumnChart(),
          const SizedBox(height: 10),
          PieChart(),
        ],
      ),
    );
  }
}
