import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/views/widgets/error_view.dart';
import 'package:yumm/views/widgets/loading_indicator.dart';
import 'package:yumm/viewmodels/analytics_bloc.dart';
import 'package:yumm/viewmodels/analytics_event.dart';
import 'package:yumm/viewmodels/analytics_state.dart';
import 'package:yumm/views/widgets/yield_chart.dart';
import 'package:yumm/constants.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticsBloc()..add(const AnalyticsRequested()),
      child: const _AnalyticsBody(),
    );
  }
}

class _AnalyticsBody extends StatelessWidget {
  const _AnalyticsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            if (state.status == AnalyticsStatus.loading || state.status == AnalyticsStatus.initial) {
              return const LoadingIndicator();
            }
            if (state.status == AnalyticsStatus.failure) {
              return ErrorView(
                message: state.errorMessage ?? 'Failed to load analytics.',
                onRetry: () => context.read<AnalyticsBloc>().add(const AnalyticsRequested()),
              );
            }

            final points = state.yieldHistory;
            final latest = points.last.valueKg;
            final first = points.first.valueKg;
            final growthPercent = (((latest - first) / first) * 100).toStringAsFixed(0);

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              children: [
                Text(AppStrings.analytics,
                    style: AppTextStyles.h1c(context).copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.totalYield, style: AppTextStyles.captionc(context)),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(latest.toStringAsFixed(0), style: AppTextStyles.h1c(context)),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text('Kg', style: AppTextStyles.bodySecondaryc(context)),
                          ),
                        ],
                      ),
                      Text('+$growthPercent% ${AppStrings.vsLastMonth}',
                          style: const TextStyle(color: AppColors.accentGreen, fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      YieldChart(points: points),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _MetricBox(
                        label: AppStrings.envRisk,
                        value: 'LOW',
                        valueColor: AppColors.accentGreen,
                        subtitle: 'Stable Environment',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _MetricBox(
                        label: AppStrings.totalHives,
                        value: '6',
                        suffix: 'units',
                        subtitle: '38 production ready',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _MetricBox(label: AppStrings.avgHealth, value: '94', suffix: '%', fullWidth: true),
                const SizedBox(height: 24),
                Text(AppStrings.apiaryEfficiency, style: AppTextStyles.h3c(context)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: state.efficiency
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(e.name, style: AppTextStyles.bodyc(context)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: LinearProgressIndicator(
                                              value: e.ratio,
                                              minHeight: 6,
                                              backgroundColor: AppColors.divider(context),
                                              color: AppColors.accentGreen,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text('${e.yieldKg.toStringAsFixed(0)}Kg', style: AppTextStyles.bodySecondaryc(context)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface(context),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.divider(context)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(AppStrings.yieldPrediction,
                            style: TextStyle(color: AppColors.primaryDark, fontSize: 10, fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(height: 12),
                      Text('Honey production is up 14% this month.', style: AppTextStyles.h3c(context)),
                      const SizedBox(height: 8),
                      Text(
                        'Environmental conditions across Apiary Alpha remain optimal for forage. Automated monitors suggest nectar flow peak in 6 days.',
                        style: AppTextStyles.bodySecondaryc(context),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  final String label;
  final String value;
  final String? suffix;
  final String? subtitle;
  final Color? valueColor;
  final bool fullWidth;

  const _MetricBox({
    required this.label,
    required this.value,
    this.suffix,
    this.subtitle,
    this.valueColor,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.captionc(context)),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: AppTextStyles.h1c(context).copyWith(color: valueColor ?? AppColors.textPrimary(context))),
              if (suffix != null) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(suffix!, style: AppTextStyles.bodySecondaryc(context)),
                ),
              ],
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: const TextStyle(color: AppColors.accentGreen, fontSize: 12)),
          ],
        ],
      ),
    );
  }
}
