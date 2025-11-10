import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'edit_user_respone.g.dart';

@JsonSerializable()
class EditUserRespone {
  String? message;
  User? user;

  EditUserRespone({this.message, this.user});

  factory EditUserRespone.fromJson(Map<String, dynamic> json) {
    return _$EditUserResponeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EditUserResponeToJson(this);
}
