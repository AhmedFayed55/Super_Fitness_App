import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_state.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/register_screen.dart';

import '../widget/custom_form_register_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();

    when(mockViewModel.state).thenReturn(const RegisterState());
    when(mockViewModel.stream).thenAnswer(
          (_) => Stream<RegisterState>.value(const RegisterState()),
    );

    when(mockViewModel.pageController).thenReturn(PageController());
    when(mockViewModel.firstName).thenReturn(TextEditingController());
    when(mockViewModel.lastName).thenReturn(TextEditingController());
    when(mockViewModel.emailController).thenReturn(TextEditingController());
    when(mockViewModel.passwordController).thenReturn(TextEditingController());

    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
    getIt.registerSingleton<RegisterViewModel>(mockViewModel);
  });

  testWidgets('RegisterScreen loads and shows first page', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider<RegisterViewModel>.value(
            value: mockViewModel,
            child: const RegisterScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(PageView), findsOneWidget);
  });
}
