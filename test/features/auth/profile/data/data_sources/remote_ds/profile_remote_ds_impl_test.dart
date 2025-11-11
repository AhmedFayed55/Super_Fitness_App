import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/profile/data/data_sources/remote_ds/profile_remote_ds_impl.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/logged_user_data/logged_user_data_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/logged_user_data/user_data_response_dto.dart';
import '../../../../forget_password/data_sources/sources/remote/forget_password_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late ApiServices mockApiServices;
  late ProfileRemoteDataSourceImpl dataSource;
  late LoggedUserDataResponseDto mockResponse;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = ProfileRemoteDataSourceImpl(mockApiServices);

    mockResponse = LoggedUserDataResponseDto(
      user: UserDataResponseDto(id: "6515", firstName: "Ahmed"),
      message: "Success",
    );
  });

  group('ProfileRemoteDataSourceImpl Tests', () {
    test(
      'getUserData should call ApiServices.getUserData and return LoggedUserDataResponseDto',
      () async {
        when(
          mockApiServices.getUserData(),
        ).thenAnswer((_) async => mockResponse);

        final result = await dataSource.getUserData();

        verify(mockApiServices.getUserData()).called(1);
        expect(result, isA<LoggedUserDataResponseDto>());
        expect(result.user!.id, equals(mockResponse.user!.id));
        expect(result.user!.firstName, equals(mockResponse.user!.firstName));
      },
    );

    test(
      'getUserData should throw exception when ApiServices throws',
      () async {
        when(
          mockApiServices.getUserData(),
        ).thenThrow(Exception('Network error'));
        expect(() => dataSource.getUserData(), throwsException);
        verify(mockApiServices.getUserData()).called(1);
      },
    );
  });
}
