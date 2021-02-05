import 'package:controlsport_app_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:controlsport_app_ecommerce/common/custom_drawer/custom_drawer_header.dart';
import 'package:controlsport_app_ecommerce/models/page_manager.dart';
import 'package:controlsport_app_ecommerce/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  // Page Controller (Controlador de page View)

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController, // Controlador da Home Screen
        physics:
            const NeverScrollableScrollPhysics(), // impidir que movimente a page view através de gestos.

        children: <Widget>[
          // App bar tela,
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Sport Control'),
            ),
          ),

          Container(
            color: Colors.red,
            child: RaisedButton(
              onPressed: () {
                pageController.jumpToPage(1);
              },
              child: Text('Proximo'),
            ),
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
