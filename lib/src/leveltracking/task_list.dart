// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/src/leveltracking/task.dart';
import 'package:green_cycle/src/utils/server.dart';

class TaskList extends StatefulWidget {
  TaskList({super.key, required this.tasks , required this.levelNumber});
  List tasks;
  int levelNumber;
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool isDone = false;
  final GlobalKey _task1 = GlobalKey();
  final GlobalKey _task2 = GlobalKey();
  final GlobalKey _task3 = GlobalKey();

  @override
  void initState() {
    super.initState();
    print(widget.tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView(
        children: [
          Center(
            child: Text(
              "Current Tasks",
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textScaler: TextScaler.linear(1.75),
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          SizedBox(
            height: 5,
          ),
          ...widget.tasks.map((task) => Task(task: task , levelNumber: widget.levelNumber,)),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
