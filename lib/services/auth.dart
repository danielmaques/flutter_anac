// ignore_for_file: unnecessary_null_comparison

import 'package:anac_simulado/models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Usuario? _userFromFirebaseUser(User usuario) {
    return usuario != null ? Usuario(uId: usuario.uid) : null;
  }

  Future signInEmailAndPass(String email, String senha) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String senha) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: senha);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}