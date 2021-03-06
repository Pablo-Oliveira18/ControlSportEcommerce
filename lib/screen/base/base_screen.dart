import 'package:controlsport_app_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:controlsport_app_ecommerce/models/page_manager.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:controlsport_app_ecommerce/screen/admin_orders/admin_orders_screen.dart';
import 'package:controlsport_app_ecommerce/screen/admin_users/admin_users_scrren.dart';
import 'package:controlsport_app_ecommerce/screen/home/home_screen.dart';
import 'package:controlsport_app_ecommerce/screen/order/orders_screen.dart';
import 'package:controlsport_app_ecommerce/screen/products/products_screen.dart';
import 'package:controlsport_app_ecommerce/screen/storage/stores_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  // Page Controller (Controlador de page View)

  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProdutsScreen(),
              OrdersScreen(),
              StoresScreen(),
              if (userManager.adminEnabled) ...[
                AdminUsersScreen(),
                AdminOrdersScreen(),
              ]
            ],
          );
        },
      ),
    );
  }
}
