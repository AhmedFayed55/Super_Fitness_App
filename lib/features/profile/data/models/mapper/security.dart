import 'package:super_fitness_app/features/profile/data/models/local_models_dto/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';

extension SecurityRolesMapper on SecurityRolesConfigResponseDto {
  SecurityRolesConfigEntity toEntity() => SecurityRolesConfigEntity(
    section: section,
    title: title?.en,
    content: content?.en,
    style: style?.toEntity(),
    roleId: roleId,
    name: name?.en,
    description: description?.en,
    permissions: permissions?.map((e) => e.toEntity()).toList(),
  );
}

extension PermissionMapper on PermissionDto {
  PermissionEntity toEntity() =>
      PermissionEntity(key: key, name: name?.en, description: description?.en);
}

extension StyleMapper on StyleDto {
  StyleEntity toEntity() => StyleEntity(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    textAlign: textAlign,
    backgroundColor: backgroundColor,
    highlightColor: highlightColor,
  );
}
