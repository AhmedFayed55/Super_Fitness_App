import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/save_message_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/helpers/message_helper.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';

class MessageHandler {
  final SaveMessageUseCase saveMessageUseCase;
  final void Function(SmartChatState) emit;
  final SmartChatState Function() getState;
  final ChatSession Function() getChatSession;
  final DocumentReference? Function() getCurrentChatRef;
  final void Function(DocumentReference?) setCurrentChatRef;
  final Future<DocumentReference?> Function({String? firstMessage})
  createOrGetCurrentChat;
  final Future<void> Function() loadUserChatsOnce;

  bool _chatsLoadedAfterFirstMessage = false;

  MessageHandler({
    required this.saveMessageUseCase,
    required this.emit,
    required this.getState,
    required this.getChatSession,
    required this.getCurrentChatRef,
    required this.setCurrentChatRef,
    required this.createOrGetCurrentChat,
    required this.loadUserChatsOnce,
  });

  Future<void> handleSendMessage(String text) async {
    if (text.trim().isEmpty) return;

    if (getState().isSendingOrReceivingMessage) return;

    final chatController = getState().chatController;

    final chatRef = await createOrGetCurrentChat(firstMessage: text);
    if (chatRef == null) return;

    final chatId = chatRef.id;
    final user = getState().user;
    if (user == null) return;

    final userMessageId =
        '${DateTime.now().millisecondsSinceEpoch}_${AppConstants.userMessageSuffix}';
    chatController.insertMessage(
      TextMessage(
        id: userMessageId,
        authorId: AppConstants.userAuthorId,
        text: text,
      ),
    );

    emit(getState().copyWith(isSendingOrReceivingMessage: true));

    try {
      await saveMessageUseCase.call(
        userId: user.id,
        chatId: chatId,
        text: text,
        sender: AppConstants.userSender,
      );

      if (!_chatsLoadedAfterFirstMessage) {
        _chatsLoadedAfterFirstMessage = true;
        await loadUserChatsOnce();
      }

      final contextualMessage = MessageHelper.buildContextualMessage(
        text: text,
        user: user,
      );

      final response = await getChatSession().sendMessage(
        Content.text(contextualMessage),
      );

      final reply = response.text?.trim();

      if (reply != null && reply.isNotEmpty) {
        final botMessageId =
            '${DateTime.now().millisecondsSinceEpoch}_${AppConstants.botMessageSuffix}';

        chatController.insertMessage(
          TextMessage(
            id: botMessageId,
            authorId: AppConstants.botAuthorId,
            text: reply,
          ),
        );

        await saveMessageUseCase.call(
          userId: user.id,
          chatId: chatId,
          text: reply,
          sender: AppConstants.botSender,
        );
      }

      emit(getState().copyWith(isSendingOrReceivingMessage: false));
    } catch (e) {
      final errorMessageId =
          '${DateTime.now().millisecondsSinceEpoch}_${AppConstants.errorMessageSuffix}';

      chatController.insertMessage(
        TextMessage(
          id: errorMessageId,
          authorId: AppConstants.botAuthorId,
          text: AppConstants.errorMessageText,
        ),
      );

      emit(
        getState().copyWith(
          isSendingOrReceivingMessage: false,
          error: e.toString(),
        ),
      );
    }
  }
}
