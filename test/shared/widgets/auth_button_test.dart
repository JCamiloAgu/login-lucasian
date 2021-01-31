import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_lucasian/shared/widgets/auth_button.dart';

void main() {
  testWidgets('Verificar el método onTap del AuthButton',
      (WidgetTester tester) async {
    int x = 0;

    final authButton = AuthButton(text: 'ingresar', onTap: () => x++);
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: authButton)));

    final btn = find.byWidget(authButton);

    expect(btn, findsOneWidget);

    await tester.tap(btn);

    expect(x, equals(1));
  });

  testWidgets('Cambio del colores de botón dependiendo del onTap',
      (WidgetTester tester) async {
    List<Color> colorsWithOnTapNull = [];
    List<Color> colorsWithOnTap = [];

    final authButton = AuthButton(text: 'ingresar', onTap: () {});
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: authButton)));

    Container container = tester.widget(find.byType(Container));
    colorsWithOnTap = (container.decoration as BoxDecoration).gradient.colors;

    final authButtonWithOnTapNull = AuthButton(text: 'ingresar', onTap: null);
    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: authButtonWithOnTapNull)));

    container = tester.widget(find.byType(Container));
    colorsWithOnTapNull =
        (container.decoration as BoxDecoration).gradient.colors;

    expect(colorsWithOnTap.length, equals(2));
    expect(colorsWithOnTapNull.length, equals(2));

    expect(colorsWithOnTapNull[0], isNot(equals(colorsWithOnTap[0])));
    expect(colorsWithOnTapNull[1], isNot(equals(colorsWithOnTap[1])));
  });
}
