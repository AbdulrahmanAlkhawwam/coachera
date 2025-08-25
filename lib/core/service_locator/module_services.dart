import 'package:get_it/get_it.dart';

import '../../features/module/data/data_source/module_remote_data_source.dart';
import '../../features/module/data/repositories/module_repository_impl.dart';
import '../../features/module/domain/repositories/module_repository.dart';
import '../../features/module/domain/use_cases/get_course_modules_uc.dart';
import '../../features/module/presentation/bloc/bloc/module_bloc.dart';

Future<void> initializeModuleServices(GetIt sl) async {
  sl.registerLazySingleton<ModuleRemoteDataSource>(
      () => ModuleRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<ModuleRepository>(
      () => ModuleRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetCourseModulesUC>(
      () => GetCourseModulesUC(repository: sl()));
  sl.registerFactory<ModuleBloc>(
    () => ModuleBloc(getCourseModulesUC: sl()),
  );
}
