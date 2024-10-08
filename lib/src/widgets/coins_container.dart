import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';

import '../utils/server.dart';

class CoinsContainer extends StatefulWidget {
  const CoinsContainer({super.key});

  @override
  State<CoinsContainer> createState() => _CoinsContainerState();
}

class _CoinsContainerState extends State<CoinsContainer> {
  late var coins = 0;
  
  Future<void> getAndUpdateUserCoins() async {
    final dio = Dio();
    final email = Auth().currentUser?.email;
    final response =
        await dio.get('$serverURLExpress/user-info/$email');
    coins = response.data['coins'];
  }

  @override
  void initState() {
    super.initState();
    getAndUpdateUserCoins();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAndUpdateUserCoins(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return buildCoinContainer(context);
        } else {
          return buildCoinContainer(context);
        }
      },
    );
  }

  IntrinsicWidth buildCoinContainer(BuildContext context) {
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
