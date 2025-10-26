sealed class ForgetPasswordPageEvent {}

class ForgetPasswordEvent extends ForgetPasswordPageEvent {
  ForgetPasswordEvent();
}

class ResetPasswordEvent extends ForgetPasswordPageEvent {
  ResetPasswordEvent();
}

class VerifyCodeEvent extends ForgetPasswordPageEvent {
  VerifyCodeEvent();
}

class TogglePasswordVisibilityEvent extends ForgetPasswordPageEvent {}
