import 'package:equatable/equatable.dart';

/// Matches the four states shown in the Figma designs:
/// Harvest Ready (gold), Warning (red), Optimal (green), Routine (blue).
enum HiveStatus { harvestReady, warning, optimal, routine }

HiveStatus hiveStatusFromString(String value) {
  switch (value.toUpperCase()) {
    case 'WARNING':
      return HiveStatus.warning;
    case 'OPTIMAL':
      return HiveStatus.optimal;
    case 'ROUTINE':
      return HiveStatus.routine;
    default:
      return HiveStatus.harvestReady;
  }
}

String hiveStatusLabel(HiveStatus status) {
  switch (status) {
    case HiveStatus.harvestReady:
      return 'Harvest Ready';
    case HiveStatus.warning:
      return 'Warning';
    case HiveStatus.optimal:
      return 'Optimal';
    case HiveStatus.routine:
      return 'Routine';
  }
}

class HiveModel extends Equatable {
  final String id; // e.g. "02"
  final String apiaryName;
  final HiveStatus status;
  final int colonyStrength;
  final int colonyCapacity;
  final double temperatureCelsius;
  final int humidityPercent;
  final double weightKg;
  final int healthPercent;
  final String activityLevel;
  final String hiveModel;
  final String hardwareId;
  final double latitude;
  final double longitude;

  const HiveModel({
    required this.id,
    required this.apiaryName,
    required this.status,
    required this.colonyStrength,
    required this.colonyCapacity,
    required this.temperatureCelsius,
    required this.humidityPercent,
    required this.weightKg,
    this.healthPercent = 80,
    this.activityLevel = 'High',
    this.hiveModel = 'Langstroth',
    this.hardwareId = 'AR-0000-L',
    this.latitude = 9.0192,
    this.longitude = 38.7525,
  });

  double get colonyStrengthRatio =>
      colonyCapacity == 0 ? 0 : colonyStrength / colonyCapacity;

  @override
  List<Object?> get props => [
        id,
        apiaryName,
        status,
        colonyStrength,
        colonyCapacity,
        temperatureCelsius,
        humidityPercent,
        weightKg,
        healthPercent,
        activityLevel,
        hiveModel,
        hardwareId,
        latitude,
        longitude,
      ];
}
