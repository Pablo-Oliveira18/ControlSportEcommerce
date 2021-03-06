import 'package:controlsport_app_ecommerce/common/custom_drawer/custom_drawer_header.dart';
import 'package:controlsport_app_ecommerce/common/custom_drawer/drawer_tile.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Drawer(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color.fromARGB(6, 218, 165, 32), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            ListView(
              children: <Widget>[
                CustomDrawerHeader(),
                const Divider(),
                // Drawer HOME
                DrawerTile(
                  iconData: Icons.home,
                  title: 'Inicio',
                  page: 0, // passado por parametro para definir a pagina
                ),

                // Drawer Produtos...
                DrawerTile(
                  iconData: Icons.list,
                  title: 'Produtos',
                  page: 1,
                ),

                // Drawer Contato...
                DrawerTile(
                  iconData: Icons.playlist_add_check,
                  title: 'Meus Pedidos',
                  page: 2,
                ),

                // Drawer Contato...
                DrawerTile(
                  iconData: Icons.contact_page,
                  title: 'Contato',
                  page: 3,
                ),

                Consumer<UserManager>(
                  builder: (_, userManager, __) {
                    if (userManager.adminEnabled) {
                      return Column(
                        children: <Widget>[
                          const Divider(),

                          /// Drawer Minha Conta
                          DrawerTile(
                            iconData: Icons.engineering,
                            title: 'Usuarios',
                            page: 4,
                          ),

                          /// Drawer Minha Conta
                          DrawerTile(
                            iconData: Icons.engineering,
                            title: 'Pedidos',
                            page: 5,
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                )

                ///
                ///
              ],
            ),
          ],
        ),
      ),
    );
  }
}
