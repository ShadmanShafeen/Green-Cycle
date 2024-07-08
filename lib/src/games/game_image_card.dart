import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameImageCard extends StatelessWidget {
  const GameImageCard({
    super.key,
    required this.context,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final BuildContext context;
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String path = "";
        switch (title) {
          case "GreenQuiz":
            path = '/games/quiz';
            break;
          case "TrashMania":
            path = '/games';
            break;
          case "Archive":
            path = '/games/archive';
            break;
        }
        context.go(path);
      },
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
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
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
