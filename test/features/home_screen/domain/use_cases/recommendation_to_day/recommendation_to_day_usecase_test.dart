import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/recommendation_to_day/recommendation_to_day_repo.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/recommendation_to_day/recommendation_to_day_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'recommendation_to_day_usecase_test.mocks.dart';

@GenerateMocks([RecommendationToDayRepo])
void main() {
  late MockRecommendationToDayRepo mockRecommendationToDayRepo;
  late RecommendationToDayUseCase recommendationToDayUseCase;
  late MusclesRandomEntity musclesRandomEntity;

  setUp(() {
    musclesRandomEntity = MusclesRandomEntity(
      message: "message",
      totalMuscles: 0,
      musclesDtoEntity: [
        MusclesDtoEntity(id: "id", name: "name", image: "image"),
      ],
    );

    mockRecommendationToDayRepo = MockRecommendationToDayRepo();
    recommendationToDayUseCase = RecommendationToDayUseCase(
      recommendationToDayRepo: mockRecommendationToDayRepo,
    );
  });

  test("success case for recommendationToDayUseCase", () async {
    // Arrange
    var mockResult = ApiSuccessResult<MusclesRandomEntity>(
      data: musclesRandomEntity,
    );
    provideDummy<ApiResult<MusclesRandomEntity>>(mockResult);

    when(
      mockRecommendationToDayRepo.recommendationToDay(),
    ).thenAnswer((_) async => mockResult);

    // Act
    var result = await recommendationToDayUseCase.call();

    // Assert
    expect(result, isA<ApiSuccessResult<MusclesRandomEntity>>());
    var successResult = result as ApiSuccessResult<MusclesRandomEntity>;
    expect(successResult.data.musclesDtoEntity, isNotEmpty);
    expect(
      successResult.data.musclesDtoEntity.first.name,
      equals(musclesRandomEntity.musclesDtoEntity.first.name),
    );

    verify(mockRecommendationToDayRepo.recommendationToDay()).called(1);
  });
}
