import 'package:equatable/equatable.dart';
import 'package:yumm/models/apiary_efficiency_model.dart';
import 'package:yumm/models/yield_point_model.dart';

enum AnalyticsStatus { initial, loading, success, failure }

class AnalyticsState extends Equatable {
  final AnalyticsStatus status;
  final List<YieldPointModel> yieldHistory;
  final List<ApiaryEfficiencyModel> efficiency;
  final String? errorMessage;

  const AnalyticsState({
    this.status = AnalyticsStatus.initial,
    this.yieldHistory = const [],
    this.efficiency = const [],
    this.errorMessage,
  });

  AnalyticsState copyWith({
    AnalyticsStatus? status,
    List<YieldPointModel>? yieldHistory,
    List<ApiaryEfficiencyModel>? efficiency,
    String? errorMessage,
  }) {
    return AnalyticsState(
      status: status ?? this.status,
      yieldHistory: yieldHistory ?? this.yieldHistory,
      efficiency: efficiency ?? this.efficiency,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, yieldHistory, efficiency, errorMessage];
}
