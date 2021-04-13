import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_manager.dart';
import 'package:flutter/cupertino.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }
}
