import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/address/address.dart';
import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_product.dart';
import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:controlsport_app_ecommerce/service/cepaberto_service.dart';
import 'package:flutter/cupertino.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  Usuario usuario;
  Address address;

  num productsPrice = 0.0;

  void updateUser(UserManager userManager) {
    usuario = userManager.usuario;
    items.clear();

    if (usuario != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await usuario.cartReference.get();
    items = cartSnap.docs
        .map((e) => CartProduct.fromDocument(e)..addListener(_onItemUpdate))
        .toList();
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((element) => element.stackable(product));
      e.increment();
    } catch (s) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdate);
      items.add(cartProduct);
      usuario.cartReference
          .add(cartProduct.toCartMap())
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdate();
    }
    notifyListeners();
  }

  void _onItemUpdate() {
    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null)
      usuario.cartReference.doc(cartProduct.id).update(cartProduct.toCartMap());
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) {
        return false;
      }
    }
    return true;
  }

  // ADDRESS

  Future<void> getAddress(String cep) async {
    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if (cepAbertoAddress != null) {
        address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade.nome,
            state: cepAbertoAddress.estado.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    usuario.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }
}
