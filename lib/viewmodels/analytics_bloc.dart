import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/dummy_data.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(const AnalyticsState()) {
    on<AnalyticsRequested>(_onRequested);
  }

  Future<void> _onRequested(AnalyticsRequested event, Emitter<AnalyticsState> emit) async {
    emit(state.copyWith(status: AnalyticsStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(
      status: AnalyticsStatus.success,
      yieldHistory: dummyYieldHistory,
      efficiency: dummyApiaryEfficiency,
    ));
  }
}
