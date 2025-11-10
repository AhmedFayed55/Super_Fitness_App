import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/chat_composer.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/chat_messages_list.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/chat_conversation.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/previous_conversations_drawer.dart';

class MockSmartChatViewModel extends Cubit<SmartChatState>
    implements SmartChatViewModel {
  MockSmartChatViewModel(super.state);

  Future<void> Function(SmartChatEvent)? _doIntentHandler;

  @override
  Future<void> doIntent(SmartChatEvent event) async {
    if (_doIntentHandler != null) {
      await _doIntentHandler!(event);
    }
  }

  @override
  bool isArabic(String text) {
    return text.contains(RegExp(r'[\u0600-\u06FF]'));
  }

  void setDoIntentHandler(Future<void> Function(SmartChatEvent) handler) {
    _doIntentHandler = handler;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSmartChatViewModel mockViewModel;
  late InMemoryChatController chatController;

  setUp(() {
    chatController = InMemoryChatController();
    mockViewModel = MockSmartChatViewModel(
      SmartChatState(
        chatController: chatController,
        userChats: const [],
        showDrawer: false,
        isLoadingChats: false,
        isLoadingMessages: false,
        isSendingOrReceivingMessage: false,
      ),
    );
  });

  tearDown(() async {
    chatController.dispose();
    await Future.delayed(const Duration(milliseconds: 60));
  });

  Future<void> pumpView(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<SmartChatViewModel>.value(
          value: mockViewModel,
          child: const ChatConversationView(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));
  }

  testWidgets('renders main chat structure', (tester) async {
    await pumpView(tester);

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ChatComposer), findsOneWidget);
    expect(find.byType(Blur), findsOneWidget);
  });

  testWidgets('shows loading spinner when isLoadingMessages=true', (
    tester,
  ) async {
    mockViewModel.emit(
      SmartChatState(
        chatController: chatController,
        isLoadingMessages: true,
        userChats: const [],
      ),
    );
    await pumpView(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.textContaining('Loading', findRichText: true), findsWidgets);
  });

  testWidgets('renders ChatMessagesList when not loading', (tester) async {
    mockViewModel.emit(
      SmartChatState(
        chatController: chatController,
        isLoadingMessages: false,
        userChats: const [],
      ),
    );
    await pumpView(tester);

    expect(find.byType(ChatMessagesList), findsOneWidget);
  });

  testWidgets('renders PreviousConversationsDrawer when showDrawer=true', (
    tester,
  ) async {
    mockViewModel.emit(
      SmartChatState(
        chatController: chatController,
        showDrawer: true,
        userChats: const [],
      ),
    );
    await pumpView(tester);

    expect(find.byType(PreviousConversationsDrawer), findsOneWidget);
  });
}
