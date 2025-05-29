import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shop_com_admin_web/data/model/order_month.dart';
import 'package:shop_com_admin_web/data/model/revenue_month.dart';
import 'package:shop_com_admin_web/providers/stat_revenue_month_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../providers/stat_order_month_provider.dart';
import '../../../utils/widgets/error_widget.dart';
import '../../../utils/widgets/loading_widget.dart';

class ColumnChartRevenueMonth extends ConsumerStatefulWidget {
  const ColumnChartRevenueMonth({super.key});

  @override
  ConsumerState<ColumnChartRevenueMonth> createState() => _ColumnChartState();
}

class _ColumnChartState extends ConsumerState<ColumnChartRevenueMonth> {
  List<SalesData> _mapToChartData(List<RevenueMonth> orders) {
    return orders.map(
      (e) {
        final String label = '${e.month.toString().padLeft(2, '0')}/${e.year}';
        return SalesData(label, e.totalRevenue!.toDouble());
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final revenueMonthStat = ref.watch(revenueMonthStatProvider);

    if (revenueMonthStat.isLoading) {
      return const LoadingWidget();
    }
    if (revenueMonthStat.isError) {
      return const ErrorsWidget();
    }
    if (revenueMonthStat.order.isEmpty) {
      return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: const Center(
            child: Text('No data'),
          ));
    }
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 1,
      child: SfCartesianChart(
        title: const ChartTitle(text: 'Doanh thu theo tháng'),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: 'Thời gian'),
        ),
        primaryYAxis: NumericAxis(
          title: const AxisTitle(text: 'Doanh thu (USD)'),
          numberFormat: NumberFormat.simpleCurrency(name: 'USD'),
        ),
        series: [
          ColumnSeries<SalesData, String>(
            name: 'Doanh thu',
            dataSource: _mapToChartData(revenueMonthStat.order),
            xValueMapper: (SalesData data, _) => data.year,
            yValueMapper: (SalesData data, _) => data.sales,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }
}

class SalesData {
  final String year;
  final double sales;

  SalesData(this.year, this.sales);
}
