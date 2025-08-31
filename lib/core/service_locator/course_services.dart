
import 'package:get_it/get_it.dart';

import '../../features/course/data/data_source/course_remote_data_source.dart';
import '../../features/course/data/repositories/course_repository_impl.dart';
import '../../features/course/domain/repositories/course_repository.dart';
import '../../features/course/domain/use_cases/enroll_course_uc.dart';
import '../../features/course/domain/use_cases/get_instructor_courses_uc.dart';
import '../../features/course/domain/use_cases/get_recommended_courses_uc.dart';
import '../../features/course/presentation/bloc/bloc/course_bloc.dart';

Future<void> initializeCourseServices(GetIt sl) async {
  sl.registerLazySingleton<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<CourseRepository>(
      () => CourseRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetRecommendedCoursesUC>(
      () => GetRecommendedCoursesUC(repository: sl()));
  sl.registerLazySingleton<GetInstructorCoursesUC>(
      () => GetInstructorCoursesUC(repository: sl()));
  sl.registerLazySingleton<EnrollCourseUC>(
      () => EnrollCourseUC(repository: sl()));
  sl.registerFactory<CourseBloc>(() => CourseBloc(
        getRecommendedCoursesUc: sl(),
        enrollCourseUc: sl(),
        getInstructorCoursesUC: sl(),
      ));
}
