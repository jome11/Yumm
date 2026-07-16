import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/repositories/hive_repository.dart';
import 'hive_detail_event.dart';
import 'hive_detail_state.dart';
import 'package:yumm/viewmodels/app_exception.dart';

class HiveDetailBloc extends Bloc<HiveDetailEvent, HiveDetailState> {
  final HiveRepository hiveRepository;

  HiveDetailBloc({required this.hiveRepository})
      : super(const HiveDetailState()) {
    on<HiveDetailRequested>(_onRequested);
  }

  Future<void> _onRequested(
    HiveDetailRequested event,
    Emitter<HiveDetailState> emit,
  ) async {
    emit(state.copyWith(status: HiveDetailStatus.loading));
    try {
      final hive = await hiveRepository.getHiveById(event.hiveId);
      emit(state.copyWith(status: HiveDetailStatus.success, hive: hive));
    } catch (e) {
      emit(state.copyWith(
        status: HiveDetailStatus.failure,
        errorMessage: mapErrorToAppException(e).message,
      ));
    }
  }
}
