import 'package:controlsport_app_ecommerce/common/cart/price_cart.dart';
import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_manager.dart';
import 'package:controlsport_app_ecommerce/models/checkout/checkout_manager.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            PriceCard(
              buttonText: 'Finalizar Pedido',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}