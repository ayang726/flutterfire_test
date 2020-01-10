import 'package:flutter/material.dart';
import 'package:flutterfire_test/screens/authentication/login.dart';
import 'package:flutterfire_test/screens/authentication/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignupScreen = false;
  void toggleSignup() {
    // print(showSignupScreen.toString());
    setState(() => {showSignupScreen = !showSignupScreen});
  }

  @override
  Widget build(BuildContext context) {
    if (showSignupScreen) {
      return SignUp(toggleSignup: this.toggleSignup);
    } else {
      return LogIn(toggleSignup: this.toggleSignup);
    }
  }
}
