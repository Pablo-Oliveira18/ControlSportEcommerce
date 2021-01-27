class Usuario {
  String email = "";
  String senha = "";
  String nomeCompleto = "";
  String cpf = "";
  String telefone = "";
  String confirmarSenha = "";

  Usuario({this.email, this.senha, this.nomeCompleto, this.cpf, this.telefone});

  String getNomeCompleto() {
    return nomeCompleto;
  }
}
