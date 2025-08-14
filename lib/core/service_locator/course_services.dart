import 'package:coachera/features/auth/presentation/manager/cubit/validate_cubit.dart';
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

import '../../features/auth/domain/use_cases/login_uc.dart';

import '../../features/auth/domain/use_cases/logout_uc.dart';
import '../../features/auth/domain/use_cases/otp_uc.dart';
import '../../features/auth/domain/use_cases/register_uc.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/course/data/repositories/course_repository_impl.dart';

//
Future<void> initializeCourseServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(http: sl()));

  // sl.registerLazySingleton<AuthLocalDataSource>(
  //     () => AuthLocalDataSourceImpl(storage: sl()));
  //
  /// Repository
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(
        dataSource: sl(),
        // storage: sl(),
      ));

  /// Use Cases
//   sl.registerLazySingleton<CheckTokenUC>(() => CheckTokenUC(repository: sl()));
//   sl.registerLazySingleton<DeleteTokenUC>(
//       () => DeleteTokenUC(repository: sl()));
  sl.registerLazySingleton<GetRecommendedCoursesUC>(() => GetRecommendedCoursesUC(repository: sl()));
  // sl.registerLazySingleton<LoginUC>(() => LoginUC(repository: sl()));
  // sl.registerLazySingleton<LogoutUC>(() => LogoutUC(repository: sl()));
//   sl.registerLazySingleton<OtpUC>(() => OtpUC(repository: sl()));
//   sl.registerLazySingleton<RegisterUC>(() => RegisterUC(repository: sl()));
//   sl.registerLazySingleton<SaveTokenUC>(() => SaveTokenUC(repository: sl()));
//
  /// State Management
  sl.registerFactory<CourseBloc>(
    () => CourseBloc(
      getRecommendedCoursesUc: sl(),
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
