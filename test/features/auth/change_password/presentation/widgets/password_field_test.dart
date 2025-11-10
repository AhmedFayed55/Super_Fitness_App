import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_state.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_view_model.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/widgets/password_field.dart';

import 'password_field_test.mocks.dart';

@GenerateMocks([ChangePasswordViewModel])
void main() {
  late MockChangePasswordViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockChangePasswordViewModel();
    when(mockViewModel.state).thenReturn(ChangePasswordState());
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest({bool isVisible = true}) {
    return MaterialApp(
      home: BlocProvider<ChangePasswordViewModel>.value(
        value: mockViewModel,
        child: Scaffold(
          body: PasswordField(
            controller: TextEditingController(),
            hintText: 'Enter password',
            isVisible: isVisible,
            onPressed: () {},
            validator: (value) =>
                value != null && value.isEmpty ? 'Password required' : null,
          ),
        ),
      ),
    );
  }

  testWidgets('test PasswordField with visibility icon isVisible = true', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest(isVisible: true));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('test PasswordField with visible icon when isVisible = false', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest(isVisible: false));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
  });
}
