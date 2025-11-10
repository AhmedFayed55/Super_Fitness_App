class SecurityRolesConfigEntity {
  final String? section;
  final String? title;
  final String? content;
  final StyleEntity? style;
  final String? roleId;
  final String? name;
  final String? description;
  final List<PermissionEntity>? permissions;

  SecurityRolesConfigEntity({
    this.section,
    this.title,
    this.content,
    this.style,
    this.roleId,
    this.name,
    this.description,
    this.permissions,
  });
}

class PermissionEntity {
  final String? key;
  final String? name;
  final String? description;

  PermissionEntity({this.key, this.name, this.description});
}

class StyleEntity {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final Map<String, String>? textAlign;
  final String? backgroundColor;
  final String? highlightColor;

  StyleEntity({this.fontSize, this.fontWeight, this.color, this.textAlign, this.backgroundColor, this.highlightColor});
}
