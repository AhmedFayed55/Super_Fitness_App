import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/profile/data/data_sources/local_ds/profile_local_ds.dart';
import 'package:super_fitness_app/features/profile/data/data_sources/remote_ds/profile_remote_ds.dart';
import 'package:super_fitness_app/features/profile/data/models/local_models_dto/help/help_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/data/models/local_models_dto/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/data/models/local_models_dto/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/data/models/logged_user_data/logged_user_data_response_dto.dart';
import 'package:super_fitness_app/features/profile/data/models/logged_user_data/user_data_response_dto.dart';
import 'package:super_fitness_app/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource, ProfileLocalDataSource])
void main() {
  late MockProfileRemoteDataSource remoteDataSource;
  late MockProfileLocalDataSource localDataSource;
  late ProfileRepoImpl repo;

  setUp(() {
    remoteDataSource = MockProfileRemoteDataSource();
    localDataSource = MockProfileLocalDataSource();
    repo = ProfileRepoImpl(remoteDataSource, localDataSource);
  });

  group('ProfileRepoImpl - getUserData', () {
    test(
      'should return ApiSuccessResult<UserDataResponseEntity> when successful',
      () async {
        final mockUserDto = UserDataResponseDto(
          id: "1",
          firstName: "John",
          email: "john@example.com",
        );
        final mockResponse = LoggedUserDataResponseDto(user: mockUserDto);

        when(
          remoteDataSource.getUserData(),
        ).thenAnswer((_) async => mockResponse);

        final result = await repo.getUserData();

        verify(remoteDataSource.getUserData()).called(1);
        expect(result, isA<ApiSuccessResult<UserDataResponseEntity>>());
        final data = (result as ApiSuccessResult<UserDataResponseEntity>).data;
        expect(data.firstName, equals(mockUserDto.firstName));
        expect(data.email, equals(mockUserDto.email));
      },
    );

    test(
      'should return ApiErrorResult when user is null in response',
      () async {
        final mockResponse = LoggedUserDataResponseDto(user: null);
        when(
          remoteDataSource.getUserData(),
        ).thenAnswer((_) async => mockResponse);

        final result = await repo.getUserData();

        expect(result, isA<ApiErrorResult<UserDataResponseEntity>>());
        final error = result as ApiErrorResult<UserDataResponseEntity>;
        expect(error.failure, isA<Failure>());
      },
    );

    test('should return ApiErrorResult on exception', () async {
      when(
        remoteDataSource.getUserData(),
      ).thenThrow(Exception('Unexpected error'));

      final result = await repo.getUserData();

      expect(result, isA<ApiErrorResult<UserDataResponseEntity>>());
      final error = result as ApiErrorResult<UserDataResponseEntity>;
      expect(error.failure, isA<Failure>());
    });
  });

  group('ProfileRepoImpl - Local Data Methods', () {
    test('getHelpScreenContent returns ApiSuccessResult', () async {
      final mockHelpDto = [HelpScreenResponseDto(section: "Help Section")];
      when(
        localDataSource.getHelpScreenContent(),
      ).thenAnswer((_) async => mockHelpDto);

      final result = await repo.getHelpScreenContent();

      verify(localDataSource.getHelpScreenContent()).called(1);
      expect(result, isA<ApiSuccessResult<List<HelpScreenResponseEntity>>>());
      final data =
          (result as ApiSuccessResult<List<HelpScreenResponseEntity>>).data;
      expect(data.length, equals(mockHelpDto.length));
      expect(data.first.section, equals(mockHelpDto.first.section));
    });

    test(
      'getPrivacyAndSecurityScreenContent returns ApiSuccessResult',
      () async {
        final mockPrivacyDto = [
          PrivacyPolicyResponseDto(section: "Privacy Title"),
        ];
        when(
          localDataSource.getPrivacyAndSecurityScreenContent(),
        ).thenAnswer((_) async => mockPrivacyDto);

        final result = await repo.getPrivacyAndSecurityScreenContent();

        verify(localDataSource.getPrivacyAndSecurityScreenContent()).called(1);
        expect(result, isA<ApiSuccessResult<List<PrivacyPolicyEntity>>>());
        final data =
            (result as ApiSuccessResult<List<PrivacyPolicyEntity>>).data;
        expect(data.length, mockPrivacyDto.length);
        expect(data.first.section, equals(mockPrivacyDto.first.section));
      },
    );

    test(
      'getSecurityRolesConfigScreenContent returns ApiSuccessResult',
      () async {
        final mockSecurityDto = [
          SecurityRolesConfigResponseDto(section: "Security Roles"),
        ];

        when(
          localDataSource.getSecurityRolesConfigScreenContent(),
        ).thenAnswer((_) async => mockSecurityDto);

        final result = await repo.getSecurityRolesConfigScreenContent();

        verify(localDataSource.getSecurityRolesConfigScreenContent()).called(1);
        expect(
          result,
          isA<ApiSuccessResult<List<SecurityRolesConfigEntity>>>(),
        );

        final data =
            (result as ApiSuccessResult<List<SecurityRolesConfigEntity>>).data;
        expect(data.length, mockSecurityDto.length);
        expect(data.first.section, equals(mockSecurityDto.first.section));
      },
    );
  });
}
