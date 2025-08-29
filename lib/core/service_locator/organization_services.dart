import 'package:get_it/get_it.dart';

import '../../features/organization/data/data_source/organization_remote_data_source.dart';
import '../../features/organization/data/repositories/organization_repository_impl.dart';
import '../../features/organization/domain/repositories/organization_repository.dart';
import '../../features/organization/domain/use_cases/get_organization_uc.dart';
import '../../features/organization/domain/use_cases/get_organizations_uc.dart';
import '../../features/organization/presentation/bloc/bloc/organization_bloc.dart';

Future<void> initializeOrganizationServices(GetIt sl) async {
  sl.registerLazySingleton<OrganizationRemoteDataSource>(
      () => OrganizationRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<OrganizationRepository>(
      () => OrganizationRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetOrganizationUC>(
      () => GetOrganizationUC(repository: sl()));
  sl.registerLazySingleton<GetOrganizationsUC>(
      () => GetOrganizationsUC(repository: sl()));
  sl.registerFactory<OrganizationBloc>(() => OrganizationBloc(
        getOrganizationUc: sl(),
        getOrganizationsUC: sl(),
      ));
}
