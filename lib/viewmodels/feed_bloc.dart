import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/dummy_data.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(const FeedState()) {
    on<FeedRequested>(_onRequested);
  }

  Future<void> _onRequested(FeedRequested event, Emitter<FeedState> emit) async {
    emit(state.copyWith(status: FeedStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: FeedStatus.success, insights: dummyInsights));
  }
}
