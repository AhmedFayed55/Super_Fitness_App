import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/recommendation_to_day/recommendation_to_day_remote_ds_impl.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:test/test.dart';

import 'recommendation_to_day_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late MusclesRandomResponse musclesRandomResponse;
  late RecommendationToDayRemoteDsImpl recommendationToDayRemoteDsImpl;

  setUp(() {
    mockApiServices = MockApiServices();
    musclesRandomResponse = MusclesRandomResponse(
      message: "message",
      totalMuscles: 1,
      musclesDto: [MusclesDto(id: "1", name: "1", image: "1")],
    );
    recommendationToDayRemoteDsImpl = RecommendationToDayRemoteDsImpl(
      apiServices: mockApiServices,
    );
  });

  test("Test RecommendationToDayRemoteDsImpl", () async {
    // Arrange
    when(
      mockApiServices.recommendationToDay(),
    ).thenAnswer((_) async => musclesRandomResponse);

    // Act
    final result = await recommendationToDayRemoteDsImpl.recommendationToDay();

    // Assert
    expect(result, isA<MusclesRandomResponse>());
    expect(result.musclesDto, isNotEmpty);
    expect(
      result.musclesDto?.first.id,
      equals(musclesRandomResponse.musclesDto?.first.id),
    );
    expect(result.totalMuscles, equals(musclesRandomResponse.totalMuscles));
    expect(result.message, equals(musclesRandomResponse.message));

    verify(mockApiServices.recommendationToDay()).called(1);
  });
}
