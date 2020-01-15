import 'package:flutter/material.dart';
import 'package:flutterfire_test/screens/authentication/login.dart';
import 'package:flutterfire_test/screens/authentication/passwordlessSignin.dart';
import 'package:flutterfire_test/screens/authentication/resetPassword.dart';
import 'package:flutterfire_test/screens/authentication/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // bool showSignupScreen = false;

  LoginMethod loginMethod = LoginMethod.loginWithEmailAndPasssword;

  void toggleSignup() {
    // print(showSignupScreen.toString());
    setState(() => {
          if (loginMethod == LoginMethod.loginWithEmailAndPasssword)
            {loginMethod = LoginMethod.signupWithEmailAndPassword}
          else if (loginMethod == LoginMethod.signupWithEmailAndPassword)
            {loginMethod = LoginMethod.loginWithEmailAndPasssword}
        });
  }

  void togglePasswordlessLogin() {
    setState(() {
      if (loginMethod != LoginMethod.passwordlessLogin) {
        loginMethod = LoginMethod.passwordlessLogin;
      } else {
        loginMethod = LoginMethod.loginWithEmailAndPasssword;
      }
    });
  }

  void gotoAuthScreenWith(LoginMethod method) {
    setState(() {
      loginMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (loginMethod) {
      case LoginMethod.signupWithEmailAndPassword:
        return SignUp(gotoAuthMethod: gotoAuthScreenWith);
      case LoginMethod.loginWithEmailAndPasssword:
        return LogIn(gotoAuthMethod: gotoAuthScreenWith);
      case LoginMethod.passwordlessLogin:
        return PasswordlessLogin(gotoAuthMethod: gotoAuthScreenWith);
      case LoginMethod.resetPassword:
        return ResetPassword(goToAuthMethod: gotoAuthScreenWith);
    }
  }
}

enum LoginMethod {
  signupWithEmailAndPassword,
  loginWithEmailAndPasssword,
  passwordlessLogin,
  resetPassword
}
