import 'package:flutter/material.dart';

class DetailsModal extends StatelessWidget {
  final int index;
  final AsyncSnapshot snapshot;
  late final Map<String, String>? element;
  bool isRecent = false;
  DetailsModal(
      {super.key,
      required this.index,
      required this.snapshot,
      required this.isRecent,
      this.element});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Item Details",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildColumn(context, "Item name", snapshot, index, 'name'),
                const SizedBox(height: 10),
                buildColumn(context, "Item Description", snapshot, index,
                    'description'),
                const SizedBox(height: 10),
                buildColumn(context, "Item Amount", snapshot, index, 'Amount'),
                const SizedBox(height: 10),
                buildColumn(
                    context, "Created At", snapshot, index, 'createdAt'),
                const SizedBox(height: 10),
                buildColumn(
                    context, "Confirmed At", snapshot, index, 'confirmedAt'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildColumn(BuildContext context, String title, AsyncSnapshot snapshot,
      int index, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryFixed,
            fontSize: 20,
          ),
        ),
        Text(
          isRecent ? element![field] : snapshot.data[index][field],
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
