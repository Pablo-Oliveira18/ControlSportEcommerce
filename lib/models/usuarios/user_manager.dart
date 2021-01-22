import 'package:controlsport_app_ecommerce/helpers/firabase_erros.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserManager extends ChangeNotifier {
  // config FIREBASE
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;

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
      onSuccess();
      await Future.delayed(Duration(seconds: 5));
    } on FirebaseAuthException catch (e, s) {
      onFail(getErrorString(e.code));
    } on Exception catch (e, s) {}
    setLoading(false);
  }

  void setLoading(bool value) {
    print(' o valor q esta aq eé o $value');
    loading = value;
    notifyListeners();
  }

  bool getLoading() {
    return loading;
  }
}
