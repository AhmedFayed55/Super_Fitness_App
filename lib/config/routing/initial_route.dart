import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/helpers/shared_pref.dart';
import 'package:super_fitness_app/core/utils/constants.dart';

import 'app_routes.dart';

String? getInitialRoute() {
  final isTokenSaved = getIt<SharedPrefHelper>().getData(
    key: AppConstants.isTokenSaved,
  );
  final isOnBoardingSeen = getIt<SharedPrefHelper>().getData(
    key: AppConstants.isOnBoardingSeen,
  );
  if (isOnBoardingSeen == null || isOnBoardingSeen == false) {
    return AppRoutes.onboarding;
  } else if (isTokenSaved == null || isTokenSaved == false) {
    return AppRoutes.login;
  } else {
    return AppRoutes.appSections;
  }
}
