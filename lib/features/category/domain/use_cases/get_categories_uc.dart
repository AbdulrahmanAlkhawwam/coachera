import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUC extends UseCase<List<Category>, ListParam> {
  final CategoryRepository repository;

  GetCategoriesUC({required this.repository});

  @override
  Future<Either<Failure, List<Category>>> call(ListParam param) async =>
      await repository.getCategories(param);
}
