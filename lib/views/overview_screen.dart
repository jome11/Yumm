import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/viewmodels/theme_cubit.dart';
import 'package:yumm/viewmodels/overview_bloc.dart';
import 'package:yumm/viewmodels/overview_event.dart';
import 'package:yumm/viewmodels/overview_state.dart';
import 'package:yumm/models/hive_model.dart';
import 'package:yumm/models/insight_model.dart';
import 'package:yumm/models/yield_point_model.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/views/hive_detail_screen.dart';
import 'package:yumm/views/my_hives_screen.dart';
import 'package:yumm/views/widgets/glass_card.dart';
import 'package:yumm/views/widgets/hex_pattern_card.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewBloc()..add(const OverviewRequested()),
      child: const _OverviewBody(),
    );
  }
}

class _OverviewBody extends StatelessWidget {
  const _OverviewBody();

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OverviewBloc, OverviewState>(
          builder: (context, state) {
            if (state.status == OverviewStatus.loading || state.status == OverviewStatus.initial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state.status == OverviewStatus.failure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.errorMessage ?? 'Failed to load dashboard.', style: AppTextStyles.bodySecondaryc(context)),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<OverviewBloc>().add(const OverviewRequested()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final stats = state.stats!;
            final userName = (state.user?.name ?? 'Natnael').split(' ').first;
            final topInsight = state.insights.isNotEmpty ? state.insights.first : null;
            final alertCount = state.hives.where((h) => h.status == HiveStatus.warning).length;

            return RefreshIndicator(
              onRefresh: () async => context.read<OverviewBloc>().add(const OverviewRefreshed()),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.goodMorning, style: AppTextStyles.captionc(context)),
                          Text(userName, style: AppTextStyles.h1c(context).copyWith(fontStyle: FontStyle.italic)),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: const Color(0xFFE3D9F5),
                            backgroundImage: state.user != null && state.user!.avatarUrl.isNotEmpty
                                ? NetworkImage(state.user!.avatarUrl)
                                : null,
                            child: (state.user == null || state.user!.avatarUrl.isEmpty)
                                ? const Icon(Icons.person, color: Color(0xFF7C6FE0), size: 18)
                                : null,
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => context.read<ThemeCubit>().toggle(!isDark),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(color: AppColors.surface(context), shape: BoxShape.circle),
                              child: Icon(
                                isDark ? Icons.dark_mode_rounded : Icons.wb_sunny_rounded,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  HexPatternCard(
                    padding: const EdgeInsets.all(20),
                    borderRadius: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppStrings.seasonYield, style: AppTextStyles.captionc(context)),
                                  const SizedBox(height: 6),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(stats.seasonYieldKg.toStringAsFixed(0), style: AppTextStyles.h1c(context)),
                                      const SizedBox(width: 6),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Text('Kg', style: AppTextStyles.bodySecondaryc(context)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(stats.seasonYieldStatus, style: AppTextStyles.bodySecondaryc(context)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.accentGreen.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Text('${stats.healthScorePercent}%',
                                      style: const TextStyle(color: AppColors.accentGreen, fontWeight: FontWeight.w800, fontSize: 16)),
                                  const Text('Health', style: TextStyle(color: AppColors.accentGreen, fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _sparkline(state.yieldHistory),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {},
                    child: GlassCard(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      borderRadius: 18,
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt_outlined, color: AppColors.textPrimary(context)),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.scanQrCode, style: AppTextStyles.bodyc(context).copyWith(fontWeight: FontWeight.w600)),
                              Text(AppStrings.scanQrCodeSubtitle, style: AppTextStyles.bodySecondaryc(context)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _statCard(context, value: '${stats.totalHives}', label: 'HIVES', icon: Icons.hexagon_outlined)),
                      const SizedBox(width: 10),
                      Expanded(child: _statCard(context, value: '${stats.ambientTempCelsius}c', label: 'TEMP', icon: Icons.thermostat_rounded)),
                      const SizedBox(width: 10),
                      Expanded(child: _statCard(context, value: '$alertCount', label: 'ALERTS', icon: Icons.notifications_none_rounded)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.fleetStatus, style: AppTextStyles.h3c(context).copyWith(fontStyle: FontStyle.italic)),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHivesScreen())),
                        child: Row(
                          children: [
                            Text(AppStrings.viewAll, style: TextStyle(color: AppColors.textSecondary(context), fontSize: 13)),
                            const SizedBox(width: 2),
                            Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.textSecondary(context)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...state.hives.take(3).map(
                        (hive) => _fleetCard(
                          context,
                          hive: hive,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HiveDetailScreen(hiveId: hive.id))),
                        ),
                      ),
                  const SizedBox(height: 16),
                  Text(AppStrings.latestAlert, style: AppTextStyles.h3c(context).copyWith(fontStyle: FontStyle.italic)),
                  const SizedBox(height: 10),
                  if (topInsight != null)
                    _insightCard(
                      context,
                      insight: topInsight,
                      onTap: topInsight.relatedHiveId == null
                          ? null
                          : () => Navigator.push(context, MaterialPageRoute(builder: (context) => HiveDetailScreen(hiveId: topInsight.relatedHiveId!))),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _sparkline(List<YieldPointModel> points) {
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
              spots: [for (int i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].valueKg)],
              isCurved: true,
              color: lineColor,
              barWidth: 2.5,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: true, color: lineColor.withOpacity(0.18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(BuildContext context, {required String value, required String label, required IconData icon}) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      borderRadius: 18,
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.h2c(context)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.captionc(context)),
        ],
      ),
    );
  }

  Widget _fleetCard(BuildContext context, {required HiveModel hive, required VoidCallback onTap}) {
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
                      Text('Hive #${hive.id}', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      Text(hive.apiaryName, style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 12)),
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
                Text('${hive.temperatureCelsius}C', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text('${hive.humidityPercent}%', style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _insightCard(BuildContext context, {required InsightModel insight, VoidCallback? onTap}) {
    final bg = AppColors.insightColor(insightTagLabel(insight.tag));
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.18), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      insightTagLabel(insight.tag),
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(insight.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(insight.meta, style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 11)),
                  const SizedBox(height: 8),
                  Text(insight.description, style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.5, height: 1.35)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
