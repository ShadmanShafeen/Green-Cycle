import 'package:flutter/material.dart';

class DetailsModal1 extends StatelessWidget {
  DetailsModal1({super.key});
  List<String> details = [
    "Mirpur 12",
    "01200000",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, index) {
          return Card(
            color: Theme.of(context).colorScheme.surfaceDim,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(details[index]),
              onTap: () {
                // Implement your functionality here
              },
              splashColor: Colors.grey,
              trailing: const Icon(Icons.search),
            ),
          );
        },
      ),
    );
  }
}
