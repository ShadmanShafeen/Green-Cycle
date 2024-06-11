import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WasteListContainer extends StatefulWidget {
  const WasteListContainer({super.key});

  @override
  State<WasteListContainer> createState() => _WasteListContainerState();
}

class _WasteListContainerState extends State<WasteListContainer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: returnAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
              tabs: [
                Tab(
                  icon: Icon(Icons.update,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                Tab(
                  icon: Icon(Icons.groups_3),
                ),
                Tab(
                  icon: Icon(Icons.edit_note),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        "Recent Items",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "All Items",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Edit Items",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar returnAppBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(right: 20),
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
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.onSurfaceVariant,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      elevation: 0, // remove shadow
    );
  }
}
