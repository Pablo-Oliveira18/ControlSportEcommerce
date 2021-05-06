import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/storage/store.dart';
import 'package:flutter/cupertino.dart';

class StoresManager extends ChangeNotifier {
  StoresManager() {
    _loadStoreList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Store> stores = [];

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('stores').get();

    stores = snapshot.docs.map((e) => Store.fromDocument(e)).toList();

    notifyListeners();
  }
}
