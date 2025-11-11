// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/domain/use_cases/register_use_case.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
// import 'package:super_fitness_app/features/auth/register/presentation/widget/content_text_fields.dart';
//
//
// @GenerateMocks([RegisterUseCase])
void main() {
//   group('ContentTextFields Widget Tests', () {
//     late RegisterViewModel viewModel;
//     late MockRegisterUseCase mockRegisterUseCase;
//
//     setUp(() {
//       mockRegisterUseCase = MockRegisterUseCase();
//       viewModel = RegisterViewModel(registerUseCase: mockRegisterUseCase);
//     });
//
//     Future<void> pumpWidget(WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           localizationsDelegates: AppLocalizations.localizationsDelegates,
//           supportedLocales: AppLocalizations.supportedLocales,
//           home: Scaffold(
//             body: BlocProvider.value(
//               value: viewModel,
//               child: const ContentTextFields(),
//             ),
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//     }
//
//     testWidgets('renders all input fields correctly', (
//       WidgetTester tester,
//     ) async {
//       await pumpWidget(tester);
//
//       // 4 TextFormFields
//       expect(find.byType(TextFormField), findsNWidgets(4));
//
//       expect(find.byIcon(Icons.person_outline_sharp), findsNWidgets(2));
//       expect(find.byIcon(Icons.email_outlined), findsOneWidget);
//       expect(find.byIcon(Icons.lock_outlined), findsOneWidget);
//     });
//
//     testWidgets('password visibility toggles correctly', (
//       WidgetTester tester,
//     ) async {
//       await pumpWidget(tester);
//
//       expect(find.byIcon(Icons.visibility_off), findsOneWidget);
//
//       await tester.tap(find.byIcon(Icons.visibility_off));
//       await tester.pumpAndSettle();
//
//       expect(find.byIcon(Icons.visibility), findsOneWidget);
//     });
//
//     testWidgets('validators show error messages when fields are empty', (
//       WidgetTester tester,
//     ) async {
//       await pumpWidget(tester);
//
//       final formFinder = find.byType(Form);
//       expect(formFinder, findsNothing);
//
//       await tester.enterText(find.byType(TextFormField).at(0), '');
//       await tester.enterText(find.byType(TextFormField).at(1), '');
//       await tester.enterText(find.byType(TextFormField).at(2), 'notanemail');
//       await tester.enterText(find.byType(TextFormField).at(3), '123');
//
//       await tester.pump();
//
//       await tester.tapAt(const Offset(0, 0));
//       await tester.pump();
//
//       final textFields = tester
//           .widgetList<TextFormField>(find.byType(TextFormField))
//           .toList();
//
//       for (var field in textFields) {
//         if (field.validator != null) {
//           final result = field.validator!("wrong_input");
//           if (result != null) {
//             expect(result, isA<String>());
//           }
//         }
//       }
//     });
//
//     testWidgets('typing in fields updates controllers correctly', (
//       WidgetTester tester,
//     ) async {
//       await pumpWidget(tester);
//
//       await tester.enterText(find.byType(TextFormField).at(0), 'Yahya');
//       await tester.enterText(find.byType(TextFormField).at(1), 'Mohamed');
//       await tester.enterText(
//         find.byType(TextFormField).at(2),
//         'yahya@example.com',
//       );
//       await tester.enterText(find.byType(TextFormField).at(3), '12345678');
//
//       expect(viewModel.firstName.text, 'Yahya');
//       expect(viewModel.lastName.text, 'Mohamed');
//       expect(viewModel.emailController.text, 'yahya@example.com');
//       expect(viewModel.passwordController.text, '12345678');
//     });
//   });
}
