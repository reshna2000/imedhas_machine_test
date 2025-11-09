import 'package:flutter/material.dart';
import 'colors_class.dart';

class Styles {
  static const String roboto = "Roboto";

  // Base Roboto styles
  static const TextStyle robotoThin = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle robotoExtraLight = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w200,
  );

  static const TextStyle robotoLight = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle robotoRegular = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle robotoMedium = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle robotoSemiBold = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle robotoBold = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle robotoExtraBold = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w800,
  );

  // Common sizes - Regular (400)
  static const TextStyle roboto10 = TextStyle(
    fontFamily: roboto,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle roboto12 = TextStyle(
    fontFamily: roboto,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle roboto14 = TextStyle(
    fontFamily: roboto,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle roboto16 = TextStyle(
    fontFamily: roboto,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle roboto18 = TextStyle(
    fontFamily: roboto,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle roboto20 = TextStyle(
    fontFamily: roboto,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle roboto24 = TextStyle(
    fontFamily: roboto,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  // Common sizes - Medium (500)
  static const TextStyle roboto12Medium = TextStyle(
    fontFamily: roboto,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle roboto14Medium = TextStyle(
    fontFamily: roboto,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle roboto16Medium = TextStyle(
    fontFamily: roboto,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle roboto18Medium = TextStyle(
    fontFamily: roboto,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle roboto20Medium = TextStyle(
    fontFamily: roboto,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  // Common sizes - SemiBold (600)
  static const TextStyle roboto14SemiBold = TextStyle(
    fontFamily: roboto,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle roboto16SemiBold = TextStyle(
    fontFamily: roboto,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle roboto18SemiBold = TextStyle(
    fontFamily: roboto,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle roboto20SemiBold = TextStyle(
    fontFamily: roboto,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // Common sizes - Bold (700)
  static const TextStyle roboto14Bold = TextStyle(
    fontFamily: roboto,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle roboto16Bold = TextStyle(
    fontFamily: roboto,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle roboto18Bold = TextStyle(
    fontFamily: roboto,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle roboto20Bold = TextStyle(
    fontFamily: roboto,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle roboto24Bold = TextStyle(
    fontFamily: roboto,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle roboto30Bold = TextStyle(
    fontFamily: roboto,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  // Form field styles
  static const TextStyle labelTextStyle = TextStyle(
    fontFamily: roboto,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontFamily: roboto,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textFieldStyle = TextStyle(
    fontFamily: roboto,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  // Dynamic size helpers
  static TextStyle robotoSize(
    double size, {
    FontWeight weight = FontWeight.w400,
  }) => TextStyle(fontFamily: roboto, fontSize: size, fontWeight: weight);

  static TextStyle robotoWhite(
    double size, {
    FontWeight weight = FontWeight.w400,
  }) => TextStyle(fontFamily: roboto, fontSize: size, fontWeight: weight);

  static TextStyle robotoMediumSize(double size) => TextStyle(
    fontFamily: roboto,
    fontSize: size,
    fontWeight: FontWeight.w500,
  );
}

