import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/entity.dart';
import '../params/search_param.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Entity>>> getEntities();

  Future<Either<Failure, List<dynamic>>> search (SearchParam param );
}
