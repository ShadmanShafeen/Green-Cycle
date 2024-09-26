// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
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
                    CircleAvatar(
                      backgroundImage: auth.currentUser!.photoURL != null
                          ? NetworkImage(auth.currentUser!.photoURL!)
                          : const AssetImage('lib/assets/img/loki.png')
                              as ImageProvider,
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
                  auth.currentUser!.email!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  auth.currentUser!.email!,
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
            buildOptionCard(context, "Recycling History", Icons.history,
                "/home/profile/waste_item_list"),
            buildOptionCard(context, "Collection Dates", Icons.today,
                "/home/profile/community_calender"),
            // buildOptionCard(context, "Usage History", Icons.history, ""),
            // buildOptionCard(context, "Privacy", Icons.privacy_tip, ""),
            // buildOptionCard(context, "Settings", Icons.settings, ""),
            buildOptionCard(context, "Log Out", Icons.logout, "/login",
                onTapMethod: () async {
              final Auth auth = Auth();
              await auth.signOut();
              if (context.mounted) {
                context.go('/login');
              }
            }),
          ],
        ),
      ),
    );
  }

  Card buildOptionCard(
      BuildContext context, String title, IconData leadingIcon, String onTap,
      {Function()? onTapMethod}) {
    return Card(
      color:
          Theme.of(context).colorScheme.surfaceContainerHigh.withOpacity(0.7),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          
          onTapMethod != null ? onTapMethod() : context.go(onTap);
        },
        splashColor: Colors.grey,
        trailing: Icon(
          Icons.arrow_right,
          color: Theme.of(context).colorScheme.primaryFixed,
        ),
        title: Text(title),
        leading: Icon(leadingIcon),
      ),
    );
  }
}
