import '../datasources/remote/recommendation_remote_datasource.dart';
import '../models/recommendation_model.dart';

class RecommendationRepository {
  final RecommendationRemoteDatasource remoteDatasource;

  RecommendationRepository({required this.remoteDatasource});

  Future<List<RecommendationModel>> getRecommendations() =>
      remoteDatasource.getRecommendations();
}
