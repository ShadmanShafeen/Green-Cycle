import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_cycle/src/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Green Cycle",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.tealAccent,
            onPrimary: Colors.white,
            secondary: Colors.greenAccent,
            onSecondary: Colors.white,
            error: Colors.pink.shade900,
            onError: Colors.white,
            background: Colors.grey.shade900,
            onBackground: Colors.white,
            surface: Colors.blueGrey.shade100,
            onSurface: Colors.tealAccent),
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme
        ),
      ),
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context , state) => HomePage()),
            
            
        ]),
      debugShowCheckedModeBanner: false,
      
    );
  }
}
