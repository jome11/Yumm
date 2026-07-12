import '../../models/apiary_efficiency_model.dart';
import '../../models/yield_point_model.dart';

class AnalyticsRemoteDatasource {
  Future<List<YieldPointModel>> getYieldHistory() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return const [
      YieldPointModel(label: 'Jan', valueKg: 520),
      YieldPointModel(label: 'Feb', valueKg: 640),
      YieldPointModel(label: 'Mar', valueKg: 780),
      YieldPointModel(label: 'Apr', valueKg: 860),
      YieldPointModel(label: 'May', valueKg: 990),
      YieldPointModel(label: 'Jun', valueKg: 1120),
      YieldPointModel(label: 'Jul', valueKg: 1280),
    ];
  }


  Future<List<ApiaryEfficiencyModel>> getApiaryEfficiency() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      ApiaryEfficiencyModel(name: 'North Orchard', yieldKg: 482, ratio: 0.86),
      ApiaryEfficiencyModel(name: 'Valley South', yieldKg: 482, ratio: 0.82),
      ApiaryEfficiencyModel(name: 'East Bank', yieldKg: 482, ratio: 0.78),
    ];
  }
}
