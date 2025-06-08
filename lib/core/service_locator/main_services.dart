// import 'package:get_it/get_it.dart';
//
//
// Future<void> initializeMainServices(GetIt sl) async {
//   /// Data Source
//   sl.registerLazySingleton<MainRemoteDatasource>(
//       () => MainRemoteDatasourceImpl(http: sl()));
//
//   /// Repository
//   sl.registerLazySingleton<MainRepository>(
//       () => MainRepositoryImpl(datasource: sl()));
//
//   /// State Management
//   sl.registerFactory<MainCubit>(
//     () => MainCubit(repository: sl()),
//   );
// }
