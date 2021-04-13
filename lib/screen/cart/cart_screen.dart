import 'package:controlsport_app_ecommerce/common/cart/empy_card.dart';
import 'package:controlsport_app_ecommerce/common/cart/login_card.dart';
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
          if (cartManager.usuario == null) {
            return LoginCard();
          }

          if (cartManager.items.isEmpty) {
            return EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: 'Que pena, você não tem nenhum produto no seu carrinho !',
            );
          }
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
                        Navigator.of(context).pushNamed('/address');
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
