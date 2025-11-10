import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/edit-profile/data/model/edit_user_respone/edit_user_respone.dart';
import 'package:super_fitness_app/features/edit-profile/data/model/edit_user_respone/user.dart';
import 'package:super_fitness_app/features/edit-profile/data/sources/edit_profile_remote_ds.dart';
import 'package:super_fitness_app/features/edit-profile/data/sources/edit_profile_remote_ds_impl.dart';

import '../../../auth/forget_password/data_sources/sources/remote/forget_password_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late EditProfileRemoteDs remoteDs;

  setUp(() {
    mockApiServices = MockApiServices();
    remoteDs = EditProfileRemoteDsImpl(mockApiServices);
  });

  test(
    'editUser should call ApiServices.editProfile with correct data and return EditUserResponse',
    () async {
      // Arrange
      final user = User(
        id: "1",
        firstName: "Ahmed",
        lastName: "Yehia",
        email: "test@test.com",
        weight: 75,
        activityLevel: "Intermediate",
        goal: "Gain weight",
        photo: "",
      );

      final apiResponse = EditUserRespone(message: "Updated", user: user);

      when(
        mockApiServices.editProfile(any),
      ).thenAnswer((_) async => apiResponse);

      // Act
      final result = await remoteDs.editUser(user);

      // Assert
      verify(
        mockApiServices.editProfile({
          AppConstants.firstName: user.firstName,
          AppConstants.lastName: user.lastName,
          AppConstants.email: user.email,
          AppConstants.weight: user.weight,
          AppConstants.activityLevel: ActivityLevel.toLevelName(
            user.activityLevel!,
          ),
          AppConstants.goal: user.goal,
        }),
      ).called(1);

      expect(result, apiResponse);
    },
  );
}
