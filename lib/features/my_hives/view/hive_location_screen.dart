import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/hive_model.dart';


class HiveLocationScreen extends StatelessWidget {
  final HiveModel hive;
  const HiveLocationScreen({super.key, required this.hive});

  @override
  Widget build(BuildContext context) {
    final point = LatLng(hive.latitude, hive.longitude);
    final label = hiveStatusLabel(hive.status);
    final accent = AppColors.statusAccent(label);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hive #${hive.id}',
            style: AppTextStyles.h2c(context).copyWith(fontStyle: FontStyle.italic)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: point,
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.yumm.hive',
                      maxZoom: 19,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: point,
                          width: 46,
                          height: 46,
                          child: Icon(Icons.location_on_rounded, color: accent, size: 46),
                        ),
                      ],
                    ),
                    // Required attribution per OpenStreetMap's tile usage policy.
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution('© OpenStreetMap contributors'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.surface(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.statusColor(label), borderRadius: BorderRadius.circular(20)),
                      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 10),
                    Text(hive.apiaryName, style: AppTextStyles.bodySecondaryc(context)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${hive.latitude.toStringAsFixed(5)}, ${hive.longitude.toStringAsFixed(5)}',
                  style: AppTextStyles.h3c(context),
                ),
                const SizedBox(height: 2),
                Text(AppStrings.hiveIdNote, style: AppTextStyles.bodySecondaryc(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
