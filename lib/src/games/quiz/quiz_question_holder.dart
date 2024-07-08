import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/games/quiz/linear_timer.dart';
import 'package:green_cycle/src/games/quiz/question_row.dart';
import 'package:green_cycle/src/games/quiz/quiz_completion_alert.dart';
import 'package:green_cycle/src/games/quiz/quiz_questions.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class QuizQuestionHolder extends StatefulWidget {
  final String questionCategory;
  const QuizQuestionHolder({super.key, required this.questionCategory});

  @override
  State<QuizQuestionHolder> createState() => _QuizQuestionHolderState();
}

class _QuizQuestionHolderState extends State<QuizQuestionHolder> {
  late final List<Map<String, dynamic>>? questions;
  ValueKey<int> timerKey = const ValueKey(0);
  int questionNumber = 0;
  String checkedAnswer = "";
  bool isCorrect = false;
  bool isAnswered = false;
  int correctAnswersCount = 0;
  int maxQuestions = 5;

  @override
  void initState() {
    super.initState();
    final tempQuestions = quizQuestions[widget.questionCategory];
    tempQuestions?.shuffle();
    questions = tempQuestions?.sublist(0, maxQuestions);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey("quiz_question_holder"),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LinearTimer(
              key: timerKey,
              maxSeconds: 10,
              onTimerEnd: () {
                setState(() {
                  isAnswered = true;
                  isCorrect = true;
                  checkedAnswer = questions?[questionNumber]["correct"];
                });

                Future.delayed(const Duration(seconds: 1), () {
                  if (questionNumber < maxQuestions - 1) {
                    setState(() {
                      checkedAnswer = "";
                      isAnswered = false;
                      isCorrect = false;
                      questionNumber++;
                      timerKey = ValueKey<int>(questionNumber);
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return QuizCompletionAlert(
                          correctAnswersCount: correctAnswersCount,
                          maxQuestions: maxQuestions,
                        );
                      },
                    );

                    Future.delayed(const Duration(seconds: 1), () {
                      context.go('/games/quiz');
                    });
                  }
                });
              },
            ),
            const SizedBox(height: 40),
            QuestionRow(
              question: questions?[questionNumber]["question"],
              questionNumber: "Question ${questionNumber + 1}",
              maxQuestions: maxQuestions,
            ),
            const SizedBox(height: 70),
            buildOptions(context),
            const SizedBox(height: 30),
            buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Column buildOptions(BuildContext context) {
    return Column(
      children: questions?[questionNumber]["options"].map<Widget>(
            (option) {
              return Column(
                children: [
                  CheckboxListTile(
                    activeColor:
                        Theme.of(context).colorScheme.surfaceContainerLowest,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withOpacity(0.5),
                    ),
                    tileColor: (checkedAnswer == option)
                        ? isAnswered
                            ? isCorrect
                                ? Colors.green
                                : Colors.red
                            : Theme.of(context).colorScheme.primaryFixed
                        : Theme.of(context).colorScheme.surfaceContainerHigh,
                    title: Text(option),
                    value: checkedAnswer == option,
                    onChanged: (bool? value) {
                      if (!isAnswered) {
                        setState(() {
                          checkedAnswer = option;
                          if (checkedAnswer ==
                              questions?[questionNumber]["correct"]) {
                            isCorrect = true;
                            correctAnswersCount++;
                          } else {
                            isCorrect = false;
                          }
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ).toList() ??
          [],
    );
  }

  Container buildNextButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        onPressed: () {
          if (checkedAnswer.isEmpty) {
            final snackBar = createSnackBar(
              title: "Warning",
              message: "Select an option",
              contentType: "failure",
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
            return;
          }

          if (checkedAnswer.isNotEmpty) {
            if (questionNumber < maxQuestions - 1) {
              setState(() {
                isAnswered = true;
              });
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  questionNumber++;
                  checkedAnswer = "";
                  isAnswered = false;
                  timerKey = ValueKey<int>(questionNumber);
                });
              });
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return QuizCompletionAlert(
                    correctAnswersCount: correctAnswersCount,
                    maxQuestions: maxQuestions,
                  );
                },
              );
              Future.delayed(const Duration(seconds: 1), () {
                context.go('/games/quiz');
              });
            }
          }
        },
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.primaryFixed.withOpacity(0.5),
          ),
          backgroundColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.tertiary,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Text(
          questionNumber < (maxQuestions - 1) ? "Next" : "Submit",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryFixed,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
