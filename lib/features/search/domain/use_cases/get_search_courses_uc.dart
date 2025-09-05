import 'package:coachera/features/search/domain/params/search_param.dart';
import 'package:coachera/features/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../course/domain/entities/course.dart';

class GetSearchCoursesUc extends UseCase<List<Course>, SearchParam> {
  final SearchRepository repository;

  GetSearchCoursesUc({required this.repository});

  @override
  Future<Either<Failure, List<Course>>> call(SearchParam param) async =>
      await repository.searchCourses(param);
}
