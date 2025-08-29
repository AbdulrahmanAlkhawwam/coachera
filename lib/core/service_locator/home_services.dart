import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/manager/cubit/validate_cubit.dart';
import '../../features/home/data/data_source/notification_remote_data_source.dart';
import '../../features/home/data/repositories/notification_repository_impl.dart';
import '../../features/home/domain/repositories/notification_repository.dart';
import '../../features/home/domain/use_cases/get_my_notification_uc.dart';
import '../../features/home/domain/use_cases/get_unread_notification_uc.dart';
import '../../features/home/domain/use_cases/mark_notification_uc.dart';
import '../../features/home/presentation/manager/cubit/navigation_cubit.dart';
import '../../features/home/presentation/manager/notification_bloc/notification_bloc.dart';
import '../../features/payment/presentation/bloc/cubit/payment_cubit.dart';

Future<void> initializeHomeServices(GetIt sl) async {
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());
  sl.registerFactory<ValidateCubit>(() => ValidateCubit());
  sl.registerFactory<PaymentCubit>(() => PaymentCubit());

  sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetMyNotificationUC>(
      () => GetMyNotificationUC(repository: sl()));
  sl.registerLazySingleton<GetUnreadNotificationUC>(
      () => GetUnreadNotificationUC(repository: sl()));
  sl.registerLazySingleton<MarkNotificationUC>(
      () => MarkNotificationUC(repository: sl()));
  sl.registerFactory<NotificationBloc>(() => NotificationBloc(
        getUnreadNotificationUC: sl(),
        getMyNotificationUC: sl(),
        markNotificationUC: sl(),
      ));
}
