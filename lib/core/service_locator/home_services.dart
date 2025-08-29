
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/manager/cubit/validate_cubit.dart';
import '../../features/home/presentation/manager/cubit/navigation_cubit.dart';
import '../../features/payment/presentation/bloc/cubit/payment_cubit.dart';

Future<void> initializeHomeServices(GetIt sl) async {
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());
  sl.registerFactory<ValidateCubit>(() => ValidateCubit());
  sl.registerFactory<PaymentCubit>(() => PaymentCubit());
}
