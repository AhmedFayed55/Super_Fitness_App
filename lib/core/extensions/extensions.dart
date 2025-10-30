import 'package:flutter/material.dart';
import '../l10n/translations/app_localizations.dart';

extension ContextExtension on BuildContext {
  /// Screen dimensions
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  /// Responsive Height
  /// Example: context.mdH(10)
  double mdH(double value, {double designHeight = 812}) {
    return height * (value / designHeight);
  }

  /// Responsive Width
  /// Example: context.mdW(20)
  double mdW(double value, {double designWidth = 375}) {
    return width * (value / designWidth);
  }

  /// Responsive Icon Size (based on both height & width)
  /// Example: context.mdIcon(24)
  double mdIcon(double value, {double designWidth = 375, double designHeight = 812}) {
    // Average scale between width & height for balanced icon size
    final scale = ((width / designWidth) + (height / designHeight)) / 2;
    return value * scale;
  }

  /// Responsive Border Radius
  /// Example: context.mdRadius(12)
  double mdRadius(double value, {double designWidth = 375}) {
    return value * (width / designWidth);
  }
}

extension Localization on BuildContext {
  /// Get localization of the context
  /// usage: context.localization
  AppLocalizations get localization => AppLocalizations.of(this)!;
}

extension ThemeX on BuildContext {
  /// Full ThemeData
  ThemeData get theme => Theme.of(this);

  /// Shortcut to textTheme
  TextTheme get textTheme => theme.textTheme;

  /// Shortcut to colorScheme
  ColorScheme get colorScheme => theme.colorScheme;
}



extension SizingX on BuildContext {
  /// Calculates a responsive icon size based on screen height
  /// usage: context.iconSize(24)
  double iconSize(double size) {
    final height = this.height;
    final ratio = size / height;
    return ratio * height;
  }

  /// مثال تاني لو عايز تستخدمها كنسبة مش رقم
  /// usage: context.iconSizeByFactor(0.07)
  double iconSizeByFactor(double factor) {
    final shortest = MediaQuery.of(this).size.shortestSide;
    return shortest * factor;
  }
}
