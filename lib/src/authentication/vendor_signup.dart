import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class VendorSignupPage extends StatefulWidget {
  const VendorSignupPage({super.key});

  @override
  State<VendorSignupPage> createState() => _VendorSignupPageState();
}

class _VendorSignupPageState extends State<VendorSignupPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerContact = TextEditingController();
  final TextEditingController _controllerCommunityName =
      TextEditingController();
  final TextEditingController _controllerCompanyName = TextEditingController();
  final TextEditingController _controllerCompanyAddress =
      TextEditingController();
  String errorMessage = '';

  Future<void> createVendor() async {
    await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text, password: _controllerPassword.text);

    final dio = Dio();
    try {
      final response = await dio.post("$serverURLExpress/vendor-signup", data: {
        "name": _controllerName.text,
        "email": _controllerEmail.text,
        "contact": _controllerContact.text,
        "community_name": _controllerCommunityName.text,
        "company_name": _controllerCompanyName.text,
        "company_address": _controllerCompanyAddress.text,
        "role": "vendor",
      });
      if (response.statusCode == 200) {
        await createQuickAlert(
          context: context.mounted ? context : context,
          title: "Vendor Account Created",
          message: "Vendor created successfully",
          type: "success",
        );
        context.go("/login");
      }
    } catch (e) {
      throw createQuickAlert(
        context: context.mounted ? context : context,
        title: "Failed to load data",
        message: "$e",
        type: "error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Name",
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 15,
            ),
          ),
          TextFormField(
            controller: _controllerName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Name',
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20.0, width: 20.0),
          const Text(
            "Email",
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 15,
            ),
          ),
          TextFormField(
            controller: _controllerEmail,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Email',
            ),
            style: const TextStyle(color: Colors.white),
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
            controller: _controllerPassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Password',
            ),
            obscureText: true,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20.0, width: 20.0),
          const Text(
            "Contact No.",
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 15,
            ),
          ),
          TextFormField(
            controller: _controllerContact,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Contact No.',
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20.0, width: 20.0),
          const Text(
            "Community Name",
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 15,
            ),
          ),
          TextFormField(
            controller: _controllerCommunityName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Community Name',
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20.0, width: 20.0),
          const Text(
            "Company Name",
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 15,
            ),
          ),
          TextFormField(
            controller: _controllerCompanyName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Company Name',
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20.0, width: 20.0),
          const Text(
            "Company Address",
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 15,
            ),
          ),
          TextFormField(
            controller: _controllerCompanyAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Please Provide Full Address',
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10.0, width: 10.0),
          const SizedBox(height: 20.0, width: 20.0),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                await createVendor();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already Have an Account?",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              TextButton(
                  onPressed: () {
                    context.go("/login");
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                        fontSize: 13),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
