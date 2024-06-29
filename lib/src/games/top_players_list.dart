import 'package:flutter/material.dart';

class TopPlayersList extends StatelessWidget {
  TopPlayersList({super.key});
  final List<Map<String, String>> topPlayersDetails = [
    {
      "name": "Player 1",
      "image": "lib/assets/images/playerAvatar.jpeg",
      "coins": "1000",
      "badge": "lib/assets/images/Gold.png",
    },
    {
      "name": "Player 2",
      "image": "lib/assets/images/playerAvatar.jpeg",
      "coins": "900",
      "badge": "lib/assets/images/Silver.png",
    },
    {
      "name": "Player 3",
      "image": "lib/assets/images/playerAvatar.jpeg",
      "coins": "800",
      "badge": "lib/assets/images/Bronze.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Players",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: topPlayersDetails.length,
              itemBuilder: (context, index) {
                return buildTopPlayerCard(
                  context,
                  topPlayersDetails[index]["name"]!,
                  topPlayersDetails[index]["image"]!,
                  index,
                  index + 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Card buildTopPlayerCard(
      BuildContext context, String s, String t, int i, int j) {
    return Card(
      color:
          Theme.of(context).colorScheme.surfaceContainerHigh.withOpacity(0.7),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(topPlayersDetails[i]["image"]!),
        ),
        title: Text(topPlayersDetails[i]["name"]!),
        subtitle: Row(
          children: [
            Image.asset(
              "lib/assets/images/coin.png",
            ),
            const SizedBox(width: 5),
            Text(topPlayersDetails[i]["coins"]!),
          ],
        ),
        trailing: Image.asset(
          topPlayersDetails[i]["badge"]!,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
