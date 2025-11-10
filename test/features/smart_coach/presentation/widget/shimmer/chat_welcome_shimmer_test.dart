import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/shimmer/chat_welcome_shimmer.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('ChatWelcomeShimmer renders correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ChatWelcomeShimmer()));

    expect(find.byType(Shimmer), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Column), findsWidgets);

    final containers = tester.widgetList<Container>(find.byType(Container));
    expect(containers, isNotEmpty);

    final largeBox = containers.where((c) {
      final size =
          c.constraints ?? const BoxConstraints.tightFor(width: 0, height: 0);
      return size.maxWidth == 280 && size.maxHeight == 280;
    });
    expect(largeBox.isNotEmpty, true);

    final buttonBox = containers.where((c) {
      final size =
          c.constraints ?? const BoxConstraints.tightFor(width: 0, height: 0);
      return size.maxHeight == 48;
    });
    expect(buttonBox.isNotEmpty, true);

    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets('ChatWelcomeShimmer shimmer color structure is valid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ChatWelcomeShimmer()));

    final shimmerFinder = find.byType(Shimmer);
    expect(shimmerFinder, findsOneWidget);

    final shimmerWidget = tester.widget<Shimmer>(shimmerFinder);
    expect(shimmerWidget, isA<Shimmer>());
  });
}
