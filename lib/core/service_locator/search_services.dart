import 'package:get_it/get_it.dart';

import '../../features/search/data/data_source/search_remote_data_source.dart';
import '../../features/search/data/repositories/search_repository_impl.dart';
import '../../features/search/domain/repositories/search_repository.dart';
import '../../features/search/domain/use_cases/get_entities_uc.dart';
import '../../features/search/presentation/bloc/search_bloc.dart';

Future<void> initializeSearchServices(GetIt sl) async {
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetEntitiesUC>(
      () => GetEntitiesUC(repository: sl()));
  sl.registerFactory<SearchBloc>(
    () => SearchBloc(getEntitiesUC: sl()),
  );
}
