import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showtoast() {
  Fluttertoast.showToast(
    msg: "Request has been sent.Please wait for the vendor to respond. ",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showtoast1() {
  Fluttertoast.showToast(
    msg: "Request couldn't be sent.Please try again. ",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class DetailsModal1 extends StatelessWidget {
  DetailsModal1({super.key});
  void insertData() async {
    final dio = Dio();
    final Auth auth = Auth();
    User? user = auth.currentUser;
    final response = await dio.post(
      "$serverURLExpress/request-community/${user!.displayName}",
      data: {
        "email": user.email,
      },
    );
    if (response.statusCode == 200) {
      showtoast();
    } else {
      showtoast1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Would You Like to Send A Request to the Vendor to be Added In The Community?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              insertData();
            },
            child: const Text(
              'Send Request',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 184, 43, 219),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Do not Send',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 184, 43, 219),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
