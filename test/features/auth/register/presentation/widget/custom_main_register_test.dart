// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
// import 'package:super_fitness_app/core/utils/keys.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/domain/use_cases/register_use_case.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
// import 'package:super_fitness_app/features/auth/register/presentation/widget/content_text_fields.dart';
// import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_circle_avatar.dart';
// import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_form_register.dart';
// import 'package:super_fitness_app/features/auth/register/presentation/widget/register_actions.dart';
//
//
// @GenerateMocks([RegisterUseCase])
void main() {
//   late MockRegisterUseCase mockRegisterUseCase;
//
//   setUp(() {
//     mockRegisterUseCase = MockRegisterUseCase();
//   });
//   testWidgets(
//     'CustomRegister builds correctly and navigates when form is valid',
//     (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           localizationsDelegates: AppLocalizations.localizationsDelegates,
//           supportedLocales: AppLocalizations.supportedLocales,
//           home: Scaffold(
//             body: BlocProvider(
//               create: (context) =>
//                   RegisterViewModel(registerUseCase: mockRegisterUseCase),
//               child: const CustomFormRegister(),
//             ),
//           ),
//         ),
//       );
//
//       expect(find.byType(CustomFormRegister), findsOneWidget);
//
//       expect(find.byKey(const Key(AppKeys.registerButton)), findsNWidgets(1));
//
//       expect(find.byType(ContentTextFields), findsOneWidget);
//
//       expect(find.byType(CustomCircleAvatar), findsNWidgets(3));
//
//       expect(find.byType(RegisterActions), findsOneWidget);
//
//       await tester.pumpAndSettle();
//
//       final firstNameField = find.byType(TextFormField).at(0);
//       final lastNameField = find.byType(TextFormField).at(1);
//       final emailField = find.byType(TextFormField).at(2);
//       final passwordField = find.byType(TextFormField).at(3);
//
//       await tester.enterText(firstNameField, 'Yahya');
//       await tester.enterText(lastNameField, 'Mohamed');
//       await tester.enterText(emailField, 'test@example.com');
//       await tester.enterText(passwordField, '12345678');
//     },
//   );
}
