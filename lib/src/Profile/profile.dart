// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/img/pp_bg.jpg'), fit: BoxFit.cover),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("lib/assets/img/loki.png"),
                      radius: 50,
                    ),
                    Positioned(
                      bottom: -6,
                      right: -3,
                      child: IconButton(
                        icon: const Icon(Icons.add_photo_alternate),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Loki Laufeyson',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'lokilaufeyson1050@sylvie.com',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHigh
                  .withOpacity(0.7),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {
                  context.go('/home/profile/waste_item_list');
                },
                splashColor: Colors.grey,
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                title: const Text("Recycling History"),
                leading: const Icon(Icons.history),
              ),
            ),
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHigh
                  .withOpacity(0.7),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {
                  context.go('/home/profile/community_calender');
                },
                splashColor: Colors.grey,
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                title: const Text("Collection Dates"),
                leading: const Icon(Icons.today),
              ),
            ),
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHigh
                  .withOpacity(0.7),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {},
                splashColor: Colors.grey,
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                title: const Text("Usage History"),
                leading: const Icon(Icons.history),
              ),
            ),
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHigh
                  .withOpacity(0.7),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {},
                splashColor: Colors.grey,
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                title: const Text("Privacy"),
                leading: const Icon(Icons.privacy_tip),
              ),
            ),
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHigh
                  .withOpacity(0.7),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {},
                splashColor: Colors.grey,
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                title: const Text("Settings"),
                leading: const Icon(Icons.settings),
              ),
            ),
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHigh
                  .withOpacity(0.7),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {},
                splashColor: Colors.grey,
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                title: const Text("Log Out"),
                leading: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
