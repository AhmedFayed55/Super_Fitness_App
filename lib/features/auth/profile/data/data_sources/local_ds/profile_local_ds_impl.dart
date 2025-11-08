import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/profile/data/data_sources/local_ds/profile_local_ds.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/help/help_screen_content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/security_roles_config/security_roles_screen_response_dto.dart';

@Injectable(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl();

  @override
  Future<List<HelpScreenContentDto>> getHelpScreenContent() async {
    final jsonString = await rootBundle.loadString(AppAssets.helpJson);
    final jsonData = json.decode(jsonString);

    final List<dynamic> jsonList = jsonData[AppConstants.helpContentKey];
    return jsonList.map((e) => HelpScreenContentDto.fromJson(e)).toList();
  }

  @override
  Future<List<PrivacyAndSecurityScreenResponseDto>>
  getPrivacyAndSecurityScreenContent() async {
    final jsonString = await rootBundle.loadString(
      AppAssets.privacyAndSecurityJson,
    );
    final jsonData = json.decode(jsonString);

    final List<dynamic> jsonList =
        jsonData[AppConstants.privacyPolicyContentKey];
    return jsonList
        .map((e) => PrivacyAndSecurityScreenResponseDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<SecurityRolesConfigResponseDto>>
  getSecurityRolesConfigScreenContent() async {
    final jsonString = await rootBundle.loadString(
      AppAssets.securityRolesConfigJson,
    );
    final jsonData = json.decode(jsonString);

    final List<dynamic> jsonList =
        jsonData[AppConstants.securityRolesContentKey];
    return jsonList
        .map((e) => SecurityRolesConfigResponseDto.fromJson(e))
        .toList();
  }
}
