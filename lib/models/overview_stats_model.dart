import 'package:equatable/equatable.dart';

/// Maps to the four stat cards on the Overview screen.
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

  Map<String, dynamic> toJson() => {
        'totalHives': totalHives,
        'totalHivesDeltaThisMonth': totalHivesDeltaThisMonth,
        'seasonYieldKg': seasonYieldKg,
        'seasonYieldStatus': seasonYieldStatus,
        'healthScorePercent': healthScorePercent,
        'healthScoreStatus': healthScoreStatus,
        'ambientTempCelsius': ambientTempCelsius,
        'ambientTempStatus': ambientTempStatus,
      };

  factory OverviewStatsModel.fromJson(Map<String, dynamic> json) => OverviewStatsModel(
        totalHives: json['totalHives'] as int,
        totalHivesDeltaThisMonth: json['totalHivesDeltaThisMonth'] as int,
        seasonYieldKg: (json['seasonYieldKg'] as num).toDouble(),
        seasonYieldStatus: json['seasonYieldStatus'] as String,
        healthScorePercent: json['healthScorePercent'] as int,
        healthScoreStatus: json['healthScoreStatus'] as String,
        ambientTempCelsius: (json['ambientTempCelsius'] as num).toDouble(),
        ambientTempStatus: json['ambientTempStatus'] as String,
      );

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
