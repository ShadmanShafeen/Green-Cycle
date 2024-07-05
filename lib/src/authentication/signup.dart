import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/authentication/vendor_signup.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  late final AnimationController fadeController;
  late final AnimationController translateController;
  bool isToggle = false;

  String? errorMessage = '';
  // bool isLoggedIn = false;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      print(_controllerEmail.text);
      print(_controllerPassword.text);
      if (_controllerPassword.text.length < 6) {
        createQuickAlert(
            context: context,
            title: "Password length must be at least 6 characters",
            message: "Please add more characters",
            type: 'error');
      } else {
        await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
        errorMessage = '';
      }
      
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

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
        child: returnForm(context),
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
              const SizedBox(height: 90.0, width: 100.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 200,
                      padding: const EdgeInsets.all(8.0),
                      child: FlutterSwitch(
                        width: isToggle ? 100 : 80,
                        showOnOff: true,
                        value: isToggle,
                        onToggle: (val) {
                          setState(() {
                            isToggle = val;
                          });
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                        activeText: "Vendor",
                        inactiveText: "User",
                        inactiveColor: Colors.grey,
                        activeTextColor:
                            Theme.of(context).colorScheme.onSurface,
                        inactiveTextColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      color: Color.fromARGB(255, 184, 43, 219),
                      fontSize: 50,
                    ),
                  ),
                  const Text(
                    "Sign Up For A New Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              !isToggle ? userForm(context) : const VendorSignupPage(),
            ],
          ),
        ),
      ],
    );
  }

  Padding userForm(BuildContext context) {
    return Padding(
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
            style: const TextStyle(color: Colors.white),
            controller: _controllerEmail,
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
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            controller: _controllerPassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Password',
            ),
          ),
          const SizedBox(height: 10.0, width: 10.0),
          const SizedBox(height: 20.0, width: 20.0),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                await createUserWithEmailAndPassword();
                if ( _controllerPassword.text.length >= 6 && errorMessage == '') {
                  context.go("/login");
                }
                
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    const Color.fromARGB(255, 224, 156, 236)),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Color.fromARGB(255, 120, 16, 146),
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15.0, width: 10.0),
          const Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "Already Have an Account?",
              style: TextStyle(
                color: Color.fromARGB(255, 184, 43, 219),
                fontSize: 15,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                context.push("/login");
              },
              child: const Text(
                'Log In',
                style: TextStyle(
                  color: Color.fromRGBO(31, 216, 139, 1),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
