import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/upcoming_workouts/get_all_muscles_response_remote_ds_impl.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_dto.dart';
import 'package:test/test.dart';

import 'get_all_muscles_response_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late GetAllMusclesResponse getAllMusclesResponse;
  late GetAllMusclesResponseRemoteDsImpl remoteDsImpl;

  setUp(() {
    mockApiServices = MockApiServices();
    getAllMusclesResponse = GetAllMusclesResponse(
      message: "message",
      musclesGroupDto: [MusclesGroupDto(id: "1", name: "1")],
    );
    remoteDsImpl = GetAllMusclesResponseRemoteDsImpl(
      apiServices: mockApiServices,
    );
  });

  test("Test GetAllMusclesResponseRemoteDsImpl", () async {
    // Arrange
    when(
      mockApiServices.upcomingWorkoutsTab(),
    ).thenAnswer((_) async => getAllMusclesResponse);

    // Act
    final result = await remoteDsImpl.getAllMuscles();

    // Assert
    expect(result, isA<GetAllMusclesResponse>());
    expect(result.musclesGroupDto, isNotEmpty);
    expect(result.message, getAllMusclesResponse.message);
    expect(
      result.musclesGroupDto?.first.id,
      equals(getAllMusclesResponse.musclesGroupDto?.first.id),
    );

    verify(mockApiServices.upcomingWorkoutsTab()).called(1);
  });
}
