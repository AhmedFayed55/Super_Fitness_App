import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/components/custom_text_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/dialogue_utils.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_event.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/blur_container.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/build_otp_input_field.dart';

class ForgetPasswordOtpPage extends StatefulWidget {
  const ForgetPasswordOtpPage({super.key});

  @override
  State<ForgetPasswordOtpPage> createState() => _ForgetPasswordOtpPageState();
}

class _ForgetPasswordOtpPageState extends State<ForgetPasswordOtpPage> {
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
          previous.errors.errorOtp != current.errors.errorOtp ||
          previous.loading.isVerifyCodeSentLoading !=
              current.loading.isVerifyCodeSentLoading ||
          previous.isVerifyCodeSent != current.isVerifyCodeSent,
      listener: (context, state) {
        if (state.errors.errorOtp != null &&
            state.errors.errorOtp!.isNotEmpty) {
          DialogueUtils.showMessage(
            context: context,
            message: tr.otp_code_is_incorrect,
            title: tr.error,
            posActionName: tr.ok,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.loading.isOtpCorrectLoading !=
              current.loading.isOtpCorrectLoading ||
          previous.loading.isVerifyCodeSentLoading !=
              current.loading.isVerifyCodeSentLoading,
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
                    verticalSpace(height * 0.056),
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
                        tr.enter_otp_code,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.0426),
                      child: Text(
                        tr.check_your_email_for_the_code,
                        style: theme.textTheme.displayMedium,
                      ),
                    ),
                    verticalSpace(height * 0.02),

                    BlurContainer(
                      children: [
                        OtpInputField(controller: viewModel.otpController),
                        verticalSpace(height * 0.02),

                        CustomElevatedButton(
                          isLoading: state.loading.isOtpCorrectLoading,
                          widget: Text(tr.confirm),
                          onPressed: state.loading.isOtpCorrectLoading
                              ? () {}
                              : () {
                                  final otp = viewModel.otpController.text;
                                  if (otp.length == 6) {
                                    FocusScope.of(context).unfocus();
                                    viewModel.doIntent(
                                      VerifyCodeEvent(code: otp),
                                    );
                                  }
                                },
                        ),

                        verticalSpace(height * 0.02),

                        Column(
                          children: [
                            Text(
                              tr.didnt_receive_verification_code,
                              style: theme.textTheme.bodyMedium,
                            ),
                            CustomTextButton(
                              isLoading: state.loading.isVerifyCodeSentLoading,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (state.email != null) {
                                  viewModel.doIntent(
                                    ForgetPasswordEvent(email: state.email!),
                                  );
                                }
                              },
                              text: tr.resend_code,
                            ),
                          ],
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
