import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../data/models/hive_model.dart';
import '../../../data/repositories/hive_repository.dart';
import '../viewmodel/hive_detail_bloc.dart';
import '../viewmodel/hive_detail_event.dart';
import '../viewmodel/hive_detail_state.dart';

/// Pushed via Navigator.pushNamed(context, AppRoutes.hiveDetail,
/// arguments: hiveId) — see route_generator.dart.
class HiveDetailScreen extends StatelessWidget {
  final String hiveId;
  const HiveDetailScreen({super.key, required this.hiveId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HiveDetailBloc(hiveRepository: sl<HiveRepository>())..add(HiveDetailRequested(hiveId)),
      child: _HiveDetailBody(hiveId: hiveId),
    );
  }
}

class _HiveDetailBody extends StatelessWidget {
  final String hiveId;
  const _HiveDetailBody({required this.hiveId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive #$hiveId', style: AppTextStyles.h2c(context).copyWith(fontStyle: FontStyle.italic)),
      ),
      body: BlocBuilder<HiveDetailBloc, HiveDetailState>(
        builder: (context, state) {
          if (state.status == HiveDetailStatus.loading || state.status == HiveDetailStatus.initial) {
            return const LoadingIndicator();
          }
          if (state.status == HiveDetailStatus.failure) {
            return ErrorView(
              message: state.errorMessage ?? 'Failed to load hive.',
              onRetry: () => context.read<HiveDetailBloc>().add(HiveDetailRequested(hiveId)),
            );
          }

          final hive = state.hive!;
          final label = hiveStatusLabel(hive.status);
          final accent = AppColors.statusAccent(label);

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.statusColor(label), borderRadius: BorderRadius.circular(20)),
                  child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 64,
                      height: 64,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: hive.healthPercent / 100,
                            strokeWidth: 6,
                            backgroundColor: Colors.black12,
                            color: const Color(0xFF7C6FE0),
                          ),
                          Text('${hive.healthPercent}%',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.textPrimary(context))),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(AppStrings.healthScore,
                        style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.textPrimary(context).withOpacity(0.6))),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _InfoBox(label: 'Temp', value: '${hive.temperatureCelsius}C')),
                  const SizedBox(width: 12),
                  Expanded(child: _InfoBox(label: 'Humidity', value: '${hive.humidityPercent}%')),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _InfoBox(label: 'Activity', value: hive.activityLevel)),
                  const SizedBox(width: 12),
                  Expanded(child: _InfoBox(label: 'HIVE MODEL', value: hive.hiveModel)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.productivityAnalysis, style: AppTextStyles.captionc(context)),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: hive.healthPercent / 100,
                        minHeight: 6,
                        backgroundColor: AppColors.divider(context),
                        color: AppColors.accentGreen,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings.estHoneyYield, style: AppTextStyles.captionc(context)),
                            Text('${hive.weightKg} Kg', style: AppTextStyles.h3c(context)),
                          ],
                        ),
                        Text('${hive.healthPercent}%', style: AppTextStyles.h3c(context)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.preGeneratedHiveId, style: AppTextStyles.captionc(context)),
                    const SizedBox(height: 4),
                    Text(hive.hardwareId, style: AppTextStyles.h1c(context).copyWith(fontStyle: FontStyle.italic)),
                    const SizedBox(height: 6),
                    Text(AppStrings.hiveIdNote, style: AppTextStyles.bodySecondaryc(context)),
                    const SizedBox(height: 18),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: QrImageView(
                          data: 'yumm-hive://${hive.hardwareId}',
                          size: 160,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.download_rounded, color: AppColors.textPrimary(context)),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.hiveLocation, arguments: hive),
                  icon: Icon(Icons.location_on_outlined, color: AppColors.textPrimary(context)),
                  label: Text(AppStrings.viewLocation, style: TextStyle(color: AppColors.textPrimary(context), fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.surface(context),
                    side: BorderSide(color: AppColors.divider(context)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.captionc(context)),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.h3c(context)),
        ],
      ),
    );
  }
}
