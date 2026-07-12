import 'package:equatable/equatable.dart';
import '../../../data/models/hive_model.dart';

enum HiveDetailStatus { initial, loading, success, failure }

class HiveDetailState extends Equatable {
  final HiveDetailStatus status;
  final HiveModel? hive;
  final String? errorMessage;

  const HiveDetailState({
    this.status = HiveDetailStatus.initial,
    this.hive,
    this.errorMessage,
  });

  HiveDetailState copyWith({
    HiveDetailStatus? status,
    HiveModel? hive,
    String? errorMessage,
  }) {
    return HiveDetailState(
      status: status ?? this.status,
      hive: hive ?? this.hive,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, hive, errorMessage];
}
