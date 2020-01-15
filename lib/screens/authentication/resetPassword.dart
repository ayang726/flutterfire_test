import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_test/screens/authentication/authenticate.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';

class ResetPassword extends StatefulWidget {
  final Function goToAuthMethod;
  ResetPassword({this.goToAuthMethod});

  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  var email = '';
  var error = '';
  var emailSent = false;

  AuthService _auth = AuthService();
  final _resetPasswordFormKey = GlobalKey<FormState>();

  void _handleResetPassword() {
    setState(() => error = '');
    if (_resetPasswordFormKey.currentState.validate()) {
      _auth.resetPassword(email).then((value) {
        setState(() {
          emailSent = true;
        });
        print('Password reset email sent to $email');
      }).catchError((e) {
        setState(() {
          error = 'There is no user corresponding to the given email.';
        });
        print('User not found: $email');
      }, test: (e) => e is PlatformException
      ).catchError((e) {
        setState(() {
          error = e.message;
        });
        print('Reset password error: ${e.toString()}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return emailSent ? 
    Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        actions: <Widget>[
          FlatButton(
            child: Text('Login'),
            onPressed: () => widget.goToAuthMethod(LoginMethod.loginWithEmailAndPasssword),
          )
        ],
      ),
      body: Center(
        child: Text('If an account exists, an email will be sent with instructions.')
      )
    )
    : Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        actions: <Widget>[
          FlatButton(
            child: Text('Login'),
            onPressed: () => widget.goToAuthMethod(LoginMethod.loginWithEmailAndPasssword),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(50),
            child: Form(
              key: _resetPasswordFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    onFieldSubmitted: (_) => {_handleResetPassword()},
                    textInputAction: TextInputAction.send,
                    validator: (value) =>
                        value.isEmpty ? "Email cannot be empty" : null,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, height: 2),
                    textAlign: TextAlign.left,
                  ),
                  RaisedButton(
                    child: Text('Email me a recovery link'),
                    onPressed: _handleResetPassword,
                    
                  )
                ]
              )
            )
          )
        ],
      )
    );
  }
}