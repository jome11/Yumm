import 'package:get_it/get_it.dart';

import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/datasources/remote/analytics_remote_datasource.dart';
import '../../data/datasources/remote/auth_remote_datasource.dart';
import '../../data/datasources/remote/hive_remote_datasource.dart';
import '../../data/datasources/remote/recommendation_remote_datasource.dart';
import '../../data/repositories/analytics_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/hive_repository.dart';
import '../../data/repositories/recommendation_repository.dart';
import '../theme/theme_cubit.dart';



final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {

  sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasource());
  sl.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasource());
  sl.registerLazySingleton<HiveRemoteDatasource>(() => HiveRemoteDatasource());
  sl.registerLazySingleton<AnalyticsRemoteDatasource>(
      () => AnalyticsRemoteDatasource());
  sl.registerLazySingleton<RecommendationRemoteDatasource>(
      () => RecommendationRemoteDatasource());


  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      remoteDatasource: sl(),
      localDatasource: sl(),
    ),
  );
  sl.registerLazySingleton<HiveRepository>(
    () => HiveRepository(remoteDatasource: sl()),
  );
  sl.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepository(remoteDatasource: sl()),
  );
  sl.registerLazySingleton<RecommendationRepository>(
    () => RecommendationRepository(remoteDatasource: sl()),
  );

  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
