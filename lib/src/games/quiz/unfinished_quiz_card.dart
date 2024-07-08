import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/games/quiz/percentage_progress_indicator.dart';

class UnfinishedQuizCard extends StatefulWidget {
  final String image;
  final String title;
  final int questions;
  final int progress;
  final Color color;
  const UnfinishedQuizCard({
    super.key,
    required this.image,
    required this.title,
    required this.questions,
    required this.progress,
    required this.color,
  });

  @override
  State<UnfinishedQuizCard> createState() => _UnfinishedQuizCardState();
}

class _UnfinishedQuizCardState extends State<UnfinishedQuizCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Container(
        alignment: Alignment.center,
        height: 90,
        child: ListTile(
          onTap: () {
            context.goNamed(
              "quiz-question",
              pathParameters: {
                "questionCategory": widget.title,
              },
            );
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage(widget.image),
            radius: 30,
          ),
          trailing: PercentageProgressIndicator(
            progress: widget.progress / widget.questions,
            color: widget.color,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          subtitle: Text(
            "${widget.questions} Questions",
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
