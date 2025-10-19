import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../di/di.dart';
import '../helpers/shared_pref.dart';
import '../utils/constants.dart';

@injectable
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit()
    : super(
        Locale(
          getIt<SharedPrefHelper>().getData(key: AppConstants.languageCode)
                  as String? ??
              AppConstants.enKey,
        ),
      );

  void changeLocale() {
    var lanCode = state.languageCode;
    if (lanCode == AppConstants.enKey) {
      getIt<SharedPrefHelper>().saveData(
        key: AppConstants.languageCode,
        val: AppConstants.arKey,
      );
      emit(const Locale(AppConstants.arKey));
    } else {
      getIt<SharedPrefHelper>().saveData(
        key: AppConstants.languageCode,
        val: AppConstants.enKey,
      );
      emit(const Locale(AppConstants.enKey));
    }
  }
}
