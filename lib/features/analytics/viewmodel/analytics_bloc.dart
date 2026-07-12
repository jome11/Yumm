import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../data/repositories/analytics_repository.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsRepository analyticsRepository;

  AnalyticsBloc({required this.analyticsRepository}) : super(const AnalyticsState()) {
    on<AnalyticsRequested>(_onRequested);
  }

  Future<void> _onRequested(AnalyticsRequested event, Emitter<AnalyticsState> emit) async {
    emit(state.copyWith(status: AnalyticsStatus.loading));
    try {
      final history = await analyticsRepository.getYieldHistory();
      final efficiency = await analyticsRepository.getApiaryEfficiency();
      emit(state.copyWith(status: AnalyticsStatus.success, yieldHistory: history, efficiency: efficiency));
    } catch (e) {
      emit(state.copyWith(status: AnalyticsStatus.failure, errorMessage: mapErrorToAppException(e).message));
    }
  }
}
