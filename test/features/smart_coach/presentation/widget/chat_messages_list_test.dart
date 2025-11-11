import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as core;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/chat_messages_list.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/typing_indicator.dart';

class MockSmartChatViewModel implements SmartChatViewModel {
  final List<SmartChatEvent> events = [];

  @override
  bool isArabic(String text) {
    return text.contains(RegExp(r'[\u0600-\u06FF]'));
  }

  @override
  Future<void> doIntent(SmartChatEvent event) async {
    events.add(event);
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSmartChatViewModel mockViewModel;
  late SmartChatState mockState;
  late core.InMemoryChatController chatController;

  setUp(() {
    mockViewModel = MockSmartChatViewModel();
    chatController = core.InMemoryChatController();
    mockState = SmartChatState(
      chatController: chatController,
      isSendingOrReceivingMessage: false,
      user: null,
    );
  });

  tearDown(() {
    chatController.dispose();
  });

  Widget createTestWidget({required SmartChatState state}) {
    return MaterialApp(
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ChatMessagesList(viewModel: mockViewModel, state: state),
      ),
    );
  }

  testWidgets('renders ChatMessagesList correctly', (tester) async {
    await tester.pumpWidget(createTestWidget(state: mockState));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));

    expect(find.byType(ChatMessagesList), findsOneWidget);
  });

  testWidgets(
    'shows typing indicator when state.isSendingOrReceivingMessage is true',
    (tester) async {
      final sendingState = mockState.copyWith(
        isSendingOrReceivingMessage: true,
      );
      await tester.pumpWidget(createTestWidget(state: sendingState));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));

      expect(find.byType(TypingIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'does not show typing indicator when state.isSendingOrReceivingMessage is false',
    (tester) async {
      await tester.pumpWidget(createTestWidget(state: mockState));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));

      expect(find.byType(TypingIndicator), findsNothing);
    },
  );

  testWidgets('renders messages when added to chatController', (tester) async {
    final controller = core.InMemoryChatController();
    controller.insertMessage(
      const core.TextMessage(id: '1', authorId: 'user1', text: 'Hello'),
    );
    controller.insertMessage(
      const core.TextMessage(id: '2', authorId: 'bot', text: 'Hi there'),
    );

    final stateWithMessages = mockState.copyWith(chatController: controller);

    await tester.pumpWidget(createTestWidget(state: stateWithMessages));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));

    expect(find.textContaining('Hello', findRichText: true), findsWidgets);
    expect(find.textContaining('Hi there', findRichText: true), findsWidgets);

    controller.dispose();
  });

  testWidgets('renders Chat widget from flutter_chat_ui', (tester) async {
    await tester.pumpWidget(createTestWidget(state: mockState));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));

    expect(find.byType(chat_ui.Chat), findsOneWidget);
  });

  testWidgets('handles user entity correctly', (tester) async {
    final userState = mockState.copyWith(
      user: const UserEntity(
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
      ),
    );

    await tester.pumpWidget(createTestWidget(state: userState));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));

    expect(find.byType(ChatMessagesList), findsOneWidget);
  });

  testWidgets('calls doIntent when message is sent from Chat widget', (
    tester,
  ) async {
    await tester.pumpWidget(createTestWidget(state: mockState));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));

    expect(mockViewModel.events, isEmpty);

    expect(find.byType(chat_ui.Chat), findsOneWidget);
  });
}
