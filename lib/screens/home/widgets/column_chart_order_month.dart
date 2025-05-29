import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/data/model/order_month.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../providers/stat_order_month_provider.dart';
import '../../../utils/widgets/error_widget.dart';
import '../../../utils/widgets/loading_widget.dart';

class ColumnChartOrderMonth extends ConsumerStatefulWidget {
  const ColumnChartOrderMonth({super.key});

  @override
  ConsumerState<ColumnChartOrderMonth> createState() => _ColumnChartState();
}

class _ColumnChartState extends ConsumerState<ColumnChartOrderMonth> {
  List<SalesData> _mapToChartData(List<OrderMonth> orders) {
    return orders.map((e) {
      final String label = '${e.month.toString().padLeft(2, '0')}/${e.year}';
      return SalesData(label, e.count!.toDouble());
    },).toList();
  }
  @override
  Widget build(BuildContext context) {
    final orderMonthStat = ref.watch(orderMonthStatProvider);

    if (orderMonthStat.isLoading) {
      return const LoadingWidget();
    }
    if (orderMonthStat.isError) {
      return const ErrorsWidget();
    }
    if (orderMonthStat.order.isEmpty) {
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
        title: const ChartTitle(text: 'Số đơn hàng theo tháng'),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(),
        series: [
          ColumnSeries<SalesData, String>(
            name: 'Doanh thu',
            dataSource: _mapToChartData(orderMonthStat.order),
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
