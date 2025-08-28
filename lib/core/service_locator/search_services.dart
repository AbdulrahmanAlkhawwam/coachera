import 'package:coachera/features/auth/presentation/manager/cubit/validate_cubit.dart';
import 'package:coachera/features/category/data/data_source/category_remote_data_source.dart';
import 'package:coachera/features/category/data/repositories/category_repository_impl.dart';
import 'package:coachera/features/category/domain/repositories/category_repository.dart';
import 'package:coachera/features/category/domain/use_cases/get_categories_uc.dart';
import 'package:coachera/features/category/presentation/bloc/bloc/category_bloc.dart';
import 'package:coachera/features/course/data/data_source/course_remote_data_source.dart';
import 'package:coachera/features/course/domain/repositories/course_repository.dart';
import 'package:coachera/features/course/domain/use_cases/get_recommended_courses_uc.dart';
import 'package:coachera/features/course/presentation/bloc/bloc/course_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/domain/use_cases/logout_uc.dart';
import '../../features/auth/domain/use_cases/register_uc.dart';
import '../../features/auth/presentation/manager/bloc/auth_bloc.dart';

import '../../features/auth/data/data_source/auth_local_data_source.dart';
import '../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

// import '../../features/auth/domain/use_cases/check_token_uc.dart';
// import '../../features/auth/domain/use_cases/delete_token_uc.dart';
import '../../features/auth/domain/use_cases/login_uc.dart';

// import '../../features/auth/domain/use_cases/logout_uc.dart';
// import '../../features/auth/domain/use_cases/otp_uc.dart';
// import '../../features/auth/domain/use_cases/register_uc.dart';
// import '../../features/auth/domain/use_cases/save_token_uc.dart';
// import '../../features/auth/presentation/manger/manager/review_bloc.dart';
// import '../../features/auth/presentation/manger/cubit/auth_pres_cubit.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/course/data/repositories/course_repository_impl.dart';
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
