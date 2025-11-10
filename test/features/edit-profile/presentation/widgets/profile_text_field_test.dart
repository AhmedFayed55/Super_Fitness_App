import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:super_fitness_app/features/edit-profile/presentation/widgets/profile_text_field.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'profile_text_field_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EditProfileCubit>()])
void main() {
  late MockEditProfileCubit mockCubit;
  late TextEditingController controller;

  setUp(() {
    mockCubit = MockEditProfileCubit();
    controller = TextEditingController(text: "Ahmed");

    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.state).thenReturn(const EditProfileState());
  });

  Widget buildWidget({required ValueChanged<String> onChanged}) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<EditProfileCubit>.value(
          value: mockCubit,
          child: Form(
            key: mockCubit.formKey,
            child: ProfileTextField(
              controller: controller,
              icon: Icons.person,
              hint: "First Name",
              onChanged: onChanged,
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('displays initial value', (tester) async {
    await tester.pumpWidget(buildWidget(onChanged: (_) {}));
    expect(find.widgetWithText(TextFormField, "Ahmed"), findsOneWidget);
  });

  testWidgets('calls onChanged when text is updated', (tester) async {
    String? capturedValue;

    await tester.pumpWidget(buildWidget(onChanged: (v) => capturedValue = v));

    await tester.enterText(find.byType(TextFormField), "Mohamed");
    await tester.pump();

    expect(capturedValue, "Mohamed");
  });

  testWidgets('triggers form validation on change', (tester) async {
    final formKey = GlobalKey<FormState>();
    when(mockCubit.formKey).thenReturn(formKey);

    await tester.pumpWidget(buildWidget(onChanged: (_) {}));

    await tester.enterText(find.byType(TextFormField), "");
    await tester.pump();

    expect(formKey.currentState!.validate(), false);
  });
}
