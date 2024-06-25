import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/games/top_image_carousel.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: const NavBar(),
      appBar: buildAppBar(context),
      body: Column(
        children: [
          TopImageCarousel(),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.all(0),
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.all(Colors.white38),
        ),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            context.go('/home');
          }
        },
      ),
      actions: const [
        Icon(Icons.search, color: Colors.white),
        SizedBox(width: 20),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            color: Colors.black54,
          ),
        ),
        SizedBox(width: 20),
      ],
      actionsIconTheme: const IconThemeData(size: 25, color: Colors.white),
    );
  }
}
