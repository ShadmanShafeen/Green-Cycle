import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({super.key , required this.task});
  final String task;
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool? isDone = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
