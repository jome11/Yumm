import 'package:equatable/equatable.dart';
import '../../../data/models/hive_model.dart';

abstract class MyHivesEvent extends Equatable {
  const MyHivesEvent();
  @override
  List<Object?> get props => [];
}

class MyHivesRequested extends MyHivesEvent {
  const MyHivesRequested();
}

class MyHivesFilterChanged extends MyHivesEvent {
  final HiveStatus? status; // null = All
  const MyHivesFilterChanged(this.status);

  @override
  List<Object?> get props => [status];
}

enum MyHivesSort { idAscending, strengthDescending, temperatureDescending }

class MyHivesSortChanged extends MyHivesEvent {
  final MyHivesSort sort;
  const MyHivesSortChanged(this.sort);

  @override
  List<Object?> get props => [sort];
}
