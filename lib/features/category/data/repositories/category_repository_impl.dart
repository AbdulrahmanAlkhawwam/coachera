import 'package:coachera/features/category/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../../home/domain/param/list_param.dart';
import '../../domain/repositories/category_repository.dart';
import '../data_source/category_remote_data_source.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryRemoteDataSource dataSource;

  CategoryRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories(ListParam param) async {
    return await AppUtils.safeCall(
        () async => await dataSource.getCategories(param));
  }
}
