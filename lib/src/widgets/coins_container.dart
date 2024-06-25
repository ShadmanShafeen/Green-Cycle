
import 'package:flutter/material.dart';

class CoinsContainer extends StatelessWidget {
  final int coins = 960;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5 , right: 5),
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(left: 5 , right: 10 , top: 7 , bottom: 7),
              child: Row (children: [
                Image.asset('lib/assets/animations/Coins.gif', width: 20, height: 20,),
                Text("Coins: " , style: TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).colorScheme.onSurface), textScaler: TextScaler.linear(0.9),),
                Text("$coins" , style: TextStyle(fontWeight: FontWeight.w700,color: Theme.of(context).colorScheme.onSurface), textScaler: TextScaler.linear(0.9),),
              ],),
            ),
          ),
        ),
      ),
    );
  }
}