import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Palette.backgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Palette.backgroundColor,
    ),
  );
}
