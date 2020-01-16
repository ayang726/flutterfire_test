import 'package:flutter/material.dart';
// import 'package:flutterfire_test/screens/authentication/passwordlessSignin.dart';
import 'package:flutterfire_test/screens/authentication/resetPassword.dart';
import 'package:flutterfire_test/screens/authentication/signup.dart';
import 'login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // bool showSignupScreen = false;

  LoginMethod _loginMethod = LoginMethod.loginWithEmailAndPasssword;

  // void toggleSignup() {
  //   // print(showSignupScreen.toString());
  //   setState(() => {
  //         if (loginMethod == LoginMethod.loginWithEmailAndPasssword)
  //           {loginMethod = LoginMethod.signupWithEmailAndPassword}
  //         else if (loginMethod == LoginMethod.signupWithEmailAndPassword)
  //           {loginMethod = LoginMethod.loginWithEmailAndPasssword}
  //       });
  // }

  // void togglePasswordlessLogin() {
  //   setState(() {
  //     if (loginMethod != LoginMethod.passwordlessLogin) {
  //       loginMethod = LoginMethod.passwordlessLogin;
  //     } else {
  //       loginMethod = LoginMethod.loginWithEmailAndPasssword;
  //     }
  //   });
  // }

  void gotoAuthScreen(LoginMethod method) {
    setState(() {
      _loginMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginMethod) {
      case LoginMethod.signupWithEmailAndPassword:
        return Signup(navigateTo: gotoAuthScreen);
        break;
      case LoginMethod.loginWithEmailAndPasssword:
        return Login(navigateTo: gotoAuthScreen);
        break;

      // case LoginMethod.passwordlessLogin:
      //   return PasswordlessLogin(gotoAuthMethod: gotoAuthScreenWith);
      case LoginMethod.resetPassword:
        return ResetPassword(navigateTo: gotoAuthScreen);
        break;
    }
  }
}

enum LoginMethod {
  signupWithEmailAndPassword,
  loginWithEmailAndPasssword,
  // passwordlessLogin,
  resetPassword
}
