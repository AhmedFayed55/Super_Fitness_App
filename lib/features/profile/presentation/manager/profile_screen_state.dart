import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/logged_user_data/user_data_response_entity.dart';

class ProfileScreenState {
  final UserDataResponseEntity? userData;
  final bool isLoadingUserData;
  final String? userDataErrorMsg;

  final List<PrivacyPolicyEntity>? privacyContent;
  final List<HelpScreenResponseEntity>? helpContent;
  final List<SecurityRolesConfigEntity>? securityContent;

  final bool isLoadingContent;
  final String? contentErrorMsg;

  const ProfileScreenState({
    this.userData,
    this.isLoadingUserData = false,
    this.userDataErrorMsg,
    this.privacyContent,
    this.helpContent,
    this.securityContent,
    this.isLoadingContent = false,
    this.contentErrorMsg,
  });

  ProfileScreenState copyWith({
    UserDataResponseEntity? userData,
    bool? isLoadingUserData,
    String? userDataErrorMsg,
    List<PrivacyPolicyEntity>? privacyContent,
    List<HelpScreenResponseEntity>? helpContent,
    List<SecurityRolesConfigEntity>? securityContent,
    bool? isLoadingContent,
    String? contentErrorMsg,
  }) => ProfileScreenState(
    userData: userData ?? this.userData,
    isLoadingUserData: isLoadingUserData ?? this.isLoadingUserData,
    userDataErrorMsg: userDataErrorMsg ?? this.userDataErrorMsg,
    privacyContent: privacyContent ?? this.privacyContent,
    helpContent: helpContent ?? this.helpContent,
    securityContent: securityContent ?? this.securityContent,
    isLoadingContent: isLoadingContent ?? this.isLoadingContent,
    contentErrorMsg: contentErrorMsg ?? this.contentErrorMsg,
  );
}
