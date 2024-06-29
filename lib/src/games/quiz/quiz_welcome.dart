import 'package:flutter/material.dart';
import 'package:green_cycle/src/games/quiz/quiz_welcome_slider.dart';
import 'package:green_cycle/src/games/quiz/quiz_welcome_top_row.dart';
import 'package:green_cycle/src/games/quiz/unfinished_quizes.dart';

class QuizWelcome extends StatelessWidget {
  const QuizWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const QuizWelcomeTopRow(),
            const SizedBox(height: 16),
            const QuizWelcomeSlider(),
            UnfinishedQuizzes(),
          ],
        ),
      ),
    );
  }
}
