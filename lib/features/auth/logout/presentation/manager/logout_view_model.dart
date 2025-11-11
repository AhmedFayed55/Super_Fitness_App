import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/logout/domain/use_case/logout_use_case.dart';
import 'package:super_fitness_app/features/auth/logout/presentation/manager/logout_event.dart';
import 'package:super_fitness_app/features/auth/logout/presentation/manager/logout_state.dart';

@injectable
class LogoutViewModel extends Cubit<LogoutState> {
  final LogoutUseCase _logoutUseCase;

  LogoutViewModel(this._logoutUseCase) : super(LogoutState());

  doIntent(LogoutEvent event) {
    switch (event) {
      case SubmitLogoutEvent():
        _logout();
    }
  }

  void _logout() async {
    emit(state.copyWith(isLoading: true));
    var result = await _logoutUseCase.call();
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isLoading: false,
            logoutEntity: result.data,
            isSuccess: true,
          ),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.failure.errorMessage,
          ),
        );
    }
  }
}
