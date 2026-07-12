import 'package:equatable/equatable.dart';
import '../../../data/models/hive_model.dart';
import '../../../data/models/insight_model.dart';
import '../../../data/models/overview_stats_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/yield_point_model.dart';

enum OverviewStatus { initial, loading, success, failure }

class OverviewState extends Equatable {
  final OverviewStatus status;
  final OverviewStatsModel? stats;
  final List<HiveModel> hives;
  final List<InsightModel> insights;
  final List<YieldPointModel> yieldHistory;
  final UserModel? user;
  final String? errorMessage;

  const OverviewState({
    this.status = OverviewStatus.initial,
    this.stats,
    this.hives = const [],
    this.insights = const [],
    this.yieldHistory = const [],
    this.user,
    this.errorMessage,
  });

  OverviewState copyWith({
    OverviewStatus? status,
    OverviewStatsModel? stats,
    List<HiveModel>? hives,
    List<InsightModel>? insights,
    List<YieldPointModel>? yieldHistory,
    UserModel? user,
    String? errorMessage,
  }) {
    return OverviewState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      hives: hives ?? this.hives,
      insights: insights ?? this.insights,
      yieldHistory: yieldHistory ?? this.yieldHistory,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, stats, hives, insights, yieldHistory, user, errorMessage];
}
