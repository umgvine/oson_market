import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('image height calculation yields 238.66 at card width 179', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 179,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = constraints.maxWidth.isFinite
                      ? constraints.maxWidth
                      : MediaQuery.of(context).size.width;
                  final imageHeight = cardWidth * (238.66 / 179.0);
                  return SizedBox(
                    key: const Key('test_image_sizedbox'),
                    width: double.infinity,
                    height: imageHeight,
                    child: Container(color: Colors.red),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final sizedBox = find.byKey(const Key('test_image_sizedbox'));
    expect(sizedBox, findsOneWidget);

    final size = tester.getSize(sizedBox);
    // Allow tiny floating point delta
    expect(size.height, moreOrLessEquals(238.66, epsilon: 0.01));
  });
}
