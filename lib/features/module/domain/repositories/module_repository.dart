import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/module.dart';

abstract class ModuleRepository {
  Future<Either<Failure, List<Module>>> getCourseModules({int? courseId});
}
