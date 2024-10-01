import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String? errorMessage = '';
  bool isLoggedIn = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool obscureText = true;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      errorMessage = '';
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> navigateToUserOrVendor() async {
    try {
      final email = _controllerEmail.text;
      final dio = Dio();
      final userInfo = await dio.get("$serverURLExpress/user-info/$email");
      String role = userInfo.data['role'];
      if (role.toLowerCase() == "user") {
        context.go("/home");
      } else {
        context.go("/vendor");
      }
    } catch (e) {
      print(e);
    }
  }

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
                      fontSize: 25,
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
                      "Email",
                      style: TextStyle(
                        color: Color.fromARGB(255, 184, 43, 219),
                        fontSize: 15,
                      ),
                    ),
                    TextFormField(
                      controller: _controllerEmail,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Email',
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
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      obscureText: obscureText,
                      controller: _controllerPassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Password',
                      ),
                    ),
                    const SizedBox(height: 10.0, width: 10.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          createForgotPassQuickAlert(context);
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 184, 43, 219),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          await signInWithEmailAndPassword();
                          if (errorMessage == '') {
                            await navigateToUserOrVendor();
                          } else {
                            createQuickAlert(
                              context: context,
                              title: "Error",
                              message: errorMessage!,
                              type: 'error',
                            );
                          }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                        ),
                        TextButton(
                            onPressed: () {
                              context.go('/signup');
                            },
                            child: Text("Signup",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary)))
                      ],
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

  Future<void> createForgotPassQuickAlert(BuildContext context) async {
    String message = '';
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: 'Send',
      customAsset: 'lib/assets/images/reset.gif',
      widget: TextFormField(
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Enter email address',
          prefixIcon: Icon(
            Icons.mail_lock,
          ),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onChanged: (value) => message = value,
      ),
      onConfirmBtnTap: () async {
        //check if valid email
        if (message.isNotEmpty) {
          await Auth().resetPassword(message);
          Navigator.pop(context);
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: "Password reset link has been sent to $message",
          );
        } else {
          Navigator.pop(context);
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: "Please enter a valid email address",
          );
        }
      },
      title: 'Forgot Password',
      text: 'Enter your email address to reset your password',
    );
  }
}
