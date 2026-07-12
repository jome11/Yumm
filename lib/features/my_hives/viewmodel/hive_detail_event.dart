import 'package:equatable/equatable.dart';

abstract class HiveDetailEvent extends Equatable {
  const HiveDetailEvent();
  @override
  List<Object?> get props => [];
}

class HiveDetailRequested extends HiveDetailEvent {
  final String hiveId;
  const HiveDetailRequested(this.hiveId);

  @override
  List<Object?> get props => [hiveId];
}
