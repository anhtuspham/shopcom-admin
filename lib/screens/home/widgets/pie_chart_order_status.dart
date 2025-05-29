import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/data/model/order_status.dart';
import 'package:shop_com_admin_web/providers/stat_order_status_provider.dart';
import 'package:shop_com_admin_web/utils/widgets/error_widget.dart';
import 'package:shop_com_admin_web/utils/widgets/loading_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartOrderStatus extends ConsumerStatefulWidget {
  const PieChartOrderStatus({super.key});

  @override
  ConsumerState<PieChartOrderStatus> createState() => _PieChartState();
}

class _PieChartState extends ConsumerState<PieChartOrderStatus> {
  List<ChartData> _mapToChartData(List<OrderStatus> orders) {
    return orders.map(
      (element) {
        String? label;
        Color color;
        switch (element.status) {
          case 'pending':
            label = 'Chờ xác nhận';
            color = Colors.orange;
          case 'processing':
            label = 'Đang vận chuyển';
            color = Colors.blue;
          case 'delivered':
            label = 'Hoàn thành';
            color = Colors.green;
          case 'cancelled':
            label = 'Hủy đơn hàng';
            color = Colors.red;
          default:
            label = element.status;
            color = Colors.grey;
        }
        ;
        return ChartData(label ?? 'Unknown', element.count!.toDouble(), color);
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final orderStatusStat = ref.watch(orderStatusStatProvider);
    if (orderStatusStat.isLoading) {
      return const LoadingWidget();
    }
    if (orderStatusStat.isError) {
      return const ErrorsWidget();
    }
    if (orderStatusStat.order.isEmpty) {
      return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: const Center(
            child: Text('No data'),
          ));
    }
    final chartData = _mapToChartData(orderStatusStat.order);

    final double total = chartData.fold(
        0, (previousValue, element) => previousValue + element.y);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: SfCircularChart(
              title: const ChartTitle(text: 'Tình trạng đơn hàng'),
              legend: const Legend(isVisible: true),
              series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              explode: true,
              // explodeAll: true,
              // dataLabelMapper: (datum, index) =>
              //     '${((datum.y / total) * 100).toStringAsFixed(1)}%',
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
