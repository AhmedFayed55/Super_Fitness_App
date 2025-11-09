import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/dialogue_utils.dart';
import 'package:super_fitness_app/core/helpers/flutter_toast.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/helpers/validators.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_event.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_state.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_view_model.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/widgets/password_field.dart';

class PasswordFormSection extends StatefulWidget {
  const PasswordFormSection({super.key});

  @override
  State<PasswordFormSection> createState() => _PasswordFormSectionState();
}

class _PasswordFormSectionState extends State<PasswordFormSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmNewPassController = TextEditingController();

  @override
  void dispose() {
    currentPassController.dispose();
    newPassController.dispose();
    confirmNewPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey[10]!,
              blurStyle: BlurStyle.inner,
              blurRadius: 10,
            ),
          ],
        ),
        child: BlocConsumer<ChangePasswordViewModel, ChangePasswordState>(
          /// Listener
          listener: (context, state) {
            if (state.isError) {
              DialogueUtils.showAlertDialog(context, state.showMessage);
            } else if (state.isSuccess) {
              ToastMessage.toastMsg(state.showMessage).then((value) {
                if (!context.mounted) return;
                context.pushNamedAndRemoveUntil(
                  AppRoutes.login,
                  predicate: (route) => false,
                );
              });
            }
          },

          /// Builder
          builder: (context, state) {
            var cubit = context.read<ChangePasswordViewModel>();
            return Column(
              children: [
                PasswordField(
                  controller: currentPassController,
                  hintText: context.localization.current_password,
                  isVisible: state.isCurrentPasswordVisible,
                  onPressed: () {
                    cubit.doIntent(IsCurrentPasswordVisible());
                  },
                  validator: (value) {
                    return Validations.validatePassword(
                      context,
                      currentPassController.text,
                    );
                  },
                ),
                verticalSpace(24),
                PasswordField(
                  controller: newPassController,
                  hintText: context.localization.new_password,
                  isVisible: state.isNewPasswordVisible,
                  onPressed: () {
                    cubit.doIntent(IsNewPasswordVisible());
                  },
                  validator: (value) {
                    return Validations.validateConfirmPassword(
                      context,
                      newPassController.text,
                      confirmNewPassController.text,
                    );
                  },
                ),
                verticalSpace(24),
                PasswordField(
                  controller: confirmNewPassController,
                  hintText: context.localization.confirm_new_password,
                  isVisible: state.isConfirmNewPasswordVisible,
                  onPressed: () {
                    cubit.doIntent(IsConfirmNewPasswordVisible());
                  },
                  validator: (value) {
                    return Validations.validateConfirmPassword(
                      context,
                      newPassController.text,
                      confirmNewPassController.text,
                    );
                  },
                ),
                verticalSpace(24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.doIntent(
                        ChangePasswordSubmitted(
                          changePasswordRequest: ChangePasswordRequest(
                            password: currentPassController.text,
                            newPassword: newPassController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: state.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : Text(context.localization.done),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
