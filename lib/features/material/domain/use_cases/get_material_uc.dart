import 'package:coachera/features/material/domain/entities/material.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/material_repository.dart';


class GetMaterialUC extends UseCase<Material, int> {
  final MaterialRepository repository;

  GetMaterialUC({required this.repository});

  @override
  Future<Either<Failure, Material>> call(int materialId) async =>
      await repository.getMaterial(materialId: materialId);
}
