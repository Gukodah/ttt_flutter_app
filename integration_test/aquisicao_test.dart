import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trigg_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Testing Aquisição", () {
    setUpAll(() async {
      await dotenv.load(fileName: ".env");
    });

    testWidgets("Test open aquisicao screen", (tester) async {
      await tester.pumpWidget(MyApp());
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();
      expect(
        find.text("Qual é a melhor opção de crédito para você hoje?"),
        findsOneWidget,
      );
    });
  });
}
