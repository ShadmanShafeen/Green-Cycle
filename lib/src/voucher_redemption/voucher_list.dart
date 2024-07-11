import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/voucher_redemption/voucher_card.dart';
import '../../.env';

class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  final Auth _auth = Auth();
  final dio = Dio();
  var allVoucherData;
  var yourVoucherData;
  Future<void> getData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String? email = user.email;
      final allVouchers = await dio.get('${backend_server}vouchers');
      final yourVouchers =
          await dio.get('${backend_server}user/vouchers/${email}');
      List<dynamic> iterable = allVouchers.data;
      print(iterable);
      allVoucherData = groupVouchersByCompany(iterable);
      print('allVoucherData');
      print(allVoucherData);
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
    getData();
  }

  // final List<Company> _voucherData = [
  //   Company(
  //       name: 'SustainCraft',
  //       imagePath: 'lib/assets/images/companyIcons/1.png',
  //       vouchers: [
  //         Voucher(
  //             userID: '1', code: '80FEC8', percent: 15, expiry: 5, cost: 100),
  //         Voucher(
  //             userID: '1', code: 'K1G5P6', percent: 10, expiry: 7, cost: 50),
  //       ]),
  //   Company(
  //       name: 'PCycle',
  //       imagePath: 'lib/assets/images/companyIcons/2.png',
  //       vouchers: [
  //         Voucher(
  //             userID: '1', code: 'D05J32', percent: 20, expiry: 3, cost: 250),
  //       ]),
  // ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              color: Theme.of(context).colorScheme.surface,
            );
          } else if (snapshot.hasError) {
            return Text(
              'Error Fetching Data :(',
              style: TextStyle(color: Colors.white),
            );
          } else {
            return ListView(
              children: [
                ...allVoucherData!.entries.map(
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
                                'lib/assets/images/companyIcons/1.png')),
                        title: Text(entry.key),
                        subtitle: Text(
                          '${entry.value.length} redeemable vouchers',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8),
                          ),
                          textScaler: TextScaler.linear(1.2),
                        ),
                        tilePadding: const EdgeInsets.all(10),
                        children: [
                          ...entry.value
                              .map((voucher) => VoucherCard(voucher: voucher))
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
