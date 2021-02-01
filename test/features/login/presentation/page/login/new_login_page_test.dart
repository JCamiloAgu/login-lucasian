import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_presenter.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/new_login_page.dart';
import 'package:login_lucasian/shared/widgets/auth_button.dart';
import 'package:login_lucasian/shared/widgets/input_with_label.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterMock extends Mock implements LoginPresenter {}

void main() {
  LoginPresenterMock loginPresenterMock;

  setUpAll(() {
    loginPresenterMock = LoginPresenterMock();
    when(loginPresenterMock.isAnyInputEmpty(any, any)).thenReturn(true);

    final sl = GetIt.instance;
    sl.registerSingleton<LoginPresenter>(loginPresenterMock);
  });

  group('Inputs del login', () {
    testWidgets(
        'Debería aparecer un error en el campo del email cuando el presenter tenga el isValidEmail en false y desaparecer cuando sea true',
        (WidgetTester tester) async {
      when(loginPresenterMock.isLoading).thenReturn(false);
      when(loginPresenterMock.isValidEmail).thenReturn(false);
      when(loginPresenterMock.isValidPassword).thenReturn(true);

      InputWithLabel getEmailInput(WidgetTester tester) {
        final Finder inputEmailFinder = find.byType(InputWithLabel).first;

        expect(inputEmailFinder, findsOneWidget);

        return tester.widget(inputEmailFinder);
      }

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      expect(getEmailInput(tester).errorText, isNotEmpty);

      loginPresenterMock.isValidEmail = true;

      when(loginPresenterMock.isValidEmail).thenReturn(true);

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      expect(getEmailInput(tester).errorText, isNull);
    });

    testWidgets(
        'Debería aparecer un error en el campo del password cuando el presenter tenga el isValidEmail en false y desaparecer cuando sea true',
        (WidgetTester tester) async {
      when(loginPresenterMock.isLoading).thenReturn(false);
      when(loginPresenterMock.isValidEmail).thenReturn(true);
      when(loginPresenterMock.isValidPassword).thenReturn(false);

      InputWithLabel getPasswordInput(WidgetTester tester) {
        final Finder inputPasswordFinder = find.byType(InputWithLabel).last;

        expect(inputPasswordFinder, findsOneWidget);

        return tester.widget(inputPasswordFinder);
      }

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      expect(getPasswordInput(tester).errorText, isNotEmpty);

      loginPresenterMock.isValidPassword = true;

      when(loginPresenterMock.isValidPassword).thenReturn(true);

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      expect(getPasswordInput(tester).errorText, isNull);
    });
  });

  group('Visibilidad del CircularProgressIndicator', () {
    testWidgets('No debería aparecer el loading', (WidgetTester tester) async {
      when(loginPresenterMock.isLoading).thenReturn(false);
      when(loginPresenterMock.isValidEmail).thenReturn(true);
      when(loginPresenterMock.isValidPassword).thenReturn(true);

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Debería aparecer el formulario y desaparecer el loading',
        (WidgetTester tester) async {
      when(loginPresenterMock.isLoading).thenReturn(true);

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('OnTap del botón', () {
    testWidgets(
        'El botón de ingresar debería estar deshabilitado si algún campo es inválido',
        (WidgetTester tester) async {
      when(loginPresenterMock.isLoading).thenReturn(false);
      when(loginPresenterMock.isValidPassword).thenReturn(false);
      when(loginPresenterMock.isValidEmail).thenReturn(false);

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      final authButtonFinder = find.byType(AuthButton);

      expect(authButtonFinder, findsOneWidget);

      final AuthButton authButton = tester.widget(authButtonFinder);

      expect(authButton.onTap, isNull);
    });

    testWidgets(
        'El botón debería estar deshabilitado aún cuando los valid del presenter son true pero los txtController están vacíos',
        (WidgetTester tester) async {
      when(loginPresenterMock.isLoading).thenReturn(false);
      when(loginPresenterMock.isValidPassword).thenReturn(true);
      when(loginPresenterMock.isValidEmail).thenReturn(true);

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      final authButtonFinder = find.byType(AuthButton);

      expect(authButtonFinder, findsOneWidget);

      final AuthButton authButton = tester.widget(authButtonFinder);

      expect(authButton.onTap, isNull);
    });

    testWidgets('El botón debería estar habilitado',
        (WidgetTester tester) async {
      when(loginPresenterMock.isLoading).thenReturn(false);
      when(loginPresenterMock.isValidPassword).thenReturn(true);
      when(loginPresenterMock.isValidEmail).thenReturn(true);
      when(loginPresenterMock.isAnyInputEmpty(any, any)).thenReturn(false);

      await tester.pumpWidget(MaterialApp(home: NewLoginPage()));

      final authButtonFinder = find.byType(AuthButton);

      expect(authButtonFinder, findsOneWidget);

      final AuthButton authButton = tester.widget(authButtonFinder);

      final Finder inputsFinder = find.byType(InputWithLabel);

      expect(inputsFinder, findsNWidgets(2));

      expect(authButton.onTap, isNotNull);
    });
  });
}
