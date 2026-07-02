import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:munday/core/theme/custom_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

@NowaGenerated()
class AppTheme {
  static const String _kThemeModeKey = '__theme_mode__';

  static ThemeMode get themeMode {
    return ThemeMode.system;
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6F61EF),
      secondary: Color(0xFF39D2C0),
      tertiary: Color(0xFFEE8B60),
      surface: Color(0xFFF1F4F8),
      error: Color(0xFFFF5963),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1D2428),
      onError: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFFF1F4F8),
    extensions: <ThemeExtension<dynamic>>[CustomColors.light],
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.normal,
        fontSize: 57.0,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF606A85),
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF606A85),
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF606A85),
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFF1D2428),
        fontSize: 16.0,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFF1D2428),
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6F61EF),
      secondary: Color(0xFF39D2C0),
      tertiary: Color(0xFFEE8B60),
      surface: Color(0xFF15161E),
      error: Color(0xFFFF5963),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: Color(0xFFFFFFFF),
      onError: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFF15161E),
    extensions: <ThemeExtension<dynamic>>[CustomColors.dark],
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.normal,
        fontSize: 57.0,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFA9ADC6),
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFA9ADC6),
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFFA9ADC6),
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFFFFFFFF),
        fontSize: 16.0,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Open Sans',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      ),
    ),
  );

  static Future<void>? saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    if (mode == ThemeMode.system) {
      prefs.remove(_kThemeModeKey);
    } else {
      prefs.setBool(_kThemeModeKey, mode == ThemeMode.dark);
    }
  }
}
