import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/dummy_data.dart';
import 'package:yumm/models/hive_model.dart';

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
  DeployHiveCubit() : super(const DeployHiveState());

  Future<void> deploy({
    required String hiveName,
    required String apiaryLocation,
    required String hiveType,
  }) async {
    emit(state.copyWith(status: DeployHiveStatus.loading));
    await Future.delayed(const Duration(milliseconds: 900));

    final newHive = HiveModel(
      id: (dummyHives.length + 1).toString().padLeft(2, '0'),
      apiaryName: apiaryLocation,
      status: HiveStatus.optimal,
      colonyStrength: 0,
      colonyCapacity: 55000,
      temperatureCelsius: 0,
      humidityPercent: 0,
      weightKg: 0,
      hiveModel: hiveType,
    );

    dummyHives.add(newHive);

    emit(state.copyWith(status: DeployHiveStatus.success, deployedHive: newHive));
  }
}
