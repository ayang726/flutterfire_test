import 'package:flutter/material.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';

class LogIn extends StatefulWidget {
  final Function toggleSignup;
  LogIn({this.toggleSignup});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var email = '';
  var password = '';
  var error = '';

  AuthService _auth = AuthService();
  final _authFormKey = GlobalKey<FormState>();

  void _handleLogIn() {
    _auth.loginWithEmailAndPassword(email, password).then((value) {
      print('user $value signed in');
    }).catchError((e) {
      setState(() {
        error = e.message;
      });
      print('login error: $e.toString()');
    });
  }

/* These two methods are for passwordless signin functionalities, so far it doesn't work
because we don't have a app id for ios. and haven't set up for android*/
  void handlePasswordlessLogin() {
    _auth.loginWithEmailAndLink(email).then(print).catchError(print);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _auth.retrieveDynamicLink(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        actions: <Widget>[
          FlatButton(
            child: Text('Sign Up'),
            onPressed: widget.toggleSignup,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
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
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) =>
                        value.isEmpty ? "Email cannot be empty" : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) =>
                        value.isEmpty ? "Password must not be empty" : null,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_authFormKey.currentState.validate()) {
                        _handleLogIn();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            child: Text("Sign in With Link"),
            onPressed: handlePasswordlessLogin,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.link_off),
        onPressed: _auth.signInAnonymous,
      ),
    );
  }
}
