import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:green_cycle/src/Locate_Vendor/map.dart';
import 'package:green_cycle/src/home_page.dart';
import 'package:green_cycle/src/object_recognition/camera_control.dart';
import 'package:green_cycle/src/object_recognition/image_preview.dart';
import 'package:green_cycle/src/waste_item_listing/main_list_container.dart';
import 'package:green_cycle/src/welcome_screen/splash_screen.dart';
import 'package:green_cycle/src/welcome_screen/welcome_screen.dart';
import 'package:permission_handler/permission_handler.dart';

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

  void requestStoragePermission() async {
    // Check if the platform is not web, as web has no permissions
    if (!kIsWeb) {
      PermissionStatus status = await Permission.storage.status;
      if (status.isPermanentlyDenied) {
        // The user opted to never again see the permission request dialog for this
        // app. The only way to change the permission's status now is to let the
        // user manually enable it in the system settings.
        openAppSettings();
      } else if (!status.isGranted) {
        status = await Permission.storage.request();
      }

      PermissionStatus cameraStatus = await Permission.camera.status;
      if (cameraStatus.isPermanentlyDenied) {
        openAppSettings();
      } else if (!cameraStatus.isGranted) {
        cameraStatus = await Permission.camera.request();
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData customTheme = ThemeData(
      useMaterial3: true,
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF40BF58), // Green
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF53134A),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF53134A),
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF342E44), // Space cadet
        onPrimaryContainer: Colors.white,
        primaryFixed: Color(0xFF8844F0), // Dark Purple
        primaryFixedDim: Color(0xFF53134A),
        onPrimaryFixed: Colors.white,
        onPrimaryFixedVariant: Colors.white,

        secondary: Color(0xFF1F8762), // accent green
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

        surface: Colors.black54,
        onSurface: Colors.white,
        surfaceDim: Color(0xFF1E1E1E),
        surfaceBright: Color(0xFF333333),
        surfaceContainerLowest: Color(0xFF070718),
        surfaceContainerLow: Color(0xFF1B1B1B),
        surfaceContainer: Color(0xFF222222),
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
      )
          .copyWith(surface: const Color(0xFF070718))
          .copyWith(error: const Color(0xFFFE7062)),
    );

    return MaterialApp.router(
      title: "Green Cycle",
      theme: customTheme,
      routerConfig: GoRouter(
        initialLocation: '/waste-item-list',
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: "/welcome",
            builder: (context, state) => const WelcomeScreen(),
          ),
          GoRoute(
            path: "/",
            builder: (context, state) => const WelcomeSplashScreen(),
          ),
          GoRoute(
            path: "/locate-vendor1",
            builder: (context, state) => const LocateMap(),
          ),
          GoRoute(
            path: "/camera-control",
            name: "camera-control",
            builder: (context, state) => CameraControl(cameras: cameras),
          ),
          GoRoute(
            path: "/image-preview/:imagePath",
            name: "image-preview",
            builder: (context, state) =>
                ImagePreview(imagePath: state.pathParameters['imagePath']!),
          ),
          GoRoute(
              path: "/waste-item-list",
              name: "waste-item-list",
              builder: (context, state) => const WasteListContainer()),
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
