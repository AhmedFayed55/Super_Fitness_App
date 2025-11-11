import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/w_g_a_data_widget.dart';

import 'w_g_a_data_widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<EditProfileCubit>(),
  MockSpec<NavigatorObserver>(),
])
void main() {
  late MockEditProfileCubit mockCubit;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockCubit = MockEditProfileCubit();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Widget createWidgetUnderTest({
    required int weight,
    required String goal,
    required String activityLevel,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<EditProfileCubit>.value(
          value: mockCubit,
          child: WGADataWidget(
            weight: weight,
            goal: goal,
            activityLevel: activityLevel,
          ),
        ),
      ),
      navigatorObservers: [mockNavigatorObserver],

      routes: {
        AppRoutes.weightGoalActivityEdit: (context) =>
            const Scaffold(body: Center(child: Text('Edit Screen'))),
      },
    );
  }

  group('WGADataWidget Tests', () {
    testWidgets('should display all provided data correctly', (
      WidgetTester tester,
    ) async {
      // Arrange
      const weight = 75;
      const goal = 'Lose Weight';
      const activityLevel = 'Moderate';

      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: weight,
          goal: goal,
          activityLevel: activityLevel,
        ),
      );

      // Assert
      expect(find.text('$weight KG'), findsOneWidget);
      expect(find.text(goal), findsOneWidget);
      expect(find.text(activityLevel), findsOneWidget);
    });

    testWidgets('should display all three editable labels', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 70,
          goal: 'Build Muscle',
          activityLevel: 'High',
        ),
      );

      // Assert
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(RichText), findsNWidgets(3));
    });

    testWidgets('should have all text fields as read-only', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 80,
          goal: 'Maintain Weight',
          activityLevel: 'Low',
        ),
      );

      // Assert
      final textFields = tester.widgetList<TextField>(find.byType(TextField));

      for (final field in textFields) {
        expect(field.readOnly, isTrue);
      }
    });

    testWidgets('should call navigatToEditsScreen when tapping weight edit', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockCubit.navigatToEditsScreen(any)).thenReturn(null);

      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 70,
          goal: 'Build Muscle',
          activityLevel: 'Moderate',
        ),
      );

      // Act
      final weightRichText = tester.widget<RichText>(
        find.byType(RichText).first,
      );

      final tapRecognizer =
          (weightRichText.text as TextSpan).children![1] as TextSpan;
      (tapRecognizer.recognizer as TapGestureRecognizer?)?.onTap?.call();

      await tester.pumpAndSettle();

      // Assert
      verify(mockCubit.navigatToEditsScreen(Edits.weight)).called(1);
    });

    testWidgets('should call navigatToEditsScreen when tapping goal edit', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockCubit.navigatToEditsScreen(any)).thenReturn(null);

      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 70,
          goal: 'Build Muscle',
          activityLevel: 'Moderate',
        ),
      );

      // Act
      final goalRichText = tester.widget<RichText>(find.byType(RichText).at(1));

      final tapRecognizer =
          (goalRichText.text as TextSpan).children![1] as TextSpan;
      (tapRecognizer.recognizer as TapGestureRecognizer?)?.onTap?.call();

      await tester.pumpAndSettle();

      // Assert
      verify(mockCubit.navigatToEditsScreen(Edits.goal)).called(1);
    });

    testWidgets('should call navigatToEditsScreen when tapping activity edit', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockCubit.navigatToEditsScreen(any)).thenReturn(null);

      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 70,
          goal: 'Build Muscle',
          activityLevel: 'Moderate',
        ),
      );

      // Act
      final activityRichText = tester.widget<RichText>(
        find.byType(RichText).at(2),
      );

      final tapRecognizer =
          (activityRichText.text as TextSpan).children![1] as TextSpan;
      (tapRecognizer.recognizer as TapGestureRecognizer?)?.onTap?.call();

      await tester.pumpAndSettle();

      // Assert
      verify(mockCubit.navigatToEditsScreen(Edits.activity)).called(1);
    });

    testWidgets('should have activity level field disabled', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 75,
          goal: 'Lose Weight',
          activityLevel: 'High',
        ),
      );

      // Assert
      final textFields = tester
          .widgetList<TextField>(find.byType(TextField))
          .toList();

      expect(textFields[0].enabled, isTrue);
      expect(textFields[1].enabled, isTrue);
      expect(textFields[2].enabled, isFalse);
    });

    testWidgets('should render correctly with different weight values', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 100,
          goal: 'Test Goal',
          activityLevel: 'Test Activity',
        ),
      );

      // Assert
      expect(find.text('100 KG'), findsOneWidget);
    });

    testWidgets('should have proper widget structure', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 70,
          goal: 'Build Muscle',
          activityLevel: 'Moderate',
        ),
      );

      // Assert
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(RichText), findsNWidgets(3));
    });

    testWidgets('should display weight with KG unit', (
      WidgetTester tester,
    ) async {
      // Arrange
      const weight = 85;

      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: weight,
          goal: 'Test',
          activityLevel: 'Test',
        ),
      );

      // Assert
      expect(find.text('$weight KG'), findsOneWidget);
    });

    testWidgets('should have three columns in widget structure', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 70,
          goal: 'Build Muscle',
          activityLevel: 'Moderate',
        ),
      );

      // Assert
      final column = tester.widget<Column>(find.byType(Column).first);
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
      expect(column.children.length, greaterThan(5));
    });

    testWidgets('should have controllers with correct text values', (
      WidgetTester tester,
    ) async {
      // Arrange
      const weight = 90;
      const goal = 'Gain Muscle';
      const activityLevel = 'Very Active';

      // Act
      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: weight,
          goal: goal,
          activityLevel: activityLevel,
        ),
      );

      // Assert
      final textFields = tester
          .widgetList<TextField>(find.byType(TextField))
          .toList();

      expect(textFields[0].controller?.text, '$weight KG');
      expect(textFields[1].controller?.text, goal);
      expect(textFields[2].controller?.text, activityLevel);
    });

    testWidgets('should navigate to edit screen when weight is tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockCubit.navigatToEditsScreen(any)).thenReturn(null);

      await tester.pumpWidget(
        createWidgetUnderTest(
          weight: 70,
          goal: 'Build Muscle',
          activityLevel: 'Moderate',
        ),
      );

      // Act
      final weightRichText = tester.widget<RichText>(
        find.byType(RichText).first,
      );
      final tapRecognizer =
          (weightRichText.text as TextSpan).children![1] as TextSpan;
      (tapRecognizer.recognizer as TapGestureRecognizer?)?.onTap?.call();

      await tester.pumpAndSettle();

      expect(find.text('Edit Screen'), findsOneWidget);
    });
  });
}
