import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/games/minesweeper/bomb_cell.dart';
import 'package:green_cycle/src/games/minesweeper/mine_cell.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class Minesweeper extends StatefulWidget {
  const Minesweeper({super.key});

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  final columns = 10;
  int numberOfBombs = 10;
  final numberOfCells = 120;
  List<List<int>> squareStatus = [];
  List<int> bombs = [];
  bool gameOver = false;
  int revealedCells = 0;
  Timer? timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();

    ///set number of bombs a random number between 1 and 20
    numberOfBombs = Random().nextInt(10) + 1;

    ///initialize the grid, first index refers
    ///to  the number of bombs around the cell and the
    ///send one refers to the cell status
    for (int i = 0; i < numberOfCells; i++) {
      squareStatus.add([0, 0]);
    }

    ///generate bombs
    for (int i = 0; i < numberOfBombs; i++) {
      int bombIndex = Random().nextInt(numberOfCells);
      if (bombs.contains(bombIndex)) {
        i--;
      } else {
        bombs.add(bombIndex);
      }
    }

    ///update the grid
    updateGrid();
    startTimer();
  }

  void revealBoxNumbers(int index) {
    // if already revealed return
    if (squareStatus[index][1] == 1) {
      return;
    }

    // if there are bombs a round the cell
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = 1;
        revealedCells++;
      });
    } else {
      // if there are no bombs around the cell
      // reveal the current box and the surrounding boxes
      // unless you are on a wall
      setState(() {
        squareStatus[index][1] = 1;
        revealedCells++;
      });

      // cell to the left unless it is the first column
      if (index % columns != 0) {
        revealBoxNumbers(index - 1);
      }

      // cell to the right unless it is the last column
      if (index % columns != columns - 1) {
        revealBoxNumbers(index + 1);
      }

      // cell above unless it is the first row
      if (index >= columns) {
        revealBoxNumbers(index - columns);
      }

      // cell below unless it is the last row
      if (index < numberOfCells - columns) {
        revealBoxNumbers(index + columns);
      }

      // cell to the top left unless it is the first column or first row
      if (index % columns != 0 && index >= columns) {
        revealBoxNumbers(index - columns - 1);
      }

      // cell to the top right unless it is the last column or first row
      if (index % columns != columns - 1 && index >= columns) {
        revealBoxNumbers(index - columns + 1);
      }

      // cell to the bottom left unless it is the first column or last row
      if (index % columns != 0 && index < numberOfCells - columns) {
        revealBoxNumbers(index + columns - 1);
      }

      // cell to the bottom right unless it is the last column or last row
      if (index % columns != columns - 1 && index < numberOfCells - columns) {
        revealBoxNumbers(index + columns + 1);
      }
    }
  }

  /// scan the grid and update the number of bombs around each cell
  void updateGrid() {
    for (int i = 0; i < numberOfCells; i++) {
      int bombsAround = 0;

      // cell to the left unless it is the first column
      if (i % columns != 0 && bombs.contains(i - 1)) {
        bombsAround++;
      }

      // cell to the right unless it is the last column
      if (i % columns != columns - 1 && bombs.contains(i + 1)) {
        bombsAround++;
      }

      // cell above unless it is the first row
      if (i >= columns && bombs.contains(i - columns)) {
        bombsAround++;
      }

      // cell below unless it is the last row
      if (i < numberOfCells - columns && bombs.contains(i + columns)) {
        bombsAround++;
      }

      // cell to the top left unless it is the first column or first row
      if (i % columns != 0 && i >= columns && bombs.contains(i - columns - 1)) {
        bombsAround++;
      }

      // cell to the top right unless it is the last column or first row
      if (i % columns != columns - 1 &&
          i >= columns &&
          bombs.contains(i - columns + 1)) {
        bombsAround++;
      }

      // cell to the bottom left unless it is the first column or last row
      if (i % columns != 0 &&
          i < numberOfCells - columns &&
          bombs.contains(i + columns - 1)) {
        bombsAround++;
      }

      // cell to the bottom right unless it is the last column or last row
      if (i % columns != columns - 1 &&
          i < numberOfCells - columns &&
          bombs.contains(i + columns + 1)) {
        bombsAround++;
      }
      setState(() {
        squareStatus[i][0] = bombsAround;
      });
    }
  }

  void refreshGrid() {
    setState(() {
      squareStatus = [];
      bombs = [];
      gameOver = false;
      numberOfBombs = Random().nextInt(10) + 1;
      revealedCells = 0;
      seconds = 0;
    });

    ///initialize the grid, first index refers
    ///to  the number of bombs around the cell and the
    ///send one refers to the cell status
    for (int i = 0; i < numberOfCells; i++) {
      setState(() {
        squareStatus.add([0, 0]);
      });
    }

    ///generate bombs
    for (int i = 0; i < numberOfBombs; i++) {
      int bombIndex = Random().nextInt(numberOfCells);
      if (bombs.contains(bombIndex)) {
        i--;
      } else {
        setState(() {
          bombs.add(bombIndex);
        });
      }
    }

    ///update the grid
    updateGrid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          //game stats and menu
          gameStatsAndMenu(context),
          //mine grid view
          buildMineGridView(context),
          //branding text
          brandingText(context),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text('Minesweeper'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          context.pop(context);
        },
      ),
    );
  }

  Container gameStatsAndMenu(BuildContext context) {
    return Container(
      height: 150,
      color: Theme.of(context).colorScheme.surfaceDim,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //game stats
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$numberOfBombs',
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              Text(
                'B O M B S',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          Card(
            color: Theme.of(context).colorScheme.primaryFixed,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                refreshGrid();
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$seconds',
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              Text(
                'T I M E',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded buildMineGridView(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
        ),
        itemCount: numberOfCells,
        itemBuilder: (context, index) {
          if (bombs.contains(index)) {
            return BombCell(
              cellStatus: index,
              revealed: gameOver ? 1 : 0,
              onTap: () async {
                setState(() {
                  gameOver = true;
                });

                await createQuickAlert(
                  context: context,
                  title: 'Game Over',
                  message:
                      'You hit a bomb! Number of Cells Revealed: $revealedCells',
                  type: 'error',
                );
              },
            );
          } else {
            return MineCell(
              cellStatus: squareStatus[index][0],
              revealed: squareStatus[index][1],
              onTap: () async {
                revealBoxNumbers(index);

                if (revealedCells == numberOfCells - numberOfBombs) {
                  await createQuickAlert(
                    context: context,
                    title: 'Congratulations',
                    message: 'You won!',
                    type: 'success',
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Padding brandingText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        'G R E E N - C Y C L E',
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds < 999) {
        setState(() {
          seconds++;
        });
      } else {
        timer.cancel();
      }
    });
  }
}
