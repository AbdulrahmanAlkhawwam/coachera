import 'package:coachera/core/error/failures.dart';

import 'package:coachera/features/material/domain/entities/material.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_util.dart';
import '../../domain/repositories/material_repository.dart';
import '../data_source/material_remote_data_source.dart';

class MaterialRepositoryImpl extends MaterialRepository {
  final MaterialRemoteDataSource dataSource;

  MaterialRepositoryImpl({required this.dataSource});

  // @override
  // Future<Either<Failure, List<Category>>> getCategories({int? page}) async =>
  //     await AppUtils.safeCall(
  //         () async => await dataSource.getCategories(page: page));

  @override
  Future<Either<Failure, Material>> getMaterial(
          {required int materialId}) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getMaterial(id: materialId));
}
