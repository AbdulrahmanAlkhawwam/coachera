part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

class GetCoursesPaginated extends CourseEvent {
  final int page;
  final Completer<List<Course>> completer;

  GetCoursesPaginated({
    required this.page,
    required this.completer,
  });
}
