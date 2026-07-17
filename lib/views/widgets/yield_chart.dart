import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yumm/models/yield_point_model.dart';
import 'package:yumm/constants.dart';

class YieldChart extends StatelessWidget {
  final List<YieldPointModel> points;
  const YieldChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    const lineColor = Color(0xFF7C6FE0);
    final maxY = (points.map((p) => p.valueKg).reduce((a, b) => a > b ? a : b) * 1.15);
    final textColor = AppColors.textSecondary(context);

    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          maxY: maxY,
          minY: 0,
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: maxY / 3,
            getDrawingHorizontalLine: (_) => FlLine(color: AppColors.divider(context), strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                interval: maxY / 3,
                getTitlesWidget: (value, meta) => Text(
                  value.toStringAsFixed(0),
                  style: TextStyle(fontSize: 10, color: textColor),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= points.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(points[i].label.substring(0, 2), style: TextStyle(fontSize: 10, color: textColor)),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [for (int i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].valueKg)],
              isCurved: true,
              color: lineColor,
              barWidth: 2.5,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: true, color: lineColor.withOpacity(0.15)),
            ),
          ],
        ),
      ),
    );
  }
}
