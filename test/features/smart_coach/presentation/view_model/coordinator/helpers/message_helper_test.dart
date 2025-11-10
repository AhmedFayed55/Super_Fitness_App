import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/helpers/message_helper.dart';

void main() {
  group('MessageHelper', () {
    late UserEntity user;
    const template =
        'Name: {name}, Age: {age}, Weight: {weight}, Height: {height}, '
        'Activity: {activityLevel}, Goal: {goal}, Message: {message}';

    setUp(() {
      user = const UserEntity(
        id: '1',
        firstName: 'Ahmed',
        lastName: 'Rageh',
        email: 'ahmed@example.com',
        gender: 'male',
        age: 25,
        weight: 75,
        height: 180,
        activityLevel: 'Active',
        goal: 'Muscle Gain',
        photo: '',
        createdAt: '',
      );
    });

    test('buildContextualMessage replaces all placeholders correctly', () {
      const text = 'Hello there';
      final result = MessageHelper.buildContextualMessage(
        text: text,
        user: user,
      ).replaceAll(AppConstants.userProfileTemplate, template);

      expect(result.contains('Ahmed Rageh'), true);
      expect(result.contains('25'), true);
      expect(result.contains('75'), true);
      expect(result.contains('180'), true);
      expect(result.contains('Active'), true);
      expect(result.contains('Muscle Gain'), true);
      expect(result.contains('Hello there'), true);
    });

    test('isArabic returns true for Arabic text', () {
      expect(MessageHelper.isArabic('مرحبا'), true);
    });

    test('isArabic returns false for English text', () {
      expect(MessageHelper.isArabic('Hello'), false);
    });
  });
}
