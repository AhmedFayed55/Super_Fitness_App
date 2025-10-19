import 'package:flutter/material.dart';
import '../l10n/translations/app_localizations.dart';

extension ContextExtension on BuildContext {
  /// Get height of context screen
  /// usage: context.height
  double get height => MediaQuery.of(this).size.height;

  /// Get width of context screen
  /// usage: context.width
  double get width => MediaQuery.of(this).size.width;
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
