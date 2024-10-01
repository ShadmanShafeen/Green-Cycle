import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/waste_item_listing/draft_items.dart';
import 'package:green_cycle/src/waste_item_listing/recent_items.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class WasteListContainer extends StatefulWidget {
  const WasteListContainer({super.key});

  @override
  State<WasteListContainer> createState() => _WasteListContainerState();
}

class _WasteListContainerState extends State<WasteListContainer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: returnAppBar(context),
        bottomNavigationBar: const NavBar(),
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              returnTabBar(context),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: TabBarView(
                    children: [
                      DraftItems(),
                      RecentItems(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar returnAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      context.go('/home');
                    }
                  },
                ),
                Text(
                  "Waste Item List",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 30,
                  ),
                  onPressed: () {
                    context.go("/home/profile");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      elevation: 0, // remove shadow
    );
  }

  TabBar returnTabBar(BuildContext context) {
    return TabBar(
      overlayColor: WidgetStateProperty.all(
        Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
      indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Theme.of(context).colorScheme.primaryFixed,
      labelColor: Theme.of(context).colorScheme.secondary,
      unselectedLabelColor: Theme.of(context).colorScheme.outlineVariant,
      tabs: const [
        Tab(
          icon: Icon(
            Icons.update,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.edit_note,
          ),
        ),
      ],
    );
  }
}
