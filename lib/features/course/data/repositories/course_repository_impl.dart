import 'package:coachera/features/course/domain/entities/course.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/repositories/course_repository.dart';
import '../data_source/course_remote_data_source.dart';

class CourseRepositoryImpl extends CourseRepository {
  final CourseRemoteDataSource dataSource;

  // final CourseLocalDataSource storage;

  CourseRepositoryImpl({
    required this.dataSource,
    // required this.storage,
  });

  @override
  Future<Either<Failure, List<Course>>> getCourses({int? page}) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getCourses(page: page));

  @override
  Future<Either<Failure, List<Course>>> getRecommendedCourses(
          {int? page}) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getRecommendedCourses(page: page));

// @override
// Future<Either<Failure, bool>> checkToken() async =>
//     await AppUtils.safeCall(() => storage.checkToken());

// @override
// Future<Either<Failure, void>> deleteToken() async =>
//     await AppUtils.safeCall(() async => await storage.deleteToken());

// @override
// Future<Either<Failure, void>> login(LoginParam param) async =>
//     await AppUtils.safeCall(() async => await dataSource
//         .login(param)
//         .then((value) => storage.saveToken(value)));

// @override
// Future<Either<Failure, void>> logout() async =>
//     await AppUtils.safeCall(() async =>
//         await dataSource.logout().then((value) => storage.removeToken()));

// @override
// Future<Either<Failure, bool>> otp(String passkey) async =>
//     await AppUtils.safeCall(() async => await dataSource.otp(passkey));

// @override
// Future<Either<Failure, User>> register(RegisterParam param) async =>
//     await AppUtils.safeCall(() async => await dataSource.register(param));

// @override
// Future<Either<Failure, void>> register(RegisterParam param) async =>
//     await AppUtils.safeCall(() async => await dataSource.register(param));

// @override
// Future<Either<Failure, void>> saveToken(String token) async =>
//     await AppUtils.safeCall(() => storage.saveToken(token));
}
