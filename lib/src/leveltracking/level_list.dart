// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:green_cycle/src/leveltracking/animated_line.dart';
import 'package:green_cycle/src/leveltracking/coins_earned_container.dart';
import 'package:green_cycle/src/leveltracking/level_container.dart';

class LevelList extends StatefulWidget {
  const LevelList({super.key, required this.currentLevel});

  final int currentLevel;

  @override
  State<LevelList> createState() => _LevelListState();
}

class _LevelListState extends State<LevelList> {
  bool currentLevelReached = false;
  bool coinsEarnedContainerVisible = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _targetKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToTarget();
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentLevelReached = true;
        coinsEarnedContainerVisible = true;
      });
    });
  }

  void _scrollToTarget() {
    final targetContext = _targetKey.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(targetContext,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      controller: _scrollController,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.up,
          children: [
            for (int i = 1; i <= 20; i++)
              if (i == widget.currentLevel - 1) ...[
                LevelContainer(
                    key: _targetKey, size: 75, level: i, levelReached: true),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: AnimatedLine(
                    value: 0, // 0 = animated line. 1 = static line
                  ),
                ),
              ] else if (i < widget.currentLevel) ...[
                LevelContainer(size: 75, level: i, levelReached: true),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: AnimatedLine(
                    value: 1, // 0 = animated line. 1 = static line
                  ),
                ),
              ] else if (i == widget.currentLevel) ...[
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: LevelContainer(
                            size: 75,
                            level: i,
                            levelReached: currentLevelReached)),
                    Visibility(
                      visible: coinsEarnedContainerVisible,
                      child: Positioned(
                        top: 20,
                        right: MediaQuery.of(context).size.width * 0.075,
                        child: CoinsEarnedContainer(),
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ] else ...[
                LevelContainer(size: 75, level: i, levelReached: false),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ]
          ],
        ),
      ),
    );
  }
}
