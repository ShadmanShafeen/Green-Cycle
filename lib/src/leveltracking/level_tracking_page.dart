// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:green_cycle/src/leveltracking/level_list.dart';
import 'package:green_cycle/src/leveltracking/task_list.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class LevelTrackingPage extends StatelessWidget {
  LevelTrackingPage({super.key});
  int currentLevel = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('lib/assets/images/LevelTrackingPage.jpeg'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: NavBar(),
        backgroundColor: Colors.transparent,
        body:  Stack(
          children: const [
            LevelList(currentLevel: 5),
            Positioned(top: 10, right: 10,child: CoinsContainer()),
          ]),
            
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _displayBottomSheet(context);
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Image.asset(
            'lib/assets/animations/Tasks.gif',
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context, 
        showDragHandle: true,
        barrierColor: Colors.black.withOpacity(0.25),
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height/2,
          child: TaskList(),
          ));
  }
}

 