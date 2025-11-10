import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/auth/logout/presentation/manager/logout_view_model.dart';
import 'package:super_fitness_app/features/auth/logout/presentation/widget/custom_dialog.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    final locale = context.localization;
    final theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (_) => getIt<LogoutViewModel>(),
      child: Material(
        // color: Colors.black87,
        color: Colors.transparent,
        child: Center(
          child: ListTile(
            leading: Image.asset(AppAssets.logout),
            title: Text(
              locale.logout,
              style: theme.displaySmall!.copyWith(
                fontSize: 14,
                color: color.primary,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: color.primary,
              size: 16,
            ),
            onTap: () => _logout(context),
          ),
        ),
      ),
    );
  }
}

void _logout(context) {
  showDialog(
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: getIt<LogoutViewModel>(),
        child: const LogoutAlertDialog(),
      );
    },
  );
}
