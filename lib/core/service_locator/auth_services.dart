
import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_source/auth_local_data_source.dart';
import '../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login_uc.dart';
import '../../features/auth/domain/use_cases/logout_uc.dart';
import '../../features/auth/domain/use_cases/register_uc.dart';
import '../../features/auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/cubit/validate_cubit.dart';

Future<void> initializeAuthServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(http: sl()));

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(storage: sl()));

  /// Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        dataSource: sl(),
        storage: sl(),
      ));

  /// Use Cases
  sl.registerLazySingleton<LoginUC>(() => LoginUC(repository: sl()));
  sl.registerLazySingleton<LogoutUC>(() => LogoutUC(repository: sl()));
//   sl.registerLazySingleton<OtpUC>(() => OtpUC(repository: sl()));
  sl.registerLazySingleton<RegisterUC>(() => RegisterUC(repository: sl()));

  /// State Management
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUC: sl(),
      logoutUC: sl(),
//       otpUC: sl(),
      registerUC: sl(),
    ),
  );
  sl.registerFactory<ValidateCubit>(
    () => ValidateCubit(),
  );
}
