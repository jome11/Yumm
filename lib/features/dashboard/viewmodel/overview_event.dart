import 'package:equatable/equatable.dart';

abstract class OverviewEvent extends Equatable {
  const OverviewEvent();
  @override
  List<Object?> get props => [];
}

class OverviewRequested extends OverviewEvent {
  const OverviewRequested();
}

class OverviewRefreshed extends OverviewEvent {
  const OverviewRefreshed();
}
