import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xFFf8c862), Color(0xFFd97e13), Color(0xFFbe7518)],
  ).createShader(
    Rect.fromLTWH(
      0.0,
      0.0,
      200.0,
      90.0,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Control \n Sport\'s ',
                style: new TextStyle(
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Olá, ${userManager.usuario?.nomeCompleto ?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userManager.isLoggedIn) {
                    userManager.signOut();
                  } else {
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(
                  userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
