import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/upcoming_workouts/get_all_muscles_response_remote_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/repositories_impl/upcoming_workouts/get_all_muscles_response_repo_impl.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';

import 'get_all_muscles_response_repo_impl_test.mocks.dart';

@GenerateMocks([GetAllMusclesResponseRemoteDs])
void main() {
  late MockGetAllMusclesResponseRemoteDs mockGetAllMusclesResponseRemoteDs;
  late GetAllMusclesResponseRepoImpl getAllMusclesResponseRepoImpl;
  late GetAllMusclesResponse getAllMusclesResponse;
  late GetAllMusclesEntity getAllMusclesEntity;

  setUp(() {
    getAllMusclesEntity = GetAllMusclesEntity(
      message: "message",
      musclesGroupDtoEntity: [MusclesGroupDtoEntity(id: "1", name: "name")],
    );

    getAllMusclesResponse = GetAllMusclesResponse(
      message: "message",
      musclesGroupDto: [MusclesGroupDto(id: "1", name: "name")],
    );

    mockGetAllMusclesResponseRemoteDs = MockGetAllMusclesResponseRemoteDs();

    getAllMusclesResponseRepoImpl = GetAllMusclesResponseRepoImpl(
      getAllMusclesResponseRemoteDs: mockGetAllMusclesResponseRemoteDs,
    );
  });

  group("Test GetAllMusclesResponseRepoImpl", () {
    test("success case with ApiSuccessResult", () async {
      // Arrange
      when(
        mockGetAllMusclesResponseRemoteDs.getAllMuscles(),
      ).thenAnswer((_) async => getAllMusclesResponse);

      // Act
      var result = await getAllMusclesResponseRepoImpl.getAllMuscles();

      // Assert
      expect(result, isA<ApiSuccessResult<GetAllMusclesEntity>>());
      var successResult = result as ApiSuccessResult<GetAllMusclesEntity>;
      expect(successResult.data.musclesGroupDtoEntity, isNotEmpty);
      expect(
        successResult.data.musclesGroupDtoEntity.first.name,
        equals(getAllMusclesEntity.musclesGroupDtoEntity.first.name),
      );

      verify(mockGetAllMusclesResponseRemoteDs.getAllMuscles()).called(1);
    });

    test("Error case with DioException", () async {
      // Arrange
      final dioException = DioException(requestOptions: RequestOptions());
      when(
        mockGetAllMusclesResponseRemoteDs.getAllMuscles(),
      ).thenThrow(dioException);

      // Act
      var result = await getAllMusclesResponseRepoImpl.getAllMuscles();

      // Assert
      expect(result, isA<ApiErrorResult<GetAllMusclesEntity>>());
      var errorResult = result as ApiErrorResult<GetAllMusclesEntity>;
      expect(errorResult.failure, isA<ServerFailure>());
      expect(errorResult.failure, isNotNull);

      verify(mockGetAllMusclesResponseRemoteDs.getAllMuscles()).called(1);
    });

    test("Error case with generic Exception", () async {
      // Arrange
      const errorMessage = "errorMessage";
      final exception = Exception(errorMessage);
      when(
        mockGetAllMusclesResponseRemoteDs.getAllMuscles(),
      ).thenThrow(exception);

      // Act
      var result = await getAllMusclesResponseRepoImpl.getAllMuscles();

      // Assert
      expect(result, isA<ApiErrorResult<GetAllMusclesEntity>>());
      var errorResult = result as ApiErrorResult<GetAllMusclesEntity>;
      expect(errorResult.failure, isA<Failure>());
      expect(errorResult.failure, isNotNull);

      verify(mockGetAllMusclesResponseRemoteDs.getAllMuscles()).called(1);
    });
  });
}
