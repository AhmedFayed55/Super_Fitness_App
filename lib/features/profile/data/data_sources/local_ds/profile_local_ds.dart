import 'package:super_fitness_app/features/profile/data/models/local_models_dto/help/help_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/data/models/local_models_dto/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/data/models/local_models_dto/security_roles_config/security_roles_screen_response_dto.dart';

abstract class ProfileLocalDataSource {
  Future<List<HelpScreenResponseDto>> getHelpScreenContent();
  Future<List<PrivacyPolicyResponseDto>> getPrivacyAndSecurityScreenContent();
  Future<List<SecurityRolesConfigResponseDto>>
  getSecurityRolesConfigScreenContent();
}
