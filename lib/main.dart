import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/Locate_Vendor/map.dart';
import 'package:green_cycle/src/Profile/profile.dart';
import 'package:green_cycle/src/Profile/usage_history.dart';
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
import 'package:green_cycle/src/notification/notification.dart';
import 'package:green_cycle/src/object_recognition/camera_control.dart';
import 'package:green_cycle/src/object_recognition/image_preview.dart';
import 'package:green_cycle/src/vendor/vendor_page.dart';
import 'package:green_cycle/src/voucher_redemption/voucher_page.dart';
import 'package:green_cycle/src/waste_item_listing/main_list_container.dart';
import 'package:green_cycle/src/welcome_screen/splash_screen.dart';
import 'package:green_cycle/src/welcome_screen/welcome_screen.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

late List<CameraDescription> cameras;
final navigatorKey = GlobalKey<NavigatorState>();
String deviceToken = "";

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Auth().initNotifications();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    throw Exception('Error: ${e.code}\nError Message: ${e.description}');
  }
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
      theme: buildLightThemeData(context),
      darkTheme: buildDarkThemeData(context),
      themeMode: ThemeMode.system,
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
          builder: (context, state) => HomePage(),
          pageBuilder: (context, state) {
            return returnCustomTransitionPage(
              child: HomePage(),
              context: context,
              type: PageTransitionType.bottomToTop,
            );
          },
          routes: [
            GoRoute(
              path: "notification",
              name: "notification",
              pageBuilder: (context, state) => returnCustomTransitionPage(
                child: const NotificationContainer(),
                context: context,
                type: PageTransitionType.topToBottom,
              ),
            ),
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
                  child: const VoucherPage(),
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
                  child: Profile(),
                  context: context,
                  type: PageTransitionType.rightToLeft,
                );
              },
              routes: [
                GoRoute(
                  path: "waste_item_list",
                  name: "waste_item_list",
                  pageBuilder: (context, state) => returnCustomTransitionPage(
                    child: const WasteListContainer(),
                    context: context,
                    type: PageTransitionType.rightToLeft,
                  ),
                ),
                GoRoute(
                  path: "community_calender",
                  name: "community_calender",
                  pageBuilder: (context, state) {
                    return returnCustomTransitionPage(
                      child: const CommunityCalendar(),
                      context: context,
                      type: PageTransitionType.bottomToTop,
                    );
                  },
                ),
                GoRoute(
                  path: "usage_history",
                  name: "usage_history",
                  pageBuilder: (context, state) {
                    return returnCustomTransitionPage(
                      child: const UsageHistory(),
                      context: context,
                      type: PageTransitionType.rightToLeft,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'community-explore',
              name: 'community-explore',
              pageBuilder: (context, state) {
                return returnCustomTransitionPage(
                  child: CommunityExplore(),
                  context: context,
                  type: PageTransitionType.bottomToTop,
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
                GoRoute(
                  path: "community-calender",
                  name: "community-calender",
                  pageBuilder: (context, state) {
                    return returnCustomTransitionPage(
                      child: const CommunityCalendar(),
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
      ],
    );
  }

  ThemeData buildDarkThemeData(BuildContext context) {
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
        secondaryFixed: Color.fromARGB(255, 64, 191, 88),
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

        surface: Color(0xFF121212),
        onSurface: Colors.white,
        surfaceDim: Color(0xFF1F1F1F),
        surfaceBright: Color(0xFF333333),
        surfaceContainerLowest: Colors.black,
        surfaceContainerLow: Colors.black87,
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

  ThemeData buildLightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFBF5840), // Complementary of Green
        textTheme: ButtonTextTheme.primary,
        padding: EdgeInsets.all(0),
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF4A5313), // Complementary of Dark Purple
        iconTheme: IconThemeData(color: Colors.black, size: 30),
      ),
      textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 80, 241, 223), // Complementary of Purple
        onPrimary: Colors.black,
        primaryContainer: Color(0xFF44342E), // Complementary of Space cadet
        onPrimaryContainer: Colors.black,
        primaryFixed: Color(0xFFF08844), // Complementary of Dark Purple
        primaryFixedDim: Color(0xFF4A5313), // Complementary of matt black
        onPrimaryFixed: Colors.black,
        onPrimaryFixedVariant: Colors.black,

        secondary:
            Color.fromARGB(255, 247, 101, 196), // Complementary of accent green
        onSecondary: Colors.black,
        secondaryContainer: Color(0xFFBF5840), // Complementary of Green
        onSecondaryContainer: Colors.black,
        secondaryFixed:
            Color.fromARGB(255, 191, 64, 88), // Complementary of Green
        secondaryFixedDim: Color(0xFF621F87), // Complementary of accent green
        onSecondaryFixed: Colors.black,
        onSecondaryFixedVariant: Colors.black,

        tertiary: Color(0xFF62FE70), // Complementary of Coral/Orange-Red
        onTertiary: Colors.black,
        tertiaryContainer: Color(0xFF62FE70),
        onTertiaryContainer: Colors.black,
        tertiaryFixed: Color(0xFF62FE70),
        tertiaryFixedDim: Color(0xFF62FE70),
        onTertiaryFixed: Colors.black,
        onTertiaryFixedVariant: Colors.black,

        error: Color(0xFF62FE70), // Complementary of Coral/Orange-Red
        onError: Colors.black,
        errorContainer: Color(0xFF20B000),
        onErrorContainer: Colors.black,

        surface: Color(0xFFFFFFFF),
        onSurface: Colors.black,
        surfaceDim: Color(0xFFF1F1F1),
        surfaceBright: Color(0xFFCCCCCC),
        surfaceContainerLowest: Colors.white70,
        surfaceContainerLow: Color(0xFFE1E1E1),
        surfaceContainer: Colors.black12,
        surfaceContainerHigh: Color(0xFFD3D3D3),
        surfaceContainerHighest: Color(0xFFCCCCCC), // Complement of 0xFF333333
        onSurfaceVariant:
            Color(0xFFABABAB), // Complement of Colors.white54 (0x8AFFFFFF)

        outline: Color(0xFF333333), // Complement of 0xFFCCCCCC
        outlineVariant: Color(0xFF777777), // Complement of 0xFF888888

        shadow: Colors.white, // Complement of Colors.black
        scrim: Colors.white, // Complement of Colors.black

        inverseSurface: Color(0xFFCCCCCC), // Complement of 0xFF333333
        onInverseSurface: Color(0xFF000000), // Complement of Colors.white
        inversePrimary:
            Color(0xFFE0789D), // Complement of 0xFF1F8762 (accent green)
        surfaceTint: Color(0xFFBF5840), // Complement of 0xFF40BF58 (Green)
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
