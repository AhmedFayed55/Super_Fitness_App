import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/chat_composer.dart';

class MockSmartChatViewModel implements SmartChatViewModel {
  @override
  bool isArabic(String text) {
    return text.contains(RegExp(r'[\u0600-\u06FF]'));
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSmartChatViewModel mockViewModel;
  late SmartChatState mockState;
  late TextEditingController controller;
  late InMemoryChatController chatController;
  late String sentText;

  setUp(() {
    mockViewModel = MockSmartChatViewModel();
    chatController = InMemoryChatController();
    mockState = SmartChatState(
      isSendingOrReceivingMessage: false,
      chatController: chatController,
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
    controller = TextEditingController();
    sentText = '';
  });

  tearDown(() {
    controller.dispose();
    chatController.dispose();
  });

  Widget createTestWidget({
    required SmartChatState state,
    required TextEditingController textController,
    required Function(String) onSend,
  }) {
    return MaterialApp(
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ChatComposer(
          controller: textController,
          state: state,
          onSend: onSend,
          viewModel: mockViewModel,
        ),
      ),
    );
  }

  testWidgets('renders ChatComposer correctly', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        state: mockState,
        textController: controller,
        onSend: (text) => sentText = text,
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.send_rounded), findsOneWidget);
  });

  testWidgets('calls onSend when send button is tapped', (tester) async {
    controller.text = 'Hello';
    await tester.pumpWidget(
      createTestWidget(
        state: mockState,
        textController: controller,
        onSend: (text) => sentText = text,
      ),
    );

    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pump();

    expect(sentText, equals('Hello'));
  });

  testWidgets('calls onSend when TextField is submitted', (tester) async {
    controller.text = 'Test message';
    await tester.pumpWidget(
      createTestWidget(
        state: mockState,
        textController: controller,
        onSend: (text) => sentText = text,
      ),
    );

    await tester.enterText(find.byType(TextField), 'Test message');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump();

    expect(sentText, equals('Test message'));
  });

  testWidgets('shows CircularProgressIndicator when sending', (tester) async {
    final sendingState = mockState.copyWith(isSendingOrReceivingMessage: true);
    await tester.pumpWidget(
      createTestWidget(
        state: sendingState,
        textController: controller,
        onSend: (text) => sentText = text,
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byIcon(Icons.send_rounded), findsNothing);
  });

  testWidgets('does not call onSend when text is empty', (tester) async {
    controller.text = '';
    await tester.pumpWidget(
      createTestWidget(
        state: mockState,
        textController: controller,
        onSend: (text) => sentText = text,
      ),
    );

    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pump();

    expect(controller.text, isEmpty);
  });

  testWidgets('TextField accepts multiline input', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        state: mockState,
        textController: controller,
        onSend: (text) => sentText = text,
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.maxLines, equals(5));
    expect(textField.minLines, equals(1));
    expect(textField.keyboardType, equals(TextInputType.multiline));
  });
}
