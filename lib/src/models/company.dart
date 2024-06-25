class Company {
  Company({required this.name, required this.imagePath, required this.vouchers , this.isExpanded = false});
  String name;
  String imagePath;
  List<Voucher> vouchers;
  bool isExpanded;
}

class Voucher {
  Voucher(
      {required this.userID,
      required this.code,
      required this.percent,
      required this.expiry});
  String userID;
  String code;
  int percent;
  int expiry;
}
