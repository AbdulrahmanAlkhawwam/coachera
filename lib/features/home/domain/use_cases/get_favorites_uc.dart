import 'package:coachera/features/home/domain/repositories/favorite_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../course/domain/entities/course.dart';

class GetFavoritesUc extends UseCaseNoParam<List<Course>> {
  final FavoriteRepository repository;

  GetFavoritesUc({required this.repository});

  @override
  Future<Either<Failure, List<Course>>> call() async =>
      await repository.getFavorites();
}
