import 'package:yumm/models/hive_model.dart';
import 'package:yumm/models/insight_model.dart';
import 'package:yumm/models/overview_stats_model.dart';

class HiveRemoteDatasource {
  Future<OverviewStatsModel> getOverviewStats() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return const OverviewStatsModel(
      totalHives: 6,
      totalHivesDeltaThisMonth: 3,
      seasonYieldKg: 1280,
      seasonYieldStatus: 'On track  ·  Jul 2026',
      healthScorePercent: 94,
      healthScoreStatus: 'Optimal Range',
      ambientTempCelsius: 24.5,
      ambientTempStatus: 'Stable in valley',
    );
  }

  Future<List<HiveModel>> getHives() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return const [
      HiveModel(
        id: '02',
        apiaryName: 'North Field',
        status: HiveStatus.harvestReady,
        colonyStrength: 38000,
        colonyCapacity: 55000,
        temperatureCelsius: 34.8,
        humidityPercent: 62,
        weightKg: 48.2,
        healthPercent: 98,
        latitude: 9.035,
        longitude: 38.748,
      ),
      HiveModel(
        id: '06',
        apiaryName: 'South Meadow',
        status: HiveStatus.warning,
        colonyStrength: 12000,
        colonyCapacity: 55000,
        temperatureCelsius: 28.4,
        humidityPercent: 61,
        weightKg: 31.5,
        healthPercent: 80,
        hardwareId: 'AR-0238-L',
        latitude: 9.012,
        longitude: 38.789,
      ),
      HiveModel(
        id: '07',
        apiaryName: 'East Grove',
        status: HiveStatus.optimal,
        colonyStrength: 42500,
        colonyCapacity: 55000,
        temperatureCelsius: 33.5,
        humidityPercent: 64,
        weightKg: 39.1,
        healthPercent: 98,
        latitude: 9.051,
        longitude: 38.721,
      ),
      HiveModel(
        id: '12',
        apiaryName: 'West Slope',
        status: HiveStatus.optimal,
        colonyStrength: 41200,
        colonyCapacity: 55000,
        temperatureCelsius: 34.0,
        humidityPercent: 61,
        weightKg: 42.3,
        healthPercent: 98,
        latitude: 9.068,
        longitude: 38.766,
      ),
      HiveModel(
        id: '15',
        apiaryName: 'Alpha Ridge',
        status: HiveStatus.harvestReady,
        colonyStrength: 33100,
        colonyCapacity: 55000,
        temperatureCelsius: 33.1,
        humidityPercent: 59,
        weightKg: 35.7,
        healthPercent: 98,
        latitude: 9.029,
        longitude: 38.705,
      ),
      HiveModel(
        id: '24',
        apiaryName: 'South Meadow',
        status: HiveStatus.routine,
        colonyStrength: 18000,
        colonyCapacity: 55000,
        temperatureCelsius: 29.8,
        humidityPercent: 55,
        weightKg: 31.5,
        healthPercent: 98,
        latitude: 9.008,
        longitude: 38.792,
      ),
    ];
  }

  Future<HiveModel> getHiveById(String id) async {
    final hives = await getHives();
    return hives.firstWhere(
      (h) => h.id == id,
      orElse: () => throw Exception('Hive #$id not found.'),
    );
  }

  Future<List<InsightModel>> getInsights() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return const [
      InsightModel(
        id: 'ins_1',
        title: 'Temperature Variance',
        description:
            '4°C drop detected over 6 hours. Possible ventilation issue or queen disruption.',
        tag: InsightTag.warning,
        relatedHiveId: '06',
        meta: 'Hive #06 · 18m ago',
      ),
      InsightModel(
        id: 'ins_2',
        title: 'Queen Activity Normal',
        description:
            'Acoustic sensors confirm healthy queen presence. Egg-laying patterns nominal across all nodes.',
        tag: InsightTag.routine,
        meta: 'Fleet-wide · 1h ago',
      ),
      InsightModel(
        id: 'ins_3',
        title: 'Harvest Window',
        description:
            'Weight sensors at peak capacity (48.2 kg). Optimal harvest window open for the next 72 hours.',
        tag: InsightTag.priority,
        relatedHiveId: '02',
        meta: 'Hive #02 · 2m ago',
      ),
    ];
  }

  Future<HiveModel> deployHive({
    required String hiveName,
    required String apiaryLocation,
    required String hiveType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 900));
    return HiveModel(
      id: (DateTime.now().millisecondsSinceEpoch % 100).toString().padLeft(2, '0'),
      apiaryName: apiaryLocation,
      status: HiveStatus.optimal,
      colonyStrength: 0,
      colonyCapacity: 55000,
      temperatureCelsius: 0,
      humidityPercent: 0,
      weightKg: 0,
      hiveModel: hiveType,
    );
  }
}
