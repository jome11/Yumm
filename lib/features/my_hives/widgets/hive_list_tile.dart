import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/hive_model.dart';

class HiveListTile extends StatelessWidget {
  final HiveModel hive;
  final VoidCallback onTap;

  const HiveListTile({super.key, required this.hive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final label = hiveStatusLabel(hive.status);
    final bg = AppColors.statusColor(label);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hive #${hive.id}',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                Text(hive.apiaryName, style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 12)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text('${hive.temperatureCelsius}',
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                Text('C', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13)),
                const SizedBox(width: 10),
                Text('${hive.humidityPercent}% RH', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13)),
                const SizedBox(width: 10),
                Text('${hive.weightKg}Kg', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13)),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (hive.healthPercent / 100).clamp(0, 1),
                minHeight: 5,
                backgroundColor: Colors.white.withOpacity(0.2),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12)),
                Text('${hive.healthPercent}%', style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
