import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:slide_to_act/slide_to_act.dart';

class VoucherCard extends StatefulWidget {
  const VoucherCard({
    super.key,
    required this.voucher,
    required this.redeemed,
    required this.voucherID,
    required this.voucherCost,
    required this.userEmail,
    required this.userCoins,
  });
  final dynamic voucher;
  final String voucherID;
  final int voucherCost;
  final String userEmail;
  final int userCoins;
  late final bool redeemed;
  @override
  State<VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    // print(widget.voucherID);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          title: widget.redeemed
              ? Row(
                  children: [
                    const Text("Code: "),
                    SelectableText(
                      widget.voucher['code'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )
              : SlideAction(
                  height: 40,
                  animationDuration: const Duration(seconds: 1),
                  sliderButtonIconSize: 10,
                  sliderButtonIconPadding: 10,
                  onSubmit: () {
                    setState(() {
                      if (widget.userCoins > widget.voucherCost) {
                        widget.redeemed = !widget.redeemed;
                        Object body = {
                          "email": widget.userEmail,
                          "voucher_id": widget.voucherID
                        };
                        dio.patch('$serverURLExpress/avail-voucher',
                            data: body);
                      } else {
                        createQuickAlert(
                          context: context,
                          title: "Oops! ",
                          message:
                              "Looks like you don't have enough coins.\nEarn coins by completing tasks and challenges",
                          type: "info",
                        );
                      }
                    });
                    return null;
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Redeem for ${widget.voucher['coins']} coins",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        textScaler: const TextScaler.linear(1.1),
                      ),
                    ],
                  ),
                ),
          subtitle: Text(
            "Expires in ${widget.voucher['expiry']} days",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          trailing: Transform.translate(
            offset: const Offset(30, -25),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                '${widget.voucher['discount']}% off',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.surface),
                textScaler: const TextScaler.linear(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
