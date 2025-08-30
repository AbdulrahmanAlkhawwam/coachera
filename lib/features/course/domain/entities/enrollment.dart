import '../../data/model/enrollment_model.dart';

class Enrollment {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int courseId;
  final int studentId;
  final CourseCompletionModel courseCompletion;
  final List<dynamic> materialCompletions;

  Enrollment({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.courseId,
    required this.studentId,
    required this.courseCompletion,
    required this.materialCompletions,
  });
}

class CourseCompletion {
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic id;
  final int enrollmentId;
  final int progress;
  final bool completed;
  final dynamic completionDate;

  CourseCompletion({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.enrollmentId,
    required this.progress,
    required this.completed,
    required this.completionDate,
  });
}
