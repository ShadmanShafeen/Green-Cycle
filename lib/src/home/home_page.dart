// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:green_cycle/src/home/action_card.dart';
import 'package:green_cycle/src/home/carousel.dart';
import 'package:green_cycle/src/home/search_bar.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CustomSearchBar(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                  children: [
                    ActionCard(label: "Locate", animatedIcon: Image.asset("lib/assets/animations/Locate.gif" , width: 50 , height: 50 ,), path: ''),
                    ActionCard(label: "Schedule", animatedIcon: Image.asset("lib/assets/animations/Schedule.gif", width: 50 , height:50), path: ''),
                    ActionCard(label: "List", animatedIcon: Image.asset("lib/assets/animations/List.gif" , width: 50 , height: 50), path: ''),
                    ActionCard(label: "Voucher", animatedIcon: Image.asset("lib/assets/animations/Vouchers.gif" , width: 50 , height: 50,), path: '/voucher-redemption'),
                    ActionCard(label: "Stories", animatedIcon: Image.asset("lib/assets/animations/Stories.gif" , width: 50 , height: 50), path: ''),
                    ActionCard(label: "Community", animatedIcon: Image.asset("lib/assets/animations/Community.gif" , width: 50 , height: 50), path: ''),
                    
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Play Exciting Games!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("lib/assets/images/quiz.jpg"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Did You Know...",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Carousel()
                ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }


}
