import 'package:flutter/material.dart';
import 'package:yumm/models/hive_model.dart';
import 'package:yumm/constants.dart';

class HiveListTile extends StatelessWidget {
  final HiveModel hive;
  final VoidCallback onTap;

  const HiveListTile({super.key, required this.hive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final label = hiveStatusLabel(hive.status);
    final accent = AppColors.statusAccent(label);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: accent.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Text('Hive #${hive.id}',
                          style: TextStyle(color: AppColors.textPrimary(context), fontSize: 18, fontWeight: FontWeight.w800)),
                      const Spacer(),
                      Flexible(
                        child: Text(
                          hive.apiaryName,
                          style: TextStyle(color: AppColors.textSecondary(context), fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text('${hive.temperatureCelsius}',
                      style: TextStyle(color: AppColors.textPrimary(context), fontSize: 16, fontWeight: FontWeight.w800)),
                  Text('C', style: TextStyle(color: AppColors.textSecondary(context), fontSize: 13)),
                  const SizedBox(width: 10),
                  Text('${hive.humidityPercent}% RH', style: TextStyle(color: AppColors.textSecondary(context), fontSize: 13)),
                  const SizedBox(width: 10),
                  Text('${hive.weightKg}Kg', style: TextStyle(color: AppColors.textSecondary(context), fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (hive.healthPercent / 100).clamp(0, 1),
                minHeight: 5,
                backgroundColor: accent.withOpacity(0.2),
                color: accent,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: TextStyle(color: AppColors.textSecondary(context), fontSize: 12)),
                Text('${hive.healthPercent}%', style: TextStyle(color: AppColors.textSecondary(context), fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
