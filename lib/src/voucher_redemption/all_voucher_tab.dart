import 'package:flutter/material.dart';
import 'package:green_cycle/src/voucher_redemption/voucher_list.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';

class AllVoucherTab extends StatelessWidget {
  const AllVoucherTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10 , right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Collectible Vouchers',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  textScaler: const TextScaler.linear(1.5),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  width: 10,
                ),
                const CoinsContainer()
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            thickness: 2,
          ),
          const Expanded(
              child: VoucherList(allVouchers: true,)),
        ],
      ),
    );
  }
}
