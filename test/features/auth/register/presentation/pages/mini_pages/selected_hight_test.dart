import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/keys.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_state.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/mini_pages/selected_hight.dart';
import '../../../../goal_and_activity/presentation/pages/activity_screen_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();

    when(mockViewModel.state).thenReturn(const RegisterState(height: 170));

    when(mockViewModel.stream).thenAnswer(
      (_) => Stream<RegisterState>.value(const RegisterState(height: 170)),
    );

    when(mockViewModel.pageController).thenReturn(PageController());
  });

  testWidgets('SelectedHight widget shows correct initial hight and texts', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const SelectedHight(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key(AppKeys.selectedHightTitle)), findsOneWidget);
    expect(
      find.byKey(const Key(AppKeys.selectedHightSubtitle)),
      findsOneWidget,
    );
    expect(find.text('170'), findsOneWidget);
    expect(find.byKey(const Key(AppKeys.selectedHightButton)), findsOneWidget);
  });
}
