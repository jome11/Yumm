import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart' as hivedb;

import 'package:yumm/app.dart';
import 'package:yumm/datasources/local/auth_local_datasource.dart';
import 'package:yumm/datasources/local/hive_cache_datasource.dart';
import 'package:yumm/datasources/remote/analytics_remote_datasource.dart';
import 'package:yumm/datasources/remote/auth_remote_datasource.dart';
import 'package:yumm/datasources/remote/hive_remote_datasource.dart';
import 'package:yumm/repositories/analytics_repository.dart';
import 'package:yumm/repositories/auth_repository.dart';
import 'package:yumm/repositories/hive_repository.dart';
import 'package:yumm/viewmodels/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await hivedb.Hive.initFlutter();
  await HiveCacheDatasource.openBox();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(
            remoteDatasource: AuthRemoteDatasource(),
            localDatasource: AuthLocalDatasource(),
          ),
        ),
        RepositoryProvider<HiveRepository>(
          create: (_) => HiveRepository(
            remoteDatasource: HiveRemoteDatasource(),
            cacheDatasource: HiveCacheDatasource(),
          ),
        ),
        RepositoryProvider<AnalyticsRepository>(
          create: (_) => AnalyticsRepository(
            remoteDatasource: AnalyticsRemoteDatasource(),
          ),
        ),
      ],
      child: BlocProvider<ThemeCubit>(
        create: (_) => ThemeCubit(),
        child: const YummApp(),
      ),
    ),
  );
}
