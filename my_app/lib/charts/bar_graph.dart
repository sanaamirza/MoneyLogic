import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';

class BarGraph extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thursAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;
  const BarGraph({
    super.key,
    required this.maxY,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thursAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
    });

  @override
  Widget build(BuildContext context) {

    BarData myBarData = BarData(monAmount: monAmount, 
    tueAmount: tueAmount, 
    wedAmount: wedAmount, 
    thursAmount: thursAmount, 
    friAmount: friAmount, 
    satAmount: satAmount, 
    sunAmount: sunAmount);

    myBarData.initialiseBarData();

    return BarChart(
      BarChartData(
        minY:0,
        maxY: maxY,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getDaysTitles
              )
          )
        ),
        barGroups: myBarData.barData.map((data) => BarChartGroupData(
          x: data.x,
          barRods: [BarChartRodData(
            toY: data.y,
            color: Color.fromARGB(255, 45, 64, 89),
            width: 20,
            borderRadius: BorderRadius.circular(3),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY,
              color: Color.fromARGB(255, 233, 230, 230)
            )
            )]
          )).toList() 
      )
    );
  }
}

Widget getDaysTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Color.fromARGB(255, 45, 64, 89),
    fontWeight: FontWeight.bold,
    fontSize: 13,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text("Mon");
        break;
      case 1:
        text = const Text("Tue");
        break;
      case 2:
        text = const Text("Wed");
        break;
      case 3:
        text = const Text("Thu");
        break;
      case 4:
        text = const Text("Fri");
        break;
      case 5:
        text = const Text("Sat");
        break;
      case 6:
        text = const Text("Sun");
        break;
      default:
        text = const Text("");
        break;
    }
    return SideTitleWidget(
      child: text, 
      axisSide: meta.axisSide);
}