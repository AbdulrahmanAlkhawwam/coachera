
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../../course/domain/entities/course.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../data_source/favorite_remote_data_source.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  final FavoriteRemoteDataSource dataSource;

  // final CourseLocalDataSource storage;

  FavoriteRepositoryImpl({
    required this.dataSource,
    // required this.storage,
  });

  @override
  Future<Either<Failure, void>> addFavorite(int courseId) async =>
      await AppUtils.safeCall(
          () async => await dataSource.addFavorite(courseId));

  @override
  Future<Either<Failure, List<Course>>> getFavorites() async =>
      await AppUtils.safeCall(() async => await dataSource.getFavorite());

  @override
  Future<Either<Failure, void>> removeFavorite(int courseId) async =>
      await AppUtils.safeCall(
          () async => await dataSource.removeFavorite(courseId));
}
