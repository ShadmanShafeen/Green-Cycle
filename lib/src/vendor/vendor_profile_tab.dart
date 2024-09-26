import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/authentication/login.dart';

class VendorProfileTab extends StatelessWidget {
  const VendorProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            onTap: () {
              Auth().signOut();
              context.go("/login");
            },
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
    );
  }
}
