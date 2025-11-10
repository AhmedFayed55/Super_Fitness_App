import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/request/get_all_exercises_request_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/exercise_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/sources/remote/popular_training_remote_ds_impl.dart';
import 'popular_training_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late PopularTrainingRemoteDsImpl dataSource;
  late MockApiServices mockApiService;

  setUp(() {
    mockApiService = MockApiServices();
    dataSource = PopularTrainingRemoteDsImpl(apiService: mockApiService);
  });

  group('PopularTrainingRemoteDsImpl', () {
    test(
      'should call getAllExercises and return GetAllExercisesResponseDto',
      () async {
        // Arrange
        final request = GetAllExercisesRequestDto(page: 1, limit: 10);

        final response = GetAllExercisesResponseDto(
          message: 'Success',
          totalExercises: 2,
          totalPages: 1,
          currentPage: 1,
          exercises: [
            ExerciseDto(
              id: '1',
              exercise: 'Push Up',
              difficultyLevel: 'Beginner',
              targetMuscleGroup: 'Chest',
            ),
            ExerciseDto(
              id: '2',
              exercise: 'Pull Up',
              difficultyLevel: 'Intermediate',
              targetMuscleGroup: 'Back',
            ),
          ],
        );

        when(
          mockApiService.getAllExercises(request),
        ).thenAnswer((_) async => response);

        // Act
        final result = await dataSource.getAllExercises(request);

        // Assert
        expect(result, isA<GetAllExercisesResponseDto>());
        expect(result.message, 'Success');
        expect(result.totalExercises, 2);
        expect(result.exercises?.first.exercise, 'Push Up');
        verify(mockApiService.getAllExercises(request)).called(1);
        verifyNoMoreInteractions(mockApiService);
      },
    );
  });
}
