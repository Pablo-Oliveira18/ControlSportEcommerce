import 'package:controlsport_app_ecommerce/common/cart/price_cart.dart';
import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_manager.dart';
import 'package:controlsport_app_ecommerce/screen/cart/components/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return ListView(
            children: <Widget>[
              Column(
                children: cartManager.items
                    .map((CartProduct) => CartTile(CartProduct))
                    .toList(),
              ),
              PriceCard(
                buttonText: 'Continuar',
                onPressed: cartManager.isCartValid
                    ? () {
                        print('valido');
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
