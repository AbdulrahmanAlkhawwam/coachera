import 'package:get_it/get_it.dart';

import '../../features/category/data/data_source/category_remote_data_source.dart';
import '../../features/category/data/repositories/category_repository_impl.dart';
import '../../features/category/domain/repositories/category_repository.dart';
import '../../features/category/domain/use_cases/get_categories_uc.dart';
import '../../features/category/presentation/bloc/bloc/category_bloc.dart';

Future<void> initializeCategoryServices(GetIt sl) async {
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetCategoriesUC>(
      () => GetCategoriesUC(repository: sl()));
  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(getCategoriesUC: sl()),
  );
}
