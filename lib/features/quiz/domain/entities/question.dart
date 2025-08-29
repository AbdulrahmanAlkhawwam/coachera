class Question {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int quizId;
  final String content;
  final String? firstAnswer;
  final String? secondAnswer;
  final String? thirdAnswer;
  final String? forthAnswer;

  Question({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.quizId,
    required this.content,
    required this.firstAnswer,
    required this.secondAnswer,
    required this.thirdAnswer,
    required this.forthAnswer,
  });

  List<String?> get answers => [
        firstAnswer,
        secondAnswer,
        thirdAnswer,
        forthAnswer,
      ];
}
