import 'package:get_it/get_it.dart';

import '../../features/learningPath/data/data_source/learning_path_remote_data_source.dart';
import '../../features/learningPath/data/repositories/learning_path_repository_impl.dart';
import '../../features/learningPath/domain/repositories/learning_path_repository.dart';
import '../../features/learningPath/domain/use_cases/get_learning_paths_uc.dart';
import '../../features/learningPath/presentation/bloc/bloc/learning_path_bloc.dart';

//
Future<void> initializeLearningPathServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<LearningPathRemoteDataSource>(
      () => LearningPathRemoteDataSourceImpl(http: sl()));

  /// Repository
  sl.registerLazySingleton<LearningPathRepository>(
      () => LearningPathRepositoryImpl(dataSource: sl()));

  /// Use Cases
//   sl.registerLazySingleton<CheckTokenUC>(() => CheckTokenUC(repository: sl()));
  sl.registerLazySingleton<GetLearningPathsUC>(
      () => GetLearningPathsUC(repository: sl()));
//   sl.registerLazySingleton<DeleteTokenUC>(
//       () => DeleteTokenUC(repository: sl()));
//   sl.registerLazySingleton<GetLearningPathUC>(
//       () => GetLearningPathUC(repository: sl()));
  // sl.registerLazySingleton<LoginUC>(() => LoginUC(repository: sl()));
  // sl.registerLazySingleton<LogoutUC>(() => LogoutUC(repository: sl()));
//   sl.registerLazySingleton<OtpUC>(() => OtpUC(repository: sl()));
//   sl.registerLazySingleton<RegisterUC>(() => RegisterUC(repository: sl()));
//   sl.registerLazySingleton<SaveTokenUC>(() => SaveTokenUC(repository: sl()));
//
  /// State Management
  sl.registerFactory<LearningPathBloc>(
    () => LearningPathBloc(
      getLearningPathsUC: sl(),
      // getCategoriesUc: sl(),
      // getLearningPathUc: sl(),
//       checkTokenUC: sl(),
//       deleteTokenUC: sl(),
//       loginUC: sl(),
//       logoutUC: sl(),
//       otpUC: sl(),
//       registerUC: sl(),
//       saveTokenUC: sl(),
    ),
  );
  // sl.registerFactory<ValidateCubit>(
  //   () => ValidateCubit(),
  // );
}
