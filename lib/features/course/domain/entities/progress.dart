import '../../data/model/course_model.dart';
import '../../data/model/progress_model.dart';
import 'completionState.dart';

class Progress {
  final int enrollmentId;
  final CourseModel course;
  final dynamic courseCompletion;
  final List<MaterialCompletionModel> materialCompletions;
  final double progress;

  Progress({
    required this.enrollmentId,
    required this.course,
    required this.courseCompletion,
    required this.materialCompletions,
    required this.progress,
  });
}

class MaterialCompletion {
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final int id;
  final int enrollmentId;
  final int materialId;
  final bool completed;
  // final CompletionState completionState;
  // final DateTime completionDate;
  // final TriggerType triggerType;

  MaterialCompletion({
    // required this.createdAt,
    // required this.updatedAt,
    // required this.id,
    required this.enrollmentId,
    required this.materialId,
    required this.completed,
    // required this.completionState,
    // required this.completionDate,
    // required this.triggerType,
  });
}
