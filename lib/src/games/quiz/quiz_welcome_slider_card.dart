import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizWelcomeSliderCard extends StatefulWidget {
  final String? title;
  final int? questions;
  final String? image;
  final int? progress;
  const QuizWelcomeSliderCard({
    super.key,
    required this.title,
    required this.questions,
    required this.image,
    required this.progress,
  });

  @override
  State<QuizWelcomeSliderCard> createState() => _QuizWelcomeSliderCardState();
}

class _QuizWelcomeSliderCardState extends State<QuizWelcomeSliderCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressBarController;

  @override
  void initState() {
    super.initState();
    _progressBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _progressBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          "quiz-question",
          pathParameters: {
            "questionCategory": widget.title!,
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(
                widget.image!,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.questions} Questions",
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: LinearProgressIndicator(
                        value: widget.progress! / widget.questions!,
                        backgroundColor: Colors.white.withOpacity(0.5),
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).colorScheme.primaryFixed,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
