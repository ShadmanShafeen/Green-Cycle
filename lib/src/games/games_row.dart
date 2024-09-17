import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/games/details_of_games/minesweeper.dart';
import 'package:green_cycle/src/games/details_of_games/snakeRun.dart';
import 'package:green_cycle/src/games/details_of_games/trashmania.dart';
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
      "image": "lib/assets/images/trashmania.png",
    },
    {
      "title": "Snake Run",
      "subtitle": "Eat the waste and grow",
      "image": "lib/assets/images/snake.jpg",
    },
    {
      "title": "Minesweeper",
      "subtitle": "Clear the waste from the field",
      "image": "lib/assets/images/mine.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Games to Play",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              childAspectRatio: 0.7,
            ),
            itemCount: gamesDetails.length,
            itemBuilder: (context, index) {
              return buildGameRowCard(
                context,
                gamesDetails[index]["title"]!,
                gamesDetails[index]["image"]!,
                200,
                200,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: GameImageCard(
              context: context,
              image: "lib/assets/images/archive.jpg",
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
      switch (title) {
        case "GreenQuiz":
          context.go("/games/quiz");
          break;
        case "TrashMania":
          context.go(
            "/games/game-details",
            extra: trashManiaDetails,
          );
          break;
        case "Snake Run":
          context.go(
            "/games/game-details",
            extra: snakeRunDetails,
          );
          break;
        case "Minesweeper":
          context.go(
            "/games/game-details",
            extra: minesweeperDetails,
          );
          break;
      }
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
