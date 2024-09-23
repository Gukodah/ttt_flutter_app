import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trigg_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Teste de login", () {
    setUpAll(() async {
      await dotenv.load(fileName: ".env.mock");
    });
    testWidgets("Tentando auto login no início", (tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      "Quando Não logado, welcome com botão de login",
      (tester) async {
        await tester.pumpWidget(MyApp());
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        await tester.pumpAndSettle();
        expect(
          find.widgetWithText(OutlinedButton, "JÁ TENHO CADASTRO"),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "Falhando login com usuário e senha inválidos",
      (tester) async {
        await tester.pumpWidget(MyApp());
        await tester.pumpAndSettle();
        await tester.tap(
          find.widgetWithText(OutlinedButton, "JÁ TENHO CADASTRO"),
        );
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byType(TextFormField).first,
          "12345678900",
        );
        await tester.enterText(
          find.byType(TextFormField).last,
          "invalid",
        );
        await tester.tap(
          find.widgetWithText(ElevatedButton, "Entrar"),
        );
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsOneWidget);
      },
    );

    testWidgets(
      "Efetuando login com usuário e senha corretos",
      (tester) async {
        await tester.pumpWidget(MyApp());
        await tester.pumpAndSettle();
        await tester.tap(
          find.widgetWithText(OutlinedButton, "JÁ TENHO CADASTRO"),
        );
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byType(TextFormField).first,
          "40260624810",
        );
        await tester.enterText(
          find.byType(TextFormField).last,
          "correct",
        );
        await tester.tap(
          find.widgetWithText(ElevatedButton, "Entrar"),
        );
        await tester.pumpAndSettle();
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      },
    );
  });
}
