import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const textBlack = Color(0xff0F2209);
  static const error = Color(0xffCC0000);
  static const primaryColor = Color(0xff0B6370);
  static const primaryColorLight = Color(0xff53ADAC);
  static const appPink = Color(0xffFCF3F3);
  static const grey = Color(0xffD3D3D3);
  static const lightGrey = Color(0xffEBEBEB);
}

final ThemeData theme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'ProgramOTBook',
  canvasColor: Colors.white,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  primaryColor: AppColors.primaryColor,
  primaryColorLight: AppColors.primaryColorLight,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.primaryColor,
    contentTextStyle: TextStyle(
      fontSize: 14,
      fontFamily: 'ProgramOTBook',
      color: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
      // TODO(anyone): set theme
      ),
  colorScheme: const ColorScheme(
    background: AppColors.appPink,
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    secondary: AppColors.primaryColor,
    surface: AppColors.appPink,
    onBackground: AppColors.textBlack,
    onError: Colors.white,
    onPrimary: AppColors.textBlack,
    onSecondary: AppColors.textBlack,
    onSurface: AppColors.textBlack,
    error: AppColors.error,
  ),
);
