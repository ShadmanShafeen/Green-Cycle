import 'package:flutter/material.dart';
import 'package:green_cycle/src/models/voucher.dart';
import 'package:slide_to_act/slide_to_act.dart';

class VoucherCard extends StatefulWidget {
  const VoucherCard({super.key, required this.voucher});
  final Voucher voucher;

  @override
  State<VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  bool redeemed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 10,
          child: ListTile(
            title: redeemed
                ? Row(
                    children: [
                      const Text("Code: "),
                      SelectableText(
                        widget.voucher.code,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
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
                        redeemed = !redeemed;
                      });
                      return null;
                    },
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          "Redeem for ${widget.voucher.cost} coins",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          textScaler: const TextScaler.linear(1.1),
                        ),
                      ],
                    ),
                  ),
            subtitle: Text(
              "Expires in ${widget.voucher.expiry} days",
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            ),
            trailing: Transform.translate(
              offset: const Offset(30, -25),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  '${widget.voucher.percent}% off',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.surface),
                  textScaler: const TextScaler.linear(0.7),
                ),
              ),
            ),
          )),
    );
  }
}
