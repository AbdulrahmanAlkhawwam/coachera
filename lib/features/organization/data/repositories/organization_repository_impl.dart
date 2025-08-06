import 'package:coachera/features/category/domain/entities/category.dart';
import 'package:coachera/features/organization/domain/entities/organization.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/repositories/organization_repository.dart';
import '../data_source/organization_remote_data_source.dart';

class OrganizationRepositoryImpl extends OrganizationRepository {
  final OrganizationRemoteDataSource dataSource;

  OrganizationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Organization>> getOrganization(int id) async =>
      await AppUtils.safeCall(() async => await dataSource.getOrganization(id));
}
