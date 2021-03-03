import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:flutter/cupertino.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _buscarTodosProdutos();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product> allProducts = [];

  Future<void> _buscarTodosProdutos() async {
    // pegar todos documentos
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();

    allProducts =
        snapProducts.docs.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }
}
