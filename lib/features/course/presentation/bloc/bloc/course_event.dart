part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

class GetCoursesPaginated extends CourseEvent {
  final int page;
  final bool reset;

  GetCoursesPaginated({
    required this.page,
    required this.reset,
  });
}

class GetRecommendedCourses extends CourseEvent {
  final ListParam param;

  GetRecommendedCourses({required this.param});
}

class EnrollCourse extends CourseEvent {
  final int courseId;

  EnrollCourse({required this.courseId});
}

class GetInstructorCourses extends CourseEvent {
  final int instructorId ;

  GetInstructorCourses({required this.instructorId});
}
