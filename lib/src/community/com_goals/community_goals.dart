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
  bool customIcon = false;

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
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHigh
                  .withOpacity(0.7),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 150,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: AssetImage('lib/assets/img/goals_bg.png'),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Community goals',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryFixedDim,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      IconButton(
                        onPressed: () {
                          context.go('/my_com');
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.primaryFixedDim,
                        ),
                      ),
                    ],
                  )),
            ),
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
                      trailing: Icon(
                        customIcon
                            ? Icons.arrow_drop_down_circle_rounded
                            : Icons.arrow_drop_down_circle_outlined,
                        color: Theme.of(context).colorScheme.secondaryFixedDim,
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
                                '${goals[index].quantity} / ${goals[index].total}',
                                style: TextStyle(
                                  color: goals[index].isCompleted
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                goals[index].isCompleted ? 'Completed!' : '',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: LinearProgressIndicator(
                            minHeight: 5.0,
                            value:
                                (goals[index].quantity) / (goals[index].total),
                            color: goals[index].isCompleted
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondaryFixedDim
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          customIcon = expanded;
                        });
                      },
                    ),
                  );
                },
              ),
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
                child: const Text(
                  'Not ready for pickup',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
