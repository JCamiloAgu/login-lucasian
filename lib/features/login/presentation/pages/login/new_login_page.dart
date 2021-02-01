import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:login_lucasian/routes/aplication_routes.dart';
import 'package:login_lucasian/shared/widgets/auth_button.dart';
import 'package:login_lucasian/shared/widgets/bezier/bezier_container.dart';
import 'package:login_lucasian/shared/widgets/input_with_label.dart';
import 'package:provider/provider.dart';

import 'login_presenter.dart';

class NewLoginPage extends StatelessWidget {
  final sl = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<LoginPresenter>()),
      ],
      child: Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: [
              Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              _Body()
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginPresenter = Provider.of<LoginPresenter>(context, listen: false);

    final accentColor = Theme.of(context).accentColor;
    final height = MediaQuery.of(context).size.height;

    return loginPresenter.isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * .2),
                  _title(accentColor),
                  SizedBox(height: 50),
                  _Form(),
                  _quickLoginFingerPrint(accentColor)
                ],
              ),
            ),
          );
  }

  Widget _title(Color accentColor) {
    return Text(
      'LOGIN',
      style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: accentColor.withRed(255),
          shadows: <BoxShadow>[
            BoxShadow(
                color: Colors.white,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ]),
    );
  }

  Widget _quickLoginFingerPrint(Color accentColor) {
    final textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w300);

    final space = SizedBox(
      height: 8,
    );
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 20),
      child: Column(
        children: [
          Text(
            'Ingrese rápidamente usando la huella dactilar',
            style: textStyle,
          ),
          space,
          IconButton(
            iconSize: 80,
            color: accentColor,
            icon: Icon(
              Icons.fingerprint,
            ),
            onPressed: () {},
          ),
          space,
          Text(
            'Huella dactilar',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginPresenter = Provider.of<LoginPresenter>(context);

    return Column(
      children: [
        InputWithLabel(
          label: 'Correo electrónico',
          textInputType: TextInputType.emailAddress,
          textEditingController: emailCtrl,
          onChange: (email) {
            loginPresenter.validateEmail(email);
          },
          errorText: loginPresenter.isValidEmail
              ? null
              : 'Correo electrónico no válido',
        ),
        SizedBox(height: 10),
        InputWithLabel(
          label: 'Contraseña',
          textInputType: TextInputType.text,
          textEditingController: passCtrl,
          isPassword: true,
          onChange: (password) {
            loginPresenter.validatePassword(password);
          },
          errorText: loginPresenter.isValidPassword
              ? null
              : 'La contraseña debe contener entre 1 y 15 caracteres',
        ),
        SizedBox(height: 20),
        AuthButton(
          text: 'Ingresar',
          onTap: loginPresenter.isAnyInputEmpty(emailCtrl.text, passCtrl.text) ||
                  !loginPresenter.isValidEmail ||
                  !loginPresenter.isValidPassword
              ? null
              : () async {
                  await loginPresenter
                      .doLogin(LoginRequest(emailCtrl.text, passCtrl.text));

                  _checkLoginStatus(loginPresenter);
                },
        ),
      ],
    );
  }

  void _checkLoginStatus(LoginPresenter loginPresenter) {
    if (loginPresenter.isLoginOk != null && !loginPresenter.isLoginOk) {
      _showAlertBadCredentials(loginPresenter);
    } else {
      Navigator.pushNamed(context, welcomeRoute);
    }
  }

  void _showAlertBadCredentials(LoginPresenter loginPresenter) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Credenciales incorrectas'),
            content: Text(loginPresenter.badLoginMessage),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Ok'),
              )
            ],
          );
        });
  }

}
