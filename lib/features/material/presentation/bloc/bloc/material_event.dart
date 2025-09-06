part of 'material_bloc.dart';

@immutable
sealed class MaterialEvent {}

class GetMaterial extends MaterialEvent {
  final int materialId;

  GetMaterial({required this.materialId});
}

class SubmitQuiz extends MaterialEvent {
  final QuizParam param;

  SubmitQuiz({required this.param});
}

class CompleteLesson extends MaterialEvent {
  final CompleteLessonParam param;
  CompleteLesson({required this.param});

}
