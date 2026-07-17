import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/models/hive_model.dart';
import 'package:yumm/repositories/hive_repository.dart';
import 'package:yumm/viewmodels/app_exception.dart';

enum DeployHiveStatus { initial, loading, success, failure }

class DeployHiveState {
  final DeployHiveStatus status;
  final HiveModel? deployedHive;
  final String? errorMessage;

  const DeployHiveState({
    this.status = DeployHiveStatus.initial,
    this.deployedHive,
    this.errorMessage,
  });

  DeployHiveState copyWith({
    DeployHiveStatus? status,
    HiveModel? deployedHive,
    String? errorMessage,
  }) {
    return DeployHiveState(
      status: status ?? this.status,
      deployedHive: deployedHive ?? this.deployedHive,
      errorMessage: errorMessage,
    );
  }
}

class DeployHiveCubit extends Cubit<DeployHiveState> {
  final HiveRepository hiveRepository;

  DeployHiveCubit({required this.hiveRepository})
      : super(const DeployHiveState());

  Future<void> deploy({
    required String hiveName,
    required String apiaryLocation,
    required String hiveType,
  }) async {
    emit(state.copyWith(status: DeployHiveStatus.loading));
    try {
      final hive = await hiveRepository.deployHive(
        hiveName: hiveName,
        apiaryLocation: apiaryLocation,
        hiveType: hiveType,
      );
      emit(state.copyWith(
        status: DeployHiveStatus.success,
        deployedHive: hive,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DeployHiveStatus.failure,
        errorMessage: mapErrorToAppException(e).message,
      ));
    }
  }
}
