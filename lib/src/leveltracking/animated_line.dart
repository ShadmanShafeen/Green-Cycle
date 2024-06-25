// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';

class AnimatedLine extends StatefulWidget {
  const AnimatedLine({super.key , required this.value});
  final double value;
  @override
  _AnimatedLineState createState() => _AnimatedLineState();
}

class _AnimatedLineState extends State<AnimatedLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Synchronize animation with this widget
      duration: Duration(seconds: 2),
      value: widget.value
      // Animation duration
    )..forward(); // Repeat the animation back and forth
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
          painter: LinePainter(
              _controller.value), // Use LinePainter to draw the line
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }
}

class LinePainter extends CustomPainter {
  final double animationValue; // Animation value to control line position

  LinePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 223, 80, 241) // Line color
      ..style = PaintingStyle.stroke // Stroke style
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.square; // Stroke width

    final double X = size.width / 2;
    final double startY = size.height;
    final double endY = size.height / 1000;

    final double currentY = startY + (endY - startY) * animationValue;

    // Draw the line
    canvas.drawLine(Offset(X, startY), Offset(X, currentY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint the line continuously
  }
}
