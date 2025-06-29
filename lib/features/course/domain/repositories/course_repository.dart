
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
// import '../../../home/domain/entities/user.dart';
import '../entities/course.dart';
import '../params/login_param.dart';
abstract class CourseRepository {

  Future<Either<Failure, List<Course>>> getCourses({int? page});

  // Future<Either<Failure, void>> login(LoginParam param);

  // Future<Either<Failure, void>> logout();

  // Future<Either<Failure, User>> register(RegisterParam param);
  // Future<Either<Failure,void>> register(RegisterParam param);

  // Future<Either<Failure, bool>> otp(String passkey);

  // Future<Either<Failure, bool>> checkToken();

  // Future<Either<Failure, void>> saveToken(String token);

 }
