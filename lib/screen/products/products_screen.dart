import 'package:controlsport_app_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:controlsport_app_ecommerce/models/products/product_manager.dart';
import 'package:controlsport_app_ecommerce/screen/products/components/product_list_tile.dart';
import 'package:controlsport_app_ecommerce/screen/products/components/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showDialog(context: context, builder: (_) => SearchDialog());
              }),
        ],
        title: const Text('Produtos'),
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount:
                productManager.allProducts.length, // tamanho da minha lista
            itemBuilder: (_, index) {
              return ProductListTile(productManager.allProducts[index]);
            },
          );
        },
      ),
    );
  }
}
