import 'package:super_fitness_app/features/edit-profile/data/model/edit_user_respone/edit_user_respone.dart';
import 'package:super_fitness_app/features/edit-profile/data/model/edit_user_respone/user.dart';

abstract interface class EditProfileRemoteDs {
  Future<EditUserRespone> editUser(User user);
}
