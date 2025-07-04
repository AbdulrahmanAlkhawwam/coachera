import 'package:coachera/features/home/domain/repositories/favorite_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../course/domain/entities/course.dart';

class DeleteFavoriteUc extends UseCase<void, int> {
  final FavoriteRepository repository;

  DeleteFavoriteUc({required this.repository});

  @override
  Future<Either<Failure, void>> call(int courseId) async =>
      await repository.removeFavorite(courseId);
}
