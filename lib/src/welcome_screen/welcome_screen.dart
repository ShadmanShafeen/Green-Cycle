import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = VideoPlayerController.asset('lib/assets/videos/welcome.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {
          _controller.setLooping(true);
          _controller.play();
          _controller.setVolume(0);
        });
      });

    fetchUserInfo(context);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Positioned(
            top: 250,
            height: MediaQuery.of(context).size.height / 2,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayer(_controller),
                  )
                : const SizedBox(),
          ),
          // Gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surface.withOpacity(0.9),
                    Theme.of(context).colorScheme.surface.withOpacity(0.8),
                    Theme.of(context).colorScheme.surface.withOpacity(0.1),
                    Theme.of(context).colorScheme.surface.withOpacity(0.05),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          // Text and buttons
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Welcome to ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Green Cycle ${userInfo != null ? userInfo!['name'] : ''}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'The app that helps you recycle and save the planet!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SlideAction(
                    borderRadius: 22,
                    elevation: 0,
                    innerColor: Theme.of(context).colorScheme.secondary,
                    outerColor: Colors.transparent,
                    sliderButtonIcon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    text: 'Swipe to Get Started',
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    onSubmit: () async {
                      final Auth auth = Auth();
                      User? user = auth.currentUser;
                      if (user != null) {
                        await fetchUserInfo(context);
                        if (userInfo!['role'] == "user") {
                          context.go('/home');
                        } else {
                          context.go('/vendor');
                        }
                      } else {
                        context.go('/signup');
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchUserInfo(BuildContext context) async {
    try {
      final Dio dio = Dio();
      final email = Auth().currentUser?.email;
      final response = await dio.get('$serverURLExpress/user-info/$email');
      if (response.statusCode == 200) {
        userInfo = response.data;
        if (context.mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      return createQuickAlert(
        context: context.mounted ? context : context,
        title: "Error",
        message: "An error occurred while updating user coins",
        type: "error",
      );
    }
  }
}
