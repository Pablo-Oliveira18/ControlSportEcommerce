import 'package:controlsport_app_ecommerce/helpers/validator.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroUserScreen extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

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
        title: const Text('Seja bem vindo! Cadastre-se'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formkey,
              child: Consumer<UserManager>(
                child: CircleAvatar(
                  radius: 56,
                  child: ClipOval(
                    child: Image.network(
                      'https://le18bcn.com/wp-content/uploads/2017/06/user-150x150.png',
                    ),
                  ),
                ),
                builder: (_, userManager, child) {
                  return ListView(
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      child,

                      SizedBox(height: 20),

                      //for Field Nome

                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.getLoading(),
                        style: style,
                        decoration: InputDecoration(
                          hintText: 'Nome Completo',
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        autocorrect: false, // não corrige o que digitou
                      ),

                      SizedBox(height: 16),

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
                        autocorrect: false, // não corrige o que digitou
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
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
