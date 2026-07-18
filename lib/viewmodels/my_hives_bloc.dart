import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/dummy_data.dart';
import 'my_hives_event.dart';
import 'my_hives_state.dart';

class MyHivesBloc extends Bloc<MyHivesEvent, MyHivesState> {
  MyHivesBloc() : super(const MyHivesState()) {
    on<MyHivesRequested>(_onRequested);
    on<MyHivesFilterChanged>((event, emit) {
      emit(state.copyWith(filter: () => event.status));
    });
    on<MyHivesSortChanged>((event, emit) {
      emit(state.copyWith(sort: event.sort));
    });
  }

  Future<void> _onRequested(MyHivesRequested event, Emitter<MyHivesState> emit) async {
    emit(state.copyWith(status: MyHivesStatus.loading));
    await Future.delayed(const Duration(milliseconds: 700));
    emit(state.copyWith(status: MyHivesStatus.success, allHives: dummyHives));
  }
}
