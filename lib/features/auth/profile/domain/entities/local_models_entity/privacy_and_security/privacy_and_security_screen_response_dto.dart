class PrivacyPolicyEntity {
  final String? section;
  final String? title;
  final List<String?>? content;
  final StyleEntity? style;
  final List<PrivacyPolicyEntity>? subSections;

  PrivacyPolicyEntity({
    this.section,
    this.title,
    this.content,
    this.style,
    this.subSections,
  });
}

class StyleEntity {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final Map<String, String>? textAlign;
  final String? backgroundColor;

  StyleEntity({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });
}
