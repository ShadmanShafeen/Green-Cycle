// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:green_cycle/src/leveltracking/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool isDone = false;
  final GlobalKey _task1 = GlobalKey();
  final GlobalKey _task2 = GlobalKey();
  final GlobalKey _task3 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10),
      child: Column(
        children: [
          Center(
            child: Text(
              "Current Tasks",
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textScaler: TextScaler.linear(1.75),
            ),
          ),
          Divider(color: Theme.of(context).colorScheme.onSurface,),
          SizedBox(height: 5,),
          Task(key: _task1, task: "Recycle 3 items",),
          SizedBox(height: 10,),
          Task(key: _task2, task: "Locate 1 vendor",),
          SizedBox(height: 10,),
          Task(key: _task3, task: "Connect with a community",),
        ],
      ),
    );
  }
}
