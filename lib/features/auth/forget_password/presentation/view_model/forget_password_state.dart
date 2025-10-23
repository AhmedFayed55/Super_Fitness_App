import 'package:equatable/equatable.dart';

class ForgetPasswordState extends Equatable {
  final bool isVerifyCodeSent;
  final bool isOtpCorrect;
  final bool isPasswordReset;
  final String? email;

  final ForgetPasswordLoading loading;
  final ForgetPasswordErrors errors;

  final bool isPasswordObscure;

  const ForgetPasswordState({
    this.isVerifyCodeSent = false,
    this.isOtpCorrect = false,
    this.isPasswordReset = false,
    this.email = '',
    this.loading = const ForgetPasswordLoading(),
    this.errors = const ForgetPasswordErrors(),
    this.isPasswordObscure = true,
  });

  ForgetPasswordState copyWith({
    bool? isVerifyCodeSent,
    bool? isOtpCorrect,
    bool? isPasswordReset,
    String? email,
    ForgetPasswordLoading? loading,
    ForgetPasswordErrors? errors,
    bool? isPasswordObscure,
  }) {
    return ForgetPasswordState(
      isVerifyCodeSent: isVerifyCodeSent ?? this.isVerifyCodeSent,
      isOtpCorrect: isOtpCorrect ?? this.isOtpCorrect,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      email: email ?? this.email,
      loading: loading ?? this.loading,
      errors: errors ?? this.errors,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }

  @override
  List<Object?> get props => [
    isVerifyCodeSent,
    isOtpCorrect,
    isPasswordReset,
    email,
    loading,
    errors,
    isPasswordObscure,
  ];
}

class ForgetPasswordLoading extends Equatable {
  final bool isVerifyCodeSentLoading;
  final bool isOtpCorrectLoading;
  final bool isPasswordResetLoading;

  const ForgetPasswordLoading({
    this.isVerifyCodeSentLoading = false,
    this.isOtpCorrectLoading = false,
    this.isPasswordResetLoading = false,
  });

  ForgetPasswordLoading copyWith({
    bool? isVerifyCodeSentLoading,
    bool? isOtpCorrectLoading,
    bool? isPasswordResetLoading,
  }) {
    return ForgetPasswordLoading(
      isVerifyCodeSentLoading:
          isVerifyCodeSentLoading ?? this.isVerifyCodeSentLoading,
      isOtpCorrectLoading: isOtpCorrectLoading ?? this.isOtpCorrectLoading,
      isPasswordResetLoading:
          isPasswordResetLoading ?? this.isPasswordResetLoading,
    );
  }

  @override
  List<Object?> get props => [
    isVerifyCodeSentLoading,
    isOtpCorrectLoading,
    isPasswordResetLoading,
  ];
}

class ForgetPasswordErrors extends Equatable {
  final String? errorOtp;
  final String? errorEmail;
  final String? errorPassword;

  const ForgetPasswordErrors({
    this.errorOtp = '',
    this.errorEmail = '',
    this.errorPassword = '',
  });

  ForgetPasswordErrors copyWith({
    String? errorOtp,
    String? errorEmail,
    String? errorPassword,
  }) {
    return ForgetPasswordErrors(
      errorOtp: errorOtp ?? this.errorOtp,
      errorEmail: errorEmail ?? this.errorEmail,
      errorPassword: errorPassword ?? this.errorPassword,
    );
  }

  @override
  List<Object?> get props => [errorOtp, errorEmail, errorPassword];
}
