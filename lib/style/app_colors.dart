import 'package:flutter/material.dart';

abstract class AppTheme implements AppColorsBase {}

abstract class AppColorsBase {
  late Color primaryBlack100;
  late Color primaryBlack75;
  late Color primaryBlack50;
  late Color primaryBlack25;

  late Color secondaryBlack100;
  late Color secondaryBlack75;
  late Color secondaryBlack50;
  late Color secondaryBlack25;

  late Color primaryYellow100;
  late Color primaryYellow75;
  late Color primaryYellow50;
  late Color primaryYellow25;

  late Color primaryGrey;
  late Color secondaryGrey;
  late Color tertiaryGrey;
  late Color primaryWhite;
  late Color primaryOrange;
}

class AppStandardColors {
  static const Color primaryBlack100 = Color(0xff1d1d1d);
  static Color primaryBlack75 = const Color(0xff1d1d1d).withOpacity(0.75);
  static Color primaryBlack50 = const Color(0xff1d1d1d).withOpacity(0.5);
  static Color primaryBlack25 = const Color(0xff1d1d1d).withOpacity(0.25);

  static const Color secondaryBlack100 = Color(0xff2d2d2d);
  static Color secondaryBlack75 = const Color(0xff2d2d2d).withOpacity(0.75);
  static Color secondaryBlack50 = const Color(0xff2d2d2d).withOpacity(0.5);
  static Color secondaryBlack25 = const Color(0xff2d2d2d).withOpacity(0.25);

  static const Color primaryYellow100 = Color(0xffe1ff0f);
  static Color primaryYellow75 = const Color(0xffe1ff0f).withOpacity(0.75);
  static Color primaryYellow50 = const Color(0xffe1ff0f).withOpacity(0.5);
  static Color primaryYellow25 = const Color(0xffe1ff0f).withOpacity(0.25);

  static const Color primaryGrey = Color(0xffb6b6b6);
  static const Color secondaryGrey = Color(0xfff5f5f5);
  static const Color tertiaryGrey = Color(0xfff9f9f9);
  static const Color primaryWhite = Color(0xffffffff);
  static const Color primaryOrange = Color(0xffFFA50F);
}
