import 'package:controlsport_app_ecommerce/helpers/firabase_erros.dart';
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

  User userAtual;

  bool _loading = false;

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
      userAtual = result.user;
      onSuccess();
    } on FirebaseAuthException catch (e, s) {
      onFail(getErrorString(e.code));
    } on Exception catch (e, s) {}
    setLoading(false);
  }

  // SIGIN
  Future<void> cadastrarUser(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    setLoading(true);
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: usuario.email, password: usuario.senha);

      userAtual = result.user;

      onSuccess();
    } on PlatformException catch (e, s) {
      onFail(getErrorString(e.code));
    } on Exception catch (e, s) {}
    setLoading(false);
  }

  // Pegar a sessão e fazer que o usuario não precise logar toda hora
  Future<void> _loadCurrentUser() async {
    final User currentUser = await auth.currentUser;
    if (currentUser != null) {
      userAtual = currentUser;
      print(userAtual.uid);
    }
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool getLoading() {
    return _loading;
  }
}
