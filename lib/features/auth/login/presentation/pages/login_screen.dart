import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_view_model.dart';
import 'package:super_fitness_app/features/auth/login/presentation/widgets/blur_widget.dart';
import '../../../../../core/utils/assets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = context.localization;
    final textTheme = context.textTheme;
    return BlocProvider(
      create: (context) => getIt<LoginScreenViewModel>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      AppAssets.loginBackground,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          spacing: 8,
                          children: [
                            verticalSpace(context.height * 0.0566),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(AppAssets.appLogo),
                                  ),
                                  verticalSpace(context.height * .042),
                                  Text(locale.hey_there,
                                      style: textTheme.labelLarge),
                                  Text(locale.welcome_back,
                                      style: textTheme.titleLarge),
                                ],
                              ),
                            ),
                            verticalSpace(context.height * 0.01),
                            const BlurWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ),
    );
  }
}