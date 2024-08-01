import 'package:flutter/material.dart';
import 'package:green_cycle/src/vendor/vendor_widgets/vendor_requests_list.dart';

class VendorApproveTab extends StatelessWidget {
  const VendorApproveTab({super.key});

  

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
            "Your Requests",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            textScaler: const TextScaler.linear(1.5),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          const Expanded(flex: 5,child: VendorRequestsList())
        ]),
      ),
    );
  }
}
