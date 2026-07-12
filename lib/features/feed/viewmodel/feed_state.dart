import 'package:equatable/equatable.dart';
import '../../../data/models/insight_model.dart';

enum FeedStatus { initial, loading, success, failure }

class FeedState extends Equatable {
  final FeedStatus status;
  final List<InsightModel> insights;
  final String? errorMessage;

  const FeedState({
    this.status = FeedStatus.initial,
    this.insights = const [],
    this.errorMessage,
  });

  FeedState copyWith({
    FeedStatus? status,
    List<InsightModel>? insights,
    String? errorMessage,
  }) {
    return FeedState(
      status: status ?? this.status,
      insights: insights ?? this.insights,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, insights, errorMessage];
}
