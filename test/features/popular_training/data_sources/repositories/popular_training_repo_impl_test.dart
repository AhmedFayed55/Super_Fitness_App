import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/exercise_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/request/get_all_exercises_request_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/repositories/popular_training_repo_impl.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/sources/remote/popular_training_remote_ds.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';

import 'popular_training_repo_impl_test.mocks.dart';

@GenerateMocks([PopularTrainingRemoteDs])
void main() {
  late MockPopularTrainingRemoteDs mockRemote;
  late PopularTrainingRepositoryImpl repo;

  setUp(() {
    mockRemote = MockPopularTrainingRemoteDs();
    repo = PopularTrainingRepositoryImpl(mockRemote);
  });

  group('getAllExercises', () {
    test('returns success when remote call succeeds', () async {
      // Arrange
      const requestEntity = GetAllExercisesRequestEntity(page: 1, limit: 10);
      final responseDto = GetAllExercisesResponseDto(
        message: 'Success',
        totalExercises: 2,
        totalPages: 1,
        currentPage: 1,
        exercises: [
          // exercise mock data
          ExerciseDto(
            id: '1',
            exercise: 'Push Up',
            difficultyLevel: 'Medium',
            primaryEquipment: 'Bodyweight',
            primaryItems: 0,
          ),
        ],
      );

      // Mock remote call
      when(
        mockRemote.getAllExercises(any),
      ).thenAnswer((_) async => responseDto);

      // Act
      final result = await repo.getAllExercises(requestEntity);

      // Assert
      expect(result, isA<ApiSuccessResult<GetAllExercisesResponseEntity>>());
      final success = result as ApiSuccessResult<GetAllExercisesResponseEntity>;
      expect(success.data.message, equals('Success'));
      expect(success.data.exercises.first.exercise, equals('Push Up'));
      verify(mockRemote.getAllExercises(any)).called(1);
    });

    test('returns error when remote throws exception', () async {
      // Arrange
      const requestEntity = GetAllExercisesRequestEntity(page: 1, limit: 10);

      when(mockRemote.getAllExercises(any)).thenThrow(Exception('Server down'));

      // Act
      final result = await repo.getAllExercises(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<GetAllExercisesResponseEntity>>());
    });

    test(
      'should map request entity to DTO correctly before calling remote',
      () async {
        // Arrange
        const requestEntity = GetAllExercisesRequestEntity(page: 3, limit: 20);
        final dto = GetAllExercisesRequestDto(page: 3, limit: 20);
        final responseDto = GetAllExercisesResponseDto(
          message: 'OK',
          totalExercises: 0,
          totalPages: 0,
          currentPage: 3,
          exercises: const [],
        );

        when(
          mockRemote.getAllExercises(dto),
        ).thenAnswer((_) async => responseDto);

        // Act
        await repo.getAllExercises(requestEntity);

        // Assert
        verify(
          mockRemote.getAllExercises(
            argThat(
              isA<GetAllExercisesRequestDto>()
                  .having((d) => d.page, 'page', 3)
                  .having((d) => d.limit, 'limit', 20),
            ),
          ),
        ).called(1);
      },
    );
  });
}
