class HelpScreenResponseDto {
  final String? section;
  final ContentDto? title;
  final ContentDto? content;
  final StyleDto? style;
  final List<ContactDto>? contentList;
  final List<FaqDto>? faqs;

  HelpScreenResponseDto({
    this.section,
    this.title,
    this.content,
    this.style,
    this.contentList,
    this.faqs,
  });

  factory HelpScreenResponseDto.fromJson(Map<String, dynamic> json) {
    List<ContactDto>? contactList;
    if (json['content'] != null && json['content'] is List) {
      contactList = (json['content'] as List)
          .map((e) => ContactDto.fromJson(e))
          .toList();
    }

    List<FaqDto>? faqList;
    if (json['content'] != null && json['section'] == 'faq') {
      faqList = (json['content'] as List)
          .map((e) => FaqDto.fromJson(e))
          .toList();
    }

    return HelpScreenResponseDto(
      section: json['section'] as String?,
      title: json['title'] != null ? ContentDto.fromJson(json['title']) : null,
      content: json['content'] != null && json['content'] is Map
          ? ContentDto.fromJson(json['content'])
          : null,
      style: json['style'] != null ? StyleDto.fromJson(json['style']) : null,
      contentList: contactList,
      faqs: faqList,
    );
  }

  Map<String, dynamic> toJson() => {
    'section': section,
    'title': title?.toJson(),
    'content': content?.toJson(),
    'style': style?.toJson(),
    'contentList': contentList?.map((e) => e.toJson()).toList(),
    'faqs': faqs?.map((e) => e.toJson()).toList(),
  };
}

class ContactDto {
  final String? id;
  final ContentDto? method;
  final ContentDto? details;
  final String? value;
  final ContactStyleDto? style;

  ContactDto({this.id, this.method, this.details, this.value, this.style});

  factory ContactDto.fromJson(Map<String, dynamic> json) => ContactDto(
    id: json['id'] as String?,
    method: json['method'] != null ? ContentDto.fromJson(json['method']) : null,
    details: json['details'] != null
        ? ContentDto.fromJson(json['details'])
        : null,
    value: json['value'] as String?,
    style: json['style'] != null
        ? ContactStyleDto.fromJson(json['style'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'method': method?.toJson(),
    'details': details?.toJson(),
    'value': value,
    'style': style?.toJson(),
  };
}

class FaqDto {
  final String? id;
  final ContentDto? question;
  final ContentDto? answer;

  FaqDto({this.id, this.question, this.answer});

  factory FaqDto.fromJson(Map<String, dynamic> json) => FaqDto(
    id: json['id'] as String?,
    question: json['question'] != null
        ? ContentDto.fromJson(json['question'])
        : null,
    answer: json['answer'] != null ? ContentDto.fromJson(json['answer']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question?.toJson(),
    'answer': answer?.toJson(),
  };
}

class ContactStyleDto {
  final StyleDto? method;
  final StyleDto? details;

  ContactStyleDto({this.method, this.details});

  factory ContactStyleDto.fromJson(Map<String, dynamic> json) =>
      ContactStyleDto(
        method: json['method'] != null
            ? StyleDto.fromJson(json['method'])
            : null,
        details: json['details'] != null
            ? StyleDto.fromJson(json['details'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'method': method?.toJson(),
    'details': details?.toJson(),
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

  Map<String, dynamic> toJson() => {
    'fontSize': fontSize,
    'fontWeight': fontWeight,
    'color': color,
    'textAlign': textAlign,
    'backgroundColor': backgroundColor,
  };
}
