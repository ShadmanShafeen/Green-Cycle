import 'package:flutter/material.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Black", style: TextStyle(color: Colors.tealAccent),),),
      bottomNavigationBar: NavBar(),
    );
  }
}
