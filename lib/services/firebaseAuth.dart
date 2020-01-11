import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_test/models/user.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  User userFromFirebaseUser(FirebaseUser user) {
    if (user != null)
      return User(uid: user.uid, email: user.email);
    else
      return null;
  }

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

  Future<String> loginWithEmailAndLink(String email) async {
    _auth.sendSignInWithEmailLink(
        email: email,
        url: 'https://flutterfiretest.page.link/RtQw',
        androidInstallIfNotAvailable: true,
        iOSBundleID: 'com.vera.flutterfiretest',
        handleCodeInApp: true,
        androidMinimumVersion: '21',
        androidPackageName: 'vera');
  }

  Future<void> retrieveDynamicLink({String email}) async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.retrieveDynamicLink();

    final Uri deepLink = data?.link;
    print(deepLink.toString());

    if (deepLink.toString() != null) {
      signInWithEmailAndLink(email: email, link: deepLink.toString());
    }
    return deepLink.toString();
  }

  Future<void> signInWithEmailAndLink({String email, String link}) async {
    final FirebaseAuth user = FirebaseAuth.instance;
    bool validLink = await user.isSignInWithEmailLink(link);
    if (validLink) {
      try {
        await user.signInWithEmailAndLink(email: email, link: link);
      } catch (e) {
        print(e);
        // _showDialog(e.toString());
      }
    }
  }
}
