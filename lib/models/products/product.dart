import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/itemSize/item_size.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    description = document['description'] as String;
    name = document['name'] as String;

    // category = document['category'] as String;
    brandy = document['brandy'] as String;
    images = List<String>.from(document.data()['images']
        as List<dynamic>); // transforma a lista dinamica em String
    deleted = (document.data()['deleted'] ?? false) as bool;
    sizes = (document.data()['sizes'] as List<dynamic> ?? [1])
        .map((s) => ItemSize.fromMap(s))
        .toList();
    category = document['category'] as String;
  }

  Product(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.sizes,
      this.brandy,
      this.category,
      this.deleted = false}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      category: category,
      brandy: brandy,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
      deleted: deleted,
    );
  }

  List<dynamic> newImages;
  String id;
  String name;
  String description;
  String category;
  String brandy;
  List<String> images;
  List<ItemSize> sizes;
  bool deleted;
  ItemSize _selectedSize;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('products/$id');

  Reference get storageRef => storage.ref().child('products').child(id);

  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
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
    return totalStock > 0 && !deleted;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest) lowest = size.price;
    }
    return lowest;
  }

  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((element) => element.name == name);
    } catch (e) {
      return null;
    }
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  void delete() {
    firestoreRef.update({'deleted': true});
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'category': category,
      'brandy': brandy,
      'sizes': exportSizeList(),
    };

    if (id == null) {
      final doc = await firestore.collection('products').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    final List<String> updateImages = [];

    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);
        final TaskSnapshot snapshot = await task;
        final String url = await snapshot.ref.getDownloadURL();
        updateImages.add(url);
      }
    }

    for (final image in images) {
      if (!newImages.contains(image) && image.contains('firebase')) {
        try {
          final ref = storage.ref(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.update({'images': updateImages});

    images = updateImages;

    loading = false;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }
}
