import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.alternate,
    required this.primaryText,
    required this.secondaryText,
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.accent1,
    required this.accent2,
    required this.accent3,
    required this.accent4,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.primaryBtnText,
    required this.lineColor,
    required this.backgroundComponents,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color alternate;
  final Color primaryText;
  final Color secondaryText;
  final Color primaryBackground;
  final Color secondaryBackground;
  final Color accent1;
  final Color accent2;
  final Color accent3;
  final Color accent4;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color primaryBtnText;
  final Color lineColor;
  final Color backgroundComponents;

  @override
  CustomColors copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? alternate,
    Color? primaryText,
    Color? secondaryText,
    Color? primaryBackground,
    Color? secondaryBackground,
    Color? accent1,
    Color? accent2,
    Color? accent3,
    Color? accent4,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? primaryBtnText,
    Color? lineColor,
    Color? backgroundComponents,
  }) {
    return CustomColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      alternate: alternate ?? this.alternate,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      primaryBackground: primaryBackground ?? this.primaryBackground,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      accent1: accent1 ?? this.accent1,
      accent2: accent2 ?? this.accent2,
      accent3: accent3 ?? this.accent3,
      accent4: accent4 ?? this.accent4,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      primaryBtnText: primaryBtnText ?? this.primaryBtnText,
      lineColor: lineColor ?? this.lineColor,
      backgroundComponents: backgroundComponents ?? this.backgroundComponents,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      alternate: Color.lerp(alternate, other.alternate, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      primaryBackground: Color.lerp(
        primaryBackground,
        other.primaryBackground,
        t,
      )!,
      secondaryBackground: Color.lerp(
        secondaryBackground,
        other.secondaryBackground,
        t,
      )!,
      accent1: Color.lerp(accent1, other.accent1, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      accent3: Color.lerp(accent3, other.accent3, t)!,
      accent4: Color.lerp(accent4, other.accent4, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      primaryBtnText: Color.lerp(primaryBtnText, other.primaryBtnText, t)!,
      lineColor: Color.lerp(lineColor, other.lineColor, t)!,
      backgroundComponents: Color.lerp(
        backgroundComponents,
        other.backgroundComponents,
        t,
      )!,
    );
  }

  static const light = CustomColors(
    primary: Color(0xFF6F61EF),
    secondary: Color(0xFF39D2C0),
    tertiary: Color(0xFFEE8B60),
    alternate: Color(0xFFE5E7EB),
    primaryText: Color(0xFFFFFFFF),
    secondaryText: Color(0xFF606A85),
    primaryBackground: Color(0xFFF1F4F8),
    secondaryBackground: Color(0xFFFFFFFF),
    accent1: Color(0x4D9489F5),
    accent2: Color(0x4C39D2C0),
    accent3: Color(0x4CEE8B60),
    accent4: Color(0x9AFFFFFF),
    success: Color(0xFF048178),
    warning: Color(0xFFFCDC0C),
    error: Color(0xFFFF5963),
    info: Color(0xFFFFFFFF),
    primaryBtnText: Color(0xFFFFFFFF),
    lineColor: Color(0xFFE0E3E7),
    backgroundComponents: Color(0xFF1D2428),
  );

  static const dark = CustomColors(
    primary: Color(0xFF6F61EF),
    secondary: Color(0xFF39D2C0),
    tertiary: Color(0xFFEE8B60),
    alternate: Color(0xFF313442),
    primaryText: Color(0xFFFFFFFF),
    secondaryText: Color(0xFFA9ADC6),
    primaryBackground: Color(0xFF15161E),
    secondaryBackground: Color(0xFF1B1D27),
    accent1: Color(0x4D9489F5),
    accent2: Color(0x4C39D2C0),
    accent3: Color(0x4CEE8B60),
    accent4: Color(0x981D2428),
    success: Color(0xFF048178),
    warning: Color(0xFFFCDC0C),
    error: Color(0xFFFF5963),
    info: Color(0xFFFFFFFF),
    primaryBtnText: Color(0xFFFFFFFF),
    lineColor: Color(0xFF22282F),
    backgroundComponents: Color(0xFF1D2428),
  );
}
