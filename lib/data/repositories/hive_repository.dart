import '../datasources/remote/hive_remote_datasource.dart';
import '../models/hive_model.dart';
import '../models/insight_model.dart';
import '../models/overview_stats_model.dart';

class HiveRepository {
  final HiveRemoteDatasource remoteDatasource;

  HiveRepository({required this.remoteDatasource});

  Future<OverviewStatsModel> getOverviewStats() =>
      remoteDatasource.getOverviewStats();

  Future<List<InsightModel>> getInsights() => remoteDatasource.getInsights();

  Future<List<HiveModel>> getHives() => remoteDatasource.getHives();

  Future<HiveModel> getHiveById(String id) =>
      remoteDatasource.getHiveById(id);

  Future<HiveModel> deployHive({
    required String hiveName,
    required String apiaryLocation,
    required String hiveType,
  }) =>
      remoteDatasource.deployHive(
        hiveName: hiveName,
        apiaryLocation: apiaryLocation,
        hiveType: hiveType,
      );
}
