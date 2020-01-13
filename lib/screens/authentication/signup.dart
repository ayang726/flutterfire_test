import 'package:flutter/material.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';
import 'package:flutterfire_test/widgets/spinner.dart';

import 'authenticate.dart';

class SignUp extends StatefulWidget {
  final Function gotoAuthMethod;
  SignUp({this.gotoAuthMethod});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email = '';
  var password = '';
  var error = '';
  var loading = false;
  // var formIsValid = false;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final AuthService _auth = AuthService();
  final _authFormKey = GlobalKey<FormState>();

  void _handleSignup() {
    if (_authFormKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _auth.signupWithEmailAndPassword(email, password).then((value) {
        print('user $value signed in');
      }).catchError((e) {
        setState(() {
          loading = false;
          error = e.message;
        });
        print('signup error: $e.toString()');
      });
    }
  }

  void _handleSigninAnon() {
    setState(() {
      loading = true;
    });
    _auth.signInAnonymous().then(print).catchError((e) {
      setState(() {
        loading = false;
        error = e.message;
      });
      print('login error: $e.toString()');
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingSpinner()
        : Scaffold(
            appBar: AppBar(
              title: Text('Sign Up'),
              // backgroundColor: Colors.green,
              actions: <Widget>[
                FlatButton(
                  child: Text('Log In'),
                  onPressed: () => widget
                      .gotoAuthMethod(LoginMethod.loginWithEmailAndPasssword),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(50),
              child: Form(
                key: _authFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                          // formIsValid = _authFormKey.currentState.validate();
                        });
                      },
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          value.isEmpty ? "Email cannot be empty" : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      focusNode: _passwordFocusNode,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                          // formIsValid = _authFormKey.currentState.validate();
                        });
                      },
                      onFieldSubmitted: (_) => _handleSignup,
                      textInputAction: TextInputAction.send,
                      validator: (value) => value.length < 6
                          ? "Password must be 6 characters or more"
                          : null,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
                    RaisedButton(
                        child: Text('Submit'), onPressed: _handleSignup),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.link_off),
              tooltip: 'Sign in Anonymously',
              onPressed: _handleSigninAnon,
            ),
          );
  }
}
