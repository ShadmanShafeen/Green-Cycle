import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameDetails extends StatefulWidget {
  final Map<String, String> gameDetails;
  const GameDetails({super.key, required this.gameDetails});

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  bool isHeartFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildClipRRect(),
            const SizedBox(height: 20),
            buildRatingPlayCardContainer(),
            const SizedBox(height: 20),
            buildPlayButton(),
            const SizedBox(height: 20),
            buildNameTag(),
          ],
        ),
      ),
    );
  }

  ClipRRect buildClipRRect() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      child: Image.asset(
        widget.gameDetails['image']!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
      ),
    );
  }

  Row buildRatingPlayCardContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildRatingCard(),
        buildPlayCard(),
      ],
    );
  }

  SizedBox buildPlayButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: () {
          if (widget.gameDetails['route'] != null) {
            context.go(widget.gameDetails['route']!);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Play',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.inverseSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container buildRatingCard() {
    return Container(
      width: 115,
      height: 115,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.star,
            size: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 5),
          const Text(
            'Rating',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          Text(
            '${widget.gameDetails["rating"]}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Container buildPlayCard() {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.play_arrow,
            size: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 5),
          const Text(
            'Play',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${widget.gameDetails["playCount"]}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Container buildNameTag() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'About ${widget.gameDetails["name"]}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.gameDetails['description']!,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: 30,
          weight: 700,
        ),
        color: Theme.of(context).colorScheme.onSurface,
        onPressed: () {
          context.pop();
        },
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(
              isHeartFilled ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isHeartFilled = !isHeartFilled;
              });
            },
          ),
        ),
        const SizedBox(width: 20),
      ],
      backgroundColor: Colors.transparent,
    );
  }
}
