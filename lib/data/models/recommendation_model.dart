import 'package:equatable/equatable.dart';

class RecommendationModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;

  const RecommendationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, description, category];
}
