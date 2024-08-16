import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';

import 'game_image_card.dart';

class TopImageCarousel extends StatefulWidget {
  const TopImageCarousel({super.key});

  @override
  State<TopImageCarousel> createState() => _TopImageCarouselState();
}

class _TopImageCarouselState extends State<TopImageCarousel> {
  int _currentGameCard = 0;
  late final carousel_slider.CarouselController _carouselController;
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
      "title": "Archive",
      "subtitle": "Know before you throw",
      "image": "lib/assets/images/archive.jpeg",
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
  void initState() {
    super.initState();
    _carouselController = carousel_slider.CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carousel_slider.CarouselSlider(
            carouselController: _carouselController,
            items: [
              ...gamesDetails.map(
                (game) => GameImageCard(
                  context: context,
                  image: game["image"]!,
                  title: game["title"]!,
                  subtitle: game["subtitle"]!,
                ),
              ),
            ],
            options: carousel_slider.CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentGameCard = index;
                });
              },
            ),
          ),
          buildCarouselDots(),
        ],
      ),
    );
  }

  Container buildCarouselDots() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < gamesDetails.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              margin: EdgeInsets.symmetric(
                  horizontal: _currentGameCard == i ? 6 : 3),
              height: 8,
              width: i == _currentGameCard ? 40 : 20,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: i == _currentGameCard
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
