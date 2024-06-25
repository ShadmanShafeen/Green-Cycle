

import 'package:flutter/material.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';

class VendorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CoinsContainer(),
    );
  }
}