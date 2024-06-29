import 'package:flutter/material.dart';
import 'package:green_cycle/src/voucher_redemption/voucher_list.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';

class VoucherRedemptionPage extends StatelessWidget {
  const VoucherRedemptionPage({super.key});
  final int collectibleVouchers = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$collectibleVouchers Collectible Vouchers',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                        textScaler: const TextScaler.linear(1.5),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const CoinsContainer()
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 2,
                  ),
                  const Expanded(
                    flex: 5,
                    child: VoucherList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
