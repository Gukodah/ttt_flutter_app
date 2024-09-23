import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trigg_app/screens/welcome_scree.dart';

void main() {
  group("Test welcome screen", () {
    testWidgets(
      "Test if buttons shows up",
      (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: WelcomeScreen(),
        ));
        expect(find.text('QUERO SER TRIGG'), findsOneWidget);
        expect(find.text('JÁ TENHO CADASTRO'), findsOneWidget);
      },
    );
  });
}
