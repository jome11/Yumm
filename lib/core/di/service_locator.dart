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

/// Global service locator. Call [setupServiceLocator] once in main()
/// before runApp. Every ViewModel (Bloc/Cubit) resolves its
/// repository dependency through `sl<T>()` instead of constructing
/// it inline, which keeps the UI layer decoupled from data layer.
final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Datasources
  sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasource());
  sl.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasource());
  sl.registerLazySingleton<HiveRemoteDatasource>(() => HiveRemoteDatasource());
  sl.registerLazySingleton<AnalyticsRemoteDatasource>(
      () => AnalyticsRemoteDatasource());
  sl.registerLazySingleton<RecommendationRemoteDatasource>(
      () => RecommendationRemoteDatasource());

  // Repositories
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

  // App-wide dark/light mode state — single shared instance.
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
