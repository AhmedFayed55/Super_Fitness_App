import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/helpers/validators.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

Future<void> _pumpLocalizedWidget(
  WidgetTester tester,
  void Function(BuildContext context) testBody,
) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          testBody(context);
          return const SizedBox.shrink();
        },
      ),
    ),
  );
}

void main() {
  group("Name Validation Test", () {
    testWidgets("when empty should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateName(context, ""),
          AppLocalizations.of(context)!.name_is_required,
        );
      });
    });

    testWidgets("when invalid should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateName(context, "A"),
          AppLocalizations.of(context)!.name_is_not_valid,
        );
      });
    });

    testWidgets("when valid should return null", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(Validations.validateName(context, "Ahmed"), null);
      });
    });
  });

  group("Email Validation Test", () {
    testWidgets("when empty should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateEmail(context, ""),
          AppLocalizations.of(context)!.email_is_required,
        );
      });
    });

    testWidgets("when invalid should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateEmail(context, "ahmedfayed.com"),
          AppLocalizations.of(context)!.email_is_not_valid,
        );
      });
    });

    testWidgets("when valid should return null", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateEmail(context, "ahmedfayed@gmail.com"),
          null,
        );
      });
    });
  });

  group("Password Validation Test", () {
    testWidgets("when empty should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validatePassword(context, ""),
          AppLocalizations.of(context)!.password_is_required,
        );
      });
    });

    testWidgets("when invalid should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validatePassword(context, "123456"),
          AppLocalizations.of(context)!.password_is_not_valid,
        );
      });
    });

    testWidgets("when valid should return null", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(Validations.validatePassword(context, "A7medfayed@5"), null);
      });
    });
  });

  group("Phone number Validation", () {
    testWidgets("when empty should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validatePhoneNumber(context, ""),
          AppLocalizations.of(context)!.phone_number_is_required,
        );
      });
    });

    testWidgets("when invalid should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validatePhoneNumber(context, "0115916"),
          AppLocalizations.of(context)!.phone_number_is_not_valid,
        );
      });
    });

    testWidgets("when valid should return null", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(Validations.validatePhoneNumber(context, "01096640218"), null);
      });
    });
  });

  group("Confirm password Validation", () {
    const String password = "A7medfayed@5";

    testWidgets("when empty should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateConfirmPassword(context, password, ""),
          AppLocalizations.of(context)!.confirm_password_is_required,
        );
      });
    });

    testWidgets("when invalid should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateConfirmPassword(context, password, "12354341"),
          AppLocalizations.of(context)!.confirm_password_is_not_valid,
        );
      });
    });

    testWidgets("when not match should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateConfirmPassword(context, password, "A7medfayd@5"),
          AppLocalizations.of(
            context,
          )!.password_and_confirm_password_must_be_same,
        );
      });
    });

    testWidgets("when valid should return null", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateConfirmPassword(
            context,
            password,
            "A7medfayed@5",
          ),
          null,
        );
      });
    });
  });

  group("Required Field Validation Test", () {
    testWidgets("when empty should return error", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(
          Validations.validateRequired(context, ""),
          AppLocalizations.of(context)!.this_field_is_required,
        );
      });
    });

    testWidgets("when filled should return null", (tester) async {
      await _pumpLocalizedWidget(tester, (context) {
        expect(Validations.validateRequired(context, "Some value"), null);
      });
    });
  });
}
