import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    // category = document['category'] as String;
    // brandy = document['brand'] as String;
    images = List<String>.from(document.data()['images']
        as List<dynamic>); // transforma a lista dinamica em String
  }

  String id;
  String name;
  String description;
  String category;
  String brandy;
  List<String> images;
}
