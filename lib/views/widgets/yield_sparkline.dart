import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yumm/models/yield_point_model.dart';

/// Compact area sparkline for the Season Yield card on Home.
class YieldSparkline extends StatelessWidget {
  final List<YieldPointModel> points;
  const YieldSparkline({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    const lineColor = Color(0xFF7C6FE0);
    return SizedBox(
      height: 90,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < points.length; i++)
                  FlSpot(i.toDouble(), points[i].valueKg),
              ],
              isCurved: true,
              color: lineColor,
              barWidth: 2.5,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: lineColor.withOpacity(0.18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
