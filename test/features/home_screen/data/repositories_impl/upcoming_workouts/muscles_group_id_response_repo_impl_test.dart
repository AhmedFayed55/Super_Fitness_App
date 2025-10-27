import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:test/test.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/upcoming_workouts/muscles_group_id_response_remote_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';
import 'package:super_fitness_app/features/home_screen/data/repositories_impl/upcoming_workouts/muscles_group_id_response_repo_impl.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'muscles_group_id_response_repo_impl_test.mocks.dart';

@GenerateMocks([MusclesGroupIdResponseRemoteDs])
void main() {
  late MockMusclesGroupIdResponseRemoteDs mockMusclesGroupIdResponseRemoteDs;
  late MusclesGroupIdResponseRepoImpl musclesGroupIdResponseRepoImpl;
  late MusclesGroupIdResponse musclesGroupIdResponse;
  late MusclesGroupIdEntity musclesGroupIdEntity;

  setUp(() {
    musclesGroupIdEntity = MusclesGroupIdEntity(
      message: "Success",
      muscleGroupDtoEntity: MuscleGroupDtoEntity(id: "id", name: "name"),
      musclesDtoEntity: [
        MusclesDtoEntity(id: "id", name: "name", image: "image"),
      ],
    );

    musclesGroupIdResponse = MusclesGroupIdResponse(
      message: "Success",
      muscleGroupDto: MuscleGroupDto(id: "id", name: "name"),
      musclesDto: [MusclesDto(id: "id", name: "name", image: "image")],
    );

    mockMusclesGroupIdResponseRemoteDs = MockMusclesGroupIdResponseRemoteDs();

    musclesGroupIdResponseRepoImpl = MusclesGroupIdResponseRepoImpl(
      musclesGroupIdResponseRemoteDs: mockMusclesGroupIdResponseRemoteDs,
    );
  });

  group("Test MusclesGroupIdResponseRepoImpl", () {
    test("success case with ApiSuccessResult", () async {
      // Arrange
      const muscleGroupId = "test";
      when(
        mockMusclesGroupIdResponseRemoteDs.getMusclesGroupId(muscleGroupId),
      ).thenAnswer((_) async => musclesGroupIdResponse);

      // Act
      var result = await musclesGroupIdResponseRepoImpl.getMusclesGroupId(
        muscleGroupId,
      );

      // Assert
      expect(result, isA<ApiSuccessResult<MusclesGroupIdEntity>>());
      var successResult = result as ApiSuccessResult<MusclesGroupIdEntity>;
      expect(
        successResult.data.muscleGroupDtoEntity.name,
        equals(musclesGroupIdResponse.muscleGroupDto?.name),
      );
      expect(successResult.data.musclesDtoEntity, isNotEmpty);
      expect(
        successResult.data.musclesDtoEntity.first.name,
        equals(musclesGroupIdEntity.musclesDtoEntity.first.name),
      );

      verify(
        mockMusclesGroupIdResponseRemoteDs.getMusclesGroupId(muscleGroupId),
      ).called(1);
    });

    test("Error case with DioException", () async {
      // Arrange
      const muscleGroupId = "test";
      final dioException = DioException(requestOptions: RequestOptions());
      when(
        mockMusclesGroupIdResponseRemoteDs.getMusclesGroupId(muscleGroupId),
      ).thenThrow(dioException);

      // Act
      var result = await musclesGroupIdResponseRepoImpl.getMusclesGroupId(
        muscleGroupId,
      );

      // Assert
      expect(result, isA<ApiErrorResult<MusclesGroupIdEntity>>());
      var errorResult = result as ApiErrorResult<MusclesGroupIdEntity>;
      expect(errorResult.failure, isA<ServerFailure>());
      expect(errorResult.failure, isNotNull);

      verify(
        mockMusclesGroupIdResponseRemoteDs.getMusclesGroupId(muscleGroupId),
      ).called(1);
    });

    test("Error case with generic Exception", () async {
      // Arrange
      const muscleGroupId = "test";
      const errorMessage = "Unexpected error";
      final exception = Exception(errorMessage);
      when(
        mockMusclesGroupIdResponseRemoteDs.getMusclesGroupId(muscleGroupId),
      ).thenThrow(exception);

      // Act
      var result = await musclesGroupIdResponseRepoImpl.getMusclesGroupId(
        muscleGroupId,
      );

      // Assert
      expect(result, isA<ApiErrorResult<MusclesGroupIdEntity>>());
      var errorResult = result as ApiErrorResult<MusclesGroupIdEntity>;
      expect(errorResult.failure, isA<Failure>());
      expect(errorResult.failure, isNotNull);

      verify(
        mockMusclesGroupIdResponseRemoteDs.getMusclesGroupId(muscleGroupId),
      ).called(1);
    });
  });
}
