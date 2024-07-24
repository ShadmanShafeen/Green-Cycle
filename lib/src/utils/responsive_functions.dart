import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

double dynamicFontSize(BuildContext context, double baseFontSize) {
  // Define the base screen width
  double baseScreenWidth = 350;

  // Get the current screen width
  double screenWidth = MediaQuery.of(context).size.width;

  // Calculate the scale factor
  double scaleFactor = screenWidth / baseScreenWidth;

  // Return the scaled font size
  return baseFontSize * scaleFactor;
}

String getFormattedCurrentDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  return formattedDate;
}

DateTime parseDate(String dateString) {
  try {
    // Define the date format
    DateFormat format = DateFormat('dd-MM-yyyy');
    // Parse the date string
    DateTime date = format.parse(dateString);
    return date;
  } catch (e) {
    // Handle the error if the date string is invalid
    print('Invalid date format: $dateString');
    return DateTime.now();
  }
}

String getDateInNormalText(String dateValue) {
  DateTime date = parseDate(dateValue);
  return DateFormat.yMMMMEEEEd().format(date);
}
