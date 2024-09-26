import 'package:flutter/material.dart';
import 'package:green_cycle/src/vendor/vendor_widgets/recycle_requests_list.dart';

class VendorRecycleApproveTab extends StatelessWidget {
  const VendorRecycleApproveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            "Your Recycle Requests",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            textScaler: const TextScaler.linear(1.5),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          Expanded(flex: 5,child: RecycleRequestsList())
        ]),
      ),
    );
  }
}
