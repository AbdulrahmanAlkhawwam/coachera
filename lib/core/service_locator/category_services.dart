import 'package:coachera/features/auth/presentation/manager/cubit/validate_cubit.dart';
import 'package:coachera/features/category/data/data_source/category_remote_data_source.dart';
import 'package:coachera/features/category/data/repositories/category_repository_impl.dart';
import 'package:coachera/features/category/domain/repositories/category_repository.dart';
import 'package:coachera/features/category/domain/use_cases/get_categories_uc.dart';
import 'package:coachera/features/category/presentation/bloc/bloc/category_bloc.dart';
import 'package:coachera/features/course/data/data_source/course_remote_data_source.dart';
import 'package:coachera/features/course/domain/repositories/course_repository.dart';
import 'package:coachera/features/course/domain/use_cases/get_courses_uc.dart';
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
// import '../../features/auth/presentation/manger/manager/organization_bloc.dart';
// import '../../features/auth/presentation/manger/cubit/auth_pres_cubit.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/course/data/repositories/course_repository_impl.dart';

//
Future<void> initializeCategoryServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(http: sl()));

  /// Repository
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
        dataSource: sl(),
      ));

  /// Use Cases
//   sl.registerLazySingleton<CheckTokenUC>(() => CheckTokenUC(repository: sl()));
//   sl.registerLazySingleton<DeleteTokenUC>(
//       () => DeleteTokenUC(repository: sl()));
  sl.registerLazySingleton<GetCategoriesUc>(
      () => GetCategoriesUc(repository: sl()));
  // sl.registerLazySingleton<LoginUC>(() => LoginUC(repository: sl()));
  // sl.registerLazySingleton<LogoutUC>(() => LogoutUC(repository: sl()));
//   sl.registerLazySingleton<OtpUC>(() => OtpUC(repository: sl()));
//   sl.registerLazySingleton<RegisterUC>(() => RegisterUC(repository: sl()));
//   sl.registerLazySingleton<SaveTokenUC>(() => SaveTokenUC(repository: sl()));
//
  /// State Management
  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      getCategoriesUc: sl(),
//       checkTokenUC: sl(),
//       deleteTokenUC: sl(),
//       loginUC: sl(),
//       logoutUC: sl(),
//       otpUC: sl(),
//       registerUC: sl(),
//       saveTokenUC: sl(),
    ),
  );
  // sl.registerFactory<ValidateCubit>(
  //   () => ValidateCubit(),
  // );
}
