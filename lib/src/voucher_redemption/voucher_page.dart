import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/voucher_redemption/all_voucher_tab.dart';
import 'package:green_cycle/src/voucher_redemption/your_voucher_tab.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class VoucherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        animationDuration: Duration(seconds: 1),
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: BackButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                context.pop();
              },
            ),
            centerTitle: true,
            title: Text(
              'Vouchers',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  letterSpacing: 3),
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              splashBorderRadius: BorderRadius.circular(30),
              tabs: [
                Tab(
                  icon: Icon(Icons.wallet)
                ),
                Tab(
                  icon: Icon(Icons.person),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AllVoucherTab(),
              YourVoucherTab()
            ],
            ),
          bottomNavigationBar: NavBar(),
        ));
  }
}
