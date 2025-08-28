import 'package:coachera/core/error/failures.dart';
import 'package:coachera/core/utils/app_util.dart';
import 'package:coachera/features/search/data/data_source/search_remote_data_source.dart';
import 'package:coachera/features/search/domain/entities/entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource dataSource;

  SearchRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Entity>>> getEntities() async =>
      await AppUtils.safeCall(() async => await dataSource.getEntities());

}
