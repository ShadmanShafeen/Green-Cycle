import 'package:flutter/material.dart';

class BombCell extends StatefulWidget {
  final int cellStatus;
  final int revealed;
  final VoidCallback onTap;
  const BombCell({
    super.key,
    required this.cellStatus,
    required this.revealed,
    required this.onTap,
  });

  @override
  State<BombCell> createState() => _BombCellState();
}

class _BombCellState extends State<BombCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(1),
        color: widget.revealed == 1
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primaryFixed,
        child: Center(
          child: Text(
            widget.revealed == 1 ? '💣' : "",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
