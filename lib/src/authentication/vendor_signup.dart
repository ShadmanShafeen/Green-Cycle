import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VendorSignupPage extends StatefulWidget {
  const VendorSignupPage({super.key});

  @override
  State<VendorSignupPage> createState() => _VendorSignupPageState();
}

class _VendorSignupPageState extends State<VendorSignupPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Company Name",
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 15,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Company Name',
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
              hintText: 'Enter Password',
            ),
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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Please Provide Full Address',
            ),
          ),
          const SizedBox(height: 10.0, width: 10.0),
          const SizedBox(height: 20.0, width: 20.0),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                context.push("/vendor");
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
