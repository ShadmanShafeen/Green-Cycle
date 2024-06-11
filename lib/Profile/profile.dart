// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:green_cycle/Profile/collection_date.dart';
import 'package:green_cycle/Profile/recycling_history.dart';
import 'package:green_cycle/Profile/usage_history.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 34,
          ),
        ),
        actions: [

          OutlinedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset('assets/img/image_10.png'),
                Text(
                '1000',
                style: TextStyle(
                  color: Color.fromARGB(255, 52, 168, 83),
                  fontSize: 15,
                ),
              ),
            ],
          )

              ),
          SizedBox(
            width: 5,
          ),
          const Icon(IconData(0xee35, fontFamily: 'MaterialIcons')),
        ],
        actionsIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 52, 168, 83),
        ),
        foregroundColor: const Color.fromARGB(255, 52, 168, 83),
      ),
      body: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CollectionDate(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: UsageHistory(),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RecyclingHistory(),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
