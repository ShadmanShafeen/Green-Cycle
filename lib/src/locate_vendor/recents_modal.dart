import 'package:flutter/material.dart';

class RecentsModal extends StatefulWidget {
  const RecentsModal({super.key});

  @override
  State<RecentsModal> createState() => _RecentsModalState();
}

List<String> recents = [
  "Viqarunnisa Noon School and College",
  "Motijheel High School",
  "Dhaka University",
  "Dhaka Medical College",
  "Dhaka College",
  "Dhaka City College",
  "Dhaka Residential Model College",
  "Notre Dame College",
  "Holy Cross College",
  "Ideal School and College",
  "Rajuk Uttara Model College",
  "Rifles Public School and College",
  "Adamjee Cantonment College",
];

class _RecentsModalState extends State<RecentsModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: recents.length,
        itemBuilder: (context, index) {
          return Card(
            color: Theme.of(context).colorScheme.surfaceDim,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(recents[index]),
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
