import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/previous_conversations_drawer.dart';

void main() {
  group('PreviousConversationsDrawer', () {
    late List<Map<String, dynamic>> mockConversations;

    setUp(() {
      mockConversations = [
        {'id': '1', 'title': 'First Conversation'},
        {'id': '2', 'title': 'Second Conversation'},
      ];
    });

    Widget createWidgetUnderTest({
      List<Map<String, dynamic>>? conversations,
      bool isLoading = false,
      VoidCallback? onClose,
      Function(String)? onSelectConversation,
      Function(String)? onDeleteConversation,
    }) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(400, 800),
            devicePixelRatio: 1.0,
          ),
          child: Scaffold(
            body: PreviousConversationsDrawer(
              conversations: conversations ?? mockConversations,
              isLoading: isLoading,
              onClose: onClose,
              onSelectConversation: onSelectConversation,
              onDeleteConversation: onDeleteConversation,
            ),
          ),
        ),
      );
    }

    testWidgets('displays loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(isLoading: true));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('displays empty state message when conversations is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(conversations: []));
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ListView), findsNothing);
      expect(find.text('No conversations yet'), findsOneWidget);
    });

    testWidgets('displays list of conversations when not empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('First Conversation'), findsOneWidget);
      expect(find.text('Second Conversation'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsNWidgets(2));
      expect(find.byIcon(Icons.delete_outline), findsNWidgets(2));
    });

    testWidgets('calls onClose when close button is tapped', (
      WidgetTester tester,
    ) async {
      bool closePressed = false;
      await tester.pumpWidget(
        createWidgetUnderTest(onClose: () => closePressed = true),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(closePressed, true);
    });

    testWidgets('calls onSelectConversation when conversation is tapped', (
      WidgetTester tester,
    ) async {
      String? selectedId;
      await tester.pumpWidget(
        createWidgetUnderTest(onSelectConversation: (id) => selectedId = id),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('First Conversation'));
      await tester.pumpAndSettle();

      expect(selectedId, '1');
    });

    testWidgets('shows delete dialog when delete button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete_outline).first);
      await tester.pumpAndSettle();

      expect(find.text('Delete Conversation'), findsOneWidget);
      expect(
        find.text('Are you sure you want to delete "First Conversation"?'),
        findsOneWidget,
      );
      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('calls onDeleteConversation when delete is confirmed', (
      WidgetTester tester,
    ) async {
      String? deletedId;
      await tester.pumpWidget(
        createWidgetUnderTest(onDeleteConversation: (id) => deletedId = id),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete_outline).first);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(deletedId, '1');
    });
  });
}
