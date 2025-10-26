import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';

class LoginScreenState extends Equatable{
  final bool isLoading;
  final UserResponseEntity? userData;
  final String? errorMsg;
  final bool isSuccess;
  final bool showToast;

  const LoginScreenState({
    this.isLoading = false,
    this.userData,
    this.errorMsg,
    this.isSuccess = false,
    this.showToast = false
  });

  LoginScreenState copyWith({
    bool? isLoading,
    UserResponseEntity? userData,
    String? errorMsg,
    bool? isSuccess,
    bool? showToast
  }) {
    return LoginScreenState(
      isLoading: isLoading ?? this.isLoading,
      userData: userData ?? this.userData,
      errorMsg: errorMsg ?? this.errorMsg,
      isSuccess: isSuccess ?? this.isSuccess,
      showToast: showToast ?? this.showToast
    );
  }

  @override
  List<Object?> get props => [isLoading,userData,errorMsg,isSuccess,showToast];
}