import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/create_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/delete_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_chat_messages_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_chats_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';

class ChatHandler {
  final CreateChatUseCase createChatUseCase;
  final GetUserChatsUseCase getUserChatsUseCase;
  final GetChatWithMessagesUseCase getChatWithMessagesUseCase;
  final DeleteChatUseCase deleteChatUseCase;

  final void Function(SmartChatState) emit;
  final SmartChatState Function() getState;
  final DocumentReference? Function() getCurrentChatRef;
  final void Function(DocumentReference?) setCurrentChatRef;

  ChatHandler({
    required this.createChatUseCase,
    required this.getUserChatsUseCase,
    required this.getChatWithMessagesUseCase,
    required this.deleteChatUseCase,
    required this.emit,
    required this.getState,
    required this.getCurrentChatRef,
    required this.setCurrentChatRef,
  });

  Future<void> createNewChat() async {
    try {
      final user = getState().user;
      if (user == null) {
        emit(getState().copyWith(error: AppConstants.defaultError));
        return;
      }

      final result = await createChatUseCase.call(
        user.id,
        '${AppConstants.defaultChatTitle} - ${DateTime.now().toLocal()}',
      );

      switch (result) {
        case FirebaseSuccessResult():
          setCurrentChatRef(result.data);
          emit(getState().copyWith(currentChatId: result.data.id));
          break;

        case FirebaseErrorResult():
          emit(getState().copyWith(error: result.failure.errorMessage));
          break;
      }
    } catch (e) {
      emit(getState().copyWith(error: e.toString()));
    }
  }

  Future<DocumentReference?> createOrGetCurrentChat({
    String? firstMessage,
  }) async {
    if (getCurrentChatRef() != null) return getCurrentChatRef();

    final user = getState().user;
    if (user == null) {
      emit(getState().copyWith(error: AppConstants.defaultError));
      return null;
    }

    final title = firstMessage ?? 'Chat on ${DateTime.now().toLocal()}';
    final result = await createChatUseCase.call(user.id, title);

    switch (result) {
      case FirebaseSuccessResult():
        setCurrentChatRef(result.data);
        emit(getState().copyWith(currentChatId: result.data.id));
        return result.data;

      case FirebaseErrorResult():
        emit(getState().copyWith(error: result.failure.errorMessage));
        return null;
    }
  }

  Future<void> loadUserChats() async {
    final user = getState().user;
    if (user == null) return;

    emit(getState().copyWith(isLoadingChats: true));
    final result = await getUserChatsUseCase.call(user.id);

    switch (result) {
      case FirebaseSuccessResult():
        final chats = result.data;

        emit(
          getState().copyWith(
            userChats: chats,
            isLoadingChats: false,
            hasLoadedChats: true,
            error: null,
          ),
        );

        if (chats.isEmpty) {
          await createNewChat();
        }
        break;

      case FirebaseErrorResult():
        emit(
          getState().copyWith(
            isLoadingChats: false,
            error: result.failure.errorMessage,
          ),
        );
        break;
    }
  }

  Future<void> selectChat(String chatId) async {
    final user = getState().user;
    if (user == null) return;

    emit(getState().copyWith(isLoadingMessages: true));
    final result = await getChatWithMessagesUseCase.call(user.id, chatId);

    switch (result) {
      case FirebaseSuccessResult():
        final chatEntity = result.data;

        final messages = chatEntity.messages.map((msgEntity) {
          return TextMessage(
            id: msgEntity.id,
            authorId: msgEntity.sender == 'user' ? 'user1' : 'bot',
            text: msgEntity.text,
          );
        }).toList();

        final newController = InMemoryChatController();
        for (final msg in messages) {
          newController.insertMessage(msg);
        }

        setCurrentChatRef(
          FirebaseFirestore.instance
              .collection(AppConstants.usersCollection)
              .doc(user.id)
              .collection(AppConstants.chatsCollection)
              .doc(chatId),
        );

        emit(
          getState().copyWith(
            currentChatId: chatId,
            isLoadingMessages: false,
            showDrawer: false,
            chatController: newController,
            error: null,
          ),
        );
        break;

      case FirebaseErrorResult():
        emit(
          getState().copyWith(
            isLoadingMessages: false,
            error: result.failure.errorMessage,
          ),
        );
        break;
    }
  }

  Future<void> deleteChat(String chatId) async {
    final user = getState().user;
    if (user == null) return;

    final result = await deleteChatUseCase.call(user.id, chatId);

    switch (result) {
      case FirebaseSuccessResult():
        final updatedChats = getState().userChats
            .where((chat) => chat.id != chatId)
            .toList();

        if (getCurrentChatRef()?.id == chatId) {
          setCurrentChatRef(null);
          _clearMessages();
        }

        emit(
          getState().copyWith(
            userChats: updatedChats,
            currentChatId: getCurrentChatRef()?.id,
          ),
        );
        break;

      case FirebaseErrorResult():
        emit(getState().copyWith(error: result.failure.errorMessage));
        break;
    }
  }

  void toggleDrawer() {
    final newShowDrawer = !getState().showDrawer;
    emit(getState().copyWith(showDrawer: newShowDrawer));

    if (newShowDrawer && getState().userChats.isEmpty) {
      loadUserChats();
    }
  }

  void _clearMessages() {
    emit(getState().copyWith(chatController: InMemoryChatController()));
  }
}
