import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_event.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_view_model.dart';

import 'login_screen_view_model_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {

  late LoginUseCase useCase;
  late LoginScreenViewModel viewModel;
  late UserResponseEntity successResponse;
  late LoginRequestEntity requestEntity;

  setUp((){
    useCase = MockLoginUseCase();
    viewModel = LoginScreenViewModel(useCase);
    successResponse = const UserResponseEntity(
      id: "65312",firstName: "Ahmed"
    );
    requestEntity = const LoginRequestEntity(email: "ahmed@gmail.com", password: "Ahmed@123");
  });

  group("doIntent -> login", (){

    test("initial state should have default values", () {
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.isSuccess, false);
      expect(viewModel.state.userData, null);
      expect(viewModel.state.errorMsg, null);
      expect(viewModel.state.showToast, false);
    });

    test("emit success state when response is ApiSuccessResult", () async {
      var successLogin = ApiSuccessResult<UserResponseEntity>(data: successResponse);

      provideDummy<ApiResult<UserResponseEntity>>(successLogin);

      when(useCase.invoke(requestEntity)).thenAnswer((_) async => successLogin);

      viewModel.emailController.text = requestEntity.email;
      viewModel.passController.text = requestEntity.password;

      await viewModel.doIntent(SubmitLoginEvent());

      verify(useCase.invoke(requestEntity)).called(1);

      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.userData, equals(successLogin.data));
      expect(viewModel.state.isSuccess, true);
      expect(viewModel.state.errorMsg, null);
      expect(viewModel.state.showToast, false);
    });

    test("emit error state when response is ApiErrorResult", () async {
      var errorResponse = ApiErrorResult<UserResponseEntity>(
        failure: ServerFailure(errorMessage: "wrong email or password"),
      );

      provideDummy<ApiResult<UserResponseEntity>>(errorResponse);

      when(useCase.invoke(requestEntity)).thenAnswer((_) async => errorResponse);

      viewModel.emailController.text = requestEntity.email;
      viewModel.passController.text = requestEntity.password;

      await viewModel.doIntent(SubmitLoginEvent());

      verify(useCase.invoke(requestEntity)).called(1);

      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.userData, null);
      expect(viewModel.state.isSuccess, false);
      expect(viewModel.state.errorMsg, equals(errorResponse.failure.errorMessage));
      expect(viewModel.state.showToast, true);
    });


  });
}