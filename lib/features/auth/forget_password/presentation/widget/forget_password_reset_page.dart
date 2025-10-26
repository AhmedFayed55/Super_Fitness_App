import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/dialogue_utils.dart';
import 'package:super_fitness_app/core/helpers/flutter_toast.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_event.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/blur_container.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/build_password_and_confirm_field.dart';

class ForgetPasswordResetPage extends StatefulWidget {
  const ForgetPasswordResetPage({super.key});

  @override
  State<ForgetPasswordResetPage> createState() =>
      _ForgetPasswordResetPageState();
}

class _ForgetPasswordResetPageState extends State<ForgetPasswordResetPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    context.read<ForgetPasswordViewModel>().doIntent(
      CloseForgetPasswordEvent(),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final theme = context.theme;
    final tr = context.localization;
    final viewModel = context.read<ForgetPasswordViewModel>();

    return BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.errors.errorPassword != current.errors.errorPassword,
      listener: (context, state) {
        if (state.errors.errorPassword != null &&
            state.errors.errorPassword!.isNotEmpty) {
          DialogueUtils.showMessage(
            context: context,
            message: tr.password_is_incorrect,
            title: tr.error,
            posActionName: tr.ok,
          );
        }
        if (state.isPasswordReset) {
          ToastMessage.toastMsg(tr.password_reset_successfully);
          Navigator.pop(context);
        }
      },
      buildWhen: (previous, current) =>
          previous.loading.isPasswordResetLoading !=
          current.loading.isPasswordResetLoading,
      builder: (context, state) {
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(height * 0.06),

                    Center(
                      child: Image.asset(
                        AppAssets.appLogo,
                        width: width * 0.186,
                        height: height * 0.06,
                      ),
                    ),

                    verticalSpace(height * 0.08),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.0426),
                      child: Text(
                        tr.create_new_password,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    verticalSpace(height * 0.008),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.0426),
                      child: Text(
                        tr.make_sure_it_8_characters_or_more,
                        style: theme.textTheme.displayMedium,
                      ),
                    ),

                    verticalSpace(height * 0.03),

                    BlurContainer(
                      children: [
                        Form(
                          key: _formKey,
                          child: BuildPasswordAndConfirmField(
                            passwordController: viewModel.passwordController,
                            confirmController:
                                viewModel.confirmPasswordController,
                          ),
                        ),

                        verticalSpace(height * 0.03),

                        CustomElevatedButton(
                          isLoading: state.loading.isPasswordResetLoading,
                          widget: Text(tr.done),
                          onPressed: state.loading.isPasswordResetLoading
                              ? () {}
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    viewModel.doIntent(
                                      ResetPasswordEvent(
                                        password:
                                            viewModel.passwordController.text,
                                      ),
                                    );
                                  }
                                  FocusScope.of(context).unfocus();
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
