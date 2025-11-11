import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

import 'package:super_fitness_app/features/edit-profile/presentation/widgets/name_email_section.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_event.dart';

import 'name_email_section_test.mocks.dart';

@GenerateMocks([EditProfileCubit])
void main() {
  late MockEditProfileCubit mockCubit;

  final user = UserEntity(
    id: "1",
    firstName: "Ahmed",
    lastName: "Yehia",
    email: "test@test.com",
    gender: "male",
    age: 22,
    weight: 75,
    height: 180,
    activityLevel: "Intermediate",
    goal: "Gain weight",
    photo: '',
    createdAt: DateTime.now(),
  );

  setUp(() {
    mockCubit = MockEditProfileCubit();

    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());

    when(mockCubit.state).thenReturn(EditProfileState(user: user));

    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<EditProfileCubit>.value(
        value: mockCubit,
        child: Scaffold(body: NameEmailSection(user: user)),
      ),
    );
  }

  testWidgets('displays initial user values', (tester) async {
    await tester.pumpWidget(buildWidget());
    expect(find.text('Ahmed'), findsOneWidget);
    expect(find.text('Yehia'), findsOneWidget);
    expect(find.text('test@test.com'), findsOneWidget);
  });

  testWidgets('calls cubit.doIntant(ChangeFirstNameEvent)', (tester) async {
    await tester.pumpWidget(buildWidget());

    await tester.enterText(find.text('Ahmed'), 'Mohamed');
    await tester.pump();

    verify(
      mockCubit.doIntant(
        argThat(
          isA<ChangeFirstNameEvent>().having(
            (e) => e.newFirstName,
            'newFirstName',
            'Mohamed',
          ),
        ),
      ),
    ).called(1);
  });

  testWidgets('calls cubit.doIntant(ChangeLastNameEvent)', (tester) async {
    await tester.pumpWidget(buildWidget());

    await tester.enterText(find.text('Yehia'), 'Ali');
    await tester.pump();

    verify(
      mockCubit.doIntant(
        argThat(
          isA<ChangeLastNameEvent>().having(
            (e) => e.newLastName,
            'newLastName',
            'Ali',
          ),
        ),
      ),
    ).called(1);
  });

  testWidgets('calls cubit.doIntant(ChangeEmailEvent)', (tester) async {
    await tester.pumpWidget(buildWidget());

    await tester.enterText(find.text('test@test.com'), 'new@test.com');
    await tester.pump();

    verify(
      mockCubit.doIntant(
        argThat(
          isA<ChangeEmailEvent>().having(
            (e) => e.email,
            'email',
            'new@test.com',
          ),
        ),
      ),
    ).called(1);
  });
}
