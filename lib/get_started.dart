import 'dart:ui';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
          child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                image: AssetImage('assets/img/bg.jpg'),
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.75, sigmaY: 1.75),
                      child: Container()),
                  Container(
                    padding: EdgeInsets.all(118),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Get Started'),
                          style: TextButton.styleFrom(
                              foregroundColor:
                                  Color.fromARGB(255, 128, 85, 254),
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                                fontFamily: 'Poppins',
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
// fit: BoxFit.fitHeight,
//               alignment: Alignment.bottomCenter,
// FilledButton(
//             onPressed: () {},
//             child: const Text('Get Started'),
//           ),
//  padding: const EdgeInsets.fromLTRB(90, 0, 90, 150),
                        
// FilledButton(
//                           style: FilledButton.styleFrom(
//                               foregroundColor:
//                                   Color.fromARGB(255, 128, 85, 254),
//                               backgroundColor: Colors.white,
//                               textStyle: const TextStyle(
//                                 fontSize: 22,
//                                 decoration: TextDecoration.underline,
//                                 fontFamily: 'Poppins',
//                                 fontStyle: FontStyle.italic,
//                               )),
//                           onPressed: () {},
//                           child: const Text('Get Started'),
//                         ),