import 'package:flutter/material.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';

class QuizWelcomeTopRow extends StatelessWidget {
  const QuizWelcomeTopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Welcome to GreenQuiz",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const CoinsContainer(
          coins: 1200,
        ),
      ],
    );
  }
}
