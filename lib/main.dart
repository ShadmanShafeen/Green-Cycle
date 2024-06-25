// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_cycle/src/home/home_page.dart';
import 'package:green_cycle/src/leveltracking/level_tracking_page.dart';
import 'package:green_cycle/src/vendor/vendor_page.dart';
import 'package:green_cycle/src/voucherredemption/voucher_redemption_page.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

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
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 223, 80, 241),
          onPrimary: Colors.white,
          primaryContainer: Color(0xFF342E44), // Space cadet
          onPrimaryContainer: Colors.white,
          primaryFixed: Color(0xFF8844F0), // Dark Purple
          primaryFixedDim: Color(0xFF53134A), // matt black
          onPrimaryFixed: Colors.white,
          onPrimaryFixedVariant: Colors.white,

          secondary: Color.fromARGB(255, 101, 247, 196), // accent green
          onSecondary: Colors.white,
          secondaryContainer: Color(0xFF40BF58), // Green
          onSecondaryContainer: Colors.white,
          secondaryFixed: Color(0xFF40BF58),
          secondaryFixedDim: Color(0xFF1F8762),
          onSecondaryFixed: Colors.white,
          onSecondaryFixedVariant: Colors.white,

          tertiary: Color(0xFFFE7062), // Coral/Orange-Red
          onTertiary: Colors.white,
          tertiaryContainer: Color(0xFFFE7062),
          onTertiaryContainer: Colors.white,
          tertiaryFixed: Color(0xFFFE7062),
          tertiaryFixedDim: Color(0xFFFE7062),
          onTertiaryFixed: Colors.white,
          onTertiaryFixedVariant: Colors.white,

          error: Color(0xFFFE7062), // Coral/Orange-Red
          onError: Colors.white,
          errorContainer: Color(0xFFB00020),
          onErrorContainer: Colors.white,

          surface: Color(0xFF222222),
          onSurface: Colors.white,
          surfaceDim: Color(0xFF1F1F1F),
          surfaceBright: Color(0xFF333333),
          surfaceContainerLowest: Colors.black38,
          surfaceContainerLow: Color(0xFF1B1B1B),
          surfaceContainer: Colors.white10,
          surfaceContainerHigh: Color(0xFF2C2C2C),
          surfaceContainerHighest: Color(0xFF333333),
          onSurfaceVariant: Colors.white,

          outline: Color(0xFFCCCCCC),
          outlineVariant: Color(0xFF888888),

          shadow: Colors.black,
          scrim: Colors.black,

          inverseSurface: Color(0xFF333333),
          onInverseSurface: Colors.white,
          inversePrimary: Color(0xFF1F8762), // accent green
          surfaceTint: Color(0xFF40BF58), // Green
        ),
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: GoRouter(initialLocation: '/voucher-redemption', routes: [
        ShellRoute(
            builder: (context, state, child) => Scaffold(
                  appBar: CustomAppBar(),
                  body: child,
                  bottomNavigationBar: NavBar(),
                ),
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: HomePage(),
                    transitionDuration: Duration(milliseconds: 750),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  );
                },
                routes: [
                  GoRoute(
                    path: 'voucher-redemption',
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: VoucherRedemptionPage(),
                        transitionDuration: Duration(milliseconds: 750),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      );
                  })
                ]
              ),
              GoRoute(
                path: '/level-tracking',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: LevelTrackingPage(),
                    transitionDuration: Duration(milliseconds: 750),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  );
                },
              ),
            ]),
        GoRoute(path: '/vendor' , builder: (context,state) => VendorPage())
      ]),
      debugShowCheckedModeBanner: false,
    );
  }
}
