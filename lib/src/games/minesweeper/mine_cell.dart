import 'package:flutter/material.dart';

class MineCell extends StatefulWidget {
  final int cellStatus;
  final int revealed;
  final VoidCallback onTap;
  const MineCell({
    super.key,
    required this.cellStatus,
    required this.revealed,
    required this.onTap,
  });

  @override
  State<MineCell> createState() => _MineCellState();
}

class _MineCellState extends State<MineCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(1),
        color: widget.revealed == 1
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primaryFixed,
        child: Center(
          child: Text(
            widget.revealed == 1 && widget.cellStatus != 0
                ? widget.cellStatus.toString()
                : "",
            style: TextStyle(
              color: widget.cellStatus == 1
                  ? Colors.greenAccent
                  : widget.cellStatus == 2
                      ? Colors.blueAccent
                      : widget.cellStatus == 3
                          ? Colors.redAccent
                          : widget.cellStatus == 4
                              ? Colors.purpleAccent
                              : widget.cellStatus == 5
                                  ? Colors.orangeAccent
                                  : widget.cellStatus == 6
                                      ? Colors.yellowAccent
                                      : widget.cellStatus == 7
                                          ? Colors.pinkAccent
                                          : widget.cellStatus == 8
                                              ? Colors.tealAccent
                                              : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
