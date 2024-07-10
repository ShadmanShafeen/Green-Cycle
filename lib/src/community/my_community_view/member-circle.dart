import 'package:flutter/material.dart';

class MemberCircle extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String points;
  final int rank;
  final bool isTopMember;

  const MemberCircle({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.points,
    required this.rank,
    this.isTopMember = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: isTopMember ? 50 : 40,
              backgroundImage: AssetImage(imageUrl),
            ),
            Positioned(
              bottom: isTopMember ? -2 : -3,
              left: isTopMember ? 27 : 21,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: const Color.fromARGB(255, 101, 247, 196),
                child: Text(
                  rank.toString(),
                  style: const TextStyle(
                    color: Color(0xFF8844F0),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (isTopMember)
              Positioned(
                top: -1.5,
                left: 27,
                child: Image.asset(
                  'lib/assets/img/crown.png',
                  height: 30,
                  width: 30,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.rocket_launch,
              color: Color.fromARGB(255, 232, 216, 71),
              size: 15,
            ),
            Text(
              points,
              style: const TextStyle(
                color: Color(0xFF40BF58),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
