sealed class SmartChatEvent {}

class InitializeChatEvent extends SmartChatEvent {}

class SendMessageEvent extends SmartChatEvent {
  final String message;
  SendMessageEvent(this.message);
}

class LoadUserDataEvent extends SmartChatEvent {}

class LoadUserChatsEvent extends SmartChatEvent {}

class SelectChatEvent extends SmartChatEvent {
  final String chatId;
  SelectChatEvent(this.chatId);
}

class DeleteChatEvent extends SmartChatEvent {
  final String chatId;
  DeleteChatEvent(this.chatId);
}

class ToggleDrawerEvent extends SmartChatEvent {}

final class CreateNewChatEvent extends SmartChatEvent {}
