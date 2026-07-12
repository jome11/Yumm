import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../data/repositories/analytics_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/hive_repository.dart';
import 'overview_event.dart';
import 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final HiveRepository hiveRepository;
  final AnalyticsRepository analyticsRepository;
  final AuthRepository authRepository;

  OverviewBloc({
    required this.hiveRepository,
    required this.analyticsRepository,
    required this.authRepository,
  }) : super(const OverviewState()) {
    on<OverviewRequested>(_onRequested);
    on<OverviewRefreshed>(_onRequested);
  }

  Future<void> _onRequested(
    OverviewEvent event,
    Emitter<OverviewState> emit,
  ) async {
    emit(state.copyWith(status: OverviewStatus.loading));
    try {
      final stats = await hiveRepository.getOverviewStats();
      final hives = await hiveRepository.getHives();
      final insights = await hiveRepository.getInsights();
      final yieldHistory = await analyticsRepository.getYieldHistory();
      final user = await authRepository.getCachedUser();
      emit(state.copyWith(
        status: OverviewStatus.success,
        stats: stats,
        hives: hives,
        insights: insights,
        yieldHistory: yieldHistory,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OverviewStatus.failure,
        errorMessage: mapErrorToAppException(e).message,
      ));
    }
  }
}
