
import 'package:flutter/material.dart';

class CoinsEarnedContainer extends StatelessWidget{
  final int coinsEarned = 100;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10 , right: 5 , top: 7 , bottom: 7),
              child: Row (children: [
                Text("${coinsEarned} Coins Earned" , style: TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).colorScheme.onSurface), textScaler: TextScaler.linear(0.75),),
                Image.asset('lib/assets/animations/Coins.gif', width: 20, height: 20,),
              ],),
            ),
          ),
        ),
      ),
    );
  }
}