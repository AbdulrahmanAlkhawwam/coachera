import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/organization.dart';

abstract class OrganizationRepository {
  Future<Either<Failure, Organization>> getOrganization(int id);

  Future<Either<Failure, List<Organization>>> getOrganizations(ListParam param);
}
