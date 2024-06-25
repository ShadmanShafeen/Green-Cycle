
// ignore_for_file: prefer_const_constructors

import 'package:green_cycle/src/home/home_page.dart';
import 'package:green_cycle/src/leveltracking/level_tracking_page.dart';
import 'package:green_cycle/src/vendor/vendor_page.dart';
import 'package:green_cycle/src/voucherredemption/voucher_redemption_page.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_cycle/src/Locate_Vendor/map.dart';
import 'package:green_cycle/src/authentication/login.dart';
import 'package:green_cycle/src/authentication/signup.dart';
import 'package:green_cycle/src/community/community_calendar.dart';
import 'package:green_cycle/src/games/games.dart';
import 'package:green_cycle/src/login.dart';
import 'package:green_cycle/src/object_recognition/camera_control.dart';
import 'package:green_cycle/src/object_recognition/image_preview.dart';
import 'package:green_cycle/src/waste_item_listing/main_list_container.dart';
import 'package:green_cycle/src/welcome_screen/splash_screen.dart';
import 'package:green_cycle/src/welcome_screen/welcome_screen.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Green Cycle",
      theme: ThemeData(
        useMaterial3: true,
        buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF40BF58), // Green
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF53134A),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
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
                path: '/home',
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
            path: "/locate-map",
            builder: (context, state) => LocateMap(
              locationData: state.extra as LocationData,
            ),
            pageBuilder: (context, state) => returnCustomTransitionPage(
              child: LocateMap(
                locationData: state.extra as LocationData,
              ),
              context: context,
              type: PageTransitionType.leftToRight,
            ),
          ),
          GoRoute(
            path: "/camera-control",
            name: "camera-control",
            builder: (context, state) => CameraControl(
              cameras: cameras,
            ),
            pageBuilder: (context, state) => returnCustomTransitionPage(
              child: CameraControl(cameras: cameras),
              context: context,
              type: PageTransitionType.size,
            ),
          ),
          GoRoute(
            path: "/image-preview/:imagePath",
            name: "image-preview",
            builder: (context, state) => ImagePreview(
              imagePath: state.pathParameters['imagePath']!,
            ),
          ),
          GoRoute(
            path: "/waste-item-list",
            name: "waste-item-list",
            builder: (context, state) => const WasteListContainer(),
            pageBuilder: (context, state) => returnCustomTransitionPage(
              child: const WasteListContainer(),
              context: context,
              type: PageTransitionType.bottomToTop,
            ),
          ),
          
          GoRoute(
            path: "/games",
            name: "games",
            builder: (context, state) => const GamesPage(),
            pageBuilder: (context, state) => returnCustomTransitionPage(
              child: const GamesPage(),
              context: context,
              type: PageTransitionType.bottomToTop,
              durationMillis: 300,
            ),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CommunityCalendar(),
            pageBuilder: (context, state) => returnCustomTransitionPage(
              child: const CommunityCalendar(),
              context: context,
              type: PageTransitionType.bottomToTop,
              durationMillis: 300,
            ),
          ),
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
        GoRoute(path: '/vendor' , builder: (context,state) => VendorPage()),
        GoRoute(
            path: "/",
            builder: (context, state) => const WelcomeSplashScreen(),
          ),
          GoRoute(
            path: "/welcome",
            builder: (context, state) => const WelcomeScreen(),
          ),
          GoRoute(
            path: "/login",
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: "/signup",
            builder: (context, state) => const SignupPage(),
          ),
      ]),
      debugShowCheckedModeBanner: false,

      

  
    );
  }
}

//creates a transition when going to the specified page
CustomTransitionPage returnCustomTransitionPage(
    {int durationMillis = 500,
    required Widget child,
    required BuildContext context,
    PageTransitionType type = PageTransitionType.fade}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: Duration(milliseconds: durationMillis),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return PageTransition(
        key: UniqueKey(),
        type: type,
        child: child,
        isIos: true,
        duration: Duration(milliseconds: durationMillis),
        reverseDuration: Duration(milliseconds: durationMillis),
        ctx: context,
        alignment: Alignment.center,
        maintainStateData: true,
      ).buildTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    },
  );
}

void requestStoragePermission() async {
  // Check if the platform is not web, as web has no permissions
  if (!kIsWeb) {
    ph.PermissionStatus status = await ph.Permission.storage.status;
    if (status.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      ph.openAppSettings();
    } else if (!status.isGranted) {
      status = await ph.Permission.storage.request();
    }

    ph.PermissionStatus cameraStatus = await ph.Permission.camera.status;
    if (cameraStatus.isPermanentlyDenied) {
      ph.openAppSettings();
    } else if (!cameraStatus.isGranted) {
      cameraStatus = await ph.Permission.camera.request();
    }
  }
}
