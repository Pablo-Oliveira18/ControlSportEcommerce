import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/address/address.dart';
import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_product.dart';
import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:controlsport_app_ecommerce/service/cepaberto_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  Usuario usuario;
  Address address;
  num deliveryPrice;

  num productsPrice = 0.0;
  num get totalPrice => productsPrice + (deliveryPrice ?? 0);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int _installments = 1;
  int get installments => _installments;
  set installments(int value) {
    _installments = value;
    notifyListeners();
  }

  void updateUser(UserManager userManager) {
    usuario = userManager.usuario;
    productsPrice = 0.0;
    items.clear();
    removeAddress();

    if (usuario != null) {
      _loadCartItems();
      _loadUserAddress();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await usuario.cartReference.get();
    items = cartSnap.docs
        .map((e) => CartProduct.fromDocument(e)..addListener(_onItemUpdate))
        .toList();
  }

  Future<void> _loadUserAddress() async {
    if (usuario.address != null &&
        await calculateDelivery(usuario.address.lat, usuario.address.long)) {
      address = usuario.address;
      notifyListeners();
    }
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

  bool get isAddressValid => address != null && deliveryPrice != null;

  // ADDRESS

  Future<void> getAddress(String cep) async {
    loading = true;
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
      }
      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;

    if (await calculateDelivery(address.lat, address.long)) {
      usuario.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }

  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc = await firestore.doc('aux/delivery').get();

    final latStore = doc.data()['lat'] as double;
    final longStore = doc.data()['long'] as double;

    final base = doc.data()['base'] as num;
    final km = doc.data()['km'] as num;
    final maxkm = doc.data()['maxkm'] as num;

    double dis =
        await Geolocator().distanceBetween(latStore, longStore, lat, long);

    dis /= 1000.0;

    debugPrint('Distance $dis');

    if (dis > maxkm) {
      return false;
    }

    deliveryPrice = base + dis * km;
    return true;
  }

  void clear() {
    for (final cartProduct in items) {
      usuario.cartReference.doc(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }

  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    usuario.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }
}
