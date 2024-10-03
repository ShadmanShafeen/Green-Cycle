import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/routes/gameRouter.dart';
import 'package:green_cycle/src/routes/home/home_router.dart';
import 'package:green_cycle/src/widgets/transitions.dart';
import 'package:showcaseview/showcaseview.dart';

import '../authentication/login.dart';
import '../authentication/signup.dart';
import '../leveltracking/level_tracking_page.dart';
import '../vendor/vendor_page.dart';
import '../welcome_screen/splash_screen.dart';
import '../welcome_screen/welcome_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    homeRouter,
    GoRoute(
      path: '/level-tracking',
      name: 'level-tracking',
      builder: (context, state) =>
          ShowCaseWidget(builder: (context) => LevelTrackingPage()),
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: ShowCaseWidget(builder: (context) => LevelTrackingPage()),
          context: context,
          type: PageTransitionType.rightToLeft,
        );
      },
    ),
    gameRouter,
    GoRoute(
      path: '/vendor',
      name: 'vendor',
      builder: (context, state) =>
          ShowCaseWidget(builder: (context) => VendorPage()),
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: ShowCaseWidget(builder: (context) => VendorPage()),
          context: context,
          type: PageTransitionType.fade,
        );
      },
    ),
    GoRoute(
      path: "/",
      name: "splash",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const WelcomeSplashScreen(),
          context: context,
          type: PageTransitionType.fade,
        );
      },
    ),
    GoRoute(
      path: "/welcome",
      name: "welcome",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const WelcomeScreen(),
          context: context,
          type: PageTransitionType.fade,
        );
      },
    ),
    GoRoute(
      path: "/login",
      name: "login",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const LoginPage(),
          context: context,
          type: PageTransitionType.fade,
        );
      },
    ),
    GoRoute(
      path: "/signup",
      name: "signup",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const SignupPage(),
          context: context,
          type: PageTransitionType.fade,
        );
      },
    ),
  ],
);
