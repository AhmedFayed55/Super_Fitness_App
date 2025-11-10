import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/exercise_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/request/get_all_exercises_request_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/sources/remote/popular_training_remote_ds.dart';

@GenerateMocks([PopularTrainingRemoteDs])
import 'popular_training_remote_ds_test.mocks.dart';

void main() {
  late MockPopularTrainingRemoteDs mockRemoteDs;

  setUp(() {
    mockRemoteDs = MockPopularTrainingRemoteDs();
  });

  group('PopularTrainingRemoteDs', () {
    test(
      'should call getAllExercises and return GetAllExercisesResponseDto with exercises data',
      () async {
        // Arrange
        final request = GetAllExercisesRequestDto(page: 1, limit: 10);

        final exercises = [
          ExerciseDto(
            id: '1',
            exercise: 'Push Up',
            difficultyLevel: 'Easy',
            targetMuscleGroup: 'Chest',
            primeMoverMuscle: 'Pectoralis Major',
            secondaryMuscle: 'Triceps',
            primaryEquipment: 'Bodyweight',
            posture: 'Prone',
            singleOrDoubleArm: 'Double',
            grip: 'Neutral',
            loadPositionEnding: 'None',
            bodyRegion: 'Upper Body',
            forceType: 'Push',
            mechanics: 'Compound',
            laterality: 'Bilateral',
            primaryExerciseClassification: 'Strength',
            shortYoutubeDemonstrationLink: 'https://youtube.com/demo_pushup',
            inDepthYoutubeExplanationLink: 'https://youtube.com/explain_pushup',
          ),
          ExerciseDto(
            id: '2',
            exercise: 'Squat',
            difficultyLevel: 'Medium',
            targetMuscleGroup: 'Legs',
            primeMoverMuscle: 'Quadriceps',
            secondaryMuscle: 'Glutes',
            primaryEquipment: 'Barbell',
            posture: 'Standing',
            singleOrDoubleArm: 'Double',
            grip: 'Overhand',
            loadPositionEnding: 'Shoulder',
            bodyRegion: 'Lower Body',
            forceType: 'Push',
            mechanics: 'Compound',
            laterality: 'Bilateral',
            primaryExerciseClassification: 'Strength',
            shortYoutubeDemonstrationLink: 'https://youtube.com/demo_squat',
            inDepthYoutubeExplanationLink: 'https://youtube.com/explain_squat',
          ),
        ];

        final response = GetAllExercisesResponseDto(
          message: 'Success',
          totalExercises: 2,
          totalPages: 1,
          currentPage: 1,
          exercises: exercises,
        );

        when(
          mockRemoteDs.getAllExercises(request),
        ).thenAnswer((_) async => response);

        // Act
        final result = await mockRemoteDs.getAllExercises(request);

        // Assert
        expect(result, isA<GetAllExercisesResponseDto>());
        expect(result.message, 'Success');
        expect(result.totalExercises, 2);
        expect(result.exercises?.first.exercise, 'Push Up');
        expect(result.exercises?.last.exercise, 'Squat');

        verify(mockRemoteDs.getAllExercises(request)).called(1);
        verifyNoMoreInteractions(mockRemoteDs);
      },
    );

    test('should throw an exception when remote call fails', () async {
      // Arrange
      final request = GetAllExercisesRequestDto(page: 1, limit: 10);

      when(
        mockRemoteDs.getAllExercises(request),
      ).thenThrow(Exception('Network Error'));

      // Act
      Future<GetAllExercisesResponseDto> call() =>
          mockRemoteDs.getAllExercises(request);

      // Assert
      expect(call, throwsA(isA<Exception>()));
      verify(mockRemoteDs.getAllExercises(request)).called(1);
      verifyNoMoreInteractions(mockRemoteDs);
    });
  });
}
