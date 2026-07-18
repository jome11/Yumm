import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumm/dummy_data.dart';
import 'package:yumm/models/user_model.dart';
import 'overview_event.dart';
import 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  OverviewBloc() : super(const OverviewState()) {
    on<OverviewRequested>(_onRequested);
    on<OverviewRefreshed>(_onRequested);
  }

  Future<void> _onRequested(OverviewEvent event, Emitter<OverviewState> emit) async {
    emit(state.copyWith(status: OverviewStatus.loading));
    await Future.delayed(const Duration(milliseconds: 700));

    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('is_logged_in') ?? false;
    final UserModel? user = loggedIn ? dummyUser : null;

    emit(state.copyWith(
      status: OverviewStatus.success,
      stats: dummyOverviewStats,
      hives: dummyHives,
      insights: dummyInsights,
      yieldHistory: dummyYieldHistory,
      user: user,
    ));
  }
}
