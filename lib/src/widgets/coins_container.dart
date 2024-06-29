import 'package:flutter/material.dart';

class CoinsContainer extends StatelessWidget {
  final int coins;

  const CoinsContainer({super.key, this.coins = 860});
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 10, top: 7, bottom: 7),
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/animations/Coins.gif',
                  width: 20,
                  height: 20,
                ),
                Text(
                  "Coins: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface),
                  textScaler: const TextScaler.linear(0.9),
                ),
                Text(
                  "$coins",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface),
                  textScaler: const TextScaler.linear(0.9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
