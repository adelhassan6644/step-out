import 'package:flutter/material.dart';
import '../core/utils/app_strings.dart';
import '../core/utils/dimensions.dart';
import '../core/utils/styles.dart';

ThemeData dark = ThemeData(
  fontFamily: AppStrings.fontFamily,
  primaryColor: const Color(0xFF7338A4),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  // accentColor: const Color(0xFF252525),
  hintColor: const Color(0xFFE7F6F8),
  appBarTheme: const AppBarTheme(
    backgroundColor:Colors.black,
  ),
  focusColor: const Color(0xFFADC4C8),

  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
    foregroundColor: Colors.white, textStyle: const TextStyle(color: Colors.white),
  )),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.fuchsia:CupertinoPageTransitionsBuilder(),
  }),

  textTheme: const TextTheme(
    labelLarge: TextStyle(color: Styles.PRIMARY_COLOR),
    displayLarge: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: Dimensions.FONT_SIZE_DEFAULT,
      fontFamily: AppStrings.fontFamily,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: Dimensions.FONT_SIZE_DEFAULT,
      fontFamily: AppStrings.fontFamily,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Dimensions.FONT_SIZE_DEFAULT,
      fontFamily: AppStrings.fontFamily,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.FONT_SIZE_DEFAULT,
      fontFamily: AppStrings.fontFamily,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: Dimensions.FONT_SIZE_DEFAULT,
      fontFamily: AppStrings.fontFamily,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: Dimensions.FONT_SIZE_DEFAULT,
      fontFamily: AppStrings.fontFamily,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: Dimensions.FONT_SIZE_DEFAULT,
      fontFamily: AppStrings.fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      fontFamily: AppStrings.fontFamily,
    ),
    bodyMedium: TextStyle(fontSize: 12.0),
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      fontFamily: AppStrings.fontFamily,
    ),
  ),
);
