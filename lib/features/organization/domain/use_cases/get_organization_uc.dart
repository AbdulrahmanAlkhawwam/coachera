import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/organization.dart';
import '../repositories/organization_repository.dart';

class GetOrganizationUC extends UseCase<Organization, int> {
  final OrganizationRepository repository;

  GetOrganizationUC({required this.repository});

  @override
  Future<Either<Failure, Organization>> call(int id) async =>
      await repository.getOrganization(id);
}
