import 'package:equatable/equatable.dart';
import '../../../data/models/hive_model.dart';
import 'my_hives_event.dart';

enum MyHivesStatus { initial, loading, success, failure }

class MyHivesState extends Equatable {
  final MyHivesStatus status;
  final List<HiveModel> allHives;
  final HiveStatus? filter;
  final MyHivesSort sort;
  final String? errorMessage;

  const MyHivesState({
    this.status = MyHivesStatus.initial,
    this.allHives = const [],
    this.filter,
    this.sort = MyHivesSort.idAscending,
    this.errorMessage,
  });

  List<HiveModel> get visibleHives {
    var list = filter == null
        ? List<HiveModel>.from(allHives)
        : allHives.where((h) => h.status == filter).toList();

    switch (sort) {
      case MyHivesSort.idAscending:
        list.sort((a, b) => a.id.compareTo(b.id));
        break;
      case MyHivesSort.strengthDescending:
        list.sort((a, b) => b.colonyStrength.compareTo(a.colonyStrength));
        break;
      case MyHivesSort.temperatureDescending:
        list.sort((a, b) => b.temperatureCelsius.compareTo(a.temperatureCelsius));
        break;
    }
    return list;
  }

  MyHivesState copyWith({
    MyHivesStatus? status,
    List<HiveModel>? allHives,
    HiveStatus? Function()? filter,
    MyHivesSort? sort,
    String? errorMessage,
  }) {
    return MyHivesState(
      status: status ?? this.status,
      allHives: allHives ?? this.allHives,
      filter: filter != null ? filter() : this.filter,
      sort: sort ?? this.sort,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, allHives, filter, sort, errorMessage];
}
