import 'package:flutter/material.dart';
import 'package:green_cycle/src/my_community_view/member-circle.dart';
import 'package:green_cycle/src/my_community_view/members.dart';

class MyCommunity extends StatelessWidget {
  const MyCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Community'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            topCard(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (BuildContext context, int index) {
                  return viewListItem(index, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewListItem(int index, BuildContext context) {
    return Card(
      color: const Color(0xFF2C2C2C).withOpacity(0.7),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(members[index].image),
        ),
        title: Text(
          members[index].name,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '${members[index].points}',
          style:
              TextStyle(color: Theme.of(context).colorScheme.secondaryFixedDim),
        ),
        trailing: Text(
          '${members.length - index + 3}',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primaryFixed, fontSize: 18),
        ),
      ),
    );
  }

  Card topCard() {
    return Card(
      color: const Color(0xFF2C2C2C).withOpacity(0.7),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Members',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MemberCircle(
                imageUrl:
                    'assets/img/avatar2.png', // Replace with actual image URL
                name: 'Alex Turner',
                points: '450 pts',
                rank: 2,
              ),
              MemberCircle(
                imageUrl:
                    'assets/img/avatar1.png', // Replace with actual image URL
                name: 'Bryan Wolf',
                points: '542 pts',
                rank: 1,
                isTopMember: true,
              ),
              MemberCircle(
                imageUrl:
                    'assets/img/avatar3.png', // Replace with actual image URL
                name: 'Nick Burg',
                points: '312 pts',
                rank: 3,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
