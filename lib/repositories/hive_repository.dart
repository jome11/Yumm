import 'package:yumm/datasources/local/hive_cache_datasource.dart';
import 'package:yumm/datasources/remote/hive_remote_datasource.dart';
import 'package:yumm/models/hive_model.dart';
import 'package:yumm/models/insight_model.dart';
import 'package:yumm/models/overview_stats_model.dart';

/// Network-first, cache-fallback: cache each successful remote fetch,
/// and fall back to the last cached copy if the network call throws.
class HiveRepository {
  final HiveRemoteDatasource remoteDatasource;
  final HiveCacheDatasource cacheDatasource;

  HiveRepository({
    required this.remoteDatasource,
    required this.cacheDatasource,
  });

  Future<OverviewStatsModel> getOverviewStats() async {
    try {
      final stats = await remoteDatasource.getOverviewStats();
      await cacheDatasource.cacheOverviewStats(stats);
      return stats;
    } catch (e) {
      final cached = cacheDatasource.getCachedOverviewStats();
      if (cached != null) return cached;
      rethrow;
    }
  }

  Future<List<InsightModel>> getInsights() async {
    try {
      final insights = await remoteDatasource.getInsights();
      await cacheDatasource.cacheInsights(insights);
      return insights;
    } catch (e) {
      final cached = cacheDatasource.getCachedInsights();
      if (cached != null) return cached;
      rethrow;
    }
  }

  Future<List<HiveModel>> getHives() async {
    try {
      final hives = await remoteDatasource.getHives();
      await cacheDatasource.cacheHives(hives);
      return hives;
    } catch (e) {
      final cached = cacheDatasource.getCachedHives();
      if (cached != null) return cached;
      rethrow;
    }
  }

  Future<HiveModel> getHiveById(String id) async {
    final hives = await getHives();
    return hives.firstWhere(
      (h) => h.id == id,
      orElse: () => throw Exception('Hive #$id not found.'),
    );
  }

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
