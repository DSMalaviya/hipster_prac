import 'package:flutter/material.dart';

class CustomTextStyles {
  static const String roboto = "Roboto";

  static TextStyle robotoRegular(BuildContext context) {
    return const TextStyle(fontFamily: roboto, fontWeight: FontWeight.w400);
  }

  static TextStyle robotoBold(BuildContext context) {
    return const TextStyle(fontFamily: roboto, fontWeight: FontWeight.w700);
  }

  static TextStyle robotoBlack(BuildContext context) {
    return const TextStyle(fontFamily: roboto, fontWeight: FontWeight.w900);
  }

  static TextStyle robotoMedium(BuildContext context) {
    return const TextStyle(fontFamily: roboto, fontWeight: FontWeight.w500);
  }

  static TextStyle robotoLight(BuildContext context) {
    return const TextStyle(fontFamily: roboto, fontWeight: FontWeight.w300);
  }
}

extension TextStyleExtension on BuildContext {
  TextStyle get robotoRegular => CustomTextStyles.robotoRegular(this);
  TextStyle get robotoBold => CustomTextStyles.robotoBold(this);
  TextStyle get robotoBlack => CustomTextStyles.robotoBlack(this);
  TextStyle get robotoMedium => CustomTextStyles.robotoMedium(this);
  TextStyle get robotoLight => CustomTextStyles.robotoLight(this);
}
