import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signInAnonymous() async {
    AuthResult result = await _auth.signInAnonymously();
    // print(result);
    return result.user.uid;
  }

  Future<String> signupWithEmailAndPassword(
      String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // print(result);
    return result.user.uid;
  }

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    // print(result);
    return result.user.uid;
  }

  Future logout() async {
    // print('logging out');
    _auth.signOut();
  }
}
