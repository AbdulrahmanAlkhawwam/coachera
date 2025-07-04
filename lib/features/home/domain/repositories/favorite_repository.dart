import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../../../course/domain/entities/course.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Course>>> getFavorites();

  Future<Either<Failure, void>> addFavorite(int courseId);

  Future<Either<Failure, void>> removeFavorite(int courseId);
}
