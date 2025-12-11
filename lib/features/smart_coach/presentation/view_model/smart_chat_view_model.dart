import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/create_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/delete_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_chat_messages_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_chats_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_data_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/save_message_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/handlers/chat_handler.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/handlers/message_handler.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/handlers/user_handler.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/helpers/message_helper.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';

@injectable
class SmartChatViewModel extends Cubit<SmartChatState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final CreateChatUseCase _createChatUseCase;
  final SaveMessageUseCase _saveMessageUseCase;
  final GetUserChatsUseCase _getUserChatsUseCase;
  final GetChatWithMessagesUseCase _getChatWithMessagesUseCase;
  final DeleteChatUseCase _deleteChatUseCase;

  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  DocumentReference? _currentChatRef;

  late final ChatHandler _chatHandler;
  late final MessageHandler _messageHandler;
  late final UserHandler _userHandler;

  SmartChatViewModel(
    this._getUserDataUseCase,
    this._createChatUseCase,
    this._saveMessageUseCase,
    this._getUserChatsUseCase,
    this._getChatWithMessagesUseCase,
    this._deleteChatUseCase,
  ) : super(SmartChatState(chatController: InMemoryChatController())) {
    _initializeHandlers();
  }
  void _initializeHandlers() {
    _chatHandler = ChatHandler(
      createChatUseCase: _createChatUseCase,
      getUserChatsUseCase: _getUserChatsUseCase,
      getChatWithMessagesUseCase: _getChatWithMessagesUseCase,
      deleteChatUseCase: _deleteChatUseCase,
      emit: emit,
      getState: () => state,
      getCurrentChatRef: () => _currentChatRef,
      setCurrentChatRef: (ref) => _currentChatRef = ref,
    );
    _messageHandler = MessageHandler(
      saveMessageUseCase: _saveMessageUseCase,
      emit: emit,
      getState: () => state,
      getChatSession: () => _chatSession,
      getCurrentChatRef: () => _currentChatRef,
      setCurrentChatRef: (ref) => _currentChatRef = ref,
      createOrGetCurrentChat: _chatHandler.createOrGetCurrentChat,
      loadUserChatsOnce: () => _chatHandler.loadUserChats(),
    );

    _userHandler = UserHandler(
      getUserDataUseCase: _getUserDataUseCase,
      emit: emit,
      getState: () => state,
      loadUserChats: () => _chatHandler.loadUserChats(),
    );
  }

  bool isArabic(String text) => MessageHelper.isArabic(text);

  Future<void> doIntent(SmartChatEvent event) async {
    switch (event) {
      case InitializeChatEvent():
        await _initializeChat();
        break;
      case SendMessageEvent():
        await _messageHandler.handleSendMessage(event.message);
        break;
      case LoadUserDataEvent():
        await _userHandler.loadUserData();
        break;
      case LoadUserChatsEvent():
        await _chatHandler.loadUserChats();
        break;
      case SelectChatEvent():
        await _chatHandler.selectChat(event.chatId);
        break;
      case DeleteChatEvent():
        await _chatHandler.deleteChat(event.chatId);
        break;
      case ToggleDrawerEvent():
        _chatHandler.toggleDrawer();
        break;
      case CreateNewChatEvent():
        await _chatHandler.createNewChat();
        break;
    }
  }

  Future<void> _initializeChat() async {
    try {
      _model = GenerativeModel(
        model: 'gemini-2.5-flash-lite',
        apiKey: dotenv.env['API_KEY']!,
      );
      _chatSession = _model.startChat();
    } catch (e) {
      emit(state.copyWith(error: "Failed to initialize chat: $e"));
    }
  }
}
