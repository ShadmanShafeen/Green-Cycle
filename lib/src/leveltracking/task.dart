import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/Locate_Vendor/location_permission_modal.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class Task extends StatefulWidget {
  Task({super.key, required this.task, required this.levelNumber});
  final String task;
  final levelNumber;
  final Map<int, String> taskLinking = {
    1: "/home",
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
      onTap: () async {
        if (widget.levelNumber == 1) {
          final Location location = Location();
          final serviceStatus = await location.serviceEnabled();
          if (!serviceStatus && context.mounted) {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (BuildContext context) {
                return const LocationPermissionModal();
              },
            );
            return;
          }

          try {
            final locationData = await location.getLocation();
            if (context.mounted) {
              context.go(
                "/home/locate-map",
                extra: locationData,
              );
            }
          } catch (e) {
            await createQuickAlert(
              context: context,
              title: "Location Error",
              message: "$e",
              type: "error",
            );

            openAppSettings();
          }
          context.pop();
        } else {
          context.pop();
          context.go(widget.taskLinking[widget.levelNumber]!);
        }
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
