import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/models/goals.dart';

import '../../widgets/styled-text2.dart';

class CommunityGoals extends StatefulWidget {
  const CommunityGoals({super.key});

  @override
  State<CommunityGoals> createState() => _CommunityGoalsState();
}

class _CommunityGoalsState extends State<CommunityGoals> {
  @override
  Widget build(BuildContext context) {
    int completedGoalsCount = 0;
    for (var goal in goals) {
      if (goal.isCompleted == true) {
        completedGoalsCount++;
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            goalsImageCard(context),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledText2('Reach these'),
                Text(
                  'Goals for your next waste pickup',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: goals[index].isCompleted
                        ? Theme.of(context)
                            .colorScheme
                            .secondaryFixedDim
                            .withOpacity(0.7)
                        : Theme.of(context)
                            .colorScheme
                            .surfaceContainerHigh
                            .withOpacity(0.7),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: Text(
                        goals[index].isCompleted
                            ? 'Goal ${index + 1} Completed!'
                            : 'Goal ${index + 1}',
                        style: TextStyle(
                          color: goals[index].isCompleted
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.secondaryFixedDim,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(
                                goals[index].description,
                                style: TextStyle(
                                  color: goals[index].isCompleted
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                '${goals[index].current_weight}kg / ${goals[index].total_weight}kg',
                                style: TextStyle(
                                  color: goals[index].isCompleted
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: LinearProgressIndicator(
                            minHeight: 5.0,
                            value: (goals[index].current_weight) /
                                (goals[index].total_weight),
                            color: goals[index].isCompleted
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondaryFixedDim
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Completed $completedGoalsCount / ${goals.length}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                ),
                onPressed: () {},
                child: Text(
                  (completedGoalsCount == goals.length)
                      ? 'Ready for Pickup'
                      : 'Not ready for pickup',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card goalsImageCard(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage('lib/assets/images/recy1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.1),
              ],
            ),
          ),
          child: Row(
            children: [
              Text(
                'Community goals',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
