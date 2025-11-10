import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';

class LogoutState {
  final bool isLoading;
  final String errorMessage;
  final bool isSuccess;
  final LogoutEntity? logoutEntity;

  LogoutState({
    this.isSuccess = false,
    this.isLoading = false,
    this.errorMessage = '',
    this.logoutEntity,
  });
  LogoutState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    LogoutEntity? logoutEntity,
  }) {
    return LogoutState(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      logoutEntity: logoutEntity ?? this.logoutEntity,
    );
  }
}
