import 'package:equatable/equatable.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';

class SmartChatState extends Equatable {
  final InMemoryChatController chatController;
  final bool isLoading;
  final bool isLoadingUser;
  final bool isLoadingChats;
  final bool isSendingOrReceivingMessage;
  final bool isLoadingMessages;
  final String? error;
  final UserEntity? user;
  final List<ChatMetadataEntity> userChats;
  final bool showDrawer;
  final String? currentChatId;
  final bool hasLoadedChats;

  const SmartChatState({
    required this.chatController,
    this.isLoading = false,
    this.isLoadingUser = false,
    this.isLoadingChats = false,
    this.isSendingOrReceivingMessage = false,
    this.isLoadingMessages = false,
    this.error,
    this.user,
    this.userChats = const [],
    this.showDrawer = false,
    this.currentChatId,
    this.hasLoadedChats = false,
  });

  SmartChatState copyWith({
    InMemoryChatController? chatController,
    bool? isLoading,
    bool? isLoadingUser,
    bool? isLoadingChats,
    bool? isSendingOrReceivingMessage,
    bool? isLoadingMessages,
    String? error,
    UserEntity? user,
    List<ChatMetadataEntity>? userChats,
    bool? showDrawer,
    String? currentChatId,
    bool? hasLoadedChats,
  }) {
    return SmartChatState(
      chatController: chatController ?? this.chatController,
      isLoading: isLoading ?? this.isLoading,
      isLoadingUser: isLoadingUser ?? this.isLoadingUser,
      isLoadingChats: isLoadingChats ?? this.isLoadingChats,
      isSendingOrReceivingMessage:
          isSendingOrReceivingMessage ?? this.isSendingOrReceivingMessage,
      isLoadingMessages: isLoadingMessages ?? this.isLoadingMessages,
      error: error,
      user: user ?? this.user,
      userChats: userChats ?? this.userChats,
      showDrawer: showDrawer ?? this.showDrawer,
      currentChatId: currentChatId ?? this.currentChatId,
      hasLoadedChats: hasLoadedChats ?? this.hasLoadedChats,
    );
  }

  @override
  List<Object?> get props => [
    identityHashCode(chatController),
    isLoading,
    isLoadingUser,
    isLoadingChats,
    isSendingOrReceivingMessage,
    isLoadingMessages,
    error,
    user,
    userChats.length,
    userChats.map((c) => c.id).toList(),
    showDrawer,
    currentChatId,
    hasLoadedChats,
  ];
}
