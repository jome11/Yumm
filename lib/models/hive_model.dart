import 'package:equatable/equatable.dart';

/// The four hive states: harvestReady, warning, optimal, routine.
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

  /// Serializes to JSON — used by the local cache and a future real API.
  Map<String, dynamic> toJson() => {
        'id': id,
        'apiaryName': apiaryName,
        'status': hiveStatusLabel(status),
        'colonyStrength': colonyStrength,
        'colonyCapacity': colonyCapacity,
        'temperatureCelsius': temperatureCelsius,
        'humidityPercent': humidityPercent,
        'weightKg': weightKg,
        'healthPercent': healthPercent,
        'activityLevel': activityLevel,
        'hiveModel': hiveModel,
        'hardwareId': hardwareId,
        'latitude': latitude,
        'longitude': longitude,
      };

  factory HiveModel.fromJson(Map<String, dynamic> json) => HiveModel(
        id: json['id'] as String,
        apiaryName: json['apiaryName'] as String,
        status: hiveStatusFromString(json['status'] as String),
        colonyStrength: json['colonyStrength'] as int,
        colonyCapacity: json['colonyCapacity'] as int,
        temperatureCelsius: (json['temperatureCelsius'] as num).toDouble(),
        humidityPercent: json['humidityPercent'] as int,
        weightKg: (json['weightKg'] as num).toDouble(),
        healthPercent: json['healthPercent'] as int? ?? 80,
        activityLevel: json['activityLevel'] as String? ?? 'High',
        hiveModel: json['hiveModel'] as String? ?? 'Langstroth',
        hardwareId: json['hardwareId'] as String? ?? 'AR-0000-L',
        latitude: (json['latitude'] as num?)?.toDouble() ?? 9.0192,
        longitude: (json['longitude'] as num?)?.toDouble() ?? 38.7525,
      );

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
