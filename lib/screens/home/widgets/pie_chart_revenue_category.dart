import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/data/model/order_status.dart';
import 'package:shop_com_admin_web/data/model/revenue_category.dart';
import 'package:shop_com_admin_web/providers/stat_order_status_provider.dart';
import 'package:shop_com_admin_web/providers/stat_revenue_category_provider.dart';
import 'package:shop_com_admin_web/utils/widgets/error_widget.dart';
import 'package:shop_com_admin_web/utils/widgets/loading_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartRevenueCategory extends ConsumerStatefulWidget {
  const PieChartRevenueCategory({super.key});

  @override
  ConsumerState<PieChartRevenueCategory> createState() => _PieChartState();
}

class _PieChartState extends ConsumerState<PieChartRevenueCategory> {
  List<ChartData> _mapToChartData(List<RevenueCategory> orders) {
    return orders.map(
      (element) {
        String? label;
        Color color;
        switch (element.category) {
          case 'Laptop':
            label = 'Laptop';
            color = Colors.orange;
          case 'Smartphone':
            label = 'Smartphone';
            color = Colors.blue;
          case 'Tablet':
            label = 'Tablet';
            color = Colors.green;
          case 'Headphone':
            label = 'Headphone';
            color = Colors.red;
          default:
            label = element.category;
            color = Colors.grey;
        }
        ;
        return ChartData(label ?? 'Unknown', element.totalRevenue!.toDouble(), color);
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final revenueCategory = ref.watch(revenueCategoryStatNotifier);
    if (revenueCategory.isLoading) {
      return const LoadingWidget();
    }
    if (revenueCategory.isError) {
      return const ErrorsWidget();
    }
    if (revenueCategory.order.isEmpty) {
      return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: const Center(
            child: Text('No data'),
          ));
    }
    final chartData = _mapToChartData(revenueCategory.order);

    final double total = chartData.fold(
        0, (previousValue, element) => previousValue + element.y);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: SfCircularChart(
              title: const ChartTitle(text: 'Doanh thu theo danh mục'),
              legend: const Legend(isVisible: true),
              series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              explode: true,
              explodeAll: true,
              dataLabelMapper: (datum, index) =>
                  '${((datum.y / total) * 100).toStringAsFixed(1)}%',
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  useSeriesColor: true,
                  connectorLineSettings:
                      ConnectorLineSettings(type: ConnectorType.curve)),
            )
          ])),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}
