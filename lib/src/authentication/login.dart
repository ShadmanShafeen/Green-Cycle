import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final AnimationController fadeController;
  late final AnimationController translateController;
  @override
  void initState() {
    super.initState();
    fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    translateController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    translateController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: returnForm(context),
        ),
      ),
    );
  }

  Stack returnForm(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            'lib/assets/images/Vector.svg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Positioned.fill(
          bottom: 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: AnimatedBuilder(
              animation: translateController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(100 * translateController.value, 0),
                  child: child,
                );
              },
              child: AnimatedBuilder(
                animation: fadeController,
                builder: (context, child) {
                  return Opacity(
                    opacity: fadeController.value,
                    child: child,
                  );
                },
                child: SvgPicture.asset(
                  'lib/assets/images/Group 1.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Color.fromARGB(255, 184, 43, 219),
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    "Log Into Your Account",
                    style: TextStyle(
                      color: Color.fromARGB(255, 184, 43, 219),
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0, width: 50.0),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Username",
                      style: TextStyle(
                        color: Color.fromARGB(255, 184, 43, 219),
                        fontSize: 15,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Give Username',
                      ),
                    ),
                    const SizedBox(height: 20.0, width: 20.0),
                    const Text(
                      "Password",
                      style: TextStyle(
                        color: Color.fromARGB(255, 184, 43, 219),
                        fontSize: 15,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Give Password',
                      ),
                    ),
                    const SizedBox(height: 10.0, width: 10.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 184, 43, 219),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0, width: 20.0),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/home');
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 156, 236)),
                        ),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 120, 16, 146),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
