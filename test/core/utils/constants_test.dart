import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/utils/constants.dart';

void main() {
  group('AppConstants', () {
    test('should contain localization keys and defaults', () {
      expect(AppConstants.languageCode, 'languageCode');
      expect(AppConstants.arKey, 'ar');
      expect(AppConstants.enKey, 'en');
      expect(AppConstants.isOnBoardingSeen, 'onboarding_seen');
    });

    test('should contain general constants', () {
      expect(AppConstants.noInternet, 'No Internet Connection');
      expect(AppConstants.animateSeconds, 300);
      expect(AppConstants.blurSigma, 10);
      expect(AppConstants.defaultError, 'An unexpected error occurred');
    });

    test('should contain firestore collection names', () {
      expect(AppConstants.usersCollection, 'users');
      expect(AppConstants.chatsCollection, 'chats');
      expect(AppConstants.messagesCollection, 'messages');
    });

    test('should contain chat role identifiers', () {
      expect(AppConstants.userAuthorId, 'user1');
      expect(AppConstants.botAuthorId, 'bot');
      expect(AppConstants.userSender, 'user');
      expect(AppConstants.botSender, 'bot');
      expect(AppConstants.userMessageSuffix, 'user');
      expect(AppConstants.botMessageSuffix, 'bot');
      expect(AppConstants.errorMessageSuffix, 'error');
    });

    test('userProfileTemplate should contain all placeholders', () {
      const tpl = AppConstants.userProfileTemplate;
      expect(tpl.contains('{name}'), isTrue);
      expect(tpl.contains('{age}'), isTrue);
      expect(tpl.contains('{weight}'), isTrue);
      expect(tpl.contains('{height}'), isTrue);
      expect(tpl.contains('{activityLevel}'), isTrue);
      expect(tpl.contains('{goal}'), isTrue);
      expect(tpl.contains('{message}'), isTrue);
      expect(tpl.startsWith('User Profile Context:'), isTrue);
      expect(tpl.trim().endsWith('User Message: {message}'), isTrue);
    });
  });
}
