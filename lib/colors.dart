import 'package:flutter/material.dart';

class MColors {
  static final Color covidMain = Color(0xFF236C76);
  static final Color covidSecond = Color(0xFF10242C);
  static final Color covidThird = Color(0xFFFFFAF4);
  static final Color covidForth = Color(0xFFFF8A23);
  static final Color covidFifth = Color(0xFFF3F4F5);

  static final kPrimaryColor = Color(0xFFFF7643);
  static final kPrimaryLightColor = Color(0xFFFFECDF);
  static final kPrimaryGradientColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFA53E), Color(0xFFFF7643)]);
  static final kSecondaryColor = Color(0xFF979797);
  static final kTextColor = Color(0xFF757575);
  // static final kTextColor = Colors.white;

  static final kAnimationDuration = Duration(microseconds: 200);
}
