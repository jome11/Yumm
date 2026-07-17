import 'package:equatable/equatable.dart';

enum InsightTag { priority, warning, routine }

String insightTagLabel(InsightTag tag) {
  switch (tag) {
    case InsightTag.priority:
      return 'PRIORITY';
    case InsightTag.warning:
      return 'WARNING';
    case InsightTag.routine:
      return 'Routine';
  }
}

InsightTag insightTagFromString(String value) {
  switch (value.toUpperCase()) {
    case 'PRIORITY':
      return InsightTag.priority;
    case 'WARNING':
      return InsightTag.warning;
    default:
      return InsightTag.routine;
  }
}

class InsightModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final InsightTag tag;
  final String meta;
  final String? relatedHiveId;

  const InsightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.meta,
    this.relatedHiveId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'tag': insightTagLabel(tag),
        'meta': meta,
        'relatedHiveId': relatedHiveId,
      };

  factory InsightModel.fromJson(Map<String, dynamic> json) => InsightModel(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        tag: insightTagFromString(json['tag'] as String),
        meta: json['meta'] as String,
        relatedHiveId: json['relatedHiveId'] as String?,
      );

  @override
  List<Object?> get props => [id, title, description, tag, meta, relatedHiveId];
}
