sealed class ForgetPasswordPageEvent {}

class ForgetPasswordEvent extends ForgetPasswordPageEvent {
  final String email;
  ForgetPasswordEvent({required this.email});
}

class VerifyCodeEvent extends ForgetPasswordPageEvent {
  final String code;
  VerifyCodeEvent({required this.code});
}

class ResetPasswordEvent extends ForgetPasswordPageEvent {
  final String password;
  ResetPasswordEvent({required this.password});
}

class TogglePasswordVisibilityEvent extends ForgetPasswordPageEvent {}

class CloseForgetPasswordEvent extends ForgetPasswordPageEvent {}
