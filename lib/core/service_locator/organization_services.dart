
import 'package:get_it/get_it.dart';

import '../../features/auth/domain/use_cases/logout_uc.dart';
import '../../features/auth/domain/use_cases/register_uc.dart';
import '../../features/auth/presentation/manager/bloc/auth_bloc.dart';

import '../../features/auth/data/data_source/auth_local_data_source.dart';
import '../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login_uc.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/course/data/repositories/course_repository_impl.dart';
import '../../features/organization/data/data_source/organization_remote_data_source.dart';
import '../../features/organization/data/repositories/organization_repository_impl.dart';
import '../../features/organization/domain/repositories/organization_repository.dart';
import '../../features/organization/domain/use_cases/get_organization_uc.dart';
import '../../features/organization/presentation/bloc/bloc/organization_bloc.dart';

//
Future<void> initializeOrganizationServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<OrganizationRemoteDataSource>(
      () => OrganizationRemoteDataSourceImpl(http: sl()));

  /// Repository
  sl.registerLazySingleton<OrganizationRepository>(
      () => OrganizationRepositoryImpl(dataSource: sl()));

  /// Use Cases
//   sl.registerLazySingleton<CheckTokenUC>(() => CheckTokenUC(repository: sl()));
//   sl.registerLazySingleton<DeleteTokenUC>(
//       () => DeleteTokenUC(repository: sl()));
  sl.registerLazySingleton<GetOrganizationUC>(
      () => GetOrganizationUC(repository: sl()));
  // sl.registerLazySingleton<LoginUC>(() => LoginUC(repository: sl()));
  // sl.registerLazySingleton<LogoutUC>(() => LogoutUC(repository: sl()));
//   sl.registerLazySingleton<OtpUC>(() => OtpUC(repository: sl()));
//   sl.registerLazySingleton<RegisterUC>(() => RegisterUC(repository: sl()));
//   sl.registerLazySingleton<SaveTokenUC>(() => SaveTokenUC(repository: sl()));
//
  /// State Management
  sl.registerFactory<OrganizationBloc>(
    () => OrganizationBloc(
      // getCategoriesUc: sl(),
      getOrganizationUc: sl(),
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
