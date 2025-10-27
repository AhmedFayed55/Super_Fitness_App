import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/recommendation_to_day/recommendation_to_day_remote_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/repositories_impl/recommendation_to_day/recommendation_to_day_repo_impl.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'recommendation_to_day_repo_impl_test.mocks.dart';

@GenerateMocks([RecommendationToDayRemoteDs])
void main() {
  late MockRecommendationToDayRemoteDs mockRecommendationToDayRemoteDs;
  late RecommendationToDayRepoImpl recommendationToDayRepoImpl;
  late MusclesRandomResponse musclesRandomResponse;
  late MusclesRandomEntity musclesRandomEntity;

  setUp(() {
    musclesRandomEntity = MusclesRandomEntity(
      message: "message",
      totalMuscles: 1,
      musclesDtoEntity: [
        MusclesDtoEntity(id: "id", name: "name", image: "image"),
      ],
    );

    musclesRandomResponse = MusclesRandomResponse(
      message: "message",
      totalMuscles: 1,
      musclesDto: [MusclesDto(id: "id", name: "name", image: "image")],
    );

    mockRecommendationToDayRemoteDs = MockRecommendationToDayRemoteDs();

    recommendationToDayRepoImpl = RecommendationToDayRepoImpl(
      recommendationToDayRemoteDs: mockRecommendationToDayRemoteDs,
    );
  });

  group("Test RecommendationToDayRepoImpl", () {
    test("success case with ApiSuccessResult", () async {
      // Arrange
      when(
        mockRecommendationToDayRemoteDs.recommendationToDay(),
      ).thenAnswer((_) async => musclesRandomResponse);

      // Act
      var result = await recommendationToDayRepoImpl.recommendationToDay();

      // Assert
      expect(result, isA<ApiSuccessResult<MusclesRandomEntity>>());
      var successResult = result as ApiSuccessResult<MusclesRandomEntity>;
      expect(successResult.data.musclesDtoEntity, isNotEmpty);
      expect(
        successResult.data.musclesDtoEntity.first.name,
        equals(musclesRandomEntity.musclesDtoEntity.first.name),
      );

      verify(mockRecommendationToDayRemoteDs.recommendationToDay()).called(1);
    });

    test("Error case with DioException", () async {
      // Arrange
      final dioException = DioException(requestOptions: RequestOptions());
      when(
        mockRecommendationToDayRemoteDs.recommendationToDay(),
      ).thenThrow(dioException);

      // Act
      var result = await recommendationToDayRepoImpl.recommendationToDay();

      // Assert
      expect(result, isA<ApiErrorResult<MusclesRandomEntity>>());
      var errorResult = result as ApiErrorResult<MusclesRandomEntity>;
      expect(errorResult.failure, isA<ServerFailure>());
      expect(errorResult.failure, isNotNull);

      verify(mockRecommendationToDayRemoteDs.recommendationToDay()).called(1);
    });

    test("Error case with generic Exception", () async {
      // Arrange
      const errorMessage = "errorMessage";
      final exception = Exception(errorMessage);
      when(
        mockRecommendationToDayRemoteDs.recommendationToDay(),
      ).thenThrow(exception);

      // Act
      var result = await recommendationToDayRepoImpl.recommendationToDay();

      // Assert
      expect(result, isA<ApiErrorResult<MusclesRandomEntity>>());
      var errorResult = result as ApiErrorResult<MusclesRandomEntity>;
      expect(errorResult.failure, isA<Failure>());
      expect(errorResult.failure, isNotNull);

      verify(mockRecommendationToDayRemoteDs.recommendationToDay()).called(1);
    });
  });
}
