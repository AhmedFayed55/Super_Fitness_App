import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_state.dart';

void main() {
  group('ForgetPasswordState', () {
    test('Default constructor sets expected initial values', () {
      const state = ForgetPasswordState();

      expect(state.isVerifyCodeSent, false);
      expect(state.isOtpCorrect, false);
      expect(state.isPasswordReset, false);
      expect(state.email, '');
      expect(state.loading, const ForgetPasswordLoading());
      expect(state.errors, const ForgetPasswordErrors());
      expect(state.isPasswordObscure, true);
    });

    test('copyWith updates only provided fields', () {
      const original = ForgetPasswordState();
      final updated = original.copyWith(
        isVerifyCodeSent: true,
        email: 'test@example.com',
        isPasswordObscure: false,
      );

      expect(updated.isVerifyCodeSent, true);
      expect(updated.email, 'test@example.com');
      expect(updated.isPasswordObscure, false);

      expect(updated.isOtpCorrect, original.isOtpCorrect);
      expect(updated.errors, original.errors);
    });

    test('Equatable correctly compares identical objects', () {
      const s1 = ForgetPasswordState();
      const s2 = ForgetPasswordState();

      expect(s1, equals(s2));
    });

    test('Equatable detects differences correctly', () {
      const s1 = ForgetPasswordState();
      final s2 = s1.copyWith(isVerifyCodeSent: true);

      expect(s1 == s2, false);
    });
  });

  group('ForgetPasswordLoading', () {
    test('Default constructor sets all loading flags to false', () {
      const loading = ForgetPasswordLoading();

      expect(loading.isVerifyCodeSentLoading, false);
      expect(loading.isOtpCorrectLoading, false);
      expect(loading.isPasswordResetLoading, false);
    });

    test('copyWith updates specific loading values', () {
      const original = ForgetPasswordLoading();
      final updated = original.copyWith(isOtpCorrectLoading: true);

      expect(updated.isOtpCorrectLoading, true);
      expect(updated.isVerifyCodeSentLoading, false);
    });

    test('Equatable correctly compares identical loading states', () {
      const l1 = ForgetPasswordLoading();
      const l2 = ForgetPasswordLoading();
      expect(l1, equals(l2));
    });
  });

  group('ForgetPasswordErrors', () {
    test('Default constructor sets all error fields to empty string', () {
      const errors = ForgetPasswordErrors();

      expect(errors.errorEmail, '');
      expect(errors.errorOtp, '');
      expect(errors.errorPassword, '');
    });

    test('copyWith updates specific error fields', () {
      const original = ForgetPasswordErrors();
      final updated = original.copyWith(errorEmail: 'invalid email');

      expect(updated.errorEmail, 'invalid email');
      expect(updated.errorOtp, '');
    });

    test('Equatable correctly compares identical error objects', () {
      const e1 = ForgetPasswordErrors();
      const e2 = ForgetPasswordErrors();
      expect(e1, equals(e2));
    });

    test('Equatable detects difference between error objects', () {
      const e1 = ForgetPasswordErrors();
      final e2 = e1.copyWith(errorPassword: 'weak');
      expect(e1 == e2, false);
    });
  });
}
