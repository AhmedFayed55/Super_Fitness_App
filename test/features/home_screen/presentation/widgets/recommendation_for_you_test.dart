import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

import 'recommendation_for_you_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  Widget createWidgetUnderTest(HomeState state) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<HomeCubit>.value(
        value: mockHomeCubit,
        child: Scaffold(
          body: Builder(
            builder: (context) {
              final cubitState = state.forYouData?.categoriesDtoEntity ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recommendation For You'),
                        Text('See All'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (var cat in cubitState)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Text(cat.strCategory),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  testWidgets('RecommendationForYou shows text items only', (tester) async {
    final mockCategories = [
      CategoriesDtoEntity(
        strCategory: "Fitness",
        strCategoryThumb: "",
        idCategory: '1',
        strCategoryDescription: 'Description',
      ),
      CategoriesDtoEntity(
        strCategory: "Yoga",
        strCategoryThumb: "",
        idCategory: '2',
        strCategoryDescription: 'Description',
      ),
    ];

    final homeState = HomeState(
      forYou: ScreenStatus.isSuccess,
      forYouData: MealsCategoriesEntity(categoriesDtoEntity: mockCategories),
    );

    when(mockHomeCubit.state).thenReturn(homeState);
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream<HomeState>.value(homeState));

    await tester.pumpWidget(createWidgetUnderTest(homeState));
    await tester.pumpAndSettle();

    expect(find.text('Recommendation For You'), findsOneWidget);
    expect(find.text('See All'), findsOneWidget);

    for (var cat in mockCategories) {
      expect(find.text(cat.strCategory), findsOneWidget);
    }
  });
}
