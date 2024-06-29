import 'package:flutter/material.dart';
import 'package:green_cycle/src/widgets/styled-text1.dart';

class CollectionDate extends StatelessWidget {
  const CollectionDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const StyledText('My Collection Date'),
          const Expanded(child: SizedBox()),
          Text('more',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryFixed,
              )),
          Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
        ]),
        Divider(
          color: Theme.of(context).colorScheme.primaryFixed,
          height: 20,
        ),
      ]),
    );
  }
}
