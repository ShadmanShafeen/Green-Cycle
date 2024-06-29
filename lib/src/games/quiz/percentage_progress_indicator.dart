import 'package:flutter/material.dart';

class PercentageProgressIndicator extends StatefulWidget {
  final double progress;
  final Color color;
  const PercentageProgressIndicator(
      {super.key, required this.progress, required this.color});

  @override
  State<PercentageProgressIndicator> createState() =>
      _PercentageProgressIndicatorState();
}

class _PercentageProgressIndicatorState
    extends State<PercentageProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation =
        Tween<double>(begin: 0, end: widget.progress).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 2000),
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            value: _animation.value,
            color: widget.color,
            backgroundColor: widget.color.withOpacity(0.2),
          ),
        ),
        Text(
          '${(widget.progress * 100).round()}%',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
