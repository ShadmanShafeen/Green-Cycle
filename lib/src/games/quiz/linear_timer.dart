import 'dart:async';

import 'package:flutter/material.dart';

class LinearTimer extends StatefulWidget {
  final int maxSeconds;
  final VoidCallback onTimerEnd;
  const LinearTimer(
      {super.key, required this.maxSeconds, required this.onTimerEnd});

  @override
  State<LinearTimer> createState() => _LinearTimerState();
}

class _LinearTimerState extends State<LinearTimer> {
  Timer? timer;
  late int seconds;

  @override
  void initState() {
    super.initState();
    seconds = widget.maxSeconds;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(20),
            value: seconds / widget.maxSeconds,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primaryFixed,
            ),
          ),
          Center(
            child: Text(
              '$seconds',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryFixed,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 3,
            child: Icon(
              Icons.timelapse_outlined,
              color:
                  Theme.of(context).colorScheme.onPrimaryFixed.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        widget.onTimerEnd();
        timer.cancel();
      }
    });
  }
}
