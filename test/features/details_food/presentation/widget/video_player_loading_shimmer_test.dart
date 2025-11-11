import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_loading_shimmer.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  testWidgets('renders shimmer widget correctly', (tester) async {
    await tester.pumpWidget(buildTestWidget(const VideoPlayerLoadingShimmer()));

    expect(find.byType(VideoPlayerLoadingShimmer), findsOneWidget);
    expect(find.byType(SizedBox), findsWidgets);
    expect(find.byType(Shimmer), findsOneWidget);

    final circleContainers = find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).shape == BoxShape.circle,
    );
    expect(circleContainers, findsNWidgets(4));

    final whiteContainers = find.byWidgetPredicate(
      (widget) => widget is Container && widget.color == Colors.white,
    );
    expect(whiteContainers, findsWidgets);
  });
}
