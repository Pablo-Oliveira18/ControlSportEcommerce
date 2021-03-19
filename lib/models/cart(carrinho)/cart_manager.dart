import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_product.dart';
import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';

class CartManager {
  List<CartProduct> items = [];

  Usuario usuario;

  void updateUser(UserManager userManager) {
    usuario = userManager.usuario;
    items.clear();

    if (usuario != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await usuario.cartReference.get();
    items = cartSnap.docs.map((e) => CartProduct.fromDocument(e)).toList();
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((element) => element.stackable(product));
      e.quantity++;
    } catch (s) {
      final cartProduct = CartProduct.fromProduct(product);
      items.add(cartProduct);
      usuario.cartReference.add(cartProduct.toCartMap());
    }
  }
}
