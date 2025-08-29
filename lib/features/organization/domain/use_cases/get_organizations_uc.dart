
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/organization.dart';
import '../repositories/organization_repository.dart';

class GetOrganizationsUC extends UseCase<List<Organization>, ListParam> {
  final OrganizationRepository repository;

  GetOrganizationsUC({required this.repository});

  @override
  Future<Either<Failure, List<Organization>>> call(param) async =>
      await repository.getOrganizations(param);
}
