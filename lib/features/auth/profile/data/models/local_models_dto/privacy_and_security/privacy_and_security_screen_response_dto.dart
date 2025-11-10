class PrivacyPolicyResponseDto {
  final String? section;
  final ContentDto? title;
  final List<ContentDto>? content;
  final StyleDto? style;
  final List<PrivacyPolicyResponseDto>? subSections;

  PrivacyPolicyResponseDto({
    this.section,
    this.title,
    this.content,
    this.style,
    this.subSections,
  });

  factory PrivacyPolicyResponseDto.fromJson(Map<String, dynamic> json) {
    ContentDto? titleDto;
    if (json['title'] != null) {
      titleDto = ContentDto.fromJson(json['title']);
    }

    List<ContentDto>? contentList;
    final contentJson = json['content'];
    if (contentJson != null) {
      if (contentJson is String) {
        contentList = [ContentDto(en: contentJson)];
      } else if (contentJson is Map<String, dynamic>) {
        contentList = [ContentDto.fromJson(contentJson)];
      } else if (contentJson is List) {
        contentList = contentJson.map((e) => ContentDto.fromJson(e)).toList();
      }
    }

    List<PrivacyPolicyResponseDto>? subSectionsList;
    if (json['sub_sections'] != null && json['sub_sections'] is List) {
      subSectionsList = (json['sub_sections'] as List)
          .map((e) => PrivacyPolicyResponseDto.fromJson(e))
          .toList();
    }

    return PrivacyPolicyResponseDto(
      section: json['section'] as String?,
      title: titleDto,
      content: contentList,
      style: json['style'] != null ? StyleDto.fromJson(json['style']) : null,
      subSections: subSectionsList,
    );
  }
}

class ContentDto {
  final dynamic en;

  ContentDto({this.en});

  factory ContentDto.fromJson(dynamic json) {
    if (json == null) return ContentDto();
    if (json is Map<String, dynamic>) return ContentDto(en: json['en']);
    if (json is String) return ContentDto(en: json);
    return ContentDto();
  }
}

class StyleDto {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final Map<String, String>? textAlign;
  final String? backgroundColor;

  StyleDto({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
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
    );
  }
}
