import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:green_cycle/styled-text1.dart';
import 'package:green_cycle/styled-text2.dart';

class RecyclingHistory extends StatelessWidget {
  const RecyclingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: const Column(
        children: [
          Row(
            children: [
              StyledText('Recycling History'),
              Expanded(child: SizedBox()),
              Text(
                'View full history',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 122, 255),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Color.fromARGB(255, 0, 122, 255),
              ),
            ],
          ),
          Row(
            children: [
              StyledText2('Coca-Cola Classic Slim Can, 12 Oz'),
              Expanded(child: SizedBox()),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
          Row(
            children: [
              StyledText2('Sterilite Plastic Shoe Boxes - 13 x 8 x 5"'),
              Expanded(child: SizedBox()),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
