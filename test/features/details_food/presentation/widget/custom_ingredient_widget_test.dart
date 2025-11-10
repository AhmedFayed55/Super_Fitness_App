import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/ingredient_entity.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_ingredient_widget.dart';

import 'custom_ingredient_widget_test.mocks.dart';

@GenerateMocks([DetailsFoodViewModel])
void main() {
  late MockDetailsFoodViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockDetailsFoodViewModel();
  });

  testWidgets('renders ingredient list correctly when state has data', (
    tester,
  ) async {
    final testEntity = DetailsFoodEntity(
      id: '1',
      name: 'Test Meal',
      instructions: '',
      youtubeUrl: '',
      ingredients: [
        const IngredientEntity(name: 'Chicken', measure: '200g'),
        const IngredientEntity(name: 'Rice', measure: '100g'),
      ],
      category: '',
      area: '',
      imageUrl: '',
      tags: '',
      sourceUrl: '',
    );

    final fakeState = DetailsFoodState(detailsFoodEntity: testEntity);

    when(mockViewModel.state).thenReturn(fakeState);
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());

    // Act
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<DetailsFoodViewModel>.value(
          value: mockViewModel,
          child: const Scaffold(body: CustomIngredientWidget()),
        ),
      ),
    );
    expect(find.text('Chicken'), findsOneWidget);
    expect(find.text('Rice'), findsOneWidget);
    expect(find.text('200g'), findsOneWidget);
    expect(find.text('100g'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}
