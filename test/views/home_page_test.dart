import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/views/home_page.dart';

void main() {
  testWidgets('Test views, HomePage', (tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    expect(find.text("Bénévole"), findsOneWidget);
    expect(find.text("Association"), findsOneWidget);
  });
}
