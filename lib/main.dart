import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_cycle/src/Locate_Vendor/map.dart';
import 'package:green_cycle/src/Profile/profile.dart';
import 'package:green_cycle/src/authentication/login.dart';
import 'package:green_cycle/src/authentication/signup.dart';
import 'package:green_cycle/src/community/com_goals/community_goals.dart';
import 'package:green_cycle/src/community/community_calendar.dart';
import 'package:green_cycle/src/community/community_explore.dart';
import 'package:green_cycle/src/community/explore_community/communities_nearby.dart';
import 'package:green_cycle/src/community/my_community_view/my_community.dart';
import 'package:green_cycle/src/games/archive/archive_container.dart';
import 'package:green_cycle/src/games/games.dart';
import 'package:green_cycle/src/games/quiz/quiz_question_holder.dart';
import 'package:green_cycle/src/games/quiz/quiz_welcome.dart';
import 'package:green_cycle/src/home/home_page.dart';
import 'package:green_cycle/src/leveltracking/level_tracking_page.dart';
import 'package:green_cycle/src/object_recognition/camera_control.dart';
import 'package:green_cycle/src/object_recognition/image_preview.dart';
import 'package:green_cycle/src/vendor/vendor_page.dart';
import 'package:green_cycle/src/voucher_redemption/voucher_redemption_page.dart';
import 'package:green_cycle/src/waste_item_listing/main_list_container.dart';
import 'package:green_cycle/src/welcome_screen/splash_screen.dart';
import 'package:green_cycle/src/welcome_screen/welcome_screen.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Green Cycle",
      theme: buildThemeData(context),
      routerConfig: buildGoRouter(),
      debugShowCheckedModeBanner: false,
    );
  }

  GoRouter buildGoRouter() {
    return GoRouter(
      initialLocation: '/home',
      routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
              pageBuilder: (context, state) {
                return returnCustomTransitionPage(
                  child: const HomePage(),
                  context: context,
                  type: PageTransitionType.bottomToTop,
                );
              },
              routes: [
                GoRoute(
                  path: "locate-map",
                  pageBuilder: (context, state) => returnCustomTransitionPage(
                    child: LocateMap(
                      locationData: state.extra as LocationData,
                    ),
                    context: context,
                    type: PageTransitionType.leftToRight,
                  ),
                ),
                GoRoute(
                  path: "camera-control",
                  name: "camera-control",
                  pageBuilder: (context, state) => returnCustomTransitionPage(
                    child: CameraControl(cameras: cameras),
                    context: context,
                    type: PageTransitionType.size,
                  ),
                ),
                GoRoute(
                  path: "image-preview/:imagePath",
                  name: "image-preview",
                  builder: (context, state) => ImagePreview(
                    imagePath: state.pathParameters['imagePath']!,
                    imageFile: state.extra as XFile,
                  ),
                ),
                GoRoute(
                  path: "waste-item-list",
                  name: "waste-item-list",
                  pageBuilder: (context, state) => returnCustomTransitionPage(
                    child: const WasteListContainer(),
                    context: context,
                    type: PageTransitionType.bottomToTop,
                  ),
                ),
                GoRoute(
                  path: 'calendar',
                  pageBuilder: (context, state) => returnCustomTransitionPage(
                    child: const CommunityCalendar(),
                    context: context,
                    type: PageTransitionType.bottomToTop,
                    durationMillis: 800,
                  ),
                ),
                GoRoute(
                  path: 'voucher-redemption',
                  pageBuilder: (context, state) {
                    return returnCustomTransitionPage(
                      child: VoucherRedemptionPage(),
                      context: context,
                      type: PageTransitionType.bottomToTop,
                      durationMillis: 800,
                    );
                  },
                ),
                GoRoute(
                  path: "profile",
                  name: "profile",
                  pageBuilder: (context, state) {
                    return returnCustomTransitionPage(
                      child: const Profile(),
                      context: context,
                      type: PageTransitionType.rightToLeft,
                    );
                  },
                ),
                GoRoute(
                  path: 'community-explore',
                  name: 'community-explore',
                  pageBuilder: (context, state) {
                    return returnCustomTransitionPage(
                      child: CommunityExplore(),
                      context: context,
                      type: PageTransitionType.rightToLeft,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: "explore-communities",
                      name: "explore-communities",
                      pageBuilder: (context, state) {
                        return returnCustomTransitionPage(
                          child: const CommunitiesNearby(),
                          context: context,
                          type: PageTransitionType.rightToLeft,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'my_com',
                      name: 'my_com',
                      builder: (context, state) => const MyCommunity(),
                      pageBuilder: (context, state) {
                        return returnCustomTransitionPage(
                          child: const MyCommunity(),
                          context: context,
                          type: PageTransitionType.rightToLeft,
                        );
                      },
                    ),
                    GoRoute(
                      path: "com-goals",
                      name: "com-goals",
                      pageBuilder: (context, state) {
                        return returnCustomTransitionPage(
                          child: const CommunityGoals(),
                          context: context,
                          type: PageTransitionType.bottomToTop,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: '/level-tracking',
              name: 'level-tracking',
              pageBuilder: (context, state) {
                return returnCustomTransitionPage(
                  child: LevelTrackingPage(),
                  context: context,
                  type: PageTransitionType.rightToLeft,
                );
              },
            ),
            GoRoute(
              path: "/games",
              name: "games",
              pageBuilder: (context, state) {
                return returnCustomTransitionPage(
                  child: const GamesPage(),
                  context: context,
                  type: PageTransitionType.leftToRight,
                );
              },
              routes: [
                GoRoute(
                  path: "archive",
                  name: "archive",
                  pageBuilder: (context, state) {
                    return returnCustomTransitionPage(
                      child: ArchiveContainer(),
                      context: context,
                      type: PageTransitionType.bottomToTop,
                    );
                  },
                ),
                GoRoute(
                  path: "quiz",
                  pageBuilder: (context, state) {
                    return returnCustomTransitionPage(
                      child: const QuizWelcome(),
                      context: context,
                      type: PageTransitionType.bottomToTop,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: "quiz-question/:questionCategory",
                      name: "quiz-question",
                      pageBuilder: (context, state) {
                        return returnCustomTransitionPage(
                          child: QuizQuestionHolder(
                            questionCategory:
                                state.pathParameters["questionCategory"]!,
                          ),
                          context: context,
                          type: PageTransitionType.rightToLeft,
                          durationMillis: 500,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

        GoRoute(
          path: '/vendor',
          builder: (context, state) => const VendorPage(),
        ),
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
      ]
    );
  }

  ThemeData buildThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF40BF58), // Green
          textTheme: ButtonTextTheme.primary,
          padding: EdgeInsets.all(0)),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF53134A),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
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
        onSurfaceVariant: Colors.white54,

        outline: Color(0xFFCCCCCC),
        outlineVariant: Color(0xFF888888),

        shadow: Colors.black,
        scrim: Colors.black,

        inverseSurface: Color(0xFF333333),
        onInverseSurface: Colors.white,
        inversePrimary: Color(0xFF1F8762), // accent green
        surfaceTint: Color(0xFF40BF58), // Green
      ),
    );
  }
}

enum PageTransitionType {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
  fade,
  size,
}

//creates a transition when going to the specified page
CustomTransitionPage returnCustomTransitionPage({
  required Widget child,
  required BuildContext context,
  required PageTransitionType type,
  int durationMillis = 500,
}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: Duration(milliseconds: durationMillis),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Widget transition;
      switch (type) {
        case PageTransitionType.leftToRight:
          transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
          break;
        case PageTransitionType.rightToLeft:
          transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
          break;
        case PageTransitionType.topToBottom:
          transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
          break;
        case PageTransitionType.bottomToTop:
          transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
          break;
        case PageTransitionType.fade:
          transition = FadeTransition(
            opacity: animation,
            child: child,
          );
          break;
        case PageTransitionType.size:
          transition = SizeTransition(
            sizeFactor: animation,
            child: child,
          );
          break;
        default:
          transition = child;
      }
      return transition;
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
