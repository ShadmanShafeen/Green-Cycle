import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/community/my_community_view/member-circle.dart';
import 'package:green_cycle/src/models/members.dart';

class MyCommunity extends StatelessWidget {
  const MyCommunity({super.key});
  bool isUser(String name) {
    if (name == 'You') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            topCard(context),
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
        tileColor: isUser(members[index].name)
            ? Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.8)
            : Theme.of(context)
                .colorScheme
                .surfaceContainerHigh
                .withOpacity(0.7),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(members[index].image),
        ),
        title: Text(
          members[index].name,
          style: isUser(members[index].name)
              ? TextStyle(
                  color: Theme.of(context).colorScheme.secondaryFixed,
                  fontWeight: FontWeight.bold,
                )
              : TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  fontWeight: FontWeight.bold,
                ),
        ),
        subtitle: Text(
          '${members[index].points}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          '${members.length - index + 3}',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primaryFixed, fontSize: 18),
        ),
      ),
    );
  }

  Card topCard(BuildContext context) {
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MemberCircle(
                imageUrl:
                    'lib/assets/img/avatar2.png', // Replace with actual image URL
                name: 'Alex Turner',
                points: '450 pts',
                rank: 2,
              ),
              MemberCircle(
                imageUrl:
                    'lib/assets/img/avatar1.png', // Replace with actual image URL
                name: 'Bryan Wolf',
                points: '542 pts',
                rank: 1,
                isTopMember: true,
              ),
              MemberCircle(
                imageUrl:
                    'lib/assets/img/avatar3.png', // Replace with actual image URL
                name: 'Nick Burg',
                points: '312 pts',
                rank: 3,
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  context.go('/home/community-explore/com-goals');
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Color.fromARGB(255, 136, 68, 240),
                  ),
                  fixedSize: WidgetStatePropertyAll<Size>(
                    Size.fromWidth(200),
                  ),
                ),
                child: const Center(
                  child: Text('Goals'),
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.event_note),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
