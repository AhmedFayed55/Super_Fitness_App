import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_state.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_view_model.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/pages/change_password_screen.dart';

import '../widgets/password_field_test.mocks.dart';

@GenerateMocks([ChangePasswordViewModel])
void main() {
  late MockChangePasswordViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockChangePasswordViewModel();

    when(mockViewModel.state).thenReturn(ChangePasswordState());
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
    if (getIt.isRegistered<ChangePasswordViewModel>()) {
      getIt.unregister<ChangePasswordViewModel>();
    }
    getIt.registerSingleton<ChangePasswordViewModel>(mockViewModel);
  });

  testWidgets('renders header and password form sections', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale("en"),
        home: BlocProvider<ChangePasswordViewModel>.value(
          value: mockViewModel,
          child: const ChangePasswordScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ChangePasswordScreen), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
  });
}
