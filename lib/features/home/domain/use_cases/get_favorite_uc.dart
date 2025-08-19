
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/favorite_repository.dart';

class GetFavoriteUC extends UseCase<bool, int> {
  final FavoriteRepository repository;

  GetFavoriteUC({required this.repository});

  @override
  Future<Either<Failure, bool>> call(int courseId) async =>
      await repository.getFavorite(courseId);
}
