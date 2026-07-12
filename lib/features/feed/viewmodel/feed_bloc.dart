import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../data/repositories/hive_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final HiveRepository hiveRepository;

  FeedBloc({required this.hiveRepository}) : super(const FeedState()) {
    on<FeedRequested>(_onRequested);
  }

  Future<void> _onRequested(FeedRequested event, Emitter<FeedState> emit) async {
    emit(state.copyWith(status: FeedStatus.loading));
    try {
      final insights = await hiveRepository.getInsights();
      emit(state.copyWith(status: FeedStatus.success, insights: insights));
    } catch (e) {
      emit(state.copyWith(
        status: FeedStatus.failure,
        errorMessage: mapErrorToAppException(e).message,
      ));
    }
  }
}
