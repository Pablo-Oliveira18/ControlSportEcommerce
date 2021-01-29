import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String email = "";
  String senha = "";
  String nomeCompleto = "";
  String cpf = "";
  String telefone = "";
  String confirmarSenha = "";
  String id = "";

  Usuario({this.email, this.senha, this.nomeCompleto, this.cpf, this.telefone});

  // salva dados do usuario no banco
  Future<void> saveData() async {
    print('Estou saldo o ${email}');
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
    };
  }

  String getNomeCompleto() {
    return nomeCompleto;
  }
}
