import 'package:coachera/features/material/domain/use_cases/complete_lesson_uc.dart';
import 'package:get_it/get_it.dart';

import '../../features/material/data/data_source/material_remote_data_source.dart';
import '../../features/material/domain/repositories/material_repository.dart';
import '../../features/material/data/repositories/material_repository_impl.dart';
import '../../features/material/domain/use_cases/get_material_uc.dart';
import '../../features/material/domain/use_cases/submit_quiz_uc.dart';
import '../../features/material/presentation/bloc/bloc/material_bloc.dart';

Future<void> initializeMaterialServices(GetIt sl) async {
  sl.registerLazySingleton<MaterialRemoteDataSource>(
      () => MaterialRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<MaterialRepository>(
      () => MaterialRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetMaterialUC>(
      () => GetMaterialUC(repository: sl()));
  sl.registerLazySingleton<CompleteLessonUC>(
      () => CompleteLessonUC(repository: sl()));
  sl.registerLazySingleton<SubmitQuizUC>(
    () => SubmitQuizUC(repository: sl()),
  );
  sl.registerFactory<MaterialBloc>(
    () => MaterialBloc(
      getMaterialUC: sl(),
      submitQuizUC: sl(),
      completeLessonUC: sl(),
    ),
  );
}
