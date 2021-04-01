import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';

import 'package:flutter/cupertino.dart';

class AdminUsersManager extends ChangeNotifier {
  List<Usuario> usuario = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription _subscription;

  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      usuario.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    _subscription =
        firestore.collection('users').snapshots().listen((snapshot) {
      usuario = snapshot.docs.map((d) => Usuario.fromDocument(d)).toList();
      usuario.sort((a, b) =>
          a.nomeCompleto.toLowerCase().compareTo(b.nomeCompleto.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names => usuario.map((e) => e.nomeCompleto).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
