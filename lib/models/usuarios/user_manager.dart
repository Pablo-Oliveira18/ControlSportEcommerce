import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlsport_app_ecommerce/helpers/firabase_erros.dart';
import 'package:controlsport_app_ecommerce/helpers/validator.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser(); //loadCorrentUser
  }

  // config FIREBASE
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Usuario usuario;

  User userAtual;

  bool _loading = false;

  bool get isLoggedIn => usuario != null;

  bool get adminEnabled => usuario != null && usuario.admin;

  ///
  ////sigin
  Future<void> fazerLogin(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    // resultado a auteticação
    setLoading(true);
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
      );
      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    } on FirebaseAuthException catch (e, s) {
      onFail(getErrorString(e.code));
    } on Exception catch (e, s) {}
    setLoading(false);
  }

  // signUP
  Future<void> cadastrarUser(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    setLoading(true);
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: usuario.email, password: usuario.senha);

      usuario.id = result.user.uid;
      this.usuario = usuario;

      await usuario.saveData();

      onSuccess();
    } on PlatformException catch (e, s) {
      onFail(getErrorString(e.code));
    } on Exception catch (e, s) {}
    setLoading(false);
  }

  // Pegar a sessão e fazer que o usuario não precise logar toda hora
  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? await auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      usuario = Usuario.fromDocument(docUser);

      final docAdmin =
          await firestore.collection('admins').doc(usuario.id).get();
      if (docAdmin.exists) {
        usuario.admin = true;
      }

      notifyListeners();
    }
  }

  // sair
  Future<void> signOut() {
    auth.signOut();
    usuario = null;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool getLoading() {
    return _loading;
  }

  // recuperar senha

  void recoverPass(String email) {
    try {
      if (emailValid(email)) {
        FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        notifyListeners();
      }
    } catch (e) {
      return;
    }
  }
}
