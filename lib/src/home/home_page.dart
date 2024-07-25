import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/Locate_Vendor/location_permission_modal.dart';
import 'package:green_cycle/src/games/game_image_card.dart';
import 'package:green_cycle/src/home/action_card.dart';
import 'package:green_cycle/src/home/carousel.dart';
import 'package:green_cycle/src/home/search_bar.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';
import 'package:location/location.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const NavBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomSearchBar(),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.photo_camera,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () {
                        context.go("/home/camera-control");
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
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
                      ),
                    ],
                  ),
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
                  context.go("/games/quiz");
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
      ),
    );
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
