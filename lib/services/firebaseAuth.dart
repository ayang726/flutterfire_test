import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterfire_test/models/user.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FacebookLogin _facebookLogin = FacebookLogin();

  User userFromFirebaseUser(FirebaseUser user) {
    if (user != null)
      return User(uid: user.uid, name: user.displayName, email: user.email);
    else
      return null;
  }

  Future<User> signInAnonymous() async {
    AuthResult result = await _auth.signInAnonymously();
    // print(result);
    return userFromFirebaseUser(result.user);
  }

  Future<User> signupWithEmailAndPassword(
      String name, String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // print(result);
    // add name to user in firebase
    UserUpdateInfo userInfo = UserUpdateInfo();
    userInfo.displayName = name;
    result.user.updateProfile(userInfo);
    // print(result.user.displayName);
    return userFromFirebaseUser(result.user);
  }

  Future<User> loginWithEmailAndPassword(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    // print(result);
    return userFromFirebaseUser(result.user);
  }

  Future<User> googleSignin() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      // print("access token" + googleSignInAuthentication.accessToken);
      final AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser firebaseUser = result.user;
      return userFromFirebaseUser(firebaseUser);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<User> facebookSignin() async {
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        // print("success");
        var credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        print("access token" + result.accessToken.token);
        final AuthResult authResult =
            await _auth.signInWithCredential(credential);

        final FirebaseUser firebaseUser = authResult.user;
        return userFromFirebaseUser(firebaseUser);

        // _sendTokenToServer(result.accessToken.token);
        // _showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
        // _showCancelledMessage();
        return null;
        break;
      case FacebookLoginStatus.error:
        // _showErrorOnUI(result.errorMessage);
        print(result.errorMessage);
        return null;
        break;
    }
  }

  Future<void> logout() async {
    // print('logging out');
    _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

////////////////////////////////////////////////////////////////////////////////////////////////////
/////// the following methods are for passwordless signin, to be used in the future.
////////////////////////////////////////////////////////////////////////////////////////////////////
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
