import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/reset_password_use_case.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/verify_reset_code_use_case.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_event.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_state.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyCodeUseCase;

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ForgetPasswordViewModel(
    this._forgetPasswordUseCase,
    this._resetPasswordUseCase,
    this._verifyCodeUseCase,
  ) : super(const ForgetPasswordState());

  Future<void> doIntent(ForgetPasswordPageEvent event) async {
    switch (event) {
      case ForgetPasswordEvent():
        await forgetPassword(event.email);
        break;

      case VerifyCodeEvent():
        await verifyCode(event.code);
        break;

      case ResetPasswordEvent():
        await resetPassword(event.password);
        break;

      case TogglePasswordVisibilityEvent():
        emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
        break;
      case CloseForgetPasswordEvent():
        await _close();
        break;
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(
      state.copyWith(
        email: email,
        loading: const ForgetPasswordLoading(
          isVerifyCodeSentLoading: true,
          isOtpCorrectLoading: false,
          isPasswordResetLoading: false,
        ),
        errors: const ForgetPasswordErrors(
          errorOtp: null,
          errorEmail: null,
          errorPassword: null,
        ),
      ),
    );

    final result = await _forgetPasswordUseCase.invoke(
      ForgetPasswordRequestEntity(email: email),
    );

    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isVerifyCodeSent: true,
            loading: const ForgetPasswordLoading(
              isVerifyCodeSentLoading: false,
              isOtpCorrectLoading: false,
              isPasswordResetLoading: false,
            ),
            errors: const ForgetPasswordErrors(),
            email: email,
          ),
        );
        break;

      case ApiErrorResult():
        emit(
          state.copyWith(
            isVerifyCodeSent: false,
            loading: const ForgetPasswordLoading(),
            errors: ForgetPasswordErrors(
              errorEmail: result.failure.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> verifyCode(String code) async {
    emit(
      state.copyWith(
        loading: const ForgetPasswordLoading(
          isVerifyCodeSentLoading: false,
          isOtpCorrectLoading: true,
          isPasswordResetLoading: false,
        ),
        errors: const ForgetPasswordErrors(),
      ),
    );

    final result = await _verifyCodeUseCase.invoke(
      VerifyResetCodeRequestEntity(resetCode: code),
    );

    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isOtpCorrect: true,
            loading: const ForgetPasswordLoading(),
          ),
        );
        break;

      case ApiErrorResult():
        emit(
          state.copyWith(
            isOtpCorrect: false,
            loading: const ForgetPasswordLoading(),
            errors: ForgetPasswordErrors(errorOtp: result.failure.errorMessage),
          ),
        );
        break;
    }
  }

  Future<void> resetPassword(String password) async {
    emit(
      state.copyWith(
        loading: const ForgetPasswordLoading(
          isPasswordResetLoading: true,
          isVerifyCodeSentLoading: false,
          isOtpCorrectLoading: false,
        ),
        errors: const ForgetPasswordErrors(),
      ),
    );

    final result = await _resetPasswordUseCase.invoke(
      ResetPasswordRequestEntity(
        newPassword: password,
        email: state.email ?? "",
      ),
    );

    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isPasswordReset: true,
            loading: const ForgetPasswordLoading(),
          ),
        );
        break;

      case ApiErrorResult():
        emit(
          state.copyWith(
            loading: const ForgetPasswordLoading(),
            errors: ForgetPasswordErrors(
              errorPassword: result.failure.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  @override
  Future<void> _close() {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
