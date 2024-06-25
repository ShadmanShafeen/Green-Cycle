import 'package:flutter/material.dart';
import 'package:green_cycle/src/models/company.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';

class VoucherList extends StatefulWidget {
  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  final List<Company> _voucherData = [
    Company(
        name: 'SustainCraft',
        imagePath: 'lib/assets/images/companyIcons/1.png',
        vouchers: [Voucher(userID: '1', code: '80FEC8', percent: 15, expiry: 5),
                   Voucher(userID: '1', code: 'K1G5P6', percent: 10, expiry: 7)]
    ),
    Company(
        name: 'PCycle',
        imagePath: 'lib/assets/images/companyIcons/2.png',
        vouchers: [Voucher(userID: '1', code: 'D05J32', percent: 15, expiry: 5),
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ..._voucherData.map((Company company) => 
        Padding(
          padding: const EdgeInsets.only(left: 5 , right: 5 , top: 10),
          child: Card(
            elevation: 10,
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ExpansionTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  leading: SizedBox(height: 40 , width: 40,child: Image.asset(company.imagePath)),
                  title: Text(company.name),
                  subtitle: Text('${company.vouchers.length} redeemable vouchers' , style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8) ,),textScaler: TextScaler.linear(1.2),),
                  tilePadding: EdgeInsets.all(10),
                  children: [
                    ...company.vouchers.map((Voucher voucher) => 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          child: ListTile(
                            title: Row(
                              children: [
                                Text("Code: "),
                                SelectableText(voucher.code , 
                                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                ),
                              ],), 
                              subtitle: Text("Expires in ${voucher.expiry} days" , style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),),
                            trailing: Transform.translate(
                              offset: Offset(30, -25),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                child: Text('${voucher.percent}% off', style: TextStyle(fontWeight: FontWeight.w700,color: Theme.of(context).colorScheme.surface) , textScaler: TextScaler.linear(0.7),),
                              ),
                            ),
                        )
                        ),
                      )
            )],
                ),
          ),
        )),
      ],
    );
  }
}
