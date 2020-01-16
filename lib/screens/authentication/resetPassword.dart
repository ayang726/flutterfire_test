import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_test/screens/authentication/authenticate.dart';

import 'package:flutterfire_test/services/firebaseAuth.dart';
import 'package:flutterfire_test/widgets/spinner.dart';

import 'authBtn.dart';
import 'inputTextFormField.dart';

class ResetPassword extends StatefulWidget {
  final Function navigateTo;
  ResetPassword({this.navigateTo});

  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  var email = '';
  var error = '';
  var emailSent = false;
  var loading = false;
  String message = "";

  AuthService _auth = AuthService();
  final _resetPasswordFormKey = GlobalKey<FormState>();

  void _handleResetPassword() {
    setState(() => error = '');
    if (_resetPasswordFormKey.currentState.validate()) {
      _auth.resetPassword(email).then((value) {
        setState(() {
          emailSent = true;
          message =
              'If an account exists, an email will be sent with instructions.';
        });
        print('Password reset email sent to $email');
        // check if email exists in database first
      }).catchError((e) {
        setState(() {
          error = 'There is no user corresponding to the given email.';
        });
        print('User not found: $email');
      }, test: (e) => e is PlatformException)
          // all other errors
          .catchError((e) {
        setState(() {
          error = e.message;
        });
        print('Reset password error: ${e.toString()}');
      });
    }
  }

  void _handleLogin() {
    widget.navigateTo(LoginMethod.loginWithEmailAndPasssword);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return LoadingSpinner();
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.arrow_left),
              onPressed: _handleLogin,
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF0078A2),
              tooltip: 'Back to Log In',
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF0078A2),
                        const Color(0xFF83E1B8)
                      ]),
                ),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Column(
                    children: [
                      Padding(
                        child: Image(
                          image: AssetImage("assets/images/veralogo.png"),
                          fit: BoxFit.contain,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100.0, vertical: 40.0),
                      ),
                      Form(
                        key: _resetPasswordFormKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          height: 330,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InputTextFormField(
                                enable: true,
                                labelText: 'Email',
                                onChange: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                validator: (value) => value.isEmpty
                                    ? "Email cannot be empty"
                                    : null,
                              ),
                              AuthBtn(
                                text: 'Email me a recovery link',
                                btnColor: Colors.white,
                                textColor: const Color(0xFF0078A2),
                                onPressed: _handleResetPassword,
                              ),
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                message,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
