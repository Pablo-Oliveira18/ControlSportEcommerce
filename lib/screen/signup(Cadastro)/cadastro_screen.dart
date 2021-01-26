import 'package:brasil_fields/brasil_fields.dart';
import 'package:controlsport_app_ecommerce/helpers/validator.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          margin: const EdgeInsets.symmetric(horizontal: 13),
          child: Form(
              key: formkey,
              child: Consumer<UserManager>(
                child: CircleAvatar(
                  radius: 40,
                  child: ClipOval(
                    child: Image.asset('assets/user.png'),
                  ),
                ),
                builder: (_, userManager, child) {
                  return ListView(
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      child,

                      const SizedBox(height: 20),

                      //for Field Nome

                      TextFormField(
                        enabled: !userManager.getLoading(),
                        textCapitalization: TextCapitalization.characters,
                        style: style,
                        decoration: InputDecoration(
                          hintText: 'Nome Completo',
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        autocorrect: false, // não corrige o que digitou
                        validator: (nome) {
                          if (nome.isEmpty)
                            return 'Campo obrigatorio';
                          else if (nome.trim().split(' ').length <= 1)
                            return 'Preencha seu nome completo';
                          else
                            return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        enabled: !userManager.getLoading(),
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        style: style,
                        decoration: InputDecoration(
                          hintText: 'Celular, EX: (37) 99822-4567',
                          prefixIcon: Icon(Icons.quick_contacts_mail),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        autocorrect: false, // não corrige o que digitou
                        validator: (cpf) {
                          if (cpf.isEmpty) return 'Campo obrigatorio';
                        },
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        enabled: !userManager.getLoading(),
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        style: style,
                        decoration: InputDecoration(
                          hintText: 'CPF, EX: 000.000.000-00',
                          prefixIcon: Icon(Icons.quick_contacts_mail),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        autocorrect: false, // não corrige o que digitou
                        validator: (cpf) {
                          if (cpf.isEmpty) return 'Campo obrigatorio';
                        },
                      ),

                      const SizedBox(height: 12),

                      // Form Field Email
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.getLoading(),
                        style: style,
                        decoration: InputDecoration(
                          hintText: 'Informe o e-mail',
                          prefixIcon: Icon(Icons.mail),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false, // não corrige o que digitou
                        validator: (email) {
                          if (email.isEmpty)
                            return 'Campo obrigatório';
                          else if (!emailValid(email))
                            return 'Email invalido';
                          else
                            return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      // form field senha
                      TextFormField(
                        controller: senhaController,
                        enabled: !userManager.getLoading(),
                        style: style,
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          prefixIcon: Icon(Icons.vpn_key),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        autocorrect: false, // não corrige o q digitou
                        obscureText: true,
                        validator: (senha) {
                          if (senha.isEmpty)
                            return 'Senha não pode ser vazio';
                          else if (senha.length < 6)
                            return 'Senha muito curta';
                          else
                            return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: senhaController,
                        enabled: !userManager.getLoading(),
                        style: style,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          hintText: 'Repita sua senha',
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
                      const SizedBox(height: 15),

                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: () {
                            formkey.currentState.validate();
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
                                  'Criar Conta',
                                  style: TextStyle(fontSize: 18),
                                ),
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
