import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_state.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_view_model.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/widgets/password_form_section.dart';

import 'password_field_test.mocks.dart';

@GenerateMocks([ChangePasswordViewModel])
void main() {
  late MockChangePasswordViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockChangePasswordViewModel();
    when(mockViewModel.state).thenReturn(ChangePasswordState());
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
    if (getIt.isRegistered<ChangePasswordViewModel>()) {
      getIt.unregister<ChangePasswordViewModel>();
    }

    getIt.registerSingleton<ChangePasswordViewModel>(mockViewModel);
  });

  testWidgets("Test password fields and button en", (tester) async {
    // Arrange
    when(mockViewModel.state).thenReturn(ChangePasswordState());

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale("en"),
        home: BlocProvider<ChangePasswordViewModel>.value(
          value: mockViewModel,
          child: const Scaffold(body: PasswordFormSection()),
        ),
      ),
    );

    // Act
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets("Test password fields and button ar", (tester) async {
    // Arrange
    when(mockViewModel.state).thenReturn(ChangePasswordState());

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale("ar"),
        home: BlocProvider<ChangePasswordViewModel>.value(
          value: mockViewModel,
          child: const Scaffold(body: PasswordFormSection()),
        ),
      ),
    );

    // Act
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
