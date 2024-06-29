import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";

class ArchiveCarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final double viewPortFraction;
  const ArchiveCarousel({
    super.key,
    required this.items,
    required this.height,
    this.viewPortFraction = 0.8,
  });

  @override
  State<ArchiveCarousel> createState() => _ArchiveCarouselState();
}

class _ArchiveCarouselState extends State<ArchiveCarousel> {
  int _currentArchiveCard = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: widget.items,
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              enlargeCenterPage: true,
              viewportFraction: widget.viewPortFraction,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentArchiveCard = index;
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < widget.items.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              margin: EdgeInsets.symmetric(
                  horizontal: _currentArchiveCard == i ? 6 : 3),
              height: 8,
              width: i == _currentArchiveCard ? 40 : 20,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: i == _currentArchiveCard
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
