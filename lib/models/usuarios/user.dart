import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String email = "";
  String senha = "";
  String nomeCompleto = "";
  String cpf = "";
  String telefone = "";
  String confirmarSenha = "";
  String id = "";
  String sexo = "";

  Usuario({
    this.email,
    this.senha,
    this.nomeCompleto,
    this.cpf,
    this.telefone,
    this.sexo,
  });

  Usuario.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nomeCompleto = document.data()['name'] as String;
    email = document.data()['email'] as String;
    sexo = document.data()['sexo'] as String;
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
    };
  }

  String getNomeCompleto() {
    return nomeCompleto;
  }
}
