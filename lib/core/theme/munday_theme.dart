import 'package:flutter/material.dart';

class MundayTheme {
  final BuildContext context;
  MundayTheme(this.context);

  static MundayTheme of(BuildContext context) => MundayTheme(context);

  ThemeData get _theme => Theme.of(context);
  ColorScheme get _colors => _theme.colorScheme;
  TextTheme get _text => _theme.textTheme;

  // Colors
  Color get primary => _colors.primary;
  Color get secondary => _colors.secondary;
  Color get tertiary => _colors.tertiary;
  Color get alternate => const Color(0xFFE0E3E7);
  Color get primaryText => _colors.onSurface;
  Color get secondaryText => const Color(0xFF606A85);
  Color get primaryBackground => _colors.surface;
  Color get secondaryBackground => const Color(0xFFFFFFFF);
  Color get primaryBtnText => _colors.onPrimary;
  Color get error => _colors.error;

  Color get info => const Color(0xFFFFFFFF);
  Color get success => const Color(0xFF249689);
  Color get warning => const Color(0xFFF9CF58);

  // Typography
  TextStyle get displayLarge => _text.displayLarge ?? const TextStyle();
  TextStyle get displayMedium => _text.displayMedium ?? const TextStyle();
  TextStyle get displaySmall => _text.displaySmall ?? const TextStyle();
  TextStyle get headlineLarge => _text.headlineLarge ?? const TextStyle();
  TextStyle get headlineMedium => _text.headlineMedium ?? const TextStyle();
  TextStyle get headlineSmall => _text.headlineSmall ?? const TextStyle();
  TextStyle get titleLarge => _text.titleLarge ?? const TextStyle();
  TextStyle get titleMedium => _text.titleMedium ?? const TextStyle();
  TextStyle get titleSmall => _text.titleSmall ?? const TextStyle();
  TextStyle get labelLarge => _text.labelLarge ?? const TextStyle();
  TextStyle get labelMedium => _text.labelMedium ?? const TextStyle();
  TextStyle get labelSmall => _text.labelSmall ?? const TextStyle();
  TextStyle get bodyLarge => _text.bodyLarge ?? const TextStyle();
  TextStyle get bodyMedium => _text.bodyMedium ?? const TextStyle();
  TextStyle get bodySmall => _text.bodySmall ?? const TextStyle();
}
