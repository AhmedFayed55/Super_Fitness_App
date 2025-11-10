import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/activity_body.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/goal_selector.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/number_selector.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/w_g_a_body.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';

import 'w_g_a_body_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EditProfileCubit>()])
void main() {
  late MockEditProfileCubit mockCubit;
  late UserEntity user;

  setUp(() {
    mockCubit = MockEditProfileCubit();

    user = UserEntity(
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
      photo: "",
      createdAt: DateTime(2024),
    );
  });

  Widget buildTestWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<EditProfileCubit>.value(
        value: mockCubit,
        child: const Scaffold(body: WGABody()),
      ),
    );
  }

  testWidgets("shows SelectNumber when selectedEdits = weight", (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 0.5;

    final state = EditProfileState(user: user, selectedEdits: Edits.weight);

    when(mockCubit.state).thenReturn(state);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(state));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(SelectNumber), findsOneWidget);
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets("shows GoalSelector when selectedEdits = goal", (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 0.5;

    final state = EditProfileState(user: user, selectedEdits: Edits.goal);

    when(mockCubit.state).thenReturn(state);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(state));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(GoalSelector), findsOneWidget);
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets("shows ActivitySelector when selectedEdits = activity", (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 0.5;

    final state = EditProfileState(user: user, selectedEdits: Edits.activity);

    when(mockCubit.state).thenReturn(state);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(state));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(ActivitySelector), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
