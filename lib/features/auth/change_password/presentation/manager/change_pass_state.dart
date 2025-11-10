class ChangePasswordState {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isCurrentPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmNewPasswordVisible;
  final String showMessage;

  ChangePasswordState({
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.isCurrentPasswordVisible = false,
    this.isNewPasswordVisible = false,
    this.isConfirmNewPasswordVisible = false,
    this.showMessage = "",
  });

  ChangePasswordState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    bool? isCurrentPasswordVisible,
    bool? isNewPasswordVisible,
    bool? isConfirmNewPasswordVisible,
    String? showMessage,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      showMessage: showMessage ?? this.showMessage,
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isCurrentPasswordVisible:
          isCurrentPasswordVisible ?? this.isCurrentPasswordVisible,
      isConfirmNewPasswordVisible:
          isConfirmNewPasswordVisible ?? this.isConfirmNewPasswordVisible,
    );
  }
}
