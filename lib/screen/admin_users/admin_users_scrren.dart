import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:controlsport_app_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:controlsport_app_ecommerce/models/admins/admin_orders_manager.dart';
import 'package:controlsport_app_ecommerce/models/admins/admin_users_manager.dart';
import 'package:controlsport_app_ecommerce/models/page_manager.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  adminUsersManager.usuario[index].nomeCompleto,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white),
                ),
                subtitle: Text(
                  adminUsersManager.usuario[index].email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  context
                      .read<AdminOrdersManager>()
                      .setUserFilter(adminUsersManager.usuario[index]);
                  context.read<PageManager>().alterarPagina(5);
                },
              );
            },
            highlightTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            indexedHeight: (index) => 80,
            strList: adminUsersManager.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}
