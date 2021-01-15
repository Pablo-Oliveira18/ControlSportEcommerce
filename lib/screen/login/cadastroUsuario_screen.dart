import 'package:controlsport_app_ecommerce/helpers/validator.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroUsuario extends StatelessWidget {
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
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: ListView(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                // Form Field Email
                TextFormField(
                  controller: emailController,
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

                // botão entrar
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
