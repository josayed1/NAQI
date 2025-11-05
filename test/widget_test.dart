import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naqi_filter/main.dart';

void main() {
  testWidgets('Naqi app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NaqiApp());

    // Verify that the app title is present
    expect(find.textContaining('نقي'), findsWidgets);
  });
}
