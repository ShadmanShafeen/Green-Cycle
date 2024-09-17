import 'package:flutter/material.dart';
import 'package:green_cycle/src/games/quiz/quiz_welcome_slider.dart';
import 'package:green_cycle/src/games/quiz/unfinished_quizes.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

import '../../widgets/coins_container.dart';

class QuizWelcome extends StatelessWidget {
  const QuizWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildWelcomeAppbar(context),
      bottomNavigationBar: const NavBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuizWelcomeSlider(),
              UnfinishedQuizzes(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildWelcomeAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      centerTitle: true,
      title: Text(
        "Welcome to GreenQuiz",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      actions: const [
        CoinsContainer(),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
