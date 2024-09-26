import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Task extends StatefulWidget {
  Task({super.key, required this.task, required this.levelNumber});
  final String task;
  final levelNumber;
  final Map<int, String> taskLinking = {
    1: "/home/locate-map",
    2: "/home/waste-item-list",
    3: "/home/waste-item-list",
    4: "/games",
    5: "/home/waste-item-list",
  };
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool? isDone = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
        context.go(widget.taskLinking[widget.levelNumber]!);
      },
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Icon(
          Icons.task,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          widget.task,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          textScaler: const TextScaler.linear(1.1),
        ),
        trailing: Transform.scale(
          scale: 1.5,
          child: Checkbox(
              value: isDone,
              onChanged: (bool? value) {
                setState(() {
                  // isDone = value;
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }
}
