import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/games/game_image_card.dart';

class GamesRow extends StatelessWidget {
  GamesRow({super.key});
  final List<Map<String, String>> gamesDetails = [
    {
      "title": "GreenQuiz",
      "subtitle": "Test your knowledge on sustainability and recycling",
      "image": "lib/assets/images/quiz.jpg",
    },
    {
      "title": "TrashMania",
      "subtitle": "Sort the waste into the correct bins",
      "image": "lib/assets/images/trash.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final game in gamesDetails)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildGameRowCard(
                      context,
                      game["title"]!,
                      game["image"]!,
                      180,
                      200,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: GameImageCard(
              context: context,
              image: "lib/assets/images/archive2.jpeg",
              title: "Archive",
              subtitle: "Know more about recycling",
            ),
          ),
        ],
      ),
    );
  }
}

InkWell buildGameRowCard(BuildContext context, String title, String image,
    double width, double height) {
  return InkWell(
    onTap: () {
      String path = title == "GreenQuiz" ? "/games/quiz" : "/games";
      context.go(path);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
