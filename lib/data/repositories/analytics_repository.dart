import '../datasources/remote/analytics_remote_datasource.dart';
import '../models/apiary_efficiency_model.dart';
import '../models/yield_point_model.dart';

class AnalyticsRepository {
  final AnalyticsRemoteDatasource remoteDatasource;

  AnalyticsRepository({required this.remoteDatasource});

  Future<List<YieldPointModel>> getYieldHistory() =>
      remoteDatasource.getYieldHistory();

  Future<List<ApiaryEfficiencyModel>> getApiaryEfficiency() =>
      remoteDatasource.getApiaryEfficiency();
}
