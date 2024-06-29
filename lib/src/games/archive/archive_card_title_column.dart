import 'package:flutter/material.dart';

class ArchiveCardTitleColumn extends StatelessWidget {
  const ArchiveCardTitleColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Did you know these facts about sustainability and recycling?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(
              Icons.energy_savings_leaf,
              color: Colors.green,
            ),
            SizedBox(width: 5),
            Text(
              "Sustainability",
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}
