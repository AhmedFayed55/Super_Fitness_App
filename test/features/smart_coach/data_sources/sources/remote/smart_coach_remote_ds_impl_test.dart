import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/response/get_user_data_response_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_remote_ds_impl.dart';

import 'smart_coach_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late SmartCoachRemoteDsImpl dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = SmartCoachRemoteDsImpl(apiService: mockApiServices);
  });

  group('SmartCoachRemoteDsImpl', () {
    test('returns GetUserDataResponseDto on success', () async {
      final response = GetUserDataResponseDto(
        message: 'User data fetched successfully',
        user: null,
      );

      when(
        mockApiServices.getUserDataSmartCoach(),
      ).thenAnswer((_) async => response);

      final result = await dataSource.getUserData();

      expect(result, isA<GetUserDataResponseDto>());
      expect(result.message, 'User data fetched successfully');
      verify(mockApiServices.getUserDataSmartCoach()).called(1);
    });

    test('throws DioException when API fails', () async {
      when(mockApiServices.getUserDataSmartCoach()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/get-user-data')),
      );

      expect(() => dataSource.getUserData(), throwsA(isA<DioException>()));
    });
  });
}
