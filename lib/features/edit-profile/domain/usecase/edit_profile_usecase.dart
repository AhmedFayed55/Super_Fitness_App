import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/domain/repo/edit_profile_repo.dart';

@injectable
class EditProfileUsecase {
  final EditProfileRepo _editProfileRepo;

  EditProfileUsecase(this._editProfileRepo);

  Future<ApiResult> invoke(UserEntity body) => _editProfileRepo.editUser(body);
}
