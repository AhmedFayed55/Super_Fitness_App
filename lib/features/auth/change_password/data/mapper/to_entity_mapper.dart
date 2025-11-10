import 'package:super_fitness_app/features/auth/change_password/data/models/change_pass_response.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';

extension ChangePasswordResponseMapper on ChangePasswordResponse {
  ChangePasswordEntity toEntity() {
    return ChangePasswordEntity(message: message ?? "", token: token ?? "");
  }
}
