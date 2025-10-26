import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/keys.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_state.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/mini_pages/selected_weight.dart';

import 'selected_weight_test.mocks.dart';


@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();

    when(mockViewModel.state).thenReturn(RegisterState(weight: 150));

    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream<RegisterState>.value(RegisterState(weight: 150)));

    when(mockViewModel.pageController).thenReturn(PageController());
  });

  testWidgets('SelectedWeight widget shows correct initial Weight and texts', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const SelectedWeight(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key(AppKeys.selectedWeightTitle)), findsOneWidget);
    expect(find.byKey(const Key(AppKeys.selectedWeightSubtitle)), findsOneWidget);
    expect(find.text('150'), findsOneWidget);
    expect(find.byKey(const Key(AppKeys.selectedWeightButton)), findsOneWidget);
  });
}
