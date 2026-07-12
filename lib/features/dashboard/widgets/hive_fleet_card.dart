import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/hive_model.dart';

/// Full-color compact card used in the "Fleet Status" list on Home.
class HiveFleetCard extends StatelessWidget {
  final HiveModel hive;
  final VoidCallback onTap;

  const HiveFleetCard({super.key, required this.hive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final label = hiveStatusLabel(hive.status);
    final bg = AppColors.statusColor(label);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Hive #${hive.id}',
                          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      Text(hive.apiaryName,
                          style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(label, style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${hive.temperatureCelsius}C',
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text('${hive.humidityPercent}%', style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
