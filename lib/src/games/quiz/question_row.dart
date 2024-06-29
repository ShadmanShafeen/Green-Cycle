import 'package:flutter/material.dart';

class QuestionRow extends StatelessWidget {
  final String question;
  final String questionNumber;
  final int maxQuestions;
  const QuestionRow({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.maxQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: questionNumber,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " / $maxQuestions",
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryFixed
                      .withOpacity(0.7),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Divider(
          color:
              Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.2),
          thickness: 1,
        ),
        const SizedBox(height: 15),
        Text(
          question,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          textScaler: const TextScaler.linear(1),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
