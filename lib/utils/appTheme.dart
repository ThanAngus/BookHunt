import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightGrey,
  primaryColor: AppColors.primary,
  useMaterial3: true,
  primarySwatch: AppColors.primarySwatch,
  fontFamily: 'Brand-Regular',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Brand-Bold',
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Brand-Bold',
      fontWeight: FontWeight.w800,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Brand-Bold',
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Brand-Bold',
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Brand-Bold',
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Brand-Bold',
    ),
    titleLarge: TextStyle(
      fontFamily: 'Brand-Regular',
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Brand-Regular',
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Brand-Regular',
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Brand-Regular',
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Brand-Regular',
    ),
    bodySmall: TextStyle(
      fontFamily: 'Brand-Regular',
    ),
  ).apply(
    bodyColor: AppColors.darkGrey,
    displayColor: AppColors.primary,
  ),
);