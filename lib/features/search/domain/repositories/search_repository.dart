import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Entity>>> getEntities();

}
