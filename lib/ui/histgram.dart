import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyChart extends StatelessWidget {
  MyChart({Key? key, required List<int> this.distribution}) : super(key: key);

  List<int> distribution = [];

  @override
  Widget build(BuildContext context) {
    List<int> diceData = this.distribution.sublist(2, 13);
    List<BarChartGroupData> bcgd = [];
    double barWidth = 30;

    diceData.asMap().forEach((i, ddata) {
      // Range is 2-12.
      bcgd.add(BarChartGroupData(x: i + 2, barRods: [
        BarChartRodData(
          toY: ddata.toDouble(),
          width: barWidth,
        ),
      ]));
    });

    return Container(
      height: 200,
      width: double.infinity,
      child: BarChart(
        BarChartData(
          barGroups: bcgd,
          borderData: FlBorderData(
              border: const Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
          )),
          gridData: FlGridData(
            show: false,
          ),
          axisTitleData: FlAxisTitleData(
              leftTitle: AxisTitle(
            showTitle: false,
          )),
        ),
      ),
    );
  }
}
