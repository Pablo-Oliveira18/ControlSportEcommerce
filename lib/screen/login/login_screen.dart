import 'package:controlsport_app_ecommerce/helpers/validator.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final GlobalKey<FormState> formkey =
      GlobalKey<FormState>(); // key do formulario

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); // key Scaffold

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Sport\'s Control'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formkey,
              child: Consumer<UserManager>(
                child: SizedBox(
                  height: 120.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                builder: (_, userManager, child) {
                  return ListView(
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      child,

                      SizedBox(height: 20),

                      // Form Field Email
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.getLoading(),
                        style: style,
                        decoration: InputDecoration(
                          hintText: 'Informe o e-mail',
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false, // não corrige o que digitou
                        validator: (email) {
                          if (!emailValid(email)) {
                            return 'Email invalido';
                          } else {
                            return null;
                          }
                        },
                      ),

                      const SizedBox(height: 16),
                      // form field senha
                      TextFormField(
                        controller: senhaController,
                        enabled: !userManager.getLoading(),

                        style: style,
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        autocorrect: false, // não corrige o q digitou
                        obscureText: true,
                        validator: (senha) {
                          if (senha.isEmpty || senha.length < 6) {
                            return 'Senha inválida';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 7),

                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text('Esqueci minha senha'),
                        ),
                      ),

                      // botão entrar
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: userManager.getLoading()
                              ? null
                              : () {
                                  if (formkey.currentState.validate()) {
                                    userManager.fazerLogin(
                                      usuario: Usuario(
                                          email: emailController.text,
                                          senha: senhaController.text),
                                      onFail: (e) {
                                        scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text('Falha ao entrar: $e'),
                                          backgroundColor: Colors.red,
                                        ));
                                      },
                                      onSuccess: () {
                                        // TODO: Fechar tela de login
                                      },
                                    );
                                  }
                                },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          child: userManager.getLoading()
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      ),

                      // botaão login Google
                      SizedBox(height: 10),
                      SizedBox(
                        height: 44,
                        child: SignInButton(
                            btnText: 'Entrar com o Google',
                            buttonType: ButtonType.google,
                            onPressed: () {
                              print('click');
                            }),
                      ),

                      // botão login git
                      SizedBox(height: 10),
                      SizedBox(
                        height: 44,
                        child: SignInButton(
                            buttonType: ButtonType.github,
                            onPressed: () {
                              print('click');
                            }),
                      ),
                      // ainda n tem conta?

                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/cadastro');
                          },
                          child:
                              const Text('Não possui uma conta? Cadastre-se'),
                        ),
                      ),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
