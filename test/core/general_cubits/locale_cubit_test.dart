import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/general_cubits/locale_cubit.dart';
import 'package:super_fitness_app/core/helpers/shared_pref.dart';
import 'package:super_fitness_app/core/utils/constants.dart';

import 'locale_cubit_test.mocks.dart';

@GenerateMocks([SharedPrefHelper])
void main() {
  late SharedPrefHelper mockSharedPrefHelper;

  setUp(() {
    mockSharedPrefHelper = MockSharedPrefHelper();

    if (getIt.isRegistered<SharedPrefHelper>()) {
      getIt.unregister<SharedPrefHelper>();
    }
    getIt.registerSingleton<SharedPrefHelper>(mockSharedPrefHelper);
  });

  group('Locale Cubit Testing', () {
    test('initial state should be Locale from SharedPref or default en', () {
      when(
        mockSharedPrefHelper.getData(key: AppConstants.languageCode),
      ).thenReturn(AppConstants.arKey);

      final cubit = LocaleCubit();

      expect(cubit.state, const Locale(AppConstants.arKey));
    });

    blocTest<LocaleCubit, Locale>(
      'emits Locale(ar) when current is en',
      build: () {
        when(
          mockSharedPrefHelper.getData(key: AppConstants.languageCode),
        ).thenReturn(AppConstants.enKey);

        when(
          mockSharedPrefHelper.saveData(
            key: AppConstants.languageCode,
            val: AppConstants.arKey,
          ),
        ).thenAnswer((_) async => true);

        return LocaleCubit();
      },
      act: (cubit) => cubit.changeLocale(),
      expect: () => [const Locale(AppConstants.arKey)],
      verify: (_) {
        verify(
          mockSharedPrefHelper.saveData(
            key: AppConstants.languageCode,
            val: AppConstants.arKey,
          ),
        ).called(1);
      },
    );

    blocTest<LocaleCubit, Locale>(
      'emits Locale(en) when current is ar',
      build: () {
        when(
          mockSharedPrefHelper.getData(key: AppConstants.languageCode),
        ).thenReturn(AppConstants.arKey);

        when(
          mockSharedPrefHelper.saveData(
            key: AppConstants.languageCode,
            val: AppConstants.enKey,
          ),
        ).thenAnswer((_) async => true);

        return LocaleCubit();
      },
      act: (cubit) => cubit.changeLocale(),
      expect: () => [const Locale(AppConstants.enKey)],
      verify: (_) {
        verify(
          mockSharedPrefHelper.saveData(
            key: AppConstants.languageCode,
            val: AppConstants.enKey,
          ),
        ).called(1);
      },
    );
  });
}
