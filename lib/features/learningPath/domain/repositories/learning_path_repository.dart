
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../course/domain/entities/course.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/learning_path.dart';

abstract class LearningPathRepository {
  Future<Either<Failure, List<LearningPath>>> getLearningPaths(ListParam param );
  //
  // Future<Either<Failure, List<Course>>> getRecommendedCourses({
  //   int? page,
  //   required FilterData filter,
  // });

// Future<Either<Failure, void>> login(LoginParam param);

// Future<Either<Failure, void>> logout();

// Future<Either<Failure, User>> register(RegisterParam param);
// Future<Either<Failure,void>> register(RegisterParam param);

// Future<Either<Failure, bool>> otp(String passkey);

// Future<Either<Failure, bool>> checkToken();

// Future<Either<Failure, void>> saveToken(String token);
}
