import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:lottie/lottie.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_state.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_view_model.dart';
import 'package:super_fitness_app/features/food/presentation/pages/food_screen.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_grid_view.dart';
import 'food_screen_test.mocks.dart';

@GenerateMocks([FoodScreenViewModel])
void main() {
  late FoodScreenViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockFoodScreenViewModel();
    if (getIt.isRegistered<FoodScreenViewModel>()) {
      getIt.unregister<FoodScreenViewModel>();
    }
    getIt.registerLazySingleton<FoodScreenViewModel>(() => mockViewModel);
  });

  tearDown(() {
    if (getIt.isRegistered<FoodScreenViewModel>()) {
      getIt.unregister<FoodScreenViewModel>();
    }
  });

  Widget createTestWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<FoodScreenViewModel>.value(
        value: mockViewModel,
        child: const FoodScreen(),
      ),
    );
  }

  group('FoodScreen Widget Tests', () {
    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      when(
        mockViewModel.state,
      ).thenReturn(const FoodScreenState(isMealsLoading: true));
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream.value(mockViewModel.state));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows FoodGridView when meals are loaded', (tester) async {
      when(mockViewModel.state).thenReturn(
        FoodScreenState(
          meals: [
            MealsResponseEntity(
              strMeal: "Ayam Percik",
              strMealThumb:
                  "https://www.themealdb.com/images/media/meals/020z181619788503.jpg",
              idMeal: "53050",
            ),
            MealsResponseEntity(
              strMeal: "Chicken Basquaise",
              strMealThumb:
                  "https://www.themealdb.com/images/media/meals/wruvqv1511880994.jpg",
              idMeal: "52934",
            ),
          ],
          isMealsLoading: false,
        ),
      );
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream.value(mockViewModel.state));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(FoodGridView), findsOneWidget);
    });

    testWidgets('shows empty animation when meals list is empty', (
      tester,
    ) async {
      when(
        mockViewModel.state,
      ).thenReturn(const FoodScreenState(meals: [], isMealsLoading: false));
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream.value(mockViewModel.state));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(Lottie), findsOneWidget);
      expect(find.byType(FoodGridView), findsNothing);
    });

    testWidgets('shows error message when mealsError is not null', (
      tester,
    ) async {
      when(
        mockViewModel.state,
      ).thenReturn(const FoodScreenState(mealsError: 'Something went wrong'));
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream.value(mockViewModel.state));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Something went wrong'), findsOneWidget);
    });
  });
}
