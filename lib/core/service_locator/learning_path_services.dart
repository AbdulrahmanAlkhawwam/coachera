import 'package:get_it/get_it.dart';

import '../../features/learningPath/data/data_source/learning_path_remote_data_source.dart';
import '../../features/learningPath/data/repositories/learning_path_repository_impl.dart';
import '../../features/learningPath/domain/repositories/learning_path_repository.dart';
import '../../features/learningPath/domain/use_cases/get_learning_paths_uc.dart';
import '../../features/learningPath/presentation/bloc/bloc/learning_path_bloc.dart';

Future<void> initializeLearningPathServices(GetIt sl) async {
  sl.registerLazySingleton<LearningPathRemoteDataSource>(
      () => LearningPathRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<LearningPathRepository>(
      () => LearningPathRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetLearningPathsUC>(
      () => GetLearningPathsUC(repository: sl()));
  sl.registerFactory<LearningPathBloc>(
    () => LearningPathBloc(getLearningPathsUC: sl()),
  );
}
