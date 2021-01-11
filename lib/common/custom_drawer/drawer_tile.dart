import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int page; // numero da pagina

  const DrawerTile({this.iconData, this.title, this.page});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // utilizar o ontap no InKell

      onTap: () {
        print('tokei');
      },
      child: SizedBox(
        // utiliza altura para espaçar os itens ...
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32), // espaçar na horizontal

              child: Icon(
                iconData,
                size: 32,
                color: Colors.grey[700],
              ),
            ),

            // Texto dos Menus
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
