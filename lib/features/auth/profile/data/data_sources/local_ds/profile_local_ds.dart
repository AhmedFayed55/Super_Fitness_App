import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/help/help_screen_content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/security_roles_config/security_roles_screen_response_dto.dart';

abstract interface class ProfileLocalDataSource{
  Future<List<HelpScreenContentDto>> getHelpScreenContent();
  Future<List<PrivacyAndSecurityScreenResponseDto>> getPrivacyAndSecurityScreenContent();
  Future<List<SecurityRolesConfigResponseDto>> getSecurityRolesConfigScreenContent();
}