import 'package:equatable/equatable.dart';

/// Maps to the four stat cards on the Overview screen:
/// Total Hives / Season Yield / Health Score / Ambient Temp.
class OverviewStatsModel extends Equatable {
  final int totalHives;
  final int totalHivesDeltaThisMonth;
  final double seasonYieldKg;
  final String seasonYieldStatus;
  final int healthScorePercent;
  final String healthScoreStatus;
  final double ambientTempCelsius;
  final String ambientTempStatus;

  const OverviewStatsModel({
    required this.totalHives,
    required this.totalHivesDeltaThisMonth,
    required this.seasonYieldKg,
    required this.seasonYieldStatus,
    required this.healthScorePercent,
    required this.healthScoreStatus,
    required this.ambientTempCelsius,
    required this.ambientTempStatus,
  });

  @override
  List<Object?> get props => [
        totalHives,
        totalHivesDeltaThisMonth,
        seasonYieldKg,
        seasonYieldStatus,
        healthScorePercent,
        healthScoreStatus,
        ambientTempCelsius,
        ambientTempStatus,
      ];
}
