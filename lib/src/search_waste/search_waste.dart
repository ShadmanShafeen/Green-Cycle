import 'package:flutter/material.dart';
import 'package:green_cycle/src/utils/waste_items_info.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class SearchWastePage extends StatelessWidget {
  SearchWastePage({super.key, required this.category});
  final String category;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const NavBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildImageViewer(context , category),
              const SizedBox(height: 10),
              buildIsRecyclableRow(context),
              const SizedBox(height: 10),
              // buildDetailsContainer(context),
              // const SizedBox(height: 5),
              buildRecycleDetailsPanel(context, category),
            ],
          ),
        ),
      ),
    );
  }
}

SizedBox buildImageViewer(BuildContext context , String category) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.25,
    child: Image.asset(
      WASTE_ITEM_ICONS[category]!,
    ),
  );
}

Widget buildIsRecyclableRow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(
        Icons.check_circle,
        color: Theme.of(context).colorScheme.secondaryFixedDim,
      ),
      const SizedBox(width: 10),
      Text(
        "Recyclable Item",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20,
        ),
      ),
    ],
  );
}

Widget buildDetailsContainer(BuildContext context, String category) {
  return Container(
    padding: const EdgeInsets.all(10),
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            category,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Category\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020: $category",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

ExpansionTile buildRecycleDetailsPanel(BuildContext context, String category) {
  return ExpansionTile(
    title: Text(
      "Recycle Details",
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 20,
      ),
    ),
    children: [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Example Items: ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: WASTE_ITEM_INFO[category]!['Example Items'],
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            const TextSpan(text: "\n"),
          ],
        ),
      ),
      // listing instructions
      for (final entry in WASTE_ITEM_INFO[category]!.entries.skip(1))
        ListTile(
          title: Text(
            entry.key,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            entry.value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
        ),
    ],
  );
}
