import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/keys.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_state.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/mini_pages/selected_gender.dart';

import 'selected_gender_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();

    when(mockViewModel.state).thenReturn(RegisterState(gender: null));

    when(mockViewModel.stream).thenAnswer(
      (_) => Stream<RegisterState>.value(RegisterState(gender: null)),
    );

    when(mockViewModel.pageController).thenReturn(PageController());
  });

  testWidgets('SelectedGender widget shows correct texts and buttons', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider<RegisterViewModel>.value(
            value: mockViewModel,
            child: const SelectedGender(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key(AppKeys.selectedGenderTitle)), findsOneWidget);
    expect(
      find.byKey(const Key(AppKeys.selectedGenderSubtitle)),
      findsOneWidget,
    );

    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);

    final nextButton = find.widgetWithText(ElevatedButton, 'Next');
    expect(tester.widget<ElevatedButton>(nextButton).onPressed, isNull);
  });
testWidgets('Tapping on Male triggers onTap', (tester) async {
    when(mockViewModel.state).thenReturn(RegisterState(gender: 'male'));

  await tester.pumpWidget(
    MaterialApp(localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

      home: Scaffold(
        body: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const SelectedGender(),
        ),
      ),
    ),
  );

  await tester.pumpAndSettle();

  final maleOption = find.text('Male');
  expect(maleOption, findsOneWidget);

  await tester.tap(maleOption);
  await tester.pump();

  final nextButton = find.widgetWithText(ElevatedButton, 'Next');
  expect(tester.widget<ElevatedButton>(nextButton).onPressed, isNotNull);
});

  



  
  
  
  
}
