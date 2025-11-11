// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:super_fitness_app/core/network/api_results.dart';
// import 'package:super_fitness_app/core/network/failures.dart';
// import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/exercise_dto.dart';
// import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/get_all_exerecises_response.dart';
// import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/difficulty_level_dto.dart';
// import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/get_difficulty_level_respone.dart';
// import 'package:super_fitness_app/features/exercise/data/repo/exercise_repo_impl.dart';
// import 'package:super_fitness_app/features/exercise/data/sources/exercise_remote_ds.dart';
//
// import 'exercise_repo_impl_test.mocks.dart';
//
// @GenerateMocks([ExerciseRemoteDataSource])
void main() {
//   late ExerciseRepoImpl repo;
//   late MockExerciseRemoteDataSource mockDataSource;
//
//   setUp(() {
//     mockDataSource = MockExerciseRemoteDataSource();
//     repo = ExerciseRepoImpl(mockDataSource);
//   });
//
//   group('ExerciseRepoImpl', () {
//     test(
//       'getAllExercisesByDifficulty should return ApiSuccess result with mapped entities',
//       () async {
//         // arrange
//         final dtoList = [
//           ExerciseDto(
//             id: '1',
//             exercise: 'Push Up',
//             difficultyLevel: 'Beginner',
//           ),
//         ];
//         final response = GetAllExerecisesResponse(exercises: dtoList);
//
//         when(
//           mockDataSource.getAllExercisesByDifficulty('1', '2'),
//         ).thenAnswer((_) async => response);
//
//         // act
//         final result = await repo.getAllExercisesByDifficulty('1', '2');
//         result as ApiSuccessResult<List>;
//         // assert
//         expect(result, isA<ApiSuccessResult<List>>());
//         expect(
//           (result as ApiSuccessResult).data.first.exercise,
//           equals('Push Up'),
//         );
//         verify(mockDataSource.getAllExercisesByDifficulty('1', '2')).called(1);
//       },
//     );
//
//     test(
//       'getExerciseDifficultesByMuscle should return ApiSuccess result with mapped entities',
//       () async {
//         // arrange
//         final dtoList = [DifficultyLevelDto(id: '10', name: 'Intermediate')];
//         final response = GetDifficultyLevelRespone(difficultyLevels: dtoList);
//
//         when(
//           mockDataSource.getDifficultyLevelsByPrimeMover('5'),
//         ).thenAnswer((_) async => response);
//
//         // act
//         final result = await repo.getExerciseDifficultesByMuscle('5');
//
//         // assert
//         expect(result, isA<ApiSuccessResult<List>>());
//         expect((result as ApiSuccessResult).data!.first.name, 'Intermediate');
//         verify(mockDataSource.getDifficultyLevelsByPrimeMover('5')).called(1);
//       },
//     );
//
//     test(
//       'should return ApiFailure result when DataSource throws exception',
//       () async {
//         // arrange
//         when(
//           mockDataSource.getAllExercisesByDifficulty('1', '2'),
//         ).thenThrow(Exception('Network error'));
//
//         // act
//         final result = await repo.getAllExercisesByDifficulty('1', '2');
//
//         // assert
//         expect(result, isA<ApiResult>());
//         expect((result as ApiErrorResult).failure, isA<Failure>());
//         verify(mockDataSource.getAllExercisesByDifficulty('1', '2')).called(1);
//       },
//     );
//   });
}
