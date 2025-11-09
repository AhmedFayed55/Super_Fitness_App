import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.loginTap,
    required this.isLoading,
  });
  final void Function() loginTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = context.localization;
    final ThemeData theme = context.theme;
    return Column(
      spacing: 5,
      children: [
        CustomElevatedButton(
          onPressed: loginTap,
          isLoading: isLoading,
          widget: Text(locale.login),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: locale.dont_have_account_yet,
                style: theme.textTheme.bodyLarge,
              ),
              TextSpan(
                text: locale.register,
                style: theme.textTheme.bodyLarge!.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: theme.colorScheme.primary,
                  color: theme.colorScheme.primary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // todo: navigate to register screen
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
