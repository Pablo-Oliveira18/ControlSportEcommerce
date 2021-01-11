import 'package:controlsport_app_ecommerce/common/custom_drawer/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Drawer(
        child: ListView(
          children: <Widget>[
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

            /// Drawer Minha Conta
            DrawerTile(
              iconData: Icons.engineering,
              title: 'Minha Conta',
              page: 4,
            ),

            ///
            ///
          ],
        ),
      ),
    );
  }
}
