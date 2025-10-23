import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/dialogue_utils.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_event.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/blur_container.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/build_email_field.dart';

class ForgetPasswordEmailPage extends StatefulWidget {
  const ForgetPasswordEmailPage({super.key});

  @override
  State<ForgetPasswordEmailPage> createState() =>
      _ForgetPasswordEmailPageState();
}

class _ForgetPasswordEmailPageState extends State<ForgetPasswordEmailPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    context.read<ForgetPasswordViewModel>().emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final viewModel = context.read<ForgetPasswordViewModel>();
    final tr = context.localization;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AppAssets.authBackground, fit: BoxFit.cover),

        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppConstants.blurSigma,
            sigmaY: AppConstants.blurSigma,
          ),
          child: Container(color: AppColors.blurOverlay),
        ),

        SafeArea(
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.056),
                  Center(
                    child: Image.asset(
                      AppAssets.appLogo,
                      width: width * 0.186,
                      height: height * 0.06,
                    ),
                  ),
                  SizedBox(height: height * 0.08),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.0426),
                    child: Text(
                      tr.enter_your_email,
                      style: context.theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.0426),
                    child: Text(
                      tr.forget_password,
                      style: context.theme.textTheme.displayMedium,
                    ),
                  ),
                  SizedBox(height: height * 0.0197),

                  BlurContainer(
                    children: [
                      BuildEmailField(
                        controller: viewModel.emailController,
                        context: context,
                      ),
                      const SizedBox(height: 20),

                      BlocConsumer<
                        ForgetPasswordViewModel,
                        ForgetPasswordState
                      >(
                        listenWhen: (previous, current) =>
                            previous.errors.errorEmail !=
                            current.errors.errorEmail,
                        listener: (context, state) {
                          final error = state.errors.errorEmail;
                          if (error != null && error.isNotEmpty) {
                            DialogueUtils.showMessage(
                              context: context,
                              message: tr.email_is_not_valid,
                              title: tr.error,
                              posActionName: tr.ok,
                            );
                          }
                        },
                        buildWhen: (previous, current) =>
                            previous.loading.isVerifyCodeSentLoading !=
                            current.loading.isVerifyCodeSentLoading,
                        builder: (context, state) {
                          final isLoading =
                              state.loading.isVerifyCodeSentLoading;
                          return CustomElevatedButton(
                            onPressed: isLoading
                                ? () {}
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      viewModel.doIntent(ForgetPasswordEvent());
                                    }
                                  },
                            isLoading: isLoading,
                            widget: Text(
                              tr.send_otp,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
