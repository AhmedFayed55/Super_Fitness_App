import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/flutter_toast.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/l10n/translations/app_localizations.dart';
import '../manager/logout_event.dart';
import '../manager/logout_state.dart';
import '../manager/logout_view_model.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final locale = context.localization;

    return BlocListener<LogoutViewModel, LogoutState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          Navigator.pop(context);
          ToastMessage.toastMsg(
            state.errorMessage,
            backgroundColor: theme.colorScheme.error,
          );
        }

        if (state.isSuccess) {
          context.pop();
          context.pushReplacementNamed(AppRoutes.login);
          ToastMessage.toastMsg(localizations.logout_successfully);
        }
      },
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 34, sigmaY: 34),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    localizations.are_you_sure_to_close_the_application,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall!.copyWith(fontSize: 20),
                  ),
                  verticalSpace(16),

                  verticalSpace(24),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () => context.pop(),
                          isLoading: false,
                          widget: Text(locale.no),
                          containerColor: Colors.transparent,
                        ),
                      ),
                      horizontalSpace(50),
                      Expanded(
                        child: BlocBuilder<LogoutViewModel, LogoutState>(
                          builder: (context, state) {
                            return CustomElevatedButton(
                              isLoading: state.isLoading,
                              widget: Text(locale.yes),
                              onPressed: () => context
                                  .read<LogoutViewModel>()
                                  .doIntent(SubmitLogoutEvent()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
