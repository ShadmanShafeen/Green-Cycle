import 'package:flutter/material.dart';
import 'package:green_cycle/src/games/games_row.dart';
import 'package:green_cycle/src/games/top_image_carousel.dart';
import 'package:green_cycle/src/games/top_players_list.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TopImageCarousel(),
            const SizedBox(height: 16),
            GamesRow(),
            TopPlayersList(),
          ],
        ),
      ),
    );
  }
}
