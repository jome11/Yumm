import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../data/repositories/hive_repository.dart';
import 'my_hives_event.dart';
import 'my_hives_state.dart';

class MyHivesBloc extends Bloc<MyHivesEvent, MyHivesState> {
  final HiveRepository hiveRepository;

  MyHivesBloc({required this.hiveRepository}) : super(const MyHivesState()) {
    on<MyHivesRequested>(_onRequested);
    on<MyHivesFilterChanged>((event, emit) {
      emit(state.copyWith(filter: () => event.status));
    });
    on<MyHivesSortChanged>((event, emit) {
      emit(state.copyWith(sort: event.sort));
    });
  }

  Future<void> _onRequested(
    MyHivesRequested event,
    Emitter<MyHivesState> emit,
  ) async {
    emit(state.copyWith(status: MyHivesStatus.loading));
    try {
      final hives = await hiveRepository.getHives();
      emit(state.copyWith(status: MyHivesStatus.success, allHives: hives));
    } catch (e) {
      emit(state.copyWith(
        status: MyHivesStatus.failure,
        errorMessage: mapErrorToAppException(e).message,
      ));
    }
  }
}
