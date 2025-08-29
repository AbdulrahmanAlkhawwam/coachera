import 'package:get_it/get_it.dart';

import '../../features/home/data/data_source/favorite_local_data_source.dart';
import '../../features/home/data/data_source/favorite_remote_data_source.dart';
import '../../features/home/data/repositories/favorite_repository_impl.dart';
import '../../features/home/domain/repositories/favorite_repository.dart';
import '../../features/home/domain/use_cases/add_favorite_uc.dart';
import '../../features/home/domain/use_cases/delete_favorite_uc.dart';
import '../../features/home/domain/use_cases/get_favorite_uc.dart';
import '../../features/home/domain/use_cases/get_favorites_uc.dart';
import '../../features/home/presentation/manager/bloc/favorite_bloc.dart';

Future<void> initializeFavoriteServices(GetIt sl) async {
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
      () => FavoriteRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<FavoriteLocalDataSource>(
      () => FavoriteLocalDataSourceImpl(storage: sl(), database: sl()));
  sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(storage: sl(), dataSource: sl()));
  sl.registerLazySingleton<AddFavoriteUc>(
      () => AddFavoriteUc(repository: sl()));
  sl.registerLazySingleton<GetFavoritesUc>(
      () => GetFavoritesUc(repository: sl()));
  sl.registerLazySingleton<DeleteFavoriteUc>(
      () => DeleteFavoriteUc(repository: sl()));
  sl.registerLazySingleton<GetFavoriteUC>(
      () => GetFavoriteUC(repository: sl()));
  sl.registerFactory<FavoriteBloc>(
    () => FavoriteBloc(
        getFavoritesUC: sl(),
        addFavoriteUc: sl(),
        deleteFavoriteUc: sl(),
        getFavoritesUc: sl()),
  );
}
