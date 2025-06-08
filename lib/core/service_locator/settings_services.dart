// import 'package:get_it/get_it.dart';
//
// import '../../features/home/data/data_source/settings_remote_data_source.dart';
// import '../../features/home/data/repositories/settings_repository_impl.dart';
// import '../../features/home/domain/repositories/settings_repository.dart';
// import '../../features/home/domain/use_cases/theme_uc.dart';
// import '../../features/home/presentation/manger/theme_notifier.dart';
//
// Future<void> initializeSettingsServices(GetIt sl) async {
//   sl.registerLazySingleton<SettingsLocalDataSource>(
//     () => SettingsLocalDataSourceImpl(storage: sl()),
//   );
//
//   sl.registerLazySingleton<SettingsRepository>(
//     () => SettingsRepositoryImpl(localDataSource: sl()),
//   );
//
//   sl.registerLazySingleton(() => GetThemeUC(repository: sl()));
//   sl.registerLazySingleton(() => SetThemeUC(repository: sl()));
//
//   sl.registerFactory(
//     () => ThemeNotifier(
//       getThemeUC: sl(),
//       setThemeUC: sl(),
//     ),
//   );
// }
