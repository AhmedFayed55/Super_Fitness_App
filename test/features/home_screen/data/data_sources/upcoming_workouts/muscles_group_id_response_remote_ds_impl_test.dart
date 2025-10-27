import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/upcoming_workouts/muscles_group_id_response_remote_ds_impl.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';
import 'package:test/test.dart';

import 'muscles_group_id_response_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late MusclesGroupIdResponse musclesGroupIdResponse;
  late MusclesGroupIdResponseRemoteDsImpl remoteDsImpl;

  setUp(() {
    mockApiServices = MockApiServices();
    musclesGroupIdResponse = MusclesGroupIdResponse(
      message: "message",
      muscleGroupDto: MuscleGroupDto(id: "1", name: "1"),
      musclesDto: [MusclesDto(id: "11", name: "11", image: "11")],
    );
    remoteDsImpl = MusclesGroupIdResponseRemoteDsImpl(
      apiServices: mockApiServices,
    );
  });

  test("Test MusclesGroupIdResponseRemoteDsImpl", () async {
    // Arrange
    const testMuscleGroupId = "test";
    when(
      mockApiServices.upcomingWorkoutsTabItems(testMuscleGroupId),
    ).thenAnswer((_) async => musclesGroupIdResponse);

    // Act
    final result = await remoteDsImpl.getMusclesGroupId(testMuscleGroupId);

    // Assert
    expect(result, isA<MusclesGroupIdResponse>());
    expect(result.musclesDto, isNotEmpty);
    expect(result.muscleGroupDto, isNotNull);
    expect(
      result.muscleGroupDto?.id,
      musclesGroupIdResponse.muscleGroupDto?.id,
    );
    expect(
      result.musclesDto?.first.id,
      equals(musclesGroupIdResponse.musclesDto?.first.id),
    );

    verify(
      mockApiServices.upcomingWorkoutsTabItems(testMuscleGroupId),
    ).called(1);
  });
}
