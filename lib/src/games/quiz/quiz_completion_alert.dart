import 'package:flutter/material.dart';

class QuizCompletionAlert extends StatelessWidget {
  final int correctAnswersCount;
  final int maxQuestions;
  const QuizCompletionAlert({
    super.key,
    required this.correctAnswersCount,
    required this.maxQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double score = correctAnswersCount / maxQuestions * 100;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${(score).toStringAsFixed(1)}% Score",
              style: TextStyle(
                color: score >= 50
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.tertiary,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "You have answered ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: "$correctAnswersCount questions ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "correctly out of ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: "$maxQuestions questions.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "You have earned ${correctAnswersCount * 10} coins!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
