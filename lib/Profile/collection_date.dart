import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:green_cycle/styled-text1.dart';

class CollectionDate extends StatelessWidget {
  const CollectionDate({super.key});

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          StyledText('My Collection Dates'),
          Expanded(child: SizedBox()),
          Text(
            'more',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 122, 255),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Color.fromARGB(255, 0, 122, 255),
          ),
        ]),
        Divider(
          color: const Color.fromARGB(255, 52, 168, 83),
          height: 20,
        ),
      ]),
    );
  }
}
