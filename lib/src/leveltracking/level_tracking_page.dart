// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/authentication/login.dart';
import 'package:green_cycle/src/leveltracking/level_list.dart';
import 'package:green_cycle/src/leveltracking/task_list.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';
import 'package:green_cycle/src/widgets/show_case_view.dart';
import 'package:showcaseview/showcaseview.dart';

class LevelTrackingPage extends StatefulWidget {
  LevelTrackingPage({super.key});

  @override
  State<LevelTrackingPage> createState() => _LevelTrackingPageState();
}

class _LevelTrackingPageState extends State<LevelTrackingPage> {
  late int currentLevel = 0;
  late int coinsEarned = 0;
  late List objectives = [];

  final GlobalKey globalKeyTaskListView = GlobalKey();
  Future<void> getUserInfo() async {
    try {
      final dio = Dio();
      final email = Auth().currentUser?.email;
      final response = await dio.get("$serverURLExpress/user-info/$email");
      currentLevel = response.data['current_level'];
    } catch (e) {
      print(e);
    }
  }

  Future<void> getLevelDetails() async {
    try {
      final dio = Dio();
      final response = await dio
          .get("$serverURLExpress/level/get-level-details/$currentLevel");
      coinsEarned = response.data['coins_earned'];
      objectives = response.data['objectives'];
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    getLevelDetails();
    WidgetsBinding.instance.addPostFrameCallback((_) => beginTutorial());
  }

  void beginTutorial() {
    ShowCaseWidget.of(context).startShowCase([globalKeyTaskListView]);
  }

  Future<void> fetchDataSequentially() async {
    await getUserInfo();
    await getLevelDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/images/LevelTrackingPage.jpeg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: NavBar(),
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: fetchDataSequentially(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error Loading Data"),
                );
              } else {
                return Stack(children: [
                  LevelList(
                      currentLevel: currentLevel,
                      coinsEarned: coinsEarned,
                      displayBottomSheet: _displayBottomSheet),
                  Positioned(top: 10, right: 10, child: CoinsContainer()),
                ]);
              }
            }),
        floatingActionButton: Showcase(
          key: globalKeyTaskListView,
          title: "Tap To View Tasks",
          description: "Finish tasks to level up and earn coins!",
          tooltipBackgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
          textColor: Theme.of(context).colorScheme.onPrimary,
          titleTextStyle: TextStyle(
              fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
          descTextStyle: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)),
          disposeOnTap: true,
          onTargetClick: () {
            _displayBottomSheet(context);
          },
          child: FloatingActionButton(
            onPressed: () {
              _displayBottomSheet(context);
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Image.asset(
              'lib/assets/animations/Tasks.gif',
              height: 50,
              width: 50,
            ),
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
              height: MediaQuery.of(context).size.height / 2,
              child: TaskList(
                tasks: objectives,
                levelNumber: currentLevel,
              ),
            ));
  }
}
