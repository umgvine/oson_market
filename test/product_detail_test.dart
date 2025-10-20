import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ya_market/screens/product_detail_screen.dart';

void main() {
  final demoProduct = {
    'id': 1,
    'name': 'Demo Product',
    'price': 12000,
    'oldPrice': 15000,
    'discount': 20,
    'rating': 4.5,
    'reviews': 12,
    'deliveryDate': '2-3 days',
    'desc': 'A demo product for testing',
    'img': 'assets/demo/demo_product.png',
    'gallery': ['assets/demo/demo_product.png'],
  };

  testWidgets('quantity increment/decrement and add-to-cart', (
    WidgetTester tester,
  ) async {
    int addCalls = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: ProductDetailScreen(
          product: demoProduct,
          onAddToCart: () => addCalls++,
        ),
      ),
    );

    // initial quantity is 1
    expect(find.text('1'), findsOneWidget);

    // tap + twice
    final addFinder = find.widgetWithIcon(IconButton, Icons.add);
    expect(addFinder, findsWidgets);
    await tester.tap(addFinder.first);
    await tester.pumpAndSettle();
    await tester.tap(addFinder.first);
    await tester.pumpAndSettle();

    expect(find.text('3'), findsOneWidget);

    // tap - once
    final removeFinder = find.widgetWithIcon(IconButton, Icons.remove);
    await tester.tap(removeFinder.first);
    await tester.pumpAndSettle();

    expect(find.text('2'), findsOneWidget);

    // Tap add-to-cart (localized label), should call onAddToCart quantity times (2)
    final cta = find.text('В корзину');
    expect(cta, findsOneWidget);
    await tester.tap(cta);
    await tester.pumpAndSettle();

    expect(addCalls, 2);

    // SnackBar is shown
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
