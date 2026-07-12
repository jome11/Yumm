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

/// A single card in the "Intelligence" feed.
class InsightModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final InsightTag tag;
  final String meta; // e.g. "Hive #06 · 18m ago"
  final String? relatedHiveId; // null when not tied to a specific hive

  const InsightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.meta,
    this.relatedHiveId,
  });

  @override
  List<Object?> get props => [id, title, description, tag, meta, relatedHiveId];
}
