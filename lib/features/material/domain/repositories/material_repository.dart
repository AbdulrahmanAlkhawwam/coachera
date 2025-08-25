import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/material.dart';

abstract class MaterialRepository {
  Future<Either<Failure, Material>> getMaterial({required int materialId});
}
