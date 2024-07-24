import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/voucher_redemption/voucher_card.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({super.key, required this.allVouchers});
  final bool allVouchers;
  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  final Auth _auth = Auth();
  final dio = Dio();
  late final Map<String, List<dynamic>> voucherData;
  late final dynamic userEmail;
  late int userCoins;

  Future<void> getAllVouchers() async {
    User? user = _auth.currentUser;
    if (user != null) {
      userEmail = user.email;
      final allVouchers =
          await dio.get('$serverURLExpress/user/vouchers/$userEmail');
      List<dynamic> iterable = allVouchers.data;
      voucherData = groupVouchersByCompany(iterable);

      final userInfo =
          await dio.get('$serverURLExpress/user-info/${user.email}');
      userCoins = userInfo.data['coins'];
    }
  }

  Future<void> getOnlyUserVouchers() async {
    User? user = _auth.currentUser;
    if (user != null) {
      userEmail = user.email;
      final yourVouchers =
          await dio.get('$serverURLExpress/user/availed-vouchers/$userEmail');
      List<dynamic> iterable = yourVouchers.data;
      voucherData = groupVouchersByCompany(iterable);

      final userInfo =
          await dio.get('$serverURLExpress/user-info/${user.email}');
      userCoins = userInfo.data['coins'];
    }
  }

  Map<String, List<dynamic>> groupVouchersByCompany(List<dynamic> vouchers) {
    return {
      for (var voucher in vouchers)
        voucher['company']:
            vouchers.where((v) => v['company'] == voucher['company']).toList()
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.allVouchers == true) {
      getAllVouchers();
    } else {
      getOnlyUserVouchers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.allVouchers ? getAllVouchers() : getOnlyUserVouchers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              color: Theme.of(context).colorScheme.surface,
            );
          } else if (snapshot.hasError) {
            return const Text(
              'Error Fetching Data :(',
              style: TextStyle(color: Colors.white),
            );
          } else {
            return ListView(
              children: [
                ...voucherData.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Card(
                      elevation: 10,
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        leading: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                              'lib/assets/images/companyIcons/1.png'),
                        ),
                        title: Text(entry.key),
                        subtitle: Text(
                          '${entry.value.length} redeemable vouchers',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8),
                          ),
                          textScaler: const TextScaler.linear(1.2),
                        ),
                        tilePadding: const EdgeInsets.all(10),
                        children: [
                          ...entry.value.map(
                            widget.allVouchers
                                ? (voucher) => VoucherCard(
                                    voucher: voucher,
                                    redeemed: false,
                                    voucherID: voucher['_id'],
                                    voucherCost: voucher['coins'],
                                    userEmail: userEmail,
                                    userCoins: userCoins)
                                : (voucher) => VoucherCard(
                                    voucher: voucher,
                                    redeemed: true,
                                    voucherID: voucher['_id'],
                                    voucherCost: voucher['coins'],
                                    userEmail: userEmail,
                                    userCoins: userCoins),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
