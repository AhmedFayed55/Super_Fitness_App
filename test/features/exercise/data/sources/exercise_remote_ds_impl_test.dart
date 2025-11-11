import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/get_all_exerecises_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/get_difficulty_level_respone.dart';
import 'package:super_fitness_app/features/exercise/data/sources/exercise_remote_ds_impl.dart';

import 'exercise_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late ExerciseRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = ExerciseRemoteDataSourceImpl(mockApiServices);
  });

  group('ExerciseRemoteDataSourceImpl', () {
    test(
      'should call ApiServices.getAllExercisesByDifficulty and return its response',
      () async {
        // arrange
        final mockResponse = GetAllExerecisesResponse(exercises: []);
        when(
          mockApiServices.getAllExercisesByDifficulty('1', '2'),
        ).thenAnswer((_) async => mockResponse);

        // act
        final result = await dataSource.getAllExercisesByDifficulty('1', '2');

        // assert
        expect(result, equals(mockResponse));
        verify(mockApiServices.getAllExercisesByDifficulty('1', '2')).called(1);
        verifyNoMoreInteractions(mockApiServices);
      },
    );

    test(
      'should call ApiServices.getDifficultyLevelsByPrimeMover and return its response',
      () async {
        // arrange
        final mockResponse = GetDifficultyLevelRespone(difficultyLevels: []);
        when(
          mockApiServices.getDifficultyLevelsByPrimeMover('5'),
        ).thenAnswer((_) async => mockResponse);

        // act
        final result = await dataSource.getDifficultyLevelsByPrimeMover('5');

        // assert
        expect(result, equals(mockResponse));
        verify(mockApiServices.getDifficultyLevelsByPrimeMover('5')).called(1);
        verifyNoMoreInteractions(mockApiServices);
      },
    );

    test('should throw exception when ApiServices throws', () async {
      // arrange
      when(
        mockApiServices.getAllExercisesByDifficulty('1', '2'),
      ).thenThrow(Exception('Network Error'));

      // act & assert
      expect(
        () async => await dataSource.getAllExercisesByDifficulty('1', '2'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
