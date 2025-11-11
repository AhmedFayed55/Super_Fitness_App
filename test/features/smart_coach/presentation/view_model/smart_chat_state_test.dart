import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';

class FakeChatController extends InMemoryChatController {}

void main() {
  group('SmartChatState', () {
    final chatController = FakeChatController();
    const user = UserEntity(
      id: '1',
      firstName: 'Ahmed',
      lastName: 'Rajeh',
      email: 'ahmed@example.com',
      gender: 'male',
      age: 25,
      weight: 70,
      height: 175,
      activityLevel: 'medium',
      goal: 'fitness',
      photo: 'photo_url',
      createdAt: '2024-01-01',
    );

    const chatMeta = ChatMetadataEntity(id: 'chat1', title: 'Chat 1');

    test('Default constructor sets expected values', () {
      final state = SmartChatState(chatController: chatController);

      expect(state.chatController, chatController);
      expect(state.isLoading, false);
      expect(state.isLoadingUser, false);
      expect(state.isLoadingChats, false);
      expect(state.isSendingOrReceivingMessage, false);
      expect(state.isLoadingMessages, false);
      expect(state.error, isNull);
      expect(state.user, isNull);
      expect(state.userChats, isEmpty);
      expect(state.showDrawer, false);
      expect(state.currentChatId, isNull);
      expect(state.hasLoadedChats, false);
    });

    test('copyWith updates only provided fields', () {
      final state = SmartChatState(chatController: chatController);
      final updated = state.copyWith(
        isLoading: true,
        user: user,
        userChats: [chatMeta],
        showDrawer: true,
        currentChatId: 'chat1',
      );

      expect(updated.isLoading, true);
      expect(updated.user, user);
      expect(updated.userChats, [chatMeta]);
      expect(updated.showDrawer, true);
      expect(updated.currentChatId, 'chat1');
      expect(updated.chatController, chatController);
      expect(updated.isLoadingUser, false);
    });

    test('Equatable correctly compares identical states', () {
      final s1 = SmartChatState(chatController: chatController);
      final s2 = SmartChatState(chatController: chatController);
      expect(s1, equals(s2));
    });

    test('Equatable detects differences between states', () {
      final s1 = SmartChatState(chatController: chatController);
      final s2 = s1.copyWith(isLoading: true);
      expect(s1 == s2, false);
    });

    test('copyWith null error resets error', () {
      final s1 = SmartChatState(chatController: chatController, error: 'Error');
      final s2 = s1.copyWith(error: null);
      expect(s2.error, null);
    });
  });
}
