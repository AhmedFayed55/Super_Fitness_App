import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';
import 'package:super_fitness_app/features/details_food/domain/use_case/details_food_use_case.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_event.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'details_food_view_model_test.mocks.dart';

@GenerateMocks([DetailsFoodUseCase])
void main() {
  provideDummy<ApiResult<DetailsFoodEntity>>(
    ApiSuccessResult(
      data: DetailsFoodEntity(
        instructions: 'dummy',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        ingredients: [],
        id: '',
        name: '',
        category: '',
        area: '',
        imageUrl: '',
        tags: '',
        sourceUrl: '',
      ),
    ),
  );
  late MockDetailsFoodUseCase mockDetailsFoodUseCase;
  late DetailsFoodViewModel viewModel;

  const testMealId = '123';
  final testEntity = DetailsFoodEntity(
    id: '123',
    name: 'Test Meal',
    instructions: 'Test Instructions',
    youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    ingredients: [],
    category: '',
    area: '',
    imageUrl: '',
    tags: '',
    sourceUrl: '',
  );

  setUp(() {
    mockDetailsFoodUseCase = MockDetailsFoodUseCase();
    viewModel = DetailsFoodViewModel(mockDetailsFoodUseCase);
  });

  group('DetailsFoodViewModel Tests', () {
    blocTest<DetailsFoodViewModel, DetailsFoodState>(
      'emits [loading, success] when DetailsDataFoodEvent succeeds',
      build: () {
        when(
          mockDetailsFoodUseCase.call(testMealId),
        ).thenAnswer((_) async => ApiSuccessResult(data: testEntity));
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(DetailsDataFoodEvent(idMeal: testMealId)),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<DetailsFoodState>().having((s) => s.isLoading, 'isLoading', true),
        isA<DetailsFoodState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.detailsFoodEntity, 'detailsFoodEntity', testEntity)
            .having((s) => s.youtubeController, 'youtubeController', isNotNull),
      ],
      verify: (_) {
        verify(mockDetailsFoodUseCase.call(testMealId)).called(1);
      },
    );

    blocTest<DetailsFoodViewModel, DetailsFoodState>(
      'emits [loading, error] when DetailsDataFoodEvent fails',
      build: () {
        when(mockDetailsFoodUseCase.call(testMealId)).thenAnswer(
          (_) async =>
              ApiErrorResult(failure: Failure(errorMessage: 'Network error')),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(DetailsDataFoodEvent(idMeal: testMealId)),
      expect: () => [
        isA<DetailsFoodState>().having((s) => s.isLoading, 'isLoading', true),
        isA<DetailsFoodState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.errorMessage, 'errorMessage', 'Network error'),
      ],
    );
  });
}
