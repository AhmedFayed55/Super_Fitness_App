import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/use_cases/change_pass_usecase.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_event.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_view_model.dart';
import 'change_pass_view_model_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  late MockChangePasswordUseCase mockUseCase;
  late ChangePasswordViewModel changePasswordViewModel;
  late ChangePasswordEntity changePasswordEntity;
  late ChangePasswordRequest request;
  late String showMessage;

  setUp(() {
    showMessage = "message";
    changePasswordEntity = ChangePasswordEntity(
      message: "message",
      token: "token",
    );
    request = ChangePasswordRequest(
      password: "password",
      newPassword: "newPassword",
    );
    mockUseCase = MockChangePasswordUseCase();
    changePasswordViewModel = ChangePasswordViewModel(mockUseCase);
  });

  group("Test ChangePasswordViewModel", () {
    test(
      "Success Case for ChangePasswordViewModel with ApiSuccessResult",
      () async {
        ///Arrange
        var mockSuccessResult = ApiSuccessResult<ChangePasswordEntity>(
          data: changePasswordEntity,
        );
        provideDummy<ApiResult<ChangePasswordEntity>>(mockSuccessResult);

        when(
          mockUseCase.call(request),
        ).thenAnswer((_) async => mockSuccessResult);

        ///Act
        await changePasswordViewModel.doIntent(
          ChangePasswordSubmitted(changePasswordRequest: request),
        );

        ///Assert
        expect(changePasswordViewModel.state.isLoading, false);
        expect(changePasswordViewModel.state.isSuccess, true);
        expect(changePasswordViewModel.state.showMessage, showMessage);

        verify(mockUseCase.call(request)).called(1);
      },
    );

    test(
      "Error Case for ChangePasswordViewModel with ApiErrorResult",
      () async {
        ///Arrange
        var errorResult = ApiErrorResult<ChangePasswordEntity>(
          failure: Failure(errorMessage: "message"),
        );
        provideDummy<ApiResult<ChangePasswordEntity>>(errorResult);

        when(mockUseCase.call(request)).thenAnswer((_) async => errorResult);

        ///Act
        await changePasswordViewModel.doIntent(
          ChangePasswordSubmitted(changePasswordRequest: request),
        );

        ///Assert
        expect(changePasswordViewModel.state.isLoading, false);
        expect(changePasswordViewModel.state.isError, true);
        expect(changePasswordViewModel.state.showMessage, showMessage);

        verify(mockUseCase.call(request)).called(1);
      },
    );

    test("Change isCurrentPasswordVisible", () async {
      ///Arrange
      final state = changePasswordViewModel.state.isCurrentPasswordVisible;

      ///Act
      await changePasswordViewModel.doIntent(IsCurrentPasswordVisible());

      ///Assert
      expect(changePasswordViewModel.state.isCurrentPasswordVisible, !state);
      expect(changePasswordViewModel.state.isError, false);

      verifyNever(mockUseCase.call(any));
    });

    test("Change isNewPasswordVisible", () async {
      ///Arrange
      final state = changePasswordViewModel.state.isNewPasswordVisible;

      ///Act
      await changePasswordViewModel.doIntent(IsNewPasswordVisible());

      ///Assert
      expect(changePasswordViewModel.state.isNewPasswordVisible, !state);
      expect(changePasswordViewModel.state.isError, false);

      verifyNever(mockUseCase.call(any));
    });

    test("Change isConfirmNewPasswordVisible", () async {
      ///Arrange
      final state = changePasswordViewModel.state.isConfirmNewPasswordVisible;

      ///Act
      await changePasswordViewModel.doIntent(IsConfirmNewPasswordVisible());

      ///Assert
      expect(changePasswordViewModel.state.isConfirmNewPasswordVisible, !state);
      expect(changePasswordViewModel.state.isError, false);

      verifyNever(mockUseCase.call(any));
    });
  });
}
