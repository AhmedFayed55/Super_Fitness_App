import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/forget_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/verify_reset_code_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/reset_password_use_case.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/verify_reset_code_use_case.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_event.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';

import 'forget_password_view_model_test.mocks.dart';

@GenerateMocks([
  ForgetPasswordUseCase,
  ResetPasswordUseCase,
  VerifyResetCodeUseCase,
])
void main() {
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockVerifyResetCodeUseCase mockVerifyResetCodeUseCase;
  late ForgetPasswordViewModel vm;

  setUpAll(() {
    provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<ResetPasswordResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
  });

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockVerifyResetCodeUseCase = MockVerifyResetCodeUseCase();
    vm = ForgetPasswordViewModel(
      mockForgetPasswordUseCase,
      mockResetPasswordUseCase,
      mockVerifyResetCodeUseCase,
    );
  });

  tearDown(() async {
    await vm.close();
  });

  const forgetPasswordResponse = ForgetPasswordResponseEntity(
    message: 'OK',
    info: "Reset code sent",
  );
  const verifyCodeResponse = VerifyResetCodeResponseEntity(status: 'OK');
  const resetPasswordResponse = ResetPasswordResponseEntity(
    message: 'done',
    token: 'token',
  );

  group('ForgetPasswordViewModel Tests', () {
    test('forgetPassword success emits isVerifyCodeSent = true', () async {
      when(
        mockForgetPasswordUseCase.invoke(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: forgetPasswordResponse));

      await vm.forgetPassword('test@example.com');

      expect(vm.state.isVerifyCodeSent, true);
      expect(vm.state.errors.errorEmail, isEmpty);
      expect(vm.state.loading.isVerifyCodeSentLoading, false);
    });

    test('forgetPassword error updates errorEmail', () async {
      when(mockForgetPasswordUseCase.invoke(any)).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: 'email error')),
      );

      await vm.forgetPassword('fail@example.com');

      expect(vm.state.isVerifyCodeSent, false);
      expect(vm.state.errors.errorEmail, 'email error');
      expect(vm.state.loading.isVerifyCodeSentLoading, false);
    });

    test('verifyCode success sets isOtpCorrect = true', () async {
      when(
        mockVerifyResetCodeUseCase.invoke(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: verifyCodeResponse));

      await vm.verifyCode('1234');

      expect(vm.state.isOtpCorrect, true);
      expect(vm.state.errors.errorOtp, isEmpty);
    });

    test('verifyCode error sets errorOtp', () async {
      when(mockVerifyResetCodeUseCase.invoke(any)).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: 'invalid code')),
      );

      await vm.verifyCode('9999');

      expect(vm.state.isOtpCorrect, false);
      expect(vm.state.errors.errorOtp, 'invalid code');
    });

    test('resetPassword success sets isPasswordReset = true', () async {
      vm.emit(vm.state.copyWith(email: 'a@b.com'));
      when(
        mockResetPasswordUseCase.invoke(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: resetPasswordResponse));

      await vm.resetPassword('newpass');

      expect(vm.state.isPasswordReset, true);
      expect(vm.state.errors.errorEmail, isEmpty);
    });

    test('resetPassword error sets errorPassword', () async {
      vm.emit(vm.state.copyWith(email: 'a@b.com'));
      when(mockResetPasswordUseCase.invoke(any)).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: 'weak password')),
      );

      await vm.resetPassword('123');

      expect(vm.state.isPasswordReset, false);
      expect(vm.state.errors.errorPassword, 'weak password');
    });

    test('togglePasswordVisibility toggles isPasswordObscure flag', () {
      final initial = vm.state.isPasswordObscure;
      vm.togglePasswordVisibility();
      expect(vm.state.isPasswordObscure, !initial);
    });

    test(
      'doIntent dispatches ForgetPasswordEvent with email correctly',
      () async {
        when(mockForgetPasswordUseCase.invoke(any)).thenAnswer(
          (_) async => ApiSuccessResult(data: forgetPasswordResponse),
        );

        await vm.doIntent(ForgetPasswordEvent(email: 'mail@test.com'));

        expect(vm.state.isVerifyCodeSent, true);
      },
    );

    test('doIntent dispatches VerifyCodeEvent with code correctly', () async {
      when(
        mockVerifyResetCodeUseCase.invoke(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: verifyCodeResponse));

      await vm.doIntent(VerifyCodeEvent(code: '9999'));

      expect(vm.state.isOtpCorrect, true);
    });

    test(
      'doIntent dispatches ResetPasswordEvent with password correctly',
      () async {
        vm.emit(vm.state.copyWith(email: 'a@b.com'));
        when(mockResetPasswordUseCase.invoke(any)).thenAnswer(
          (_) async => ApiSuccessResult(data: resetPasswordResponse),
        );

        await vm.doIntent(ResetPasswordEvent(password: 'secret'));

        expect(vm.state.isPasswordReset, true);
      },
    );

    test(
      'doIntent dispatches TogglePasswordVisibilityEvent correctly',
      () async {
        final initial = vm.state.isPasswordObscure;
        await vm.doIntent(TogglePasswordVisibilityEvent());
        expect(vm.state.isPasswordObscure, !initial);
      },
    );

    test(
      'doIntent dispatches CloseForgetPasswordEvent and disposes controllers',
      () async {
        await vm.doIntent(CloseForgetPasswordEvent());
        expect(() => vm.emailController.text, returnsNormally);
      },
    );
  });
}
