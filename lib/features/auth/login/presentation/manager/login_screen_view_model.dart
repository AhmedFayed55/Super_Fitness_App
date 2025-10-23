import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_event.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_state.dart';

@injectable
class LoginScreenViewModel extends Cubit<LoginScreenState> {
  LoginScreenViewModel(this._useCase) : super(const LoginScreenState());

  final LoginUseCase _useCase;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  doIntent(LoginScreenEvent event) {
    switch (event) {
      case SubmitLoginEvent():
        _login(
          LoginRequestEntity(
            email: emailController.text,
            password: passController.text,
          ),
        );
    }
  }

  Future<void> _login(LoginRequestEntity request) async {
    emit(state.copyWith(isLoading: true, errorMsg: null, userData: null,isSuccess: false,showToast: false));
    var response = await _useCase.invoke(request);

    switch (response) {
      case ApiSuccessResult<UserResponseEntity>():
        emit(state.copyWith(isLoading: false, userData: response.data,isSuccess: true));
      case ApiErrorResult<UserResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMsg: response.failure.errorMessage,
            showToast: true
          ),
        );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passController.dispose();
    return super.close();
  }
}