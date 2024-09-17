import 'package:flutter/material.dart';
import 'package:green_cycle/src/games/games_row.dart';
import 'package:green_cycle/src/games/top_image_carousel.dart';
import 'package:green_cycle/src/games/top_players_list.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const NavBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
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
      ),
    );
  }
}
