import 'package:flutter/material.dart';
import 'package:green_cycle/src/games/archive/archive_card.dart';
import 'package:green_cycle/src/games/archive/archive_card_title_column.dart';
import 'package:green_cycle/src/games/archive/archive_carousel.dart';
import 'package:green_cycle/src/games/archive/archive_search_bar.dart';
import 'package:green_cycle/src/games/archive/title_row.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class ArchiveContainer extends StatelessWidget {
  ArchiveContainer({super.key});
  final List<String> archiveImages = [
    "lib/assets/images/trash.png",
    "lib/assets/images/trash2.png",
    "lib/assets/images/trash3.png",
    "lib/assets/images/trash4.png",
  ];
  final List<Map<String, String>> archiveCardTrivia = [
    {
      "title": "Plastic Bottles",
      "description":
          "Plastic bottles are one of the most common items found in landfills. They take 450 years to decompose."
              "Recycling one plastic bottle can save enough energy to power a 60-watt light bulb for up to six hours."
              "Recycling plastic bottles can save up to 1,000 gallons of water per year.",
      "image1": "lib/assets/images/bottle.png",
      "image2": "lib/assets/images/bottle1.png",
    },
    {
      "title": "Polythene Bags",
      "description":
          "Polythene bags are one of the most common items found in landfills. They take 500 years to decompose."
              "Recycling one polythene bag can save enough energy to power a 60-watt light bulb for up to six hours."
              "Recycling polythene bags can save up to 1,000 gallons of water per year.",
      "image1": "lib/assets/images/polythene.png",
      "image2": "lib/assets/images/polythene1.jpeg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const NavBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ArchiveSearchBar(),
              const SizedBox(height: 25),
              const TitleRow(),
              const SizedBox(height: 25),
              ArchiveCarousel(
                height: MediaQuery.of(context).size.height * 0.3,
                items: [
                  for (int i = 0; i < archiveImages.length; i++)
                    buildArchiveImageCard(i),
                ],
              ),
              const ArchiveCardTitleColumn(),
              const SizedBox(height: 25),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < archiveCardTrivia.length; i++)
                      ArchiveCard(
                        cardTitle: archiveCardTrivia[i]["title"]!,
                        cardText: archiveCardTrivia[i]["description"]!,
                        image1: archiveCardTrivia[i]["image1"]!,
                        image2: archiveCardTrivia[i]["image2"]!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildArchiveImageCard(int i) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(archiveImages[i]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
