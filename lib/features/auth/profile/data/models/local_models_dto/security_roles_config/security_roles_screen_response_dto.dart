class SecurityRolesConfigResponseDto {
  final String? section;
  final ContentDto? title;
  final ContentDto? content;
  final StyleDto? style;
  final String? roleId;
  final ContentDto? name;
  final ContentDto? description;
  final List<PermissionDto>? permissions;

  SecurityRolesConfigResponseDto({
    this.section,
    this.title,
    this.content,
    this.style,
    this.roleId,
    this.name,
    this.description,
    this.permissions,
  });

  factory SecurityRolesConfigResponseDto.fromJson(Map<String, dynamic> json) {
    List<PermissionDto>? perms;
    if (json['permissions'] != null && json['permissions'] is List) {
      perms = (json['permissions'] as List)
          .map((e) => PermissionDto.fromJson(e))
          .toList();
    }

    return SecurityRolesConfigResponseDto(
      section: json['section'] as String?,
      title: json['title'] != null ? ContentDto.fromJson(json['title']) : null,
      content: json['content'] != null
          ? ContentDto.fromJson(json['content'])
          : null,
      style: json['style'] != null ? StyleDto.fromJson(json['style']) : null,
      roleId: json['role_id'] as String?,
      name: json['name'] != null ? ContentDto.fromJson(json['name']) : null,
      description: json['description'] != null
          ? ContentDto.fromJson(json['description'])
          : null,
      permissions: perms,
    );
  }

  Map<String, dynamic> toJson() => {
    'section': section,
    'title': title?.toJson(),
    'content': content?.toJson(),
    'style': style?.toJson(),
    'role_id': roleId,
    'name': name?.toJson(),
    'description': description?.toJson(),
    'permissions': permissions?.map((e) => e.toJson()).toList(),
  };
}

class PermissionDto {
  final String? key;
  final ContentDto? name;
  final ContentDto? description;

  PermissionDto({this.key, this.name, this.description});

  factory PermissionDto.fromJson(Map<String, dynamic> json) => PermissionDto(
    key: json['key'] as String?,
    name: json['name'] != null ? ContentDto.fromJson(json['name']) : null,
    description: json['description'] != null
        ? ContentDto.fromJson(json['description'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'key': key,
    'name': name?.toJson(),
    'description': description?.toJson(),
  };
}

class ContentDto {
  final String? en;

  ContentDto({this.en});

  factory ContentDto.fromJson(dynamic json) {
    if (json == null) return ContentDto();
    if (json is Map<String, dynamic>) {
      return ContentDto(en: json['en'] as String?);
    }
    if (json is String) return ContentDto(en: json);
    return ContentDto();
  }

  Map<String, dynamic> toJson() => {'en': en};
}

class StyleDto {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final Map<String, String>? textAlign;
  final String? backgroundColor;
  final String? highlightColor;

  StyleDto({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
    this.highlightColor,
  });

  factory StyleDto.fromJson(Map<String, dynamic> json) {
    Map<String, String>? align;
    if (json['textAlign'] != null && json['textAlign'] is Map) {
      align = (json['textAlign'] as Map).map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      );
    }
    return StyleDto(
      fontSize: (json['fontSize'] != null)
          ? (json['fontSize'] as num).toDouble()
          : null,
      fontWeight: json['fontWeight'] as String?,
      color: json['color'] as String?,
      textAlign: align,
      backgroundColor: json['backgroundColor'] as String?,
      highlightColor: json['highlightColor'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'fontSize': fontSize,
    'fontWeight': fontWeight,
    'color': color,
    'textAlign': textAlign,
    'backgroundColor': backgroundColor,
    'highlightColor': highlightColor,
  };
}
