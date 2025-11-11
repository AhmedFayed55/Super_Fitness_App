import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/change_password/data/data_sources/remote/change_pass_remote_ds_impl.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_pass_response.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';

import '../../../../../home_screen/data/data_sources/home_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late ChangePasswordRequest changePasswordRequest;
  late ChangePasswordResponse changePasswordResponse;
  late ChangePasswordRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    changePasswordResponse = ChangePasswordResponse(
      message: "message",
      token: "token",
    );
    changePasswordRequest = ChangePasswordRequest(
      password: "password",
      newPassword: "newPassword",
    );
    remoteDataSource = ChangePasswordRemoteDataSourceImpl(mockApiServices);
  });

  test("Test remoteDataSource in Data_Layer", () async {
    /// Arrange
    when(
      mockApiServices.changePassword(changePasswordRequest),
    ).thenAnswer((_) async => changePasswordResponse);

    /// Act
    final result = await remoteDataSource.changePassword(changePasswordRequest);

    /// assert
    expect(result, isA<ChangePasswordResponse>());
    expect(result.message, equals(changePasswordResponse.message));
    expect(result.token, equals(changePasswordResponse.token));

    verify(mockApiServices.changePassword(changePasswordRequest)).called(1);
  });
}
