import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/screens/login/get_cpf_screen.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Widget screen;

  setUp(() {
    dotenv.testLoad(fileInput: File('.env.mock').readAsStringSync());
    screen = MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: Consumer<UserProvider>(
          builder: (context, user, _) => LoginGetCpfScreen(),
        ),
      ),
    );
  });

  group('Test get cpf screen', () {
    testWidgets('test labels in screen', (WidgetTester tester) async {
      await tester.pumpWidget(screen);

      expect(find.text('Vamos fazer login!'), findsOneWidget);

      expect(find.text('Informe seu CPF'), findsWidgets);
    });

    testWidgets('test input in screen', (WidgetTester tester) async {
      await tester.pumpWidget(screen);

      // test if is show
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('test next buttons is show', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      final buttonContainer = tester.widget<Container>(find.byType(Container).last);

      // test if label is show
      expect(find.text('AVANÇAR'), findsOneWidget);

      // test button content alignment
      expect(buttonContainer.alignment, Alignment.center);
    });
  });
}
