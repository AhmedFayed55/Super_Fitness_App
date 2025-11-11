import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/response/get_user_data_response_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_remote_ds.dart';

@GenerateMocks([SmartCoachRemoteDs])
import 'smart_coach_remote_ds_test.mocks.dart';

void main() {
  late MockSmartCoachRemoteDs mockRemoteDs;

  setUp(() {
    mockRemoteDs = MockSmartCoachRemoteDs();
  });

  group('SmartCoachRemoteDs', () {
    test('should call getUserData and return GetUserDataResponseDto', () async {
      final response = GetUserDataResponseDto(
        message: 'User data fetched successfully',
        user: null,
      );

      when(mockRemoteDs.getUserData()).thenAnswer((_) async => response);

      final result = await mockRemoteDs.getUserData();

      expect(result, isA<GetUserDataResponseDto>());
      expect(result.message, 'User data fetched successfully');
      verify(mockRemoteDs.getUserData()).called(1);
      verifyNoMoreInteractions(mockRemoteDs);
    });
  });
}
