sealed class LoginScreenEvent {}

class SubmitLoginEvent extends LoginScreenEvent {
  String email;
  String password;
  SubmitLoginEvent({required this.email, required this.password});
}
