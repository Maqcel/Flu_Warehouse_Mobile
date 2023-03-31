import 'package:flu_warehouse_mobile/style/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {
  AppTheme _currentTheme = StandardTheme();

  AppTheme get getTheme => _currentTheme;

  void setTheme(AppTheme themeMode) {
    _currentTheme = themeMode;
    notifyListeners();
  }
}

abstract class AppTheme implements AppColorsBase {}

class StandardTheme extends AppTheme {
  @override
  Color primaryBlack100 = AppStandardColors.primaryBlack100;
  @override
  Color primaryBlack75 = AppStandardColors.primaryBlack75;
  @override
  Color primaryBlack50 = AppStandardColors.primaryBlack50;
  @override
  Color primaryBlack25 = AppStandardColors.primaryBlack25;

  @override
  Color secondaryBlack100 = AppStandardColors.secondaryBlack100;
  @override
  Color secondaryBlack75 = AppStandardColors.secondaryBlack75;
  @override
  Color secondaryBlack50 = AppStandardColors.secondaryBlack50;
  @override
  Color secondaryBlack25 = AppStandardColors.secondaryBlack25;

  @override
  Color primaryYellow100 = AppStandardColors.primaryYellow100;
  @override
  Color primaryYellow75 = AppStandardColors.primaryYellow75;
  @override
  Color primaryYellow50 = AppStandardColors.primaryYellow50;
  @override
  Color primaryYellow25 = AppStandardColors.primaryYellow25;

  @override
  Color primaryGrey = AppStandardColors.primaryGrey;
  @override
  Color secondaryGrey = AppStandardColors.secondaryGrey;
  @override
  Color tertiaryGrey = AppStandardColors.tertiaryGrey;
  @override
  Color primaryWhite = AppStandardColors.primaryWhite;
}
