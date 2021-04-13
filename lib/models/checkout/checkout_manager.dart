import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_manager.dart';
import 'package:flutter/cupertino.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  void checkout() {
    _decrementStock();
  }

  void _decrementStock() {
    // 1. Ler todos os estoques 3xM
    // 2. Decremento localmente os estoques 2xM
    // 3. Salvar os estoques no firebase 2xM
  }
}
