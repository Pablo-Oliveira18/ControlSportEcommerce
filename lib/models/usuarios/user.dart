import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/models/address/address.dart';

class Usuario {
  String email = "";
  String senha = "";
  String nomeCompleto = "";
  String cpf = "";
  String telefone = "";
  String confirmarSenha = "";
  String id = "";
  String sexo = "";
  bool admin = false;

  Usuario({
    this.email,
    this.senha,
    this.nomeCompleto,
    this.cpf,
    this.telefone,
    this.sexo,
  });

  Address address;
  Usuario.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nomeCompleto = document.data()['name'] as String;
    email = document.data()['email'] as String;
    sexo = document.data()['sexo'] as String;
    if (document.data().containsKey('address')) {
      address =
          Address.fromMap(document.data()['address'] as Map<String, dynamic>);
    }
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  // salva dados do usuario no banco
  Future<void> saveData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(toMapUser());
  }

  Map<String, dynamic> toMapUser() {
    return {
      'name': nomeCompleto,
      'email': email,
      'cpf': cpf,
      'telefone': telefone,
      'sexo': sexo,
      if (address != null) 'address': address.toMap(),
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }

  String getNomeCompleto() {
    return nomeCompleto;
  }
}
