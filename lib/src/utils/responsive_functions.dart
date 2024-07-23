import 'package:flutter/cupertino.dart';

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
