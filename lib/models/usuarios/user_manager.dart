import 'dart:io';

import 'package:controlsport_app_ecommerce/helpers/firabase_erros.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class UserManager {
  // config FIREBASE
  final FirebaseAuth auth = FirebaseAuth.instance;

  ///
  ////sigin
  Future<void> fazerLogin(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    // resultado a auteticação
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
      );
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }
}
