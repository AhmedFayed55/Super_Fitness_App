import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/profile/data/data_sources/local_ds/profile_local_ds.dart';
import 'package:super_fitness_app/features/auth/profile/data/data_sources/remote_ds/profile_remote_ds.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/mapper/help.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/mapper/privacy.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/mapper/security.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/mapper/user_data.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/auth/profile/domain/repositories/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;
  ProfileRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<ApiResult<UserDataResponseEntity>> getUserData() {
    return safeApiCall<UserDataResponseEntity>(() async {
      final response = await _remoteDataSource.getUserData();
      final userDto = response.user;
      if (userDto == null) {
        throw Exception("User object is missing in response");
      }
      return userDto.toEntity();
    });
  }

  @override
  Future<ApiResult<List<HelpScreenResponseEntity>>> getHelpScreenContent() {
    return safeLocalCall<List<HelpScreenResponseEntity>>(() async {
      final dtoList = await _localDataSource.getHelpScreenContent();
      return dtoList.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<PrivacyPolicyEntity>>>
  getPrivacyAndSecurityScreenContent() {
    return safeLocalCall<List<PrivacyPolicyEntity>>(() async {
      final dtoList = await _localDataSource
          .getPrivacyAndSecurityScreenContent();
      return dtoList.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<SecurityRolesConfigEntity>>>
  getSecurityRolesConfigScreenContent() {
    return safeLocalCall<List<SecurityRolesConfigEntity>>(() async {
      final dtoList = await _localDataSource
          .getSecurityRolesConfigScreenContent();
      return dtoList.map((e) => e.toEntity()).toList();
    });
  }
}
