import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_arrow_back.dart';

void main() {
  testWidgets('arrow back custom widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body:  BackArrowButton())),
    );

    expect(find.byType(BackArrowButton), findsOneWidget);

    final containerFinder = find.byType(Container);
    expect(containerFinder, findsOneWidget);

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final Image image = tester.widget(imageFinder);
    expect(image.image, isA<AssetImage>());
    final assetImage = image.image as AssetImage;
    expect(assetImage.assetName.contains('arrow_back'), true);
  });
}
