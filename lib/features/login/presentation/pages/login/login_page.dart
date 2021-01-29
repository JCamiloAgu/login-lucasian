import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:login_lucasian/features/login/domain/models/login_request.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/widgets/submit_button.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/widgets/custom_input.dart';
import 'package:provider/provider.dart';

import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final sl = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<LoginPresenter>()),
      ],
      child: LoginPageBody(),
    );
  }
}

class LoginPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * .9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Form(),
              Text(
                'Términos y condiciones de uso',
                style: TextStyle(fontWeight: FontWeight.w200),
              )
            ],
          ),
        ),
      )),
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

    return loginPresenter.isLoading
        ? Expanded(child: Center(child: CircularProgressIndicator()))
        : Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                CustomInput(
                  icon: Icons.email_outlined,
                  placeholder: 'Email',
                  textInputType: TextInputType.emailAddress,
                  onChange: (value) => loginPresenter.validateFields(
                      LoginRequest(emailCtrl.text, passCtrl.text)),
                  errorText: loginPresenter.isValidEmail
                      ? null
                      : 'Correo electrónico no válido',
                  textEditingController: emailCtrl,
                ),
                CustomInput(
                  icon: Icons.lock_outline,
                  placeholder: 'Contraseña',
                  textEditingController: passCtrl,
                  onChange: (value) => loginPresenter.validateFields(
                      LoginRequest(emailCtrl.text, passCtrl.text)),
                  errorText: loginPresenter.isValidPassword
                      ? null
                      : 'La contraseña es requerida y no puede tener más de 15 caracteres',
                  isPassword: true,
                ),
                SubmitButton(
                    text: 'Ingresar',
                    onPressed: !loginPresenter.isValidEmail ||
                            !loginPresenter.isValidPassword
                        ? null
                        : () async {
                            await loginPresenter.doLogin(
                                LoginRequest(emailCtrl.text, passCtrl.text));

                            _checkLoginStatus(loginPresenter);
                          })
              ],
            ),
          );
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

  void _checkLoginStatus(LoginPresenter loginPresenter) {
    if (loginPresenter.isLoginOk != null && !loginPresenter.isLoginOk) {
      _showAlertBadCredentials(loginPresenter);
    } else {
      Navigator.pushNamed(context, 'welcome');
    }
  }
}
