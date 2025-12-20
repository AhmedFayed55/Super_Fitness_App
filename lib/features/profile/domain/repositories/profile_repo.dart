import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/logged_user_data/user_data_response_entity.dart';

abstract interface class ProfileRepo {
  Future<ApiResult<UserDataResponseEntity>> getUserData();
  Future<ApiResult<List<HelpScreenResponseEntity>>> getHelpScreenContent();
  Future<ApiResult<List<PrivacyPolicyEntity>>>
  getPrivacyAndSecurityScreenContent();
  Future<ApiResult<List<SecurityRolesConfigEntity>>>
  getSecurityRolesConfigScreenContent();
}
