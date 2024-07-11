// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: NavBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("lib/assets/img/loki.png"),
                radius: 50,
              ),
              Text(
                'Loki Layperson',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                'lokilaufeyson1050@sylvie.com',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
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
              onTap: () {},
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
              onTap: () {},
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
    );
  }
}
