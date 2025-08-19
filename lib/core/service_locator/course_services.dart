import 'package:get_it/get_it.dart';

import '../../features/course/data/data_source/course_remote_data_source.dart';
import '../../features/course/data/data_source/module_remote_data_source.dart';
import '../../features/course/data/repositories/course_repository_impl.dart';
import '../../features/course/data/repositories/module_repository_impl.dart';
import '../../features/course/domain/repositories/course_repository.dart';
import '../../features/course/domain/repositories/module_repository.dart';
import '../../features/course/domain/use_cases/get_course_modules_uc.dart';
import '../../features/course/domain/use_cases/get_recommended_courses_uc.dart';
import '../../features/course/presentation/bloc/bloc/course_bloc.dart';

Future<void> initializeCourseServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<ModuleRemoteDataSource>(
      () => ModuleRemoteDataSourceImpl(http: sl()));

  /// Repository
  sl.registerLazySingleton<CourseRepository>(
      () => CourseRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<ModuleRepository>(
      () => ModuleRepositoryImpl(dataSource: sl()));

  /// Use Cases
  sl.registerLazySingleton<GetRecommendedCoursesUC>(
      () => GetRecommendedCoursesUC(repository: sl()));
  sl.registerLazySingleton<GetCourseModulesUC>(
      () => GetCourseModulesUC(repository: sl()));

  /// State Management
  sl.registerFactory<CourseBloc>(
    () => CourseBloc(
      getCourseModulesUC: sl(),
      getRecommendedCoursesUc: sl(),
    ),
  );
}
