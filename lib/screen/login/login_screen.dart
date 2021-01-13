import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: EdgeInsets.all(16),
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 120.0,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 20),

              // Form Field Email
              TextFormField(
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
                  return null;
                },
              ),

              const SizedBox(height: 16),
              // form field senha
              TextFormField(
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
              const SizedBox(height: 16),

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
                  onPressed: () {},
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: const Text(
                    'Entra',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
