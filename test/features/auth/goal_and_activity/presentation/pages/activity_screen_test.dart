import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/pages/activity_screen.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/widgets/activity_blocbuilder.dart';
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
        const RegisterState(activitySelected: 'beginner'),
      ]),
    );

    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
    getIt.registerSingleton<RegisterViewModel>(mockViewModel);
  });

  testWidgets('Test ActivityScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: BlocProvider<RegisterViewModel>.value(
            value: mockViewModel,
            child: ActivityScreen(),
          ),
        ),
      ),
    );

    final localization = await AppLocalizations.delegate.load(
      const Locale('en'),
    );

    expect(
      find.text(localization.your_regular_physical_activity_level),
      findsOneWidget,
    );

    expect(find.byType(ActivityBlocBuilder), findsOneWidget);

    await tester.pump();
  });
}
