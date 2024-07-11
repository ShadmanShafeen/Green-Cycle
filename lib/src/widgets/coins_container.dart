import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/.env';
import 'package:green_cycle/auth.dart';

class CoinsContainer extends StatefulWidget {
  CoinsContainer({
    super.key,
  });

  @override
  State<CoinsContainer> createState() => _CoinsContainerState();
}

class _CoinsContainerState extends State<CoinsContainer> {
  var coins;

  final Auth _auth = Auth();
  final dio = Dio();

  Future<void> getUserCoins() async {
    User? user = _auth.currentUser;
    final response = await dio.get('${backend_server}user-info/${user?.email}');
    print(response);
    print(response.data['coins']);
    coins = response.data['coins'];
  }

  @override
  void initState() {
    super.initState();
    getUserCoins();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserCoins(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Loading...');
        } else {
          return IntrinsicWidth(
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 10, top: 7, bottom: 7),
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
      },
    );
  }
}
