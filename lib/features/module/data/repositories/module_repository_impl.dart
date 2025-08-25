import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/module.dart';
import '../../domain/repositories/module_repository.dart';
import '../data_source/module_remote_data_source.dart';

class ModuleRepositoryImpl extends ModuleRepository {
  final ModuleRemoteDataSource dataSource;

  ModuleRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Module>>> getCourseModules(
          {int? courseId}) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getCourseModules(courseId: courseId));
}
