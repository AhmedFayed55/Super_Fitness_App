import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';

abstract interface class EditProfileRepo {
  Future<ApiResult> editUser(UserEntity body);
}
