import '../../models/recommendation_model.dart';

class RecommendationRemoteDatasource {
  Future<List<RecommendationModel>> getRecommendations() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return const [
      RecommendationModel(
        id: 'rec_1',
        title: 'Expand super boxes on Apiary Alpha Ridge',
        description:
            'Brood production is trending high across 3 hives. Adding supers now prevents overcrowding before the nectar peak.',
        category: 'Capacity',
      ),
      RecommendationModel(
        id: 'rec_2',
        title: 'Schedule inspection for Hive #06',
        description:
            'Temperature variance combined with rising humidity suggests a possible entrance blockage.',
        category: 'Health',
      ),
      RecommendationModel(
        id: 'rec_3',
        title: 'Plan harvest logistics for Hive #02',
        description:
            'Weight has reached peak capacity. Arrange extraction equipment within the next 2 days.',
        category: 'Harvest',
      ),
      RecommendationModel(
        id: 'rec_4',
        title: 'Relocate Hive #24 wind buffer',
        description:
            'Ambient conditions at Alpha Ridge show elevated temperature swings; a windbreak could stabilize internal climate.',
        category: 'Environment',
      ),
    ];
  }
}
