class Voucher {
  Voucher({
    required this.userID,
    required this.code,
    required this.percent,
    required this.expiry,
    required this.cost,
  });
  String userID;
  String code;
  int percent;
  int expiry;
  int cost;
}
