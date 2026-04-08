import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../params/search_param.dart';
import '../repositories/search_repository.dart';

class SearchUC extends UseCase<List<dynamic>, SearchParam> {
  final SearchRepository repository;

  SearchUC({required this.repository});

  @override
  Future<Either<Failure, List<dynamic>>> call(SearchParam param) async =>
      await repository.search(param);
}
