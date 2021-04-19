import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/order/order.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:flutter/cupertino.dart';

class OrdersManager extends ChangeNotifier {
  Usuario usuario;

  List<Order> orders = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription _subscription;

  void updateUser(Usuario usuario) {
    this.usuario = usuario;

    orders.clear();

    _subscription?.cancel();

    if (usuario != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore
        .collection('orders')
        .where('user', isEqualTo: usuario.id)
        .snapshots()
        .listen((event) {
      orders.clear();
      for (final doc in event.docs) {
        orders.add(Order.fromDocument(doc));
      }

      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
