class VendorRequest {
  VendorRequest({
    required this.userID,
    required this.userName,
    required this.items,
    required this.contactNo,
    required this.imagePath,
  });
  String userID;
  String userName;
  Map<String, int> items;
  String contactNo;
  String imagePath;
  bool isAccepted = false;
}
