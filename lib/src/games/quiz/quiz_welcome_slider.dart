import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/src/games/quiz/quiz_welcome_slider_card.dart';

class QuizWelcomeSlider extends StatefulWidget {
  const QuizWelcomeSlider({super.key});

  @override
  State<QuizWelcomeSlider> createState() => _QuizWelcomeSliderState();
}

class _QuizWelcomeSliderState extends State<QuizWelcomeSlider> {
  int _currentQuizCard = 0;
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: [
              for (int i = 0; i < sliderDetails.length; i++)
                QuizWelcomeSliderCard(
                  title: sliderDetails[i]["title"],
                  questions: int.tryParse(sliderDetails[i]["questions"]!),
                  image: sliderDetails[i]["image"],
                  progress: int.tryParse(sliderDetails[i]["progress"]!),
                ),
            ],
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentQuizCard = index;
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
          for (int i = 0; i < sliderDetails.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              margin: EdgeInsets.symmetric(
                  horizontal: _currentQuizCard == i ? 6 : 3),
              height: 8,
              width: i == _currentQuizCard ? 40 : 20,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: i == _currentQuizCard
                    ? Theme.of(context).colorScheme.primaryFixed
                    : Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
