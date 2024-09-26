import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/Locate_Vendor/location_permission_modal.dart';
import 'package:green_cycle/src/games/game_image_card.dart';
import 'package:green_cycle/src/home/action_card.dart';
import 'package:green_cycle/src/home/carousel.dart';
import 'package:green_cycle/src/home/waste_items_wheel.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const CustomAppBar(),
      bottomNavigationBar: userInfo != null
          ? NavBar(
              showGame: userInfo?["current_level"] >= 3,
            )
          : const NavBar(
              showGame: false,
            ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 15,
            ),
            if (userInfo != null)
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                    children: [
                      ActionCard(
                        label: "Locate",
                        animatedIcon: Image.asset(
                          "lib/assets/animations/Locate.gif",
                          width: 50,
                          height: 50,
                        ),
                        path: '/home/locate-map',
                      ),
                      ActionCard(
                        label: "Schedule",
                        animatedIcon: Image.asset(
                          "lib/assets/animations/Schedule.gif",
                          width: 50,
                          height: 50,
                        ),
                        path: '/home/calendar',
                      ),
                      ActionCard(
                        label: "List",
                        animatedIcon: Image.asset(
                          "lib/assets/animations/List.gif",
                          width: 50,
                          height: 50,
                        ),
                        path: '/home/waste-item-list',
                      ),
                      ActionCard(
                        label: "Voucher",
                        animatedIcon: Image.asset(
                          "lib/assets/animations/Vouchers.gif",
                          width: 50,
                          height: 50,
                        ),
                        path: '/home/voucher-redemption',
                      ),
                      ActionCard(
                        label: "Stories",
                        animatedIcon: Image.asset(
                          "lib/assets/animations/Stories.gif",
                          width: 50,
                          height: 50,
                        ),
                        path: '/home',
                      ),
                      ActionCard(
                        label: "Community",
                        animatedIcon: Image.asset(
                          "lib/assets/animations/Community.gif",
                          width: 50,
                          height: 50,
                        ),
                        path: '/home/community-explore',
                        disabled: userInfo?["current_level"] < 2,
                        disabledMessage: "Unlocks at level 4",
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
              child: Text(
                "Gain Recycling Knowledge",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WasteItemsWheel(scrollController: scrollController),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.tertiary),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.photo_camera,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Scan',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      context.go("/home/camera-control");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Play Exciting Games!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.push("/games");
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                height: 250,
                child: GameImageCard(
                  title: "GreenQuiz",
                  subtitle: "Test your knowledge on recycling",
                  image: "lib/assets/images/quiz.jpg",
                  context: context,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Did You Know...",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Carousel(),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUserInfo() async {
    try {
      final dio = Dio();
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

void showLocationPermission(BuildContext context) async {
  final Location location = Location();
  final serviceStatus = await location.serviceEnabled();
  if (!serviceStatus && context.mounted) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return const LocationPermissionModal();
      },
    );
    return;
  }

  final locationData = await location.getLocation();
  if (context.mounted) {
    context.go(
      "/home/locate-map",
      extra: locationData,
    );
  }
}
