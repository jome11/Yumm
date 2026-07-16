import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/viewmodels/theme_cubit.dart';
import 'package:yumm/views/widgets/error_view.dart';
import 'package:yumm/views/widgets/loading_indicator.dart';
import 'package:yumm/repositories/analytics_repository.dart';
import 'package:yumm/repositories/auth_repository.dart';
import 'package:yumm/repositories/hive_repository.dart';
import 'package:yumm/views/widgets/insight_feed_card.dart';
import 'package:yumm/viewmodels/overview_bloc.dart';
import 'package:yumm/viewmodels/overview_event.dart';
import 'package:yumm/viewmodels/overview_state.dart';
import 'package:yumm/views/widgets/hive_fleet_card.dart';
import 'package:yumm/views/widgets/stat_card.dart';
import 'package:yumm/views/widgets/yield_sparkline.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/routes.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewBloc(
        hiveRepository: context.read<HiveRepository>(),
        analyticsRepository: context.read<AnalyticsRepository>(),
        authRepository: context.read<AuthRepository>(),
      )..add(const OverviewRequested()),
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
              return const LoadingIndicator();
            }
            if (state.status == OverviewStatus.failure) {
              return ErrorView(
                message: state.errorMessage ?? 'Failed to load dashboard.',
                onRetry: () => context.read<OverviewBloc>().add(const OverviewRequested()),
              );
            }

            final stats = state.stats!;
            final userName = (state.user?.name ?? 'Natnael').split(' ').first;
            final topInsight = state.insights.isNotEmpty ? state.insights.first : null;

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
                          Text(userName,
                              style: AppTextStyles.h1c(context).copyWith(fontStyle: FontStyle.italic)),
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
                              decoration: BoxDecoration(
                                color: AppColors.surface(context),
                                shape: BoxShape.circle,
                              ),
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
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface(context),
                      borderRadius: BorderRadius.circular(22),
                    ),
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
                                      Text('${stats.seasonYieldKg.toStringAsFixed(0)}',
                                          style: AppTextStyles.h1c(context)),
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
                                      style: const TextStyle(
                                          color: AppColors.accentGreen, fontWeight: FontWeight.w800, fontSize: 16)),
                                  const Text('Health', style: TextStyle(color: AppColors.accentGreen, fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        YieldSparkline(points: state.yieldHistory),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface(context),
                        borderRadius: BorderRadius.circular(18),
                      ),
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
                      Expanded(
                        child: StatCard(
                          value: '${stats.totalHives}',
                          label: 'HIVES',
                          icon: Icons.hexagon_outlined,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          value: '${stats.ambientTempCelsius}c',
                          label: 'TEMP',
                          icon: Icons.thermostat_rounded,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          value: '${state.hives.where((h) => h.status.name == 'warning').length}',
                          label: 'ALERTS',
                          icon: Icons.notifications_none_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.fleetStatus,
                          style: AppTextStyles.h3c(context).copyWith(fontStyle: FontStyle.italic)),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.myHives),
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
                        (hive) => HiveFleetCard(
                          hive: hive,
                          onTap: () => Navigator.pushNamed(context, AppRoutes.hiveDetail, arguments: hive.id),
                        ),
                      ),
                  const SizedBox(height: 16),
                  Text(AppStrings.latestAlert,
                      style: AppTextStyles.h3c(context).copyWith(fontStyle: FontStyle.italic)),
                  const SizedBox(height: 10),
                  if (topInsight != null)
                    InsightFeedCard(
                      insight: topInsight,
                      onTap: topInsight.relatedHiveId == null
                          ? null
                          : () => Navigator.pushNamed(context, AppRoutes.hiveDetail, arguments: topInsight.relatedHiveId),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
