import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/authentication/login.dart';
import 'package:green_cycle/src/utils/server.dart';

class VendorProfileTab extends StatefulWidget {
  const VendorProfileTab({super.key});

  @override
  State<VendorProfileTab> createState() => _VendorProfileTabState();
}

class _VendorProfileTabState extends State<VendorProfileTab> {
  final email = Auth().currentUser?.email;
  String name = "";
  String vendor_email = "";
  Future<void> getUserInfo() async {
    try {
      final dio = Dio();
      final userInfo = await dio.get("$serverURLExpress/user-info/$email");
      name = userInfo.data['name'];
      vendor_email = userInfo.data['email'];
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error Fetching data"),
            );
          } else {
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
                      name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      vendor_email,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                  width: double.infinity,
                ),
                // Card(
                //   color: Theme.of(context)
                //       .colorScheme
                //       .surfaceContainerHigh
                //       .withOpacity(0.7),
                //   elevation: 5,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: ListTile(
                //     onTap: () {},
                //     splashColor: Colors.grey,
                //     trailing: Icon(
                //       Icons.arrow_right,
                //       color: Theme.of(context).colorScheme.primaryFixed,
                //     ),
                //     title: const Text("Recycling History"),
                //     leading: const Icon(Icons.history),
                //   ),
                // ),
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
        });
  }
}
