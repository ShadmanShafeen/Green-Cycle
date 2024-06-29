import 'package:flutter/material.dart';

class StyledText2 extends StatelessWidget {
  const StyledText2(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
    );
  }
}
