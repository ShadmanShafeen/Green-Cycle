import 'package:green_cycle/src/models/voucher.dart';

class Company {
  Company(
      {required this.name,
      required this.imagePath,
      required this.vouchers,
      this.isExpanded = false});
  String name;
  String imagePath;
  List<Voucher> vouchers;
  bool isExpanded;
}
