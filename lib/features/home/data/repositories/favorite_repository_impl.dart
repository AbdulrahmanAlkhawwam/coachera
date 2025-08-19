import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../../course/domain/entities/course.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../data_source/favorite_local_data_source.dart';
import '../data_source/favorite_remote_data_source.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  final FavoriteRemoteDataSource dataSource;
  final FavoriteLocalDataSource storage;

  FavoriteRepositoryImpl({
    required this.dataSource,
    required this.storage,
  });

  @override
  Future<Either<Failure, void>> addFavorite(int courseId) async =>
      await AppUtils.safeCall(
          () async => await dataSource.addFavorite(courseId));

  @override
  Future<Either<Failure, List<Course>>> getFavorites() async =>
      await AppUtils.safeCall(() async => await dataSource
          .getFavorites()
          .then((courses) => storage.enterCourses(courses)));

  @override
  Future<Either<Failure, void>> removeFavorite(int courseId) async =>
      await AppUtils.safeCall(
          () async => await dataSource.removeFavorite(courseId));

  @override
  Future<Either<Failure, bool>> getFavorite(int courseId) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getFavorite(courseId));
}
