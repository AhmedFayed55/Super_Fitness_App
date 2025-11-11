import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/keys.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_circle_avatar.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_form_register.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/register_actions.dart';

import '../../../goal_and_activity/presentation/pages/activity_screen_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockRegisterViewModel;

  setUp(() {
    mockRegisterViewModel = MockRegisterViewModel();

    when(mockRegisterViewModel.pageController).thenReturn(PageController());

    when(mockRegisterViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockRegisterViewModel.firstName).thenReturn(TextEditingController());
    when(mockRegisterViewModel.lastName).thenReturn(TextEditingController());
    when(
      mockRegisterViewModel.emailController,
    ).thenReturn(TextEditingController());
    when(
      mockRegisterViewModel.passwordController,
    ).thenReturn(TextEditingController());
  });

  testWidgets('custom form register', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider<RegisterViewModel>.value(
            value: mockRegisterViewModel,
            child: const CustomFormRegister(),
          ),
        ),
      ),
    );

    expect(find.byType(RegisterActions), findsNWidgets(1));

    expect(find.byType(CustomCircleAvatar), findsNWidgets(3));

    expect(find.byKey(const Key(AppKeys.alreadyHaveAccount)), findsOneWidget);
    expect(find.byKey(const Key(AppKeys.loginTextButton)), findsOneWidget);
  });

  testWidgets('action in register button', (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: RegisterActions(
            onTapRegister: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    final registerButton = find.byKey(const Key(AppKeys.registerAction));
    await tester.tap(registerButton);
    await tester.pumpAndSettle();
    expect(wasTapped, isTrue);
  });
}
