import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/material/domain/param/quiz_param.dart';
import 'package:flutter/material.dart' hide Material, MaterialState;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/question_indecator.dart';
import '../../domain/entities/material.dart';
import '../bloc/bloc/material_bloc.dart';

class QuizLessonScreen extends StatefulWidget {
  final Material quiz;

  const QuizLessonScreen({super.key, required this.quiz});

  @override
  State<QuizLessonScreen> createState() => _QuizLessonScreenState();
}

class _QuizLessonScreenState extends State<QuizLessonScreen> {
  int currentIndex = 0;
  final Map<int, int> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    final questions = widget.quiz.quiz!.questions.reversed.toList();
    final question = questions[currentIndex];
    final answers = question.answers;

    return BlocConsumer<MaterialBloc, MaterialState>(
      listener: (context, state) {
        if (state.status == MaterialStatus.success) {
          context.pop();
        }
        if (state.status == MaterialStatus.error) {
          context.showErrorSnackBar(massage: state.message);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Question ${currentIndex + 1} / ${questions.length}",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            top: 8,
            bottom: context.bottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizIndicator(
                currentIndex: currentIndex,
                total: questions.length,
              ),
              const SizedBox(height: 20),
              Card(
                color: context.colors.primaryContainer,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: context.colors.primary),
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    question.content,
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...answers.asMap().entries.map((entry) {
                final idx = entry.key;
                final text = entry.value;

                if (text == null) return const SizedBox.shrink();

                final isSelected = userAnswers[question.id] == idx;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        userAnswers[question.id] = idx;
                      });
                    },
                    child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? context.colors.secondary
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      color: isSelected
                          ? context.colors.onSecondary
                          : context.colors.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? context.colors.secondary
                                : context.colors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: userAnswers[question.id] == null
                    ? null
                    : () {
                        if (currentIndex < questions.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          final questionsPayload = userAnswers.entries.map((e) {
                            return {
                              "questionId": e.key,
                              "answerIndex": e.value,
                            };
                          }).toList();

                          context.read<MaterialBloc>().add(
                                SubmitQuiz(
                                  param: QuizParam(
                                    quizId: widget.quiz.id,
                                    questions: questionsPayload,
                                  ),
                                ),
                              );
                        }
                      },
                child: Text(
                  currentIndex == questions.length - 1 ? "Finish" : "Submit",
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: context.colors.onSecondary),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
