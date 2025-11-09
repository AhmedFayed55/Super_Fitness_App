import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/use_cases/change_pass_usecase.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_event.dart';
import 'change_pass_state.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _useCase;

  ChangePasswordViewModel(this._useCase) : super(ChangePasswordState());

  void doIntent(ChangePasswordEvent event) {
    switch (event) {
      case ChangePasswordSubmitted():
        _changePasswordSubmitted(event.changePasswordRequest);
        break;
      case IsCurrentPasswordVisible():
        _isCurrentPasswordVisible();
        break;
      case IsNewPasswordVisible():
        _isNewPasswordVisible();
        break;
      case IsConfirmNewPasswordVisible():
        _isConfirmNewPasswordVisible();
        break;
    }
  }

  void _changePasswordSubmitted(ChangePasswordRequest request) async {
    emit(state.copyWith(isLoading: true, isError: false));
    var result = await _useCase.call(request);
    switch (result) {
      case ApiSuccessResult<ChangePasswordEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            showMessage: result.data.message,
          ),
        );
      case ApiErrorResult<ChangePasswordEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            showMessage: result.failure.errorMessage,
          ),
        );
    }
  }

  void _isCurrentPasswordVisible() {
    emit(
      state.copyWith(
        isCurrentPasswordVisible: !state.isCurrentPasswordVisible,
        isError: false,
      ),
    );
  }

  void _isNewPasswordVisible() {
    emit(
      state.copyWith(
        isNewPasswordVisible: !state.isNewPasswordVisible,
        isError: false,
      ),
    );
  }

  void _isConfirmNewPasswordVisible() {
    emit(
      state.copyWith(
        isConfirmNewPasswordVisible: !state.isConfirmNewPasswordVisible,
        isError: false,
      ),
    );
  }
}
