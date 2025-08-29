class QuizParam {
  final int quizId;

  final List<Map<String, dynamic>> questions;

  QuizParam({
    required this.questions,
    required this.quizId,
  });
}
