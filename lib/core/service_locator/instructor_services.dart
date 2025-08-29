import 'package:get_it/get_it.dart';

import '../../features/course/data/data_source/course_remote_data_source.dart';
import '../../features/course/data/repositories/course_repository_impl.dart';
import '../../features/course/domain/repositories/course_repository.dart';
import '../../features/course/domain/use_cases/get_recommended_courses_uc.dart';
import '../../features/course/presentation/bloc/bloc/course_bloc.dart';
import '../../features/instructor/data/data_source/instructor_remote_data_source.dart';
import '../../features/instructor/data/repositories/instructor_repository_impl.dart';
import '../../features/instructor/domain/repositories/instructor_repository.dart';
import '../../features/instructor/domain/use_cases/get_instructors_uc.dart';
import '../../features/instructor/presentation/bloc/bloc/instructor_bloc.dart';

Future<void> initializeInstructorServices(GetIt sl) async {
  sl.registerLazySingleton<InstructorRemoteDataSource>(
      () => InstructorRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<InstructorRepository>(
      () => InstructorRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetInstructorsUC>(
      () => GetInstructorsUC(repository: sl()));
  sl.registerFactory<InstructorBloc>(
      () => InstructorBloc(getInstructorsUC: sl()));
}
