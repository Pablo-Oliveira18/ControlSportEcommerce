import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/itemSize/item_size.dart';
import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {
  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    // category = document['category'] as String;
    // brandy = document['brand'] as String;
    images = List<String>.from(document.data()['images']
        as List<dynamic>); // transforma a lista dinamica em String
    sizes = (document.data()['sizes'] as List<dynamic> ?? [1])
        .map((s) => ItemSize.fromMap(s))
        .toList();
  }

  String id;
  String name;
  String description;
  String category;
  String brandy;
  List<String> images;
  List<ItemSize> sizes;

  ItemSize _selectedSize;

  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }
}
