import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/organization.dart';

abstract class OrganizationRepository {
  Future<Either<Failure, Organization>> getOrganization(int id);
}
