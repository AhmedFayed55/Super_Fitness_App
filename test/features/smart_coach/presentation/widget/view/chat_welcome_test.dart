import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/chat_welcome.dart';

// Fake SmartChat Bloc
class FakeSmartChatViewModel extends Cubit<SmartChatState>
    implements SmartChatViewModel {
  FakeSmartChatViewModel({SmartChatState? initialState})
    : super(
        initialState ??
            SmartChatState(
              chatController: InMemoryChatController(),
              user: null,
              isLoading: false,
            ),
      );

  @override
  Future<void> doIntent(SmartChatEvent event) async {}

  @override
  bool isArabic(String text) => false;
}

// Fake Localization Object (matches your app’s fields)
class FakeLocalization {
  String get hi => 'Hi';
  // ignore: non_constant_identifier_names
  String get hi_user => 'Hi %s,';
  String get user => 'User';
  // ignore: non_constant_identifier_names
  String get i_am_your_smart_coach => 'I Am Your Smart Coach';
  // ignore: non_constant_identifier_names
  String get how_can_i_assist_you => 'How Can I Assist You';
  String get today => 'Today?';
  // ignore: non_constant_identifier_names
  String get get_started => 'Get Started';
}

// Fake AppLocalization InheritedWidget (mimics your real one)
class FakeAppLocalization extends InheritedWidget {
  final FakeLocalization localization;
  const FakeAppLocalization({
    required this.localization,
    required super.child,
    super.key,
  });

  static FakeAppLocalization? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FakeAppLocalization>();
  }

  @override
  bool updateShouldNotify(FakeAppLocalization oldWidget) =>
      localization != oldWidget.localization;
}

// Patch the real extension lookup so context.localization finds our fake one
extension FakeLocalizationOverride on BuildContext {
  FakeLocalization get localization =>
      FakeAppLocalization.of(this)!.localization;
}

void main() {
  group('ChatWelcomeView', () {
    late FakeLocalization fakeLocalization;

    setUp(() {
      fakeLocalization = FakeLocalization();
    });

    testWidgets(
      'renders correctly and triggers onGetStarted when user is not available',
      (tester) async {
        bool pressed = false;

        // Ensure a sufficiently large test window to avoid layout overflow in the row
        // ignore: deprecated_member_use
        tester.binding.window.physicalSizeTestValue = const Size(1440, 3120);
        // ignore: deprecated_member_use
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        addTearDown(() {
          // ignore: deprecated_member_use
          tester.binding.window.clearPhysicalSizeTestValue();
          // ignore: deprecated_member_use
          tester.binding.window.clearDevicePixelRatioTestValue();
        });

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: BlocProvider<SmartChatViewModel>(
              create: (_) => FakeSmartChatViewModel(),
              child: FakeAppLocalization(
                localization: fakeLocalization,
                child: ChatWelcomeView(
                  onGetStarted: () {
                    pressed = true;
                  },
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(
          find.text(
            fakeLocalization.hi_user.replaceFirst('%s', fakeLocalization.user),
          ),
          findsOneWidget,
        );
        expect(
          find.text(fakeLocalization.i_am_your_smart_coach),
          findsOneWidget,
        );

        // The bottom messages are rendered using RichText (TextSpan),
        // so query the RichText widget and assert its plain text contains the expected strings.
        final rich = tester.widget<RichText>(find.byType(RichText));
        final richPlain = rich.text.toPlainText();
        expect(richPlain, contains(fakeLocalization.how_can_i_assist_you));
        expect(richPlain, contains(fakeLocalization.today));
        expect(find.text(fakeLocalization.get_started), findsOneWidget);

        await tester.tap(find.text(fakeLocalization.get_started));
        await tester.pump();

        expect(pressed, isTrue);
      },
    );

    testWidgets('renders correctly with user name when user is available', (
      tester,
    ) async {
      const user = UserEntity(
        id: '1',
        firstName: 'Ahmed',
        lastName: 'Test',
        email: 'a@test.com',
        gender: 'male',
        age: 30,
        weight: 70,
        height: 175,
        activityLevel: 'medium',
        goal: 'fitness',
        photo: '',
        createdAt: '',
      );
      final initialState = SmartChatState(
        chatController: InMemoryChatController(),
        user: user,
        isLoading: false,
      );

      // Ensure a sufficiently large test window to avoid layout overflow in the row
      // ignore: deprecated_member_use
      tester.binding.window.physicalSizeTestValue = const Size(1440, 3120);
      // ignore: deprecated_member_use
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      addTearDown(() {
        // ignore: deprecated_member_use
        tester.binding.window.clearPhysicalSizeTestValue();
        // ignore: deprecated_member_use
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider<SmartChatViewModel>(
            create: (_) => FakeSmartChatViewModel(initialState: initialState),
            child: FakeAppLocalization(
              localization: fakeLocalization,
              child: ChatWelcomeView(onGetStarted: () {}),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text(fakeLocalization.hi_user.replaceFirst('%s', user.firstName)),
        findsOneWidget,
      );
      expect(find.text(fakeLocalization.i_am_your_smart_coach), findsOneWidget);
    });
  });
}
