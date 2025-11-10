import 'package:super_fitness_app/features/auth/logout/data/model/logout_response_dto.dart';
import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';

extension LogoutMapper on LogoutResponseDto {
  LogoutEntity toEntity() => LogoutEntity(message: message ?? '');
}
