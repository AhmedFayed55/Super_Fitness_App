class HelpScreenResponseEntity {
  final String? section;
  final String? title;
  final String? content;
  final StyleEntity? style;
  final List<ContactEntity>? contacts;
  final List<FaqEntity>? faqs;

  HelpScreenResponseEntity({
    this.section,
    this.title,
    this.content,
    this.style,
    this.contacts,
    this.faqs,
  });
}

class ContactEntity {
  final String? id;
  final String? method;
  final String? details;
  final String? value;
  final ContactStyleEntity? style;

  ContactEntity({this.id, this.method, this.details, this.value, this.style});
}

class ContactStyleEntity {
  final StyleEntity? method;
  final StyleEntity? details;

  ContactStyleEntity({this.method, this.details});
}

class FaqEntity {
  final String? id;
  final String? question;
  final String? answer;

  FaqEntity({this.id, this.question, this.answer});
}

class StyleEntity {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final Map<String, String>? textAlign;
  final String? backgroundColor;

  StyleEntity({this.fontSize, this.fontWeight, this.color, this.textAlign, this.backgroundColor});
}
