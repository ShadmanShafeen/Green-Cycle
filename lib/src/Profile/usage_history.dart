import 'package:flutter/material.dart';
import 'package:green_cycle/src/widgets/styled-text1.dart';

class UsageHistory extends StatelessWidget {
  const UsageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            children: [
              StyledText('My Usage History'),
            ],
          ),
          Container(
            color: Theme.of(context).colorScheme.primaryFixed,
            height: 1,
          ),
          Row(
            children: [
              Expanded(
                child: Image.asset('assets/img/graph.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
