import 'package:flutter/material.dart';
import 'package:green_cycle/src/games/quiz/unfinished_quiz_card.dart';

class UnfinishedQuizzes extends StatelessWidget {
  UnfinishedQuizzes({super.key});
  final List<Map<String, String>> sliderDetails = [
    {
      "title": "Recycling Quiz",
      "questions": "20",
      "image": "lib/assets/images/recy1.png",
      "progress": "15",
    },
    {
      "title": "Nature Trivia",
      "questions": "15",
      "image": "lib/assets/images/recy2.png",
      "progress": "10",
    },
    {
      "title": "Waste Classification",
      "questions": "20",
      "image": "lib/assets/images/recy3.png",
      "progress": "5",
    },
    {
      "title": "Sustainability and Reusability",
      "questions": "20",
      "image": "lib/assets/images/trash.png",
      "progress": "7",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final List<Color> randomColors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.primaryFixed,
      Theme.of(context).colorScheme.tertiary,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Unfinished Quizzes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 310,
          child: ListView.builder(
            itemCount: sliderDetails.length,
            itemBuilder: (context, index) {
              return UnfinishedQuizCard(
                color: randomColors[index],
                image: sliderDetails[index]["image"]!,
                title: sliderDetails[index]["title"]!,
                questions: int.parse(sliderDetails[index]["questions"]!),
                progress: int.parse(sliderDetails[index]["progress"]!),
              );
            },
          ),
        ),
      ],
    );
  }
}
