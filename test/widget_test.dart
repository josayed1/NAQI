// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naqi/main.dart';
import 'package:naqi/services/settings_service.dart';

void main() {
  testWidgets('Naqi app smoke test', (WidgetTester tester) async {
    // Initialize settings service
    final settingsService = await SettingsService.getInstance();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(settingsService: settingsService));

    // Verify that the app title is present
    expect(find.text('نقي'), findsAtLeastNWidgets(1));
  });
}
