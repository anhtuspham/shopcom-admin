import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatefulWidget {
  const ColumnChart({super.key});

  @override
  State<ColumnChart> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: const ChartTitle(text: 'Doanh thu theo năm'),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(),
      series: [
        ColumnSeries<SalesData, String>(
          name: 'Doanh thu',
          dataSource: [
            SalesData('2019', 35),
            SalesData('2020', 28),
            SalesData('2021', 34),
            SalesData('2022', 32),
            SalesData('2023', 40),
          ],
          xValueMapper: (SalesData data, _) => data.year,
          yValueMapper: (SalesData data, _) => data.sales,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}

class SalesData {
  final String year;
  final double sales;

  SalesData(this.year, this.sales);
}
