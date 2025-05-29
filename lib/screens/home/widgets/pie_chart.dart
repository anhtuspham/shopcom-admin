import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart({super.key});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Hoàn thành', 25),
      ChartData('Đang vận chuyển', 38),
      ChartData('Chờ xác nhận', 34),
      ChartData('Bị hủy', 20)
    ];
    final double total = chartData.fold(0, (previousValue, element) => previousValue + element.y);
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
              explodeAll: true,
              dataLabelMapper: (datum, index) => '${((datum.y / total) * 100).toStringAsFixed(1)}%',
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                useSeriesColor: true,
                connectorLineSettings: ConnectorLineSettings(type: ConnectorType.curve)
              ),
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
