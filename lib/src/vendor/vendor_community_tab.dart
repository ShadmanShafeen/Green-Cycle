// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/community/my_community_view/member-circle.dart';
import 'package:green_cycle/src/models/members.dart';
import 'package:green_cycle/src/vendor/vendor_widgets/member_add_modal.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';

class VendorCommunityTab extends StatelessWidget {
  const VendorCommunityTab({super.key});
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/img/my_com_bg.jpg',
            ),
            fit: BoxFit.cover,
            opacity: .5,
          ),
        ),
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 350, child: topCard(context)),
            const SizedBox(
              height: 10,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            showDragHandle: true,
            context: context,
            builder: (ctx) => const MemberAddModal(),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget viewListItem(int index, BuildContext context) {
    return Card(
      color: const Color(0xFF2C2C2C).withOpacity(0.7),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
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
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                )
              : TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
        ),
        subtitle: Text(
          '${members[index].points} coins',
          style: isUser(members[index].name)
              ? TextStyle(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  fontWeight: FontWeight.bold,
                )
              : TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
        ),
        trailing: Text(
          '${index + 4}',
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary, fontSize: 18),
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
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/img/leaderboard_bg3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0),
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'My Community Members',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.logout,
                  //     color: Colors.white,
                  //   ),
                  //   onPressed: () {},
                  // ),
                ],
              ),
              MemberCircle(
                imageUrl: 'lib/assets/img/avatar1.png',
                name: 'Bryan Wolf',
                points: '542 coins',
                rank: 1,
                isTopMember: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MemberCircle(
                    imageUrl: 'lib/assets/img/avatar2.png',
                    name: 'Alex Turner',
                    points: '450 coins',
                    rank: 2,
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  MemberCircle(
                    imageUrl: 'lib/assets/img/avatar3.png',
                    name: 'Nick Burg',
                    points: '312 coins',
                    rank: 3,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: FilledButton(
                      onPressed: () {
                        context.go('/home/community-explore/com-goals');
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromARGB(240, 136, 68, 240),
                        ),
                        fixedSize: WidgetStatePropertyAll<Size>(
                          Size.fromWidth(200),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Goals',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: FilledButton(
                      onPressed: () {
                        context
                            .go('/home/community-explore/community-calender');
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromARGB(240, 136, 68, 240),
                        ),
                        fixedSize: WidgetStatePropertyAll<Size>(
                          Size.fromWidth(200),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Schedule',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
