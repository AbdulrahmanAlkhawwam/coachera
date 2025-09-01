import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

// import '../../../home/domain/entities/user.dart';
import '../../../home/domain/param/list_param.dart';
import '../../../home/presentation/widgets/filter_sheet.dart';
import '../entities/course.dart';
import '../entities/enrollment.dart';
import '../entities/progress.dart';

abstract class CourseRepository {
  // Future<Either<Failure, List<Course>>> getCourses({int? page});

  Future<Either<Failure, List<Course>>> getRecommendedCourses(ListParam param);

  Future<Either<Failure, Enrollment>> enroll(int courseId);

  Future<Either<Failure, List<Course>>> getInstructorCourses(int instructorId);

  Future<Either<Failure, List<Course>>> getLearningPathCourses (int learningPathId);

  Future<Either<Failure, List<Progress>>> getProgress();

// Future<Either<Failure, void>> login(LoginParam param);

// Future<Either<Failure, void>> logout();

// Future<Either<Failure, User>> register(RegisterParam param);
// Future<Either<Failure,void>> register(RegisterParam param);

// Future<Either<Failure, bool>> otp(String passkey);

// Future<Either<Failure, bool>> checkToken();

// Future<Either<Failure, void>> saveToken(String token);
}
