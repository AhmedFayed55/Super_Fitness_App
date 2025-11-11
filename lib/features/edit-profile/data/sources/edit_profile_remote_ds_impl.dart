import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/edit-profile/data/model/edit_user_respone/edit_user_respone.dart';
import 'package:super_fitness_app/features/edit-profile/data/model/edit_user_respone/user.dart';
import 'package:super_fitness_app/features/edit-profile/data/sources/edit_profile_remote_ds.dart';

@Injectable(as: EditProfileRemoteDs)
class EditProfileRemoteDsImpl implements EditProfileRemoteDs {
  final ApiServices _apiServices;

  EditProfileRemoteDsImpl(this._apiServices);
  @override
  Future<EditUserRespone> editUser(User user) async {
    return await _apiServices.editProfile({
      AppConstants.firstName: user.firstName,
      AppConstants.lastName: user.lastName,
      AppConstants.email: user.email,
      AppConstants.weight: user.weight,
      AppConstants.activityLevel: ActivityLevel.toLevelName(
        user.activityLevel!,
      ),
      AppConstants.goal: user.goal,
    });
  }
}
