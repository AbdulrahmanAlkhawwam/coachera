import 'package:coachera/features/course/domain/entities/course.dart';
import 'package:coachera/features/course/domain/entities/enrollment.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../../home/domain/param/list_param.dart';
import '../../../home/presentation/widgets/filter_sheet.dart';
import '../../domain/entities/progress.dart';
import '../../domain/repositories/course_repository.dart';
import '../data_source/course_remote_data_source.dart';

class CourseRepositoryImpl extends CourseRepository {
  final CourseRemoteDataSource dataSource;

  CourseRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Course>>> getRecommendedCourses(
          ListParam param) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getRecommendedCourses(param));

  @override
  Future<Either<Failure, Enrollment>> enroll(int courseId) async =>
      await AppUtils.safeCall(() async => await dataSource.enroll(courseId));

  @override
  Future<Either<Failure, List<Course>>> getInstructorCourses(
          int instructorId) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getInstructorCourses(instructorId));

  @override
  Future<Either<Failure, List<Progress>>> getProgress() async =>
      await AppUtils.safeCall(() async => await dataSource.getProgress());

  @override
  Future<Either<Failure, List<Course>>> getLearningPathCourses(
          int learningPathId) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getLearningPathCourses(learningPathId));
}
