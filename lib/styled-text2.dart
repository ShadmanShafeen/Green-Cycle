import 'package:flutter/material.dart';

class StyledText2 extends StatelessWidget {
  const StyledText2(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromARGB(255, 107, 107, 107),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
    );
  }
}
