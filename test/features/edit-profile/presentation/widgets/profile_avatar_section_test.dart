import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/profile_avatar_section.dart';

void main() {
  final testUser = UserEntity(
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
    photo: "https://example.com/photo.jpg",
    createdAt: DateTime.now(),
  );

  Widget buildWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: ProfileAvatarSection(user: testUser)),
    );
  }

  testWidgets('displays correct full name', (tester) async {
    await tester.pumpWidget(buildWidget());
    expect(find.text('Ahmed Yehia'), findsOneWidget);
  });

  testWidgets('displays edit icon', (tester) async {
    await tester.pumpWidget(buildWidget());
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('shows placeholder while loading image', (tester) async {
    await tester.pumpWidget(buildWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
