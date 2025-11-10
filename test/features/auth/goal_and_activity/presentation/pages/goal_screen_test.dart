import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/pages/goal_screen.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/widgets/goal_blocbuilder.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_state.dart';

import 'activity_screen_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();

    when(mockViewModel.state).thenReturn(const RegisterState());

    when(mockViewModel.stream).thenAnswer(
      (_) => Stream<RegisterState>.fromIterable([
        const RegisterState(),
        const RegisterState(goalSelected: 'Lose Weight'),
      ]),
    );

    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
    getIt.registerSingleton<RegisterViewModel>(mockViewModel);
  });

  testWidgets("Test GoalScreen", (WidgetTester tester) async {
    final localization = await AppLocalizations.delegate.load(
      const Locale('en'),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: BlocProvider<RegisterViewModel>.value(
            value: mockViewModel,
            child: GoalScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            (widget.text as TextSpan).toPlainText().contains(
              localization.what_is_your_goal,
            ),
      ),
      findsOneWidget,
    );

    expect(find.byType(GoalBlocBuilder), findsOneWidget);
  });
}
