import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/keys.dart';

class RegisterActions extends StatelessWidget {
  const RegisterActions({super.key, required this.onTapRegister});
  final void Function() onTapRegister;

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    var color = context.colorScheme;
    final double fieldWidth = MediaQuery.of(context).size.width * 0.1;

    return Padding(
      padding: EdgeInsets.only(left: fieldWidth, right: fieldWidth),
      child: Column(
        children: [
          CustomElevatedButton(
            key: const Key(AppKeys.registerAction),
            onPressed: onTapRegister,
            isLoading: false,
            widget: Text(locale.register),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                locale.already_have_account,
                key: const Key(AppKeys.alreadyHaveAccount),
              ),
              TextButton(
                onPressed: () => context.pushNamed(AppRoutes.login),
                child: Text(
                  key: const Key(AppKeys.loginTextButton),
                  locale.login,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: color.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
