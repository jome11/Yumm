import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/dummy_data.dart';
import 'package:yumm/models/hive_model.dart';
import 'hive_detail_event.dart';
import 'hive_detail_state.dart';

class HiveDetailBloc extends Bloc<HiveDetailEvent, HiveDetailState> {
  HiveDetailBloc() : super(const HiveDetailState()) {
    on<HiveDetailRequested>(_onRequested);
  }

  Future<void> _onRequested(HiveDetailRequested event, Emitter<HiveDetailState> emit) async {
    emit(state.copyWith(status: HiveDetailStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));

    HiveModel? hive;
    for (final h in dummyHives) {
      if (h.id == event.hiveId) {
        hive = h;
        break;
      }
    }

    if (hive == null) {
      emit(state.copyWith(status: HiveDetailStatus.failure, errorMessage: 'Hive #${event.hiveId} not found.'));
      return;
    }
    emit(state.copyWith(status: HiveDetailStatus.success, hive: hive));
  }
}
