import 'package:coachera/features/home/domain/repositories/favorite_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class AddFavoriteUc extends UseCase<void, int> {
  final FavoriteRepository repository;

  AddFavoriteUc({required this.repository});

  @override
  Future<Either<Failure, void>> call(int courseId) async =>
      await repository.addFavorite(courseId);
}
