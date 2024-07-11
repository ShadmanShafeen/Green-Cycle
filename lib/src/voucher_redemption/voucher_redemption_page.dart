import 'package:flutter/material.dart';
import 'package:green_cycle/src/voucher_redemption/voucher_list.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class VoucherRedemptionPage extends StatelessWidget {
  VoucherRedemptionPage({super.key});
  final int collectibleVouchers = 3;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: NavBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: SingleChildScrollView(
          child: 
            Column(
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
                    CoinsContainer()
                  ],
                ),
                Divider(
                  color: Theme.of(context).colorScheme.secondary,
                  thickness: 2,
                ),
                 Container(
                  height: MediaQuery.of(context).size.height,
                  child: VoucherList()),
              ],
            ),
          
        ),
      ),
    );
  }
}
