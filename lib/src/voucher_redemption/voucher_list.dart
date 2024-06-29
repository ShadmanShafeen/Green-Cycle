import 'package:flutter/material.dart';
import 'package:green_cycle/src/models/company.dart';
import 'package:green_cycle/src/models/voucher.dart';
import 'package:green_cycle/src/voucher_redemption/voucher_card.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  final List<Company> _voucherData = [
    Company(
        name: 'SustainCraft',
        imagePath: 'lib/assets/images/companyIcons/1.png',
        vouchers: [
          Voucher(
              userID: '1', code: '80FEC8', percent: 15, expiry: 5, cost: 100),
          Voucher(
              userID: '1', code: 'K1G5P6', percent: 10, expiry: 7, cost: 50),
        ]),
    Company(
        name: 'PCycle',
        imagePath: 'lib/assets/images/companyIcons/2.png',
        vouchers: [
          Voucher(
              userID: '1', code: 'D05J32', percent: 20, expiry: 3, cost: 250),
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ..._voucherData.map(
          (Company company) => Padding(
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
                    child: Image.asset(company.imagePath)),
                title: Text(company.name),
                subtitle: Text(
                  '${company.vouchers.length} redeemable vouchers',
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
                  ...company.vouchers
                      .map((Voucher voucher) => VoucherCard(voucher: voucher))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
