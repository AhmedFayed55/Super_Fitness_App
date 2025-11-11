// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
// import 'package:super_fitness_app/features/auth/logout/presentation/manager/logout_state.dart';
// import 'package:super_fitness_app/features/auth/logout/presentation/manager/logout_view_model.dart';
// import 'package:super_fitness_app/features/auth/logout/presentation/widget/custom_dialog.dart';
//
// import 'custom_dialog_test.mocks.dart';
//
// @GenerateMocks([LogoutViewModel])
void main() {
//   late LogoutViewModel logoutViewModel;
//
//   setUp(() {
//     logoutViewModel = MockLogoutViewModel();
//   });
//
//   testWidgets('LogoutAlertDialog shows text and buttons', (tester) async {
//     when(logoutViewModel.state).thenReturn(LogoutState());
//     when(logoutViewModel.stream).thenAnswer((_) => const Stream.empty());
//
//     await tester.pumpWidget(
//       MaterialApp(
//         localizationsDelegates: AppLocalizations.localizationsDelegates,
//         supportedLocales: AppLocalizations.supportedLocales,
//         home: BlocProvider<LogoutViewModel>(
//           create: (_) => logoutViewModel,
//           child: const Scaffold(body: LogoutAlertDialog()),
//         ),
//       ),
//     );
//
//     expect(find.text('Are you sure to close the application?'), findsOneWidget);
//
//     expect(find.text('Yes'), findsOneWidget);
//     expect(find.text('No'), findsOneWidget);
//   });
//
//   testWidgets('Tapping Yes and No buttons closes dialog', (tester) async {
//     when(logoutViewModel.state).thenReturn(LogoutState());
//     when(logoutViewModel.stream).thenAnswer((_) => const Stream.empty());
//     await tester.pumpWidget(
//       MaterialApp(
//         localizationsDelegates: AppLocalizations.localizationsDelegates,
//         supportedLocales: AppLocalizations.supportedLocales,
//         home: Scaffold(
//           body: BlocProvider(
//             create: (_) => logoutViewModel,
//             child: const LogoutAlertDialog(),
//           ),
//         ),
//       ),
//     );
//
//     expect(find.text('Are you sure to close the application?'), findsOneWidget);
//
//     await tester.tap(find.text('No'));
//     await tester.pump();
//
//     await tester.tap(find.text('Yes'));
//     await tester.pump();
//   });
}
