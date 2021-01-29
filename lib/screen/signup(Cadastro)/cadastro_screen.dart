import 'package:brasil_fields/brasil_fields.dart';
import 'package:controlsport_app_ecommerce/helpers/validator.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CadastroUserScreen extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 12.0);

  final GlobalKey<FormState> formkey =
      GlobalKey<FormState>(); // key do formulario

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); // key Scaffold

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final Usuario usuario = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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

                    // ************** FIELD NOME ************\\\\\\\\\\\
                    TextFormField(
                      enabled: !userManager.getLoading(),
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
                          return 'Campo obrigatório';
                        else if (nome.trim().split(' ').length <= 1)
                          return 'Preencha seu nome completo';
                        else
                          return null;
                      },
                      onSaved: (nome) {
                        usuario.nomeCompleto = nome;
                      },
                    ),
                    // ************** FIELD NOME ************\\\\\\\\\\\

                    const SizedBox(height: 12),

                    // ************** FIELD Celular ************\\\\\\\\\\\
                    TextFormField(
                      enabled: !userManager.getLoading(),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                      style: style,
                      decoration: InputDecoration(
                        hintText: 'Celular, EX: (37) 99822-4567',
                        prefixIcon: Icon(Icons.phone),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      autocorrect: false, // não corrige o que digitou
                      validator: (cel) {
                        if (cel.isEmpty)
                          return 'Campo obrigatório';
                        else if (cel.length < 15)
                          return ('Preencha o campo todo');
                        else
                          return null;
                      },

                      onSaved: (cel) {
                        print(cel);
                      },
                    ),
                    // ************** FIELD Celular ************\\\\\\\\\\\

                    const SizedBox(height: 12),

                    // ************** FIELD CPF ************\\\\\\\\\\\
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
                        if (cpf.isEmpty)
                          return 'Campo obrigatório';
                        else if (cpf.length < 14)
                          return 'Preencha todos os campos';
                        else if (!CPF.isValid(cpf))
                          return 'CPF invalido';
                        else
                          return null;
                      },
                    ),
                    // ************** FIELD CPF ************\\\\\\\\\\\

                    const SizedBox(height: 12),

                    // ************** FIELD EMAIL ************\\\\\\\\\\\
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
                      onSaved: (email) {
                        usuario.email = email;
                      },
                    ),
                    // ************** FIELD EMAIL ************\\\\\\\\\\\

                    const SizedBox(height: 12),

                    // ************** FIELD SENHA ************\\\\\\\\\\\
                    TextFormField(
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
                          return 'Campo obrigatório';
                        else if (senha.length < 6)
                          return 'Senha muito curta';
                        else
                          return null;
                      },
                      onSaved: (senha) {
                        usuario.senha = senha;
                      },
                    ),
                    // ************** FIELD SENHA ************\\\\\\\\\\\

                    const SizedBox(height: 12),

                    // ************** FIELD SENHA ************\\\\\\\\\\\
                    TextFormField(
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
                      validator: (confSenha) {
                        if (confSenha.isEmpty || confSenha.length < 6) {
                          return 'Senha inválida';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (confSenha) {
                        usuario.confirmarSenha = confSenha;
                      },
                    ),
                    // ************** FIELD SENHA ************\\\\\\\\\\\

                    const SizedBox(height: 15),

                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: () {
                          if (formkey.currentState.validate()) {
                            formkey.currentState.save();
                            if (usuario.senha != usuario.confirmarSenha) {
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: const Text('Senhas não conferem'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            userManager.cadastrarUser(
                                usuario: usuario,
                                onFail: (e) {
                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Falha ao entrar: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                onSuccess: () {
                                  debugPrint('sucesso');
                                  //TODO: POP
                                });
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
                                'Criar Conta',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
