import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/edit-profile/data/mapper/to_dto.dart';
import 'package:super_fitness_app/features/edit-profile/data/sources/edit_profile_remote_ds.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/domain/repo/edit_profile_repo.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileRemoteDs _editProfileRemoteDs;

  EditProfileRepoImpl(this._editProfileRemoteDs);

  @override
  Future<ApiResult> editUser(UserEntity user) {
    return safeApiCall(() async => _editProfileRemoteDs.editUser(user.toDto()));
  }
}
